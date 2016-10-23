Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32781 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756632AbcJWPTa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2016 11:19:30 -0400
From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
        linux-iio@vger.kernel.org, harald@ccbib.org,
        stefan.wahren@i2se.com, fabio.estevam@freescale.com,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v8 5/5] mfd: Move binding document
Date: Sun, 23 Oct 2016 17:19:01 +0200
Message-Id: <8dd0d136619121e5c89566550b81680b238380a5.1477235446.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1477235446.git.ksenija.stanojevic@gmail.com>
References: <cover.1477235446.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1477235446.git.ksenija.stanojevic@gmail.com>
References: <cover.1477235446.git.ksenija.stanojevic@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The bindings, which are now used in MFD, need also to be
documented in the MFD binding document.

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
---
Changes in v8:
 - rebase onto 4.9-rc1

Changes in v7:
 - add to the patchset

 .../devicetree/bindings/iio/adc/mxs-lradc.txt      | 47 ----------------------
 .../devicetree/bindings/mfd/mxs-lradc.txt          | 47 ++++++++++++++++++++++
 2 files changed, 47 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/mxs-lradc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
deleted file mode 100644
index 555fb11..0000000
--- a/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
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
diff --git a/Documentation/devicetree/bindings/mfd/mxs-lradc.txt b/Documentation/devicetree/bindings/mfd/mxs-lradc.txt
new file mode 100644
index 0000000..555fb11
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mxs-lradc.txt
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
-- 
1.9.1

