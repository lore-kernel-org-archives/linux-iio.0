Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:45883 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754214AbdA0I6C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 03:58:02 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: [PATCH v2 16/25] dt-bindings: power: supply: add AXP20X/AXP22X battery DT binding
Date: Fri, 27 Jan 2017 09:54:49 +0100
Message-Id: <20170127085458.18270-17-quentin.schulz@free-electrons.com>
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.

This patch adds the DT binding documentation for the battery power
supply which gets various data from the PMIC, such as the battery status
(charging, discharging, full, dead), current max limit, current current,
battery capacity (in percentage), voltage max and min limits, current
voltage and battery capacity (in Ah).

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v2:
 - changed DT node name from ac_power_supply to ac-power-supply,
 - removed io-channels and io-channel-names from DT (the IIO mapping is
 done in the IIO ADC driver now),
 - added x-powers,constant-charge-current property to set the maximal
 default constant current charge of the battery,

 .../bindings/power/supply/axp20x_battery.txt       | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
new file mode 100644
index 0000000..6f7eff2
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
@@ -0,0 +1,25 @@
+AXP20x and AXP22x battery power supply
+
+Required Properties:
+ - compatible, one of:
+			"x-powers,axp209-battery-power-supply"
+			"x-powers,axp221-battery-power-supply"
+
+Optional properties:
+ - x-powers,constant-charge-current: its value in uA gives the PMIC the default
+ maximal allowed value for the constant charge current of the battery.
+
+This node is a subnode of the axp20x/axp22x PMIC.
+
+The AXP20X and AXP22X can read the battery voltage, charge and discharge
+currents of the battery by reading ADC channels from the AXP20X/AXP22X
+ADC.
+
+Example:
+
+&axp209 {
+	battery_power_supply: battery-power-supply {
+		compatible = "x-powers,axp209-battery-power-supply";
+		x-powers,constant-charge-current = <600000>;
+	}
+};
-- 
2.9.3

