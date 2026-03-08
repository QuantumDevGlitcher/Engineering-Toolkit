from src.pipelines.evaluation_pipeline import EvaluationPipeline

def test_eval_pipeline_smoke(tmp_path):
    p = tmp_path / "smoke.jsonl"
    p.write_text('{"id":"1","input":"2+2","expected_contains":["2"]}\n', encoding="utf-8")

    runner = lambda s: f"output:{s}"
    ev = EvaluationPipeline(runner)
    res = ev.run_jsonl(str(p))
    assert res[0]["ok"] is True
