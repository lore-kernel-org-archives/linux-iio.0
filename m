Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35721 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752709AbbIPIPQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Sep 2015 04:15:16 -0400
From: Adriana Reus <adriana.reus@intel.com>
To: robherring2@gmail.com, jic23@kernel.org
Cc: pmeerw@pmeerw.net, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, Adriana Reus <adriana.reus@intel.com>
Subject: [v7 PATCH 2/2] devicetree: Add documentation for UPISEMI us5182d ALS and Proximity sensor
Date: Wed, 16 Sep 2015 11:14:12 +0300
Message-Id: <1442391252-7368-3-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1442391252-7368-1-git-send-email-adriana.reus@intel.com>
References: <1442391252-7368-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added entries in i2c/vendor-prefixes for the us5182d als and proximity sensor.
Also added a documentation file for this sensor's properties.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 Changes since v6:
 * Added some aditional clarifications on the optional
   properties, as suggested by Rob.

 .../devicetree/bindings/iio/light/us5182d.txt      | 34 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/us5182d.txt

diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt b/Documentation/devicetree/bindings/iio/light/us5182d.txt
new file mode 100644
index 0000000..6f0a530
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/us5182d.txt
@@ -0,0 +1,34 @@
+* UPISEMI us5182d I2C ALS and Proximity sensor
+
+Required properties:
+- compatible: must be "upisemi,usd5182"
+- reg: the I2C address of the device
+
+Optional properties:
+- upisemi,glass-coef: glass attenuation factor - compensation factor of
+                      resolution 1000 for material transmittance.
+- upisemi,dark-ths: array of 8 elements containing 16-bit thresholds (adc
+                    counts) corresponding to every scale.
+- upisemi,upper-dark-gain: 8-bit dark gain compensation factor(4 int and 4
+                           fractional bits - Q4.4) applied when light > threshold
+- upisemi,lower-dark-gain: 8-bit dark gain compensation factor(4 int and 4
+                           fractional bits - Q4.4) applied when light < threshold
+
+If the optional properties are not specified these factors will default to the
+values in the below example.
+The glass-coef defaults to no compensation for the covering material.
+The threshold array defaults to experimental values that work with US5182D
+sensor on evaluation board - roughly between 12-32 lux.
+There will be no dark-gain compensation by default when ALS > thresh
+(0 * dark-gain), and a 1.35 compensation factor when ALS < thresh.
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
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 341695b..85ba915 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -213,6 +213,7 @@ toshiba	Toshiba Corporation
 toumaz	Toumaz
 tplink	TP-LINK Technologies Co., Ltd.
 truly	Truly Semiconductors Limited
+upisemi	uPI Semiconductor Corp.
 usi	Universal Scientific Industrial Co., Ltd.
 v3	V3 Semiconductor
 variscite	Variscite Ltd.
-- 
1.9.1

