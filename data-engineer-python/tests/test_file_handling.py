from pathlib import Path

from file_splitter.file_handling import line_generator, OutputFileProvider

PARENT_DIR = Path(__file__).parent
RESOURCES = PARENT_DIR / "resources"
OUTPUT_DIR = PARENT_DIR / "test_file_handling_output"


def test_line_generator():
    result = list(line_generator(RESOURCES / "demo_input.txt"))
    assert result == [
        6 * "a" + "\n",
        6 * "b" + "\n",
        6 * "c",
    ]


def test_output_file_provider():
    first_file = OUTPUT_DIR / "my_file_0.txt"
    second_file = OUTPUT_DIR / "my_file_1.txt"
    with OutputFileProvider(OUTPUT_DIR, "my_file_{file_part}.txt") as ofp:
        ofp.provision_output_dir()
        assert ofp._current_file_name == first_file
        assert not first_file.exists()
        ofp.write("a")

    assert first_file.exists()
    with open(first_file, "r") as f:
        assert f.read() == "a"

    with OutputFileProvider(OUTPUT_DIR, "my_file_{file_part}.txt") as ofp:
        ofp.provision_output_dir()
        ofp.write("b")
        ofp.next_file_part()
        ofp.write("c")

    with open(first_file, "r") as f:
        assert f.read() == "b"
    with open(second_file, "r") as f:
        assert f.read() == "c"
