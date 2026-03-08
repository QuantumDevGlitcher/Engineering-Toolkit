import ast
import operator as op

_ALLOWED_OPS = {
    ast.Add: op.add,
    ast.Sub: op.sub,
    ast.Mult: op.mul,
    ast.Div: op.truediv,
    ast.Pow: op.pow,
    ast.USub: op.neg,
}

def _safe_eval(node):
    if isinstance(node, ast.Num):  # Python < 3.8
        return node.n
    if isinstance(node, ast.Constant):  # Python >= 3.8
        if isinstance(node.value, (int, float)):
            return node.value
        raise ValueError("Only numbers allowed")

    if isinstance(node, ast.BinOp) and type(node.op) in _ALLOWED_OPS:
        return _ALLOWED_OPS[type(node.op)](_safe_eval(node.left), _safe_eval(node.right))

    if isinstance(node, ast.UnaryOp) and type(node.op) in _ALLOWED_OPS:
        return _ALLOWED_OPS[type(node.op)](_safe_eval(node.operand))

    raise ValueError("Unsupported expression")

class CalculatorTool:
    name = "calculator"

    def run(self, expression: str) -> str:
        tree = ast.parse(expression, mode="eval")
        result = _safe_eval(tree.body)
        return str(result)
