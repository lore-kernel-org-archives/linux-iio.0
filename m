Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f173.google.com ([209.85.210.173]:35526 "EHLO
        mail-wj0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbcLFNvH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2016 08:51:07 -0500
Received: by mail-wj0-f173.google.com with SMTP id v7so321590496wjy.2
        for <linux-iio@vger.kernel.org>; Tue, 06 Dec 2016 05:51:06 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 1/3] iio: adc: add device tree bindings for Qualcomm PM8xxx ADCs
Date: Tue,  6 Dec 2016 14:50:53 +0100
Message-Id: <1481032253-27019-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds the device tree bindings for the Qualcomm PM8xxx
ADCs. This is based on the existing DT bindings for the
SPMI ADC so there are hopefully no controversial features.

Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: Ivan T. Ivanov <iivanov.xz@gmail.com>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/iio/adc/qcom,pm8xxx-xoadc.txt         | 160 +++++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
new file mode 100644
index 000000000000..6e51e3e74b88
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
@@ -0,0 +1,160 @@
+Qualcomm's PM8xxx voltage XOADC
+
+The Qualcomm PM8xxx PMICs contain a HK/XO ADC (Housekeeping/Chrystal
+oscillator ADC) encompass PM8018, PM8038, PM8058, PM8917 and PM8921.
+
+Required properties:
+
+- compatible: should be one of:
+  "qcom,pm8018-adc"
+  "qcom,pm8038-adc"
+  "qcom,pm8058-adc"
+  "qcom,pm8917-adc"
+  "qcom,pm8921-adc"
+
+- reg: should contain the ADC base address in the PMIC, typically
+  0x197.
+
+The following required properties are standard for IO channels, see
+iio-bindings.txt for more details:
+
+- #address-cells: should be set to <1>
+
+- #size-cells: should be set to <0>
+
+- #io-channel-cells: should be set to <1>
+
+- interrupts: should refer to the parent PMIC interrupt controller
+  and reference the proper ADC interrupt.
+
+Required subnodes:
+
+The ADC channels are configured as subnodes of the ADC. Since some of
+them are used for calibrating the ADC, these nodes are compulsory:
+
+ref_625mv {
+	reg = <0x0c>;
+};
+
+ref_1250mv {
+	reg = <0x0d>;
+};
+
+ref_muxoff {
+	reg = <0x0f>;
+};
+
+These three nodes are used for absolute and ratiometric calibration
+and only need to have these reg values: they are by hardware defined
+to be 1:1 ratio converters that sample 625, 1250 and 0 V and create
+an interpolation calibration for all other ADCs.
+
+Optional subnodes: any channels other than channel 0x0c, 0x0d and
+0x0f are optional.
+
+Required channel node properties:
+
+- reg: should contain the hardware channel number in the range
+  0 .. 0x0f (4 bits). The hardware only supports 16 channels.
+
+Optional channel node properties:
+
+- qcom,decimation:
+  Value type: <u32>
+  Definition: This parameter is used to decrease ADC sampling rate.
+          Quicker measurements can be made by reducing decimation ratio.
+          Valid values are 512, 1024, 2048, 4096.
+          If property is not found, default value of 512 will be used.
+
+- qcom,ratiometric:
+  Value type: <empty>
+  Definition: Channel calibration type. If this property is specified
+          VADC will use the VDD reference (1.8V) and GND for channel
+          calibration. If property is not found, channel will be
+          calibrated with 0.625V and 1.25V reference channels, also
+          known as absolute calibration.
+
+- qcom,ratiometric-ref:
+  Value type: <u32>
+  Definition: The reference voltage pair when using ratiometric
+          calibration:
+	  0 = XO_IN/XOADC_GND
+	  1 = PMIC_IN/XOADC_GND
+	  2 = PMIC_IN/BMS_CSP
+	  3 (invalid)
+	  4 = XOADC_GND/XOADC_GND
+	  5 = XOADC_VREF/XOADC_GND
+
+Example:
+
+xoadc: xoadc@197 {
+	compatible = "qcom,pm8058-adc";
+	reg = <0x197>;
+	interrupt-parent = <&pm8058>;
+	interrupts = <76 1>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	#io-channel-cells = <1>;
+
+	vcoin {
+		reg = <0x00>;
+	};
+	vbat {
+		reg = <0x01>;
+	};
+	dcin {
+		reg = <0x02>;
+	};
+	ichg {
+		reg = <0x03>;
+	};
+	vph_pwr {
+		reg = <0x04>;
+	};
+	mpp5 {
+		reg = <0x05>;
+	};
+	mpp6 {
+		reg = <0x06>;
+	};
+	mpp7 {
+		reg = <0x07>;
+	};
+	mpp8 {
+		reg = <0x08>;
+	};
+	mpp9 {
+		reg = <0x09>;
+	};
+	usb_vbus {
+		reg = <0x0a>;
+	};
+	die_temp {
+		reg = <0x0b>;
+	};
+	ref_625mv {
+		reg = <0x0c>;
+	};
+	ref_1250mv {
+		reg = <0x0d>;
+	};
+	ref_325mv {
+		reg = <0x0e>;
+	};
+	ref_muxoff {
+		reg = <0x0f>;
+	};
+};
+
+
+/* IIO client node */
+iio-hwmon {
+	compatible = "iio-hwmon";
+	io-channels = <&xoadc 0x01>, /* Battery */
+		    <&xoadc 0x02>, /* DC in (charger) */
+		    <&xoadc 0x04>, /* VPH the main system voltage */
+		    <&xoadc 0x0b>, /* Die temperature */
+		    <&xoadc 0x0c>, /* Reference voltage 1.25V */
+		    <&xoadc 0x0d>, /* Reference voltage 0.625V */
+		    <&xoadc 0x0e>; /* Reference voltage 0.325V */
+};
-- 
2.7.4

