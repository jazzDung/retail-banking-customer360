class UnsupportedFilterOperation(Exception):
    def __init__(self, operation):
        self.operation = operation
        super().__init__(f"Unsupported filter operation: {operation}")