Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:30846 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422778AbcBQRxv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 17 Feb 2016 12:53:51 -0500
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>,
	=?UTF-8?q?Gr=C3=A9gor=20Boirie?= <gregor.boirie@parrot.com>
Subject: [PATCH v3 4/6] iio:pressure:ms5611: DT bindings documentation
Date: Wed, 17 Feb 2016 18:52:52 +0100
Message-ID: <b94c67ed8d9148707e4b613c747fc654c52c62d3.1455731233.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1455731233.git.gregor.boirie@parrot.com>
References: <cover.1455731233.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Grégor Boirie <gregor.boirie@parrot.com>

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 .../devicetree/bindings/iio/pressure/ms5611.txt       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5611.txt

diff --git a/Documentation/devicetree/bindings/iio/pressure/ms5611.txt b/Documentation/devicetree/bindings/iio/pressure/ms5611.txt
new file mode 100644
index 0000000..986415a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/ms5611.txt
@@ -0,0 +1,19 @@
+MEAS ms5611 family pressure sensors
+
+Pressure sensors from MEAS Switzerland with SPI and I2C bus interfaces.
+
+Required properties:
+- compatible: "ms5611" or "ms5607"
+- reg: the I2C or SPI address the device will respond to
+
+Optional properties:
+- vdd-supply: an optional regulator that needs to be on to provide VDD
+  power to the sensor.
+
+Example:
+
+ms5607@77 {
+	compatible = "ms5607";
+	reg = <0x77>;
+	vdd-supply = <&ldo_3v3_gnss>;
+};
-- 
2.1.4

