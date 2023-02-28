import argparse
from pathlib import Path

from file_splitter.file_handling import OutputFileProvider, line_generator
from file_splitter.splitter import file_splitter


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-file", type=str, required=True)
    parser.add_argument("--output-dir", type=str, required=True)
    parser.add_argument("--max-bytes", type=int, required=True)
    parser.add_argument("--max-lines", type=int, required=True)

    args = parser.parse_args()

    print(args.input_file)
    print(args.output_dir)
    print(args.max_bytes)
    print(args.max_lines)

    return args


def main(input_file: Path, output_dir: Path, max_bytes: int, max_lines: int):
    output_file_name_pattern = f"{input_file.stem}-part{{file_part}}{input_file.suffix}"

    with OutputFileProvider(
        output_dir, output_file_name_pattern
    ) as output_file_provider:
        output_file_provider.provision_output_dir()
        file_splitter(
            max_bytes,
            max_lines,
            line_generator(input_file),
            output_file_provider,
        )


if __name__ == "__main__":
    _args = parse_args()
    main(
        Path(_args.input_file),
        Path(_args.output_dir),
        _args.max_bytes,
        _args.max_lines,
    )
