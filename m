Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:44882 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbcDJNLO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 10 Apr 2016 09:11:14 -0400
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCH] iio: mxs-lradc: Move binding document out of staging as well
Date: Sun, 10 Apr 2016 13:03:18 +0000
Message-Id: <1460293398-23654-1-git-send-email-harald@ccbib.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

commit f836c45922446df872250a12dd08e48978aceb2f moved mxs-lradc driver
out of staging. However the binding document was left in the old place.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 .../devicetree/bindings/iio/adc/mxs-lradc.txt      | 47 ++++++++++++++++++++++
 .../bindings/staging/iio/adc/mxs-lradc.txt         | 47 ----------------------
 2 files changed, 47 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
 delete mode 100644 Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
new file mode 100644
index 0000000..555fb11
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
@@ -0,0 +1,47 @@
+* Freescale MXS LRADC device driver
+
+Required properties:
+- compatible: Should be "fsl,imx23-lradc" for i.MX23 SoC and "fsl,imx28-lradc"
+              for i.MX28 SoC
+- reg: Address and length of the register set for the device
+- interrupts: Should contain the LRADC interrupts
+
+Optional properties:
+- fsl,lradc-touchscreen-wires: Number of wires used to connect the touchscreen
+                               to LRADC. Valid value is either 4 or 5. If this
+                               property is not present, then the touchscreen is
+                               disabled. 5 wires is valid for i.MX28 SoC only.
+- fsl,ave-ctrl: number of samples per direction to calculate an average value.
+                Allowed value is 1 ... 32, default is 4
+- fsl,ave-delay: delay between consecutive samples. Allowed value is
+                 2 ... 2048. It is used if 'fsl,ave-ctrl' > 1, counts at
+                 2 kHz and its default is 2 (= 1 ms)
+- fsl,settling: delay between plate switch to next sample. Allowed value is
+                1 ... 2047. It counts at 2 kHz and its default is
+                10 (= 5 ms)
+
+Example for i.MX23 SoC:
+
+	lradc@80050000 {
+		compatible = "fsl,imx23-lradc";
+		reg = <0x80050000 0x2000>;
+		interrupts = <36 37 38 39 40 41 42 43 44>;
+		status = "okay";
+		fsl,lradc-touchscreen-wires = <4>;
+		fsl,ave-ctrl = <4>;
+		fsl,ave-delay = <2>;
+		fsl,settling = <10>;
+	};
+
+Example for i.MX28 SoC:
+
+	lradc@80050000 {
+		compatible = "fsl,imx28-lradc";
+		reg = <0x80050000 0x2000>;
+		interrupts = <10 14 15 16 17 18 19 20 21 22 23 24 25>;
+		status = "okay";
+		fsl,lradc-touchscreen-wires = <5>;
+		fsl,ave-ctrl = <4>;
+		fsl,ave-delay = <2>;
+		fsl,settling = <10>;
+	};
diff --git a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
deleted file mode 100644
index 555fb11..0000000
--- a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* Freescale MXS LRADC device driver
-
-Required properties:
-- compatible: Should be "fsl,imx23-lradc" for i.MX23 SoC and "fsl,imx28-lradc"
-              for i.MX28 SoC
-- reg: Address and length of the register set for the device
-- interrupts: Should contain the LRADC interrupts
-
-Optional properties:
-- fsl,lradc-touchscreen-wires: Number of wires used to connect the touchscreen
-                               to LRADC. Valid value is either 4 or 5. If this
-                               property is not present, then the touchscreen is
-                               disabled. 5 wires is valid for i.MX28 SoC only.
-- fsl,ave-ctrl: number of samples per direction to calculate an average value.
-                Allowed value is 1 ... 32, default is 4
-- fsl,ave-delay: delay between consecutive samples. Allowed value is
-                 2 ... 2048. It is used if 'fsl,ave-ctrl' > 1, counts at
-                 2 kHz and its default is 2 (= 1 ms)
-- fsl,settling: delay between plate switch to next sample. Allowed value is
-                1 ... 2047. It counts at 2 kHz and its default is
-                10 (= 5 ms)
-
-Example for i.MX23 SoC:
-
-	lradc@80050000 {
-		compatible = "fsl,imx23-lradc";
-		reg = <0x80050000 0x2000>;
-		interrupts = <36 37 38 39 40 41 42 43 44>;
-		status = "okay";
-		fsl,lradc-touchscreen-wires = <4>;
-		fsl,ave-ctrl = <4>;
-		fsl,ave-delay = <2>;
-		fsl,settling = <10>;
-	};
-
-Example for i.MX28 SoC:
-
-	lradc@80050000 {
-		compatible = "fsl,imx28-lradc";
-		reg = <0x80050000 0x2000>;
-		interrupts = <10 14 15 16 17 18 19 20 21 22 23 24 25>;
-		status = "okay";
-		fsl,lradc-touchscreen-wires = <5>;
-		fsl,ave-ctrl = <4>;
-		fsl,ave-delay = <2>;
-		fsl,settling = <10>;
-	};
-- 
2.1.4

