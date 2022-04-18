"Represent a python wheel file"

load("//py/private:providers.bzl", "PyWheelInfo")

_ATTRS = {
    "src": attr.label(
        allow_files = [".whl"],
    ),
}

def _make_py_wheel_info_from_filegroup(wheel_filegroup):
    files_depsets = []
    files_depsets.append(wheel_filegroup[DefaultInfo].files)
    files_depsets.append(wheel_filegroup[DefaultInfo].default_runfiles.files)

    return PyWheelInfo(
        files = depset(transitive = files_depsets),
        default_runfiles = wheel_filegroup[DefaultInfo].default_runfiles,
    )

def _py_wheel_impl(ctx):
    py_wheel_info = _make_py_wheel_info_from_filegroup(ctx.attr.src)
    return [
        py_wheel_info,
    ]

py_wheel_lib = struct(
    implementation = _py_wheel_impl,
    attrs = _ATTRS,
    provides = [PyWheelInfo],
)