import json
from pathlib import Path
import unittest

class TestDataJson(unittest.TestCase):
    def test_loads_and_has_personal_info(self):
        data_file = Path(__file__).resolve().parents[1] / 'data' / 'data.json'
        with data_file.open() as f:
            data = json.load(f)
        # Ensure required key exists
        self.assertIn('personalInfo', data)

if __name__ == '__main__':
    unittest.main()
