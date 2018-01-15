Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:43756 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754540AbeAOKfB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jan 2018 05:35:01 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com,
        julian.calaby@gmail.com,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v3 02/16] dt-bindings: iio: adc: add binding for X-Powers AXP PMICs ADC
Date: Mon, 15 Jan 2018 11:33:36 +0100
Message-Id: <8191dd8cc334049b8b91a231f9f276b6d0689628.1516012352.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

X-Powers PMICs have several ADC channels that can be used for different
purposes, e.g. PMIC internal temperature, battery voltage or AC current.

This is the documentation for AXP209, AXP221/223 and AXP813 ADC
bindings.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 48 +++++++++-
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
new file mode 100644
index 0000000..7a63139
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
@@ -0,0 +1,48 @@
+* X-Powers AXP ADC bindings
+
+Required properties:
+  - compatible: should be one of:
+    - "x-powers,axp209-adc",
+    - "x-powers,axp221-adc",
+    - "x-powers,axp813-adc",
+  - #io-channel-cells: should be 1,
+
+Example:
+
+&axp22x {
+	adc {
+		compatible = "x-powers,axp221-adc";
+		#io-channel-cells = <1>;
+	};
+};
+
+ADC channels and their indexes per variant:
+
+AXP209
+------
+ 0 | acin_v
+ 1 | acin_i
+ 2 | vbus_v
+ 3 | vbus_i
+ 4 | pmic_temp
+ 5 | gpio0_v
+ 6 | gpio1_v
+ 7 | ipsout_v
+ 8 | batt_v
+ 9 | batt_chrg_i
+10 | batt_dischrg_i
+
+AXP22x
+------
+ 0 | pmic_temp
+ 1 | batt_v
+ 2 | batt_chrg_i
+ 3 | batt_dischrg_i
+
+AXP813
+------
+ 0 | pmic_temp
+ 1 | gpio0_v
+ 2 | batt_v
+ 3 | batt_chrg_i
+ 4 | batt_dischrg_i
-- 
git-series 0.9.1
