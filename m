Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34228 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbdAQOe3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2017 09:34:29 -0500
Received: by mail-lf0-f54.google.com with SMTP id v186so109363051lfa.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2017 06:34:28 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rama Krishna Phani A <rphani@codeaurora.org>
Subject: [PATCH 1/3 v3] iio: adc: add device tree bindings for Qualcomm PM8xxx ADCs
Date: Tue, 17 Jan 2017 15:25:13 +0100
Message-Id: <20170117142515.10578-1-linus.walleij@linaro.org>
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
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rama Krishna Phani A <rphani@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Collapse the ratiometric property into one that enables and
  selects a ratiometric reference in one go.
- Use foo: adc-channel@X notation consequently
- Document that the reference voltage is compulsory.
ChangeLog v1->v2:
- Spelling fixes
---
 .../bindings/iio/adc/qcom,pm8xxx-xoadc.txt         | 149 +++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
new file mode 100644
index 000000000000..53cd146d8096
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
@@ -0,0 +1,149 @@
+Qualcomm's PM8xxx voltage XOADC
+
+The Qualcomm PM8xxx PMICs contain a HK/XO ADC (Housekeeping/Crystal
+oscillator ADC) encompassing PM8018, PM8038, PM8058 and PM8921.
+
+Required properties:
+
+- compatible: should be one of:
+  "qcom,pm8018-adc"
+  "qcom,pm8038-adc"
+  "qcom,pm8058-adc"
+  "qcom,pm8921-adc"
+
+- reg: should contain the ADC base address in the PMIC, typically
+  0x197.
+
+- xoadc-ref-supply: should reference a regulator that can supply
+  a reference voltage on demand. The reference voltage may vary
+  with PMIC variant but is typically something like 2.2 or 1.8V.
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
+adc-channel@c {
+	reg = <0x0c>;
+};
+
+adc-channel@d {
+	reg = <0x0d>;
+};
+
+adc-channel@f {
+	reg = <0x0f>;
+};
+
+These three nodes are used for absolute and ratiometric calibration
+and only need to have these reg values: they are by hardware definition
+1:1 ratio converters that sample 625, 1250 and 0 milliV and create
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
+  Definition: This parameter is used to decrease the ADC sampling rate.
+          Quicker measurements can be made by reducing the decimation ratio.
+          Valid values are 512, 1024, 2048, 4096.
+          If the property is not found, a default value of 512 will be used.
+
+- qcom,ratiometric:
+  Value type: <u32>
+  Definition: Channel calibration type. If this property is specified
+          VADC will use a special voltage references for channel
+          calibration. The available references are specified in the
+	  as a u32 value setting (see below) and it is compulsory
+	  to also specify this reference if ratiometric calibration
+	  is selected.
+
+	  If the property is not found, the channel will be
+          calibrated with the 0.625V and 1.25V reference channels, also
+          known as an absolute calibration.
+  The reference voltage pairs when using ratiometric calibration:
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
+	vcoin: adc-channel@0 {
+		reg = <0x00>;
+	};
+	vbat: adc-channel@1 {
+		reg = <0x01>;
+	};
+	dcin: adc-channel@2 {
+		reg = <0x02>;
+	};
+	ichg: adc-channel@3 {
+		reg = <0x03>;
+	};
+	vph_pwr: adc-channel@4 {
+		reg = <0x04>;
+	};
+	usb_vbus: adc-channel@a {
+		reg = <0x0a>;
+	};
+	die_temp: adc-channel@b {
+		reg = <0x0b>;
+	};
+	ref_625mv: adc-channel@c {
+		reg = <0x0c>;
+	};
+	ref_1250mv: adc-channel@d {
+		reg = <0x0d>;
+	};
+	ref_325mv: adc-channel@e {
+		reg = <0x0e>;
+	};
+	ref_muxoff: adc-channel@f {
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
2.9.3

