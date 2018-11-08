Return-Path: <SRS0=04kl=NT=gmail.com=songqiang1304521@kernel.org>
From: Song Qiang <songqiang1304521@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	preid@electromag.com.au,
	himanshujha199640@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v6 2/3] iio: magnetometer: Add DT support for PNI RM3100
Date: Thu,  8 Nov 2018 17:27:48 +0800
Message-Id: <20181108092749.12167-3-songqiang1304521@gmail.com>
In-Reply-To: <20181108092749.12167-1-songqiang1304521@gmail.com>
References: <20181108092749.12167-1-songqiang1304521@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/magnetometer/pni,rm3100.txt  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
new file mode 100644
index 000000000000..497c932e9e39
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
@@ -0,0 +1,20 @@
+* PNI RM3100 3-axis magnetometer sensor
+
+Required properties:
+
+- compatible : should be "pni,rm3100"
+- reg : the I2C address or SPI chip select number of the sensor.
+
+Optional properties:
+
+- interrupts: data ready (DRDY) from the chip.
+  The interrupts can be triggered on level high.
+
+Example:
+
+rm3100: rm3100@20 {
+	compatible = "pni,rm3100";
+	reg = <0x20>;
+	interrupt-parent = <&gpio0>;
+	interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.17.1
