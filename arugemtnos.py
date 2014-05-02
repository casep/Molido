#!/usr/bin/env python
import argparse
parser = argparse.ArgumentParser(prog='PROG')
parser.add_argument('--foo', help='foo help', type=int, required=True)
parser.add_argument('--bar', help='bar help')
args = parser.parse_args()

print args.foo
