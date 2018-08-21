Return-Path: <SRS0=0k+x=LE=gmail.com=marcus.folkesson@kernel.org>
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: iio: dac: add bindings for ltc1660
Date: Tue, 21 Aug 2018 21:31:25 +0200
Message-Id: <20180821193126.15733-2-marcus.folkesson@gmail.com>
In-Reply-To: <20180821193126.15733-1-marcus.folkesson@gmail.com>
References: <20180821193126.15733-1-marcus.folkesson@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

LTC1665/LTC1660 is a 8/10-bit Digital-to-Analog Converter (DAC)
with eight individual channels.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
    	- rename file, ltc166x -> ltc1660

 .../devicetree/bindings/iio/dac/ltc1660.txt         | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc1660.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ltc1660.txt b/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
new file mode 100644
index 000000000000..c5b5f22d6c64
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ltc1660.txt
@@ -0,0 +1,21 @@
+* Linear Technology Micropower octal 8-Bit and 10-Bit DACs
+
+Required properties:
+ - compatible: Must be one of the following:
+		"lltc,ltc1660"
+		"lltc,ltc1665"
+ - reg: SPI chip select number for the device
+ - vref-supply: Phandle to the voltage reference supply
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+	 Documentation/devicetree/bindings/spi/spi-bus.txt.
+	 Max frequency for this chip is 5 MHz.
+
+Example:
+dac@0 {
+	compatible = "lltc,ltc1660";
+	reg = <0>;
+	spi-max-frequency = <5000000>;
+	vref-supply = <&vref_reg>;
+};
-- 
2.11.0.rc2
