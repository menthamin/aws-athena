"""This script contains functions related to sql parsing"""


def parse_sql_file(file_path: str) -> str:
    """
    Parse sql file by command unit for execution.

    :param file_path: sql script path
    :return: string
    """

    with open(file_path) as f:
        sql_commands = f.read()

    return sql_commands
