Return-Path: <dmurphy@ti.com>
From: Dan Murphy <dmurphy@ti.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 2/3] iio: bindings: Add TI afe4403 heart monitor documentation
Date: Mon, 11 May 2015 15:05:25 -0500
Message-ID: <1431374726-23383-3-git-send-email-dmurphy@ti.com>
In-Reply-To: <1431374726-23383-1-git-send-email-dmurphy@ti.com>
References: <1431374726-23383-1-git-send-email-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add the TI afe4403 heart monitor device tree
binding documentation.  health directory
created under iio.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/iio/health/ti_afe4403.txt  | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/ti_afe4403.txt

diff --git a/Documentation/devicetree/bindings/iio/health/ti_afe4403.txt b/Documentation/devicetree/bindings/iio/health/ti_afe4403.txt
new file mode 100644
index 0000000..b196b17
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/health/ti_afe4403.txt
@@ -0,0 +1,26 @@
+* Texas Instruments - AFE4403 Heart rate and Pulse Oximeter
+
+The device consists of a low-noise receiver channel
+with an integrated analog-to-digital converter (ADC),
+an LED transmit section, and diagnostics for sensor and LED fault detection.
+
+Required properties:
+  - compatible: Must contain "ti,afe4403".
+  - ste-gpio: GPIO for the spi control line
+  - data-ready-gpio: GPIO interrupt when the afe4403 has data
+  - led-supply: Chip supply to the device
+
+Optional properties:
+  - reset-gpio: GPIO used to reset the device via HW
+
+Example:
+
+&heart_rate {
+	compatible = "ti,afe4403";
+	ste-gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
+	data-ready-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	led-supply = <&vbat>;
+};
+
+Technical Datasheet:
+http://www.ti.com/product/AFE4403/datasheet
-- 
1.9.1
