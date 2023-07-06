#!/usr/bin/env bash

BUILDDIR=${PWD}

# Python virtual environment
cd ${BUILDDIR}
/usr/local/bin/python3.9 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install install -r requirements.txt

# QCEngine
cd ${BUILDDIR}
git clone https://github.com/MolSSI/QCEngine.git

# QCElemental
cd ${BUILDDIR}
git clone https://github.com/MolSSI/QCElemental.git
cd QCElemental
git checkout v0.25.1

# Special GAMESS branch for QCEngine
cd ${BUILDDIR}
if [ ! -f ${BUILDDIR}/gamess-qcengine/gamess.00.x]
then
   git clone git@github.com:gms-bbg/gamess.git gamess-qcengine
   cd gamess-qcengine
   git checkout saromleang/qcengine
   ./bin/create-install-info.py --gfortran --mkl --sockets --fortran_version=5.5.0 --qcengine \
   --rungms \
   --restart=${HOME}/restart \
   --scratch=${HOME}/scratch
   make -j8
fi
# PATHS
export PYTHONPATH=${BUILDDIR}/QCEngine:${BUILDDIR}/QCElemental:${PYTHONPATH}
export PATH=${BUILDDIR}/gamess-qcengine:${PATH}

# Test
cd ${BUILDDIR}
python test-qcengine-gamess.py
