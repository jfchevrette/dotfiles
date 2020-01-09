#!/usr/bin/env python

from argparse import ArgumentParser
from i3ipc import Connection


__version__ = '0.0.1'


def main(args):
    ipc = Connection()
    for window in ipc.get_tree():
        if args.all or window.focused:
            window.command('opacity ' + args.opacity)


if __name__ == '__main__':
    parser = ArgumentParser(description='Set opacity of current window(s)')

    parser.add_argument('opacity',
                        action='store',
                        default='1.0',
                        help='desired opacity between 0 and 1',
                        metavar='[0..1]',
                        nargs='?')

    parser.add_argument('-a',
                        '--all',
                        action='store_true',
                        dest='all',
                        help='set opacity for all windows')

    parser.add_argument(
        '--version',
        action='version',
        version='%(prog)s (version {version})'.format(version=__version__))

    args = parser.parse_args()
    main(args)
