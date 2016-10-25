Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49332 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S941850AbcJYQ1A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 12:27:00 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>
Subject: [PATCH 09/10] ARM: dts: stm32f429: enable adc on eval board
Date: Tue, 25 Oct 2016 18:25:21 +0200
Message-ID: <1477412722-24061-10-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
References: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Enable analog to digital converter on stm32f429i-eval board.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32429i-eval.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 6bfc595..0e8c900 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -65,6 +65,20 @@
 		serial0 = &usart1;
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_vref: regulator@0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "vref";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		green {
@@ -123,3 +137,19 @@
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+&adc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&adc3_in8_pin>;
+	vref-supply = <&reg_vref>;
+	status = "okay";
+	adc3: adc3-slave@200 {
+		st,adc-channels = <8>;
+		status = "okay";
+	};
+
+	jadc3: adc3-injected@200 {
+		st,adc-channels = <8>;
+		status = "okay";
+	};
+};
-- 
1.9.1

