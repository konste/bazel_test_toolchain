workspace(name = "test_toolchain")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "rules_cc",
    remote = "https://github.com/bazelbuild/rules_cc.git",
    commit = "8774a4decd63f45a636f40a75700c06b7ea9d30a",
    shallow_since = "1579787417 -0800", 
)

register_toolchains(":test_toolchain") 

