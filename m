Return-Path: <SRS0=MDWi=26=google.com=raltherr@kernel.org>
From: Rick Altherr <raltherr@google.com>
To: openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Rob Herring <robh+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 1/2] Documentation: dt-bindings: Document bindings for Aspeed AST2400/AST2500 ADC
Date: Tue, 21 Mar 2017 13:48:27 -0700
Message-Id: <20170321204828.31303-1-raltherr@google.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Rick Altherr <raltherr@google.com>
---

Changes in v2:
- Rewritten as an IIO ADC device

 .../devicetree/bindings/iio/adc/aspeed_adc.txt       | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
new file mode 100644
index 000000000000..7748c2c2ad0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
@@ -0,0 +1,20 @@
+Aspeed AST2400/2500 ADC
+
+This device is a 10-bit converter for 16 voltage channels.  All inputs are
+single ended.
+
+Required properties:
+- compatible: Should be "aspeed,ast2400-adc" or "aspeed,ast2500-adc"
+- reg: memory window mapping address and length
+- clocks: Input clock used to derive the sample clock. Expected to be the
+          SoC's APB clock.
+- #io-channel-cells: Must be set to <1> to indicate channels are selected
+                     by index.
+
+Example:
+	adc@1e6e9000 {
+		compatible = "aspeed,ast2400-adc";
+		reg = <0x1e6e9000 0xB0>;
+		clocks = <&clk_apb>;
+		#io-channel-cells = <1>;
+	};
-- 
2.12.1.500.gab5fba24ee-goog
