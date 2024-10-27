# cmd-wrap-convert-fd-args-to-tmpfile

Wrapper script for calling another command line that replaces all the named
pipes (FIFOs) starting with `/dev/fd/` with actual files containing their
content. These are typically created through a shell's process substitution
feature; however, some programs do not handle these named pipes as input.

For example, `git diff --no-index` cannot read from named pipes, unlike
programs like `vimdiff`, and thus requires special handling in versions of Git
prior to v2.42.0
[^git-log-commit-diff-no-index-named-pipes]
[^git-relnotes-diff-no-index-named-pipes]
.

[^git-log-commit-diff-no-index-named-pipes]: [diff --no-index: support reading from named pipes · git/git@1e3f265 · GitHub](https://github.com/git/git/commit/1e3f26542a6ecd3006c2c0d5ccc0bae4a700f7e5)

[^git-relnotes-diff-no-index-named-pipes]: [Git v2.42 Release Notes: `git diff --no-index`](https://github.com/git/git/blob/v2.42.0/Documentation/RelNotes/2.42.0.txt#L25-L27).
