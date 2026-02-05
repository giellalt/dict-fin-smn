"""Fix all attributes named `re` by converting them into a separate <re> element
immediately preceding the element that had the attribute.

Usage:
    python fix_re_attrs.py /path/to/V_finsmn.xml
If no path is given, uses the default repository path.
"""
from xml.etree import ElementTree as ET
from pathlib import Path
import shutil
import sys
import re

DEFAULT_PATH = "/Users/ttr000/git/giellalt/dict-fin-smn/src/V_finsmn.xml"

def fix_re_attributes(filepath: str):
    filepath = Path(filepath)
    if not filepath.exists():
        print(f"File not found: {filepath}")
        return
    # Backup original
    bak = filepath.with_suffix(filepath.suffix + ".bak")
    shutil.copy2(filepath, bak)
    print(f"Backup written to {bak}")

    text = filepath.read_text(encoding="utf-8")

    # 1) Convert any <t ... l_par="VALUE" ...> into: <re>VALUE</re>\n<t ... (without the re attribute)
    t_re = re.compile(r'(<t\b[^>]*?)\s+l_par="([^"]*)"([^>]*>)', flags=re.IGNORECASE)
    def _repl(m):
        start = m.group(1)   # part of <t ... before re
        val = m.group(2)     # re value
        rest = m.group(3)    # rest of attributes up to '>'
        return f'<re>{val}</re>\n{start}{rest}'
    text, count1 = t_re.subn(_repl, text)

    # 2) Fix common malformed <re> tags that end with a trailing '<' before the next tag,
    #    e.g. "<re>irti<\n   <t ...>" -> "<re>irti</re>\n<t ...>"
    malformed_re = re.compile(r'<re>([^<]*?)<\s*(?=<\w)', flags=re.DOTALL)
    text, count2 = malformed_re.subn(r'<re>\1</re>\n<', text)

    # 3) (Optional) small cleanup: remove any empty re elements (if produced)
    text, count3 = re.subn(r'\n*<re>\s*</re>\n*', '\n', text)

    # Write back if changes made
    total_changes = count1 + count2 + count3
    if total_changes:
        filepath.write_text(text, encoding="utf-8")
        print(f"Updated {filepath} — inserted {count1} <re> from attributes and fixed {count2} malformed <re> occurrences.")
    else:
        print("No re=\"...\" attributes or malformed <re> tags found; nothing changed.")

if __name__ == "__main__":
    path = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_PATH
    fix_re_attributes(path)
