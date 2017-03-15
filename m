Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:58788 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbdCOK4l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 06:56:41 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: icenowy@aosc.xyz, bonbons@linux-vserver.org, sre@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        liam@networkimprov.net, thomas.petazzoni@free-electrons.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH v4 11/18] dt-bindings: power: supply: add AXP20X/AXP22X battery DT binding
Date: Wed, 15 Mar 2017 11:55:30 +0100
Message-Id: <20170315105537.22349-12-quentin.schulz@free-electrons.com>
In-Reply-To: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.

This patch adds the DT binding documentation for the battery power
supply which gets various data from the PMIC, such as the battery status
(charging, discharging, full, dead), current max limit, current current,
battery capacity (in percentage), voltage max and min limits, current
voltage and battery capacity (in Ah).

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---

v4:
 - added monitored-battery optional property,
 - added example with battery,

v3:
 - removed constant charge current property, now should use the WIP
 battery framework,

v2:
 - changed DT node name from ac_power_supply to ac-power-supply,
 - removed io-channels and io-channel-names from DT (the IIO mapping is
 done in the IIO ADC driver now),
 - added x-powers,constant-charge-current property to set the maximal
 default constant current charge of the battery,
 .../bindings/power/supply/axp20x_battery.txt       | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
new file mode 100644
index 0000000..89cb7a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
@@ -0,0 +1,30 @@
+AXP20x and AXP22x battery power supply
+
+Required Properties:
+ - compatible, one of:
+			"x-powers,axp209-battery-power-supply"
+			"x-powers,axp221-battery-power-supply"
+
+Optional properties:
+ - monitored-battery, phandle to a fixed battery
+
+This node is a subnode of the axp20x/axp22x PMIC.
+
+The AXP20X and AXP22X can read the battery voltage, charge and discharge
+currents of the battery by reading ADC channels from the AXP20X/AXP22X
+ADC.
+
+Example:
+
+battery: battery {
+	compatible = "fixed-battery";
+	voltage-min-design-microvolt = <3200000>;
+	constant-charge-microamp = <300000>;
+};
+
+&axp209 {
+	battery_power_supply: battery-power-supply {
+		compatible = "x-powers,axp209-battery-power-supply";
+		monitored-battery = <&battery>;
+	}
+};
-- 
2.9.3

