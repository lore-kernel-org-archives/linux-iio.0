Return-Path: <SRS0=dCX1=EK=free-electrons.com=quentin.schulz@kernel.org>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	wens@csie.org,
	sre@kernel.org,
	linux@armlinux.org.uk,
	maxime.ripard@free-electrons.com,
	lee.jones@linaro.org
Cc: linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	linux-sunxi@googlegroups.com,
	julian.calaby@gmail.com,
	Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v3 12/16] power: supply: axp20x_battery: add support for AXP813
Date: Mon, 15 Jan 2018 11:33:46 +0100
Message-Id: <42b2e555083abbab43e48362175dc9c2eeeedf3c.1516012352.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

The X-Powers AXP813 PMIC has got some slight differences from
AXP20X/AXP22X PMICs:
 - the maximum voltage supplied by the PMIC is 4.35 instead of 4.36/4.24
 for AXP20X/AXP22X,
 - the constant charge current formula is different,

It also has a bit to tell whether the battery percentage returned by the
PMIC is valid.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/power/supply/axp20x_battery.c | 42 ++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index d73c78f..e75fa90 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -49,6 +49,8 @@
 #define AXP22X_CHRG_CTRL1_TGT_4_22V	(1 << 5)
 #define AXP22X_CHRG_CTRL1_TGT_4_24V	(3 << 5)
 
+#define AXP813_CHRG_CTRL1_TGT_4_35V	(3 << 5)
+
 #define AXP20X_CHRG_CTRL1_TGT_CURR	GENMASK(3, 0)
 
 #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
@@ -133,6 +135,35 @@ static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
 	return 0;
 }
 
+static int axp813_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
+					  int *val)
+{
+	int ret, reg;
+
+	ret = regmap_read(axp20x_batt->regmap, AXP20X_CHRG_CTRL1, &reg);
+	if (ret)
+		return ret;
+
+	switch (reg & AXP20X_CHRG_CTRL1_TGT_VOLT) {
+	case AXP20X_CHRG_CTRL1_TGT_4_1V:
+		*val = 4100000;
+		break;
+	case AXP20X_CHRG_CTRL1_TGT_4_15V:
+		*val = 4150000;
+		break;
+	case AXP20X_CHRG_CTRL1_TGT_4_2V:
+		*val = 4200000;
+		break;
+	case AXP813_CHRG_CTRL1_TGT_4_35V:
+		*val = 4350000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int axp20x_get_constant_charge_current(struct axp20x_batt_ps *axp,
 					      int *val)
 {
@@ -491,6 +522,14 @@ struct axp_data axp221_data = {
 	.set_max_voltage = axp22x_battery_set_max_voltage,
 };
 
+struct axp_data axp813_data = {
+	.ccc_scale = 200000,
+	.ccc_offset = 200000,
+	.has_fg_valid = true,
+	.get_max_voltage = axp813_battery_get_max_voltage,
+	.set_max_voltage = axp20x_battery_set_max_voltage,
+};
+
 static const struct of_device_id axp20x_battery_ps_id[] = {
 	{
 		.compatible = "x-powers,axp209-battery-power-supply",
@@ -498,6 +537,9 @@ static const struct of_device_id axp20x_battery_ps_id[] = {
 	}, {
 		.compatible = "x-powers,axp221-battery-power-supply",
 		.data = (void *)&axp221_data,
+	}, {
+		.compatible = "x-powers,axp813-battery-power-supply",
+		.data = (void *)&axp813_data,
 	}, { /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
-- 
git-series 0.9.1
