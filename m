Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	marex@denx.de,
	linux-pm@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 1/2] iio: light: DT binding docs for APDS9960 driver
Date: Sun, 12 Jul 2015 19:20:42 -0700
Message-Id: <1436754043-6232-2-git-send-email-mranostay@gmail.com>
In-Reply-To: <1436754043-6232-1-git-send-email-mranostay@gmail.com>
References: <1436754043-6232-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Document compatible string, and required DT properties for APDS9960
chipset driver.

Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 .../devicetree/bindings/iio/light/apds9960.txt        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/apds9960.txt

diff --git a/Documentation/devicetree/bindings/iio/light/apds9960.txt b/Documentation/devicetree/bindings/iio/light/apds9960.txt
new file mode 100644
index 0000000..7a47d28
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/apds9960.txt
@@ -0,0 +1,19 @@
+* Avago APDS9960 gesture/RGB/ALS/proximity sensor
+
+http://www.avagotech.com/docs/AV02-4191EN
+
+Required properties:
+
+  - compatible: must be "avago,apds9960"
+  - reg: the I2c address of the sensor
+  - interrupt-parent: should be the phandle for the interrupt controller
+  - interrupts: interrupt mapping for GPIO IRQ
+
+Example:
+
+apds9960@39 {
+	compatible = "avago,apds9960";
+	reg = <0x39>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <16 1>;
+};
-- 
1.9.1
