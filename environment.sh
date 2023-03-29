#!/usr/bin/env bash

BUILDDIR=${PWD}
cd ${BUILDDIR}
source venv/bin/activate
export PYTHONPATH=${BUILDDIR}/QCEngine:${BUILDDIR}/QCElemental:${PYTHONPATH}
export PATH=${BUILDDIR}/gamess-qcengine:${PATH}

