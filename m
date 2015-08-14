Return-Path: <adriana.reus@intel.com>
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net,
	daniel.baluta@intel.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH 2/2] devicetree: Add documentation for UPISEMI us5182d ALS and Proximity sensor
Date: Fri, 14 Aug 2015 12:17:41 +0300
Message-Id: <1439543861-20768-3-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1439543861-20768-1-git-send-email-adriana.reus@intel.com>
References: <1439543861-20768-1-git-send-email-adriana.reus@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added entries in trivial-devices and i2c/vendor-prefixes for
the us5182d als and proximity sensor. Also added a documentation file for
this sensor's properties.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 .../devicetree/bindings/i2c/trivial-devices.txt    |  1 +
 .../devicetree/bindings/iio/light/us5182d.txt      | 24 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 3 files changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/us5182d.txt

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 00f8652..96d3b9c 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -99,4 +99,5 @@ ti,tsc2003		I2C Touch-Screen Controller
 ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
 ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
 ti,tmp275		Digital Temperature Sensor
+upisemi,usd5182		Als and Proximity Sensor
 winbond,wpct301		i2c trusted platform module (TPM)
diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt b/Documentation/devicetree/bindings/iio/light/us5182d.txt
new file mode 100644
index 0000000..9ac3336
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/us5182d.txt
@@ -0,0 +1,24 @@
+* UPISEMI us5182d I2C ALS and Proximity sensor
+
+Required properties:
+- compatible: must be "upisemi,usd5182"
+- reg: the I2C address of the device
+
+Optional properties:
+- upisemi,glass-coef: glass attenuation factor
+- upisemi,dark-ths: array of thresholds corresponding to every scale
+- upisemi,upper-dark-gain: tuning factor applied when light > th
+- upisemi,lower-dark-gain: tuning factor applied when light < th
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
