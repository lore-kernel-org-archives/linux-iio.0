Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42731 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933419AbdABQiA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 11:38:00 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: [PATCH 01/22] dt-bindings: iio: adc: add AXP20X/AXP22X ADC DT binding
Date: Mon,  2 Jan 2017 17:37:01 +0100
Message-Id: <20170102163723.7939-2-quentin.schulz@free-electrons.com>
In-Reply-To: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
battery voltage, battery charge and discharge currents, AC-in and VBUS
voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.

This adds the device tree binding documentation for the X-Powers AXP20X
and AXP22X PMICs ADCs.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 .../devicetree/bindings/iio/adc/axp20x_adc.txt     | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
new file mode 100644
index 0000000..1b60065
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
@@ -0,0 +1,24 @@
+X-Powers AXP20X and AXP22X PMIC Analog to Digital Converter (ADC)
+
+The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
+battery voltage, battery charge and discharge currents, AC-in and VBUS
+voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
+
+The AXP22X PMICs do not have all ADCs of the AXP20X though.
+
+Required properties:
+ - compatible, one of:
+			"x-powers,axp209-adc"
+			"x-powers,axp221-adc"
+ - #io-channel-cells = <1>;
+
+This is a subnode of the AXP20X PMIC.
+
+Example:
+
+&axp209 {
+	axp209_adc: axp209_adc {
+		compatible = "x-powers,axp209-adc";
+		#io-channel-cells = <1>;
+	};
+};
-- 
2.9.3

