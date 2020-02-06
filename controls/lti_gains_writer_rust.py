import numpy as np

import os


def _package(packages_list):
    return "package " + ".".join(packages_list) + ";"


def _offset(offset):
    return "  " * offset


def _class_declaration(name, offset=0):
    return _offset(offset) + "public class {} {{".format(name)


def _static_class_declaration(name, offset=0):
    return _offset(offset) + "public static class {} {{".format(name)


def _class_end(offset=0):
    return _offset(offset) + "}"


def _format_matrix_row(row):
    res = list(np.nditer(row))
    return ("{}, " * row.shape[1]).format(*res)[:-2]


def _matrix_declaration(name, mat, offset=0):
    string = _offset(offset) + "public static final double {}[][] = {{".format(name)
    for row in range(mat.shape[0]):
        fmtrow = _format_matrix_row(mat[row])
        string += f"\n{_offset(offset + 1)}{{{fmtrow}}},"
    string += f"\n{_offset(offset)}}};"
    return string


def _constant_declaration(name, constant, offset=0):
    if isinstance(constant, np.matrix):
        return _matrix_declaration(name, constant, offset)
    elif isinstance(constant, float):
        return _offset(offset) + "public static final double {} = {};".format(
            name, constant
        )
    else:
        raise ValueError("Unsupported constant with type {}".format(type(constant)))


def _all_constants(constants, offset=0):
    return "\n".join(
        _constant_declaration(name, constant, offset)
        for name, constant in list(constants.items())
    )


# TODO(m3rcuriel) have this inherit from smtg
class JavaGainsWriter(object):
    def __init__(self, gains, name, package):
        if not isinstance(gains, list):
            gains = [gains]
        self.gains = gains
        self.name = name
        self.package = package

    def _gain_classes(self):
        output = ""
        for gain in self.gains:
            offset = 0
            if len(self.gains) != 1:
                offset = 1
                output += _static_class_declaration(gain.name, offset=1)
                output += "\n"

            output += (
                _all_constants(gain.get_constants_to_write(), offset=offset + 1) + "\n"
            )

            if len(self.gains) != 1:
                output += _class_end(offset)

        return output

    def write(self, java_file_path):
        with open(os.path.join(java_file_path, self.name + ".java"), "w") as jfile:
            jfile.write(
                """{package}

{class_declaration}
{gain_classes}
{class_end}
""".format(
                    package=_package(self.package),
                    class_declaration=_class_declaration(self.name),
                    gain_classes=self._gain_classes(),
                    class_end=_class_end(),
                )
            )
