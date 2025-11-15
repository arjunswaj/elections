---
mode: agent
description: Extract results by running the SQL query on the database.
tools: ['edit', 'search', 'runCommands', 'runTasks', 'postgres-mcp/*', 'usages', 'vscodeAPI', 'think', 'problems', 'changes']
---

Your goal is to help the user extract results by running the SQL query on the database directly from the terminal using `psql` (invoked from the command palette/terminal).

Ask the user for the use case or the specific query if it is not already included/highlighted. When a query is provided, don't modify it unless there are obvious mistakes. Wrap the query inside a PostgreSQL client side copy `\copy` statement so that it is exported straight to CSV, e.g.

```
\copy (
	SELECT column1, column2 FROM your_table WHERE condition
) TO '/path/to/your_file.csv' WITH (FORMAT CSV, HEADER);"
```

Execute this wrapped query with the remote PostgreSQL instance by running `psql -h <remote_host> -U <username> -d <database> -c "COPY (...)"` (fill in host/user/db as appropriate). Because the database is hosted remotely, always include the `-h`, `-U`, and `-d` flags plus any required SSL or password environment variables. The values for these flags can be found in the `connection.yaml` file in the project root.

Choose the final CSV destination path up front (e.g. `result/Bihar/<desired_file_name>.csv`) and reference it in the `COPY` command so the export is written there directly. Confirm that the file was created successfully once the command finishes.

Take the top 5 rows from the query result (you can rerun the query with `LIMIT 5` via `psql -h ... -U ... -d ... -c "<query> LIMIT 5"`) and update the relevant section in the `BIHAR.md` file using the #edit/editFiles tool and `BIHAR-GRAPH.md` file using the #edit/editFiles tool. Some existing data with old results may be present in these files, so replace the outdated rows with the new ones.

Finally, inform the user that the results have been extracted on the remote database, exported to the CSV file via `COPY`, and reflected in the markdown files. Share the same summary of the extracted results with the user.