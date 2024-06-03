class UnsupportedOrderType(Exception):
    def __init__(self, type):
        self.type = type
        super().__init__(f"Unsupported filter operation: {type}")