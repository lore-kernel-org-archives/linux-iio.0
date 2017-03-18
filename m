Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35503 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbdCRNmD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2017 09:42:03 -0400
Received: by mail-lf0-f54.google.com with SMTP id j90so42100912lfk.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2017 06:41:07 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5] ARM: dts: add XOADC and IIO HWMON to MSM8660/APQ8060
Date: Sat, 18 Mar 2017 14:34:34 +0100
Message-Id: <20170318133434.22468-1-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds the PM8058 XOADC node to the PM8058 PMIC node,
defines the 16 channels and further also define an IIO HWMON
node for the channels that are used for housekeeping of
voltages and die temperature for the PMIC chip die.

Tested on the APQ8060 DragonBoard:
cd /sys/class/hwmon/hwmon0
cat in2_input
4773 (DC mains ~5V)
cat in4_input
625  (0.625V reference voltage)
cat in5_input
1250 (1.25V reference voltage)
cat temp1_input
35852 (die temperature)

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v5:
- Switch to the twocell addressing scheme specified in the new
  bindings.
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 59 +++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 91c9a62ae725..3934a123b182 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -63,6 +63,22 @@
 		};
 	};
 
+	/*
+	 * These channels from the ADC are simply hardware monitors.
+	 * That is why the ADC is referred to as "HKADC" - HouseKeeping
+	 * ADC.
+	 */
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&xoadc 0x00 0x01>, /* Battery */
+			    <&xoadc 0x00 0x01>, /* DC in (charger) */
+			    <&xoadc 0x00 0x04>, /* VPH the main system voltage */
+			    <&xoadc 0x00 0x0b>, /* Die temperature */
+			    <&xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
+			    <&xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
+			    <&xoadc 0x00 0x0e>; /* Reference voltage 0.325V */
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -267,6 +283,49 @@
 					row-hold = <91500>;
 				};
 
+				xoadc: xoadc@197 {
+					compatible = "qcom,pm8058-adc";
+					reg = <0x197>;
+					interrupts-extended = <&pm8058 76 IRQ_TYPE_EDGE_RISING>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+					#io-channel-cells = <2>;
+
+					vcoin: adc-channel@00 {
+						reg = <0x00 0x00>;
+					};
+					vbat: adc-channel@01 {
+						reg = <0x00 0x01>;
+					};
+					dcin: adc-channel@02 {
+						reg = <0x00 0x02>;
+					};
+					ichg: adc-channel@30 {
+						reg = <0x00 0x03>;
+					};
+					vph_pwr: adc-channel@04 {
+						reg = <0x00 0x04>;
+					};
+					usb_vbus: adc-channel@0a {
+						reg = <0x00 0x0a>;
+					};
+					die_temp: adc-channel@0b {
+						reg = <0x00 0x0b>;
+					};
+					ref_625mv: adc-channel@0c {
+						reg = <0x00 0x0c>;
+					};
+					ref_1250mv: adc-channel@0d {
+						reg = <0x00 0x0d>;
+					};
+					ref_325mv: adc-channel@0e {
+						reg = <0x00 0x0e>;
+					};
+					ref_muxoff: adc-channel@0f {
+						reg = <0x00 0x0f>;
+					};
+				};
+
 				rtc@1e8 {
 					compatible = "qcom,pm8058-rtc";
 					reg = <0x1e8>;
-- 
2.9.3

