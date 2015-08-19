Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53368 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbbHSJIG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 19 Aug 2015 05:08:06 -0400
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net, daniel.baluta@intel.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH  v4 2/2] devicetree: Add documentation for UPISEMI us5182d ALS and Proximity sensor
Date: Wed, 19 Aug 2015 12:07:53 +0300
Message-Id: <1439975273-16387-3-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1439975273-16387-1-git-send-email-adriana.reus@intel.com>
References: <1439975273-16387-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added entries in i2c/vendor-prefixes for the us5182d als and proximity sensor.
Also added a documentation file for this sensor's properties.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 Changes since v3:
 * Added more specific description for the optional properties
 * Removed an extra newline

 .../devicetree/bindings/iio/light/us5182d.txt      | 23 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/us5182d.txt

diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt b/Documentation/devicetree/bindings/iio/light/us5182d.txt
new file mode 100644
index 0000000..7785c56
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/us5182d.txt
@@ -0,0 +1,23 @@
+* UPISEMI us5182d I2C ALS and Proximity sensor
+
+Required properties:
+- compatible: must be "upisemi,usd5182"
+- reg: the I2C address of the device
+
+Optional properties:
+- upisemi,glass-coef: glass attenuation factor
+- upisemi,dark-ths: array of thresholds (adc counts) corresponding to every scale
+- upisemi,upper-dark-gain: tuning factor(4 int and 4 fractional bits - Q4.4) applied when light > threshold
+- upisemi,lower-dark-gain: tuning factor(4 int and 4 fractional bits - Q4.4) applied when light < threshold
+
+Example:
+
+    usd5182@39 {
+                compatible = "upisemi,usd5182";
+                reg = <0x39>;
+                upisemi,glass-coef = < 1000 >;
+                upisemi,dark-ths = /bits/ 16 <170 200 512 512 800 2000 4000 8000>;
+                upisemi,upper-dark-gain = /bits/ 8 <0x00>;
+                upisemi,lower-dark-gain = /bits/ 8 <0x16>;
+    };
+
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index d444757..5b40bab 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -211,6 +211,7 @@ toshiba	Toshiba Corporation
 toumaz	Toumaz
 tplink	TP-LINK Technologies Co., Ltd.
 truly	Truly Semiconductors Limited
+upisemi	uPI Semiconductor Corp.
 usi	Universal Scientific Industrial Co., Ltd.
 v3	V3 Semiconductor
 variscite	Variscite Ltd.
-- 
1.9.1

