Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40336 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755381AbaJNTOA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 14 Oct 2014 15:14:00 -0400
From: Dan Murphy <dmurphy@ti.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [RFC Patch 2/3] iio: bindings: Add TI afe4403 heart monitor documentation
Date: Tue, 14 Oct 2014 14:13:51 -0500
Message-ID: <1413314032-923-3-git-send-email-dmurphy@ti.com>
In-Reply-To: <1413314032-923-1-git-send-email-dmurphy@ti.com>
References: <1413314032-923-1-git-send-email-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add the TI afe4403 heart monitor device tree
binding documentation.  heart_monitors directory
created under iio.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/iio/heart_monitors/ti_afe4403.txt     |   23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/heart_monitors/ti_afe4403.txt

diff --git a/Documentation/devicetree/bindings/iio/heart_monitors/ti_afe4403.txt b/Documentation/devicetree/bindings/iio/heart_monitors/ti_afe4403.txt
new file mode 100644
index 0000000..d612dd6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/heart_monitors/ti_afe4403.txt
@@ -0,0 +1,23 @@
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
+  - 
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
-- 
1.7.9.5

