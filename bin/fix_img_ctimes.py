import hashlib
import os
from datetime import datetime as dt
from pathlib import Path

# see https://pypi.org/project/win32-setctime/
from win32_setctime import setctime


def fix_file(filepath: Path):
    tss = [
        filepath.stat().st_atime,
        filepath.stat().st_ctime,
        filepath.stat().st_mtime,
    ]

    # get lowest date
    ts = min(tss)
    date = dt.fromtimestamp(ts)
    # resolve duplicates by sha1 (also can use BLAKE2b)
    sha1 = hashlib.sha1(filepath.read_bytes())
    date_formated = date.strftime("%Y-%m-%d_%H-%M-%S-%f")

    new_filepath = Path(f'{date_formated}_{sha1.hexdigest()}{filepath.suffix}')

    print(f'Set ctime {filepath} {date_formated}')
    setctime(filepath.name, ts)

    if filepath == new_filepath:
        print(f'Same name, skip rename {filepath}')
        return

    if new_filepath.exists():
        print(f'ERROR! file {new_filepath.name} exists')
        return

    print(f'{filepath.name: <30} -> {new_filepath.name}')
    filepath = filepath.rename(new_filepath)


def fix_images(prompt=True):
    if os.name != 'nt':
        print(f"Only works in windows")
        exit(1)

    # manual CWD check
    if prompt:
        ans = input(f'CWD is {Path(".").absolute()} Continue? [y/n]').lower().strip()[0]
        if ans != 'y':
            exit(1)

    image_suffixes = [
        '.jpg',
        '.jpeg',
        '.png',
    ]
    images = [
        f for f in Path('.').glob('*') if f.is_file() and f.suffix in image_suffixes
    ]
    for image in images:
        fix_file(image)


def main():
    fix_images()


if __name__ == '__main__':
    main()
