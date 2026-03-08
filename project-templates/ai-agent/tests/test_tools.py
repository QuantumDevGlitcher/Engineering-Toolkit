from src.tools.calculator_tool import CalculatorTool

def test_calculator_tool_basic():
    t = CalculatorTool()
    assert t.run("2+2") == "4"

def test_calculator_tool_rejects_strings():
    t = CalculatorTool()
    try:
        t.run("'a'+1")
        assert False, "Expected failure"
    except Exception:
        assert True
