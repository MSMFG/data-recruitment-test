from pathlib import Path

from file_splitter.__main__ import main

PARENT_DIR = Path(__file__).parent
RESOURCES = PARENT_DIR / "resources"
OUTPUT_DIR = PARENT_DIR / "test_main_output"


def test_main():
    main(RESOURCES / "demo_input.txt", OUTPUT_DIR, 9999, 2)

    with open(OUTPUT_DIR / "demo_input-part0.txt", "r") as f:
        assert f.read() == "aaaaaa\nbbbbbb\n"
    with open(OUTPUT_DIR / "demo_input-part1.txt", "r") as f:
        assert f.read() == "cccccc"
