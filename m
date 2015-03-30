Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:45409
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbbC3If1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2015 04:35:27 -0400
From: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH v3 2/5] iio: mlx90614: Add devicetree bindings documentation
Date: Mon, 30 Mar 2015 10:34:59 +0200
Message-Id: <1427704502-22347-3-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1427704502-22347-1-git-send-email-vianney.leclement@essensium.com>
References: <1427704502-22347-1-git-send-email-vianney.leclement@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Also introduce "melexis" as a vendor prefix for device tree bindings.

Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>

---

v3: new patch split out from v2 patch 6 (power management)
---
 .../devicetree/bindings/iio/temperature/mlx90614.txt      | 15 +++++++++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt     |  1 +
 2 files changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90614.txt

diff --git a/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
new file mode 100644
index 0000000..4c959f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
@@ -0,0 +1,15 @@
+* Melexis MLX90614 contactless IR temperature sensor
+
+http://melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
+
+Required properties:
+
+  - compatible: should be "melexis,mlx90614"
+  - reg: the I2C address of the sensor
+
+Example:
+
+mlx90614@5a {
+	compatible = "melexis,mlx90614";
+	reg = <0x5a>;
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index fae26d0..c8db30c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -110,6 +110,7 @@ lltc	Linear Technology Corporation
 marvell	Marvell Technology Group Ltd.
 maxim	Maxim Integrated Products
 mediatek	MediaTek Inc.
+melexis	Melexis N.V.
 merrii	Merrii Technology Co., Ltd.
 micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
-- 
2.3.4

