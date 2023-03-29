import qcengine as qcng
import qcelemental as qcel

mol = qcel.models.Molecule.from_data("""
O  0.0  0.000  -0.129
H  0.0 -1.494  1.027
H  0.0  1.494  1.027
""")

inp = qcel.models.AtomicInput(
    molecule=mol,
    driver="energy",
    model={"method": "SCF", "basis": "midi"}
    )

ret = qcng.compute(inp, "gamess")

print(ret)

print(ret.return_result)
print(ret.provenance.cpu)

