import shutil
from pathlib import Path
from typing import TextIO


def line_generator(input_file: Path):
    """
    Does all the side-effecting file handling stuff for input
    """
    with open(input_file, "r") as f:
        for line in f:
            yield line


class OutputFileProvider:
    def __init__(self, output_dir: Path, output_file_name_pattern: str):
        """
        Does all the side-effecting file handling stuff for output
        designed to be used as a context manager

        :param output_dir: directory to write to
        :param output_file_name_pattern: file_name to write to.
            `{file_part}` is substituted with the file part number
        """
        self.output_dir = output_dir
        self.output_file_name_pattern = output_file_name_pattern
        self.file_part: int = 0
        self.__current_file_handle: TextIO | None = None

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self._close()

    def provision_output_dir(self):
        shutil.rmtree(self.output_dir, ignore_errors=True)
        self.output_dir.mkdir()

    @property
    def _current_file_name(self) -> Path:
        file_name = self.output_file_name_pattern.format(file_part=self.file_part)
        return self.output_dir / file_name

    @property
    def _current_file_handle(self) -> TextIO:
        if not self.__current_file_handle:
            self.__current_file_handle = open(self._current_file_name, "w")
        return self.__current_file_handle

    def write(self, line: str):
        self._current_file_handle.write(line)

    def next_file_part(self):
        self._close()
        self.file_part += 1

    def _close(self):
        if self._current_file_handle:
            self._current_file_handle.close()
            self.__current_file_handle = None
