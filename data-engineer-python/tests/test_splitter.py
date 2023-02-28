from unittest import mock

from file_splitter.splitter import file_splitter


def test_file_splitter_no_split():
    output_file_provider = mock.MagicMock()
    file_splitter(
        99999,
        99999,
        (
            50 * "a",
            50 * "b",
            50 * "c",
        ),
        output_file_provider,
    )

    expected_calls = [
        mock.call.write(50 * "a"),
        mock.call.write(50 * "b"),
        mock.call.write(50 * "c"),
    ]

    assert output_file_provider.method_calls == expected_calls


def test_file_splitter_split_on_bytes():
    output_file_provider = mock.MagicMock()
    file_splitter(
        125,
        99999,
        (
            50 * "a",
            50 * "b",
            50 * "c",
        ),
        output_file_provider,
    )

    expected_calls = [
        mock.call.write(50 * "a"),
        mock.call.write(50 * "b"),
        mock.call.next_file_part,
        mock.call.write(50 * "c"),
    ]

    assert output_file_provider.method_calls == expected_calls


def test_file_splitter_split_on_lines():
    output_file_provider = mock.MagicMock()
    file_splitter(
        99999,
        2,
        (
            50 * "a",
            50 * "b",
            50 * "c",
        ),
        output_file_provider,
    )

    expected_calls = [
        mock.call.write(50 * "a"),
        mock.call.write(50 * "b"),
        mock.call.next_file_part,
        mock.call.write(50 * "c"),
    ]

    assert output_file_provider.method_calls == expected_calls
