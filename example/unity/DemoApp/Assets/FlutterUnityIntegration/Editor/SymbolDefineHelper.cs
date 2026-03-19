using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEditor.Build;

namespace FlutterUnityIntegration.Editor
{
    public static class SymbolDefineHelper
    {
        public static void SetScriptingDefine(string symbol, bool enable)
        {
            bool changesMade = false;
            
            // Iterate over all named build targets available
#if UNITY_2021_2_OR_NEWER
            foreach (NamedBuildTarget namedTarget in GetAllNamedBuildTargets())
            {
                string defines = PlayerSettings.GetScriptingDefineSymbols(namedTarget);
                var defineList = new List<string>(defines.Split(';'));

                bool contains = defineList.Contains(symbol);
                if (enable && !contains)
                {
                    defineList.Add(symbol);
                    changesMade = true;
                    Debug.Log($"Added '{symbol}' to {namedTarget.TargetName}");
                }
                else if (!enable && contains)
                {
                    defineList.Remove(symbol);
                    changesMade = true;
                    Debug.Log($"Removed '{symbol}' from {namedTarget.TargetName}");
                }

                PlayerSettings.SetScriptingDefineSymbols(namedTarget, string.Join(";", defineList));
            }
#else
            foreach (BuildTargetGroup group in GetAllBuildTargetGroups())
            {
                string defines = PlayerSettings.GetScriptingDefineSymbolsForGroup(group);
                var defineList = new List<string>(defines.Split(';'));

                bool contains = defineList.Contains(symbol);
                if (enable && !contains)
                {
                    defineList.Add(symbol);
                    changesMade = true;
                    Debug.Log($"Added '{symbol}' to {group}");
                }
                else if (!enable && contains)
                {
                    defineList.Remove(symbol);
                    changesMade = true;
                    Debug.Log($"Removed '{symbol}' from {group}");
                }

                PlayerSettings.SetScriptingDefineSymbolsForGroup(group, string.Join(";", defineList));
            }
#endif

            if (changesMade)
            {
                EditorUtility.RequestScriptReload();
                Debug.Log("Script reload requested.");
            }
            else
            {
                Debug.Log("No changes made to scripting define symbols.");
            }
        }

#if UNITY_2021_2_OR_NEWER
        private static IEnumerable<NamedBuildTarget> GetAllNamedBuildTargets()
        {
            yield return NamedBuildTarget.FromBuildTargetGroup(BuildTargetGroup.Standalone);
            yield return NamedBuildTarget.FromBuildTargetGroup(BuildTargetGroup.Android);
            yield return NamedBuildTarget.FromBuildTargetGroup(BuildTargetGroup.iOS);
            yield return NamedBuildTarget.FromBuildTargetGroup(BuildTargetGroup.WebGL);
        }
#else
        private static IEnumerable<BuildTargetGroup> GetAllBuildTargetGroups()
        {
            yield return BuildTargetGroup.Standalone;
            yield return BuildTargetGroup.Android;
            yield return BuildTargetGroup.iOS;
            yield return BuildTargetGroup.WebGL;
        }
#endif
    }
}
