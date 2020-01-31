load("@rules_cc//cc:action_names.bzl", "ACTION_NAMES")
load(
    "@rules_cc//cc:cc_toolchain_config_lib.bzl",
    "action_config",
    "artifact_name_pattern",
    "env_entry",
    "env_set",
    "feature",
    "feature_set",
    "flag_group",
    "flag_set",
    "tool",
    "tool_path",
    "variable_with_value",
    "with_feature_set",
)

all_compile_actions = [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.assemble,
    ACTION_NAMES.preprocess_assemble,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.clif_match,
    ACTION_NAMES.lto_backend,
]

def _impl(ctx):

    # print (ACTION_NAMES.cpp_compile)
    cpp_compile_action = action_config(
        action_name = ACTION_NAMES.cpp_compile,
        implies = [
        ],
        tools = [tool(path = "echo")],
    )

    action_configs = [
        cpp_compile_action,
    ]

    fastbuild_feature = feature(
        name = "fastbuild",
        flag_sets = [
            flag_set(
                actions = [ACTION_NAMES.c_compile, ACTION_NAMES.cpp_compile],
                flag_groups = [flag_group(flags = ["/DFASTBUILD_FASTBUILD_FASTBUILD_FASTBUILD_FASTBUILD_FASTBUILD_FASTBUILD"])]
            )
        ]
    )

    dbg_feature = feature(
        name = "dbg",
        flag_sets = [
            flag_set(
                actions = [ACTION_NAMES.c_compile, ACTION_NAMES.cpp_compile],
                flag_groups = [flag_group(flags = ["/DDBG_DBG_DBG_DBG_DBG_DBG_DBG_DBG_DBG_DBG_DBG_DBG_DBG_DBG_DBG_DBG_DBG"])]
            )
        ]
    )

    opt_feature = feature(
        name = "opt",
        flag_sets = [
            flag_set(
                actions = [ACTION_NAMES.c_compile, ACTION_NAMES.cpp_compile],
                flag_groups = [flag_group(flags = ["/DOPT_OPT_OPT_OPT_OPT_OPT_OPT_OPT_OPT_OPT_OPT_OPT_OPT_OPT_OPT_OPT"])]
            )
        ]
    )

    tab_compile_debug_flags_feature = feature(
        name = "tab_compile_debug_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "/Dtab_compile_debug_flags_tab_compile_debug_flags_tab_compile_debug_flags_tab_compile_debug_flags_tab_compile_debug_flags",
                        ],
                    ),
                ],
            ),
        ],
        requires = [
            feature_set(features = ["dbg"]),
        ],
    )

    tab_compile_release_flags_feature = feature(
        name = "tab_compile_release_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "/Dtab_compile_release_flags_tab_compile_release_flags_tab_compile_release_flags_tab_compile_release_flags_tab_compile_release_flags",
                        ],
                    ),
                ],
            ),
        ],
        requires = [
            feature_set(features = ["fastbuild"]),
            feature_set(features = ["opt"]),
        ],
    )



    features = [
        fastbuild_feature,
        dbg_feature,
        opt_feature,
        tab_compile_debug_flags_feature,
        tab_compile_release_flags_feature,
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        action_configs = action_configs,
        toolchain_identifier = "test_cc_toolchain",
        host_system_name = "local",
        target_system_name = "local",
        target_cpu = "",
        target_libc = "",
        compiler = "",
        abi_version = "local",
        abi_libc_version = "local"
    )

test_cc_toolchain_config = rule(
    implementation = _impl,
    provides = [CcToolchainConfigInfo]
)


