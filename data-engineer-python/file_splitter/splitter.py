from typing import Iterable

from file_splitter.file_handling import OutputFileProvider


def file_splitter(
    max_bytes: int,
    max_lines: int,
    lines: Iterable[str],
    output_file_provider: OutputFileProvider,
):
    current_file_bytes = 0
    current_number_lines = 0
    for line in lines:
        line_bytes = len(line.encode("utf8"))

        if (
            current_file_bytes + line_bytes > max_bytes
            or current_number_lines + 1 > max_lines
        ):
            output_file_provider.next_file_part()
            current_file_bytes = 0
            current_number_lines = 0

        output_file_provider.write(line)

        current_file_bytes += line_bytes
        current_number_lines += 1
