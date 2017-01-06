Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:39908 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162359AbdAFDkA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2017 22:40:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170102163723.7939-18-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com> <20170102163723.7939-18-quentin.schulz@free-electrons.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 6 Jan 2017 11:39:33 +0800
Message-ID: <CAGb2v66XnWOGcaLeRo+cb6NGqfm_cyJVoK+GURUo5iV4pdZzew@mail.gmail.com>
Subject: Re: [PATCH 17/22] power: supply: add battery driver for AXP20X and
 AXP22X PMICs
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Sebastian Reichel <sre@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

 Hi,

On Tue, Jan 3, 2017 at 12:37 AM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
>
> This patch adds the battery power supply driver to get various data from
> the PMIC, such as the battery status (charging, discharging, full,
> dead), current max limit, current current, battery capacity (in
> percentage), voltage max and min limits, current voltage and battery
> capacity (in Ah).
>
> This battery driver uses the AXP20X/AXP22X ADC driver as PMIC data
> provider.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/power/supply/Kconfig          |  12 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/axp20x_battery.c | 458 ++++++++++++++++++++++++++++++++++
>  3 files changed, 471 insertions(+)
>  create mode 100644 drivers/power/supply/axp20x_battery.c
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index c552b4b..48619de 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -226,6 +226,18 @@ config CHARGER_AXP20X
>           This driver can also be built as a module. If so, the module will be
>           called axp20x_ac_power.
>
> +config BATTERY_AXP20X
> +       tristate "X-Powers AXP20X battery driver"
> +       depends on MFD_AXP20X
> +       depends on AXP20X_ADC
> +       depends on IIO
> +       help
> +         Say Y here to enable support for X-Powers AXP20X PMICs' battery power
> +         supply.
> +
> +         This driver can also be built as a module. If so, the module will be
> +         called axp20x_battery.
> +
>  config AXP288_CHARGER
>         tristate "X-Powers AXP288 Charger"
>         depends on MFD_AXP20X && EXTCON_AXP288
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 7d22417..5a217b2 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_TEST_POWER)      += test_power.o
>
>  obj-$(CONFIG_BATTERY_88PM860X) += 88pm860x_battery.o
>  obj-$(CONFIG_BATTERY_ACT8945A) += act8945a_charger.o
> +obj-$(CONFIG_BATTERY_AXP20X)   += axp20x_battery.o
>  obj-$(CONFIG_CHARGER_AXP20X)   += axp20x_ac_power.o
>  obj-$(CONFIG_BATTERY_DS2760)   += ds2760_battery.o
>  obj-$(CONFIG_BATTERY_DS2780)   += ds2780_battery.o
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> new file mode 100644
> index 0000000..e1d7b5f
> --- /dev/null
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -0,0 +1,458 @@
> +/*
> + * Battery power supply driver for X-Powers AXP20X and AXP22X PMICs
> + *
> + * Copyright 2016 Free Electrons NextThing Co.
> + *     Quentin Schulz <quentin.schulz@free-electrons.com>
> + *
> + * This driver is based on a previous upstreaming attempt by:
> + *     Bruno Prémont <bonbons@linux-vserver.org>
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License. See the file "COPYING" in the main directory of this
> + * archive for more details.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/time.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/mfd/axp20x.h>
> +
> +#define AXP20X_PWR_STATUS_BAT_CHARGING BIT(2)
> +
> +#define AXP20X_PWR_OP_BATT_PRESENT     BIT(5)
> +#define AXP20X_PWR_OP_BATT_ACTIVATED   BIT(3)
> +
> +#define AXP209_FG_PERCENT              GENMASK(6, 0)
> +#define AXP22X_FG_VALID                        BIT(7)
> +
> +#define AXP20X_CHRG_CTRL1_TGT_VOLT     GENMASK(6, 5)
> +#define AXP20X_CHRG_CTRL1_TGT_4_1V     (0 << 5)
> +#define AXP20X_CHRG_CTRL1_TGT_4_15V    BIT(5)
> +#define AXP20X_CHRG_CTRL1_TGT_4_2V     (2 << 5)
> +#define AXP20X_CHRG_CTRL1_TGT_4_36V    (3 << 5)
> +#define AXP20X_CHRG_CTRL1_TGT_CURR     GENMASK(3, 0)
> +
> +#define AXP22X_CHRG_CTRL1_TGT_4_22V    BIT(5)
> +#define AXP22X_CHRG_CTRL1_TGT_4_24V    (3 << 5)
> +
> +#define AXP20X_V_OFF_MASK              GENMASK(2, 0)
> +
> +struct axp20x_batt_ps {
> +       struct regmap *regmap;
> +       struct power_supply *batt;
> +       struct axp20x_dev *axp20x;
> +       struct iio_channel *batt_chrg_i;
> +       struct iio_channel *batt_dischrg_i;
> +       struct iio_channel *batt_v;
> +       u8 axp_id;
> +};
> +
> +static int axp20x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
> +                                         int *val)
> +{
> +       int ret, reg;
> +
> +       ret = regmap_read(axp20x_batt->regmap, AXP20X_CHRG_CTRL1, &reg);
> +       if (ret)
> +               return ret;
> +
> +       switch (reg & AXP20X_CHRG_CTRL1_TGT_VOLT) {
> +       case AXP20X_CHRG_CTRL1_TGT_4_1V:
> +               *val = 4100000;
> +               break;
> +       case AXP20X_CHRG_CTRL1_TGT_4_15V:
> +               *val = 4150000;
> +               break;
> +       case AXP20X_CHRG_CTRL1_TGT_4_2V:
> +               *val = 4200000;
> +               break;
> +       case AXP20X_CHRG_CTRL1_TGT_4_36V:
> +               *val = 4360000;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int axp22x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
> +                                         int *val)
> +{
> +       int ret, reg;
> +
> +       ret = regmap_read(axp20x_batt->regmap, AXP20X_CHRG_CTRL1, &reg);
> +       if (ret)
> +               return ret;
> +
> +       switch (reg & AXP20X_CHRG_CTRL1_TGT_VOLT) {
> +       case AXP20X_CHRG_CTRL1_TGT_4_1V:
> +               *val = 4100000;
> +               break;
> +       case AXP20X_CHRG_CTRL1_TGT_4_2V:
> +               *val = 4200000;
> +               break;
> +       case AXP22X_CHRG_CTRL1_TGT_4_22V:
> +               *val = 4220000;
> +               break;
> +       case AXP22X_CHRG_CTRL1_TGT_4_24V:
> +               *val = 4240000;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int axp20x_battery_get_prop(struct power_supply *psy,
> +                                  enum power_supply_property psp,
> +                                  union power_supply_propval *val)
> +{
> +       struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
> +       struct iio_channel *chan;
> +       int ret = 0, reg, val1;
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_PRESENT:
> +       case POWER_SUPPLY_PROP_ONLINE:
> +               ret = regmap_read(axp20x_batt->regmap, AXP20X_PWR_OP_MODE,
> +                                 &reg);
> +               if (ret)
> +                       return ret;
> +
> +               val->intval = !!(reg & AXP20X_PWR_OP_BATT_PRESENT);
> +               break;
> +
> +       case POWER_SUPPLY_PROP_STATUS:
> +               ret = regmap_read(axp20x_batt->regmap, AXP20X_PWR_INPUT_STATUS,
> +                                 &reg);
> +               if (ret)
> +                       return ret;
> +
> +               if (reg & AXP20X_PWR_STATUS_BAT_CHARGING) {
> +                       val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +                       return 0;
> +               }
> +
> +               ret = iio_read_channel_processed(axp20x_batt->batt_dischrg_i,
> +                                                &val1);
> +               if (ret)
> +                       return ret;
> +
> +               if (val1) {
> +                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +                       return 0;
> +               }
> +
> +               ret = regmap_read(axp20x_batt->regmap, AXP20X_FG_RES, &val1);
> +               if (ret)
> +                       return ret;
> +
> +               /*
> +                * Fuel Gauge data takes 7 bits but the stored value seems to be
> +                * directly the raw percentage without any scaling to 7 bits.
> +                */
> +               if ((val1 & AXP209_FG_PERCENT) == 100)
> +                       val->intval = POWER_SUPPLY_STATUS_FULL;
> +               else
> +                       val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +               break;
> +
> +       case POWER_SUPPLY_PROP_HEALTH:
> +               ret = regmap_read(axp20x_batt->regmap, AXP20X_PWR_OP_MODE,
> +                                 &val1);
> +               if (ret)
> +                       return ret;
> +
> +               if (val1 & AXP20X_PWR_OP_BATT_ACTIVATED) {
> +                       val->intval = POWER_SUPPLY_HEALTH_DEAD;
> +                       return 0;
> +               }
> +
> +               val->intval = POWER_SUPPLY_HEALTH_GOOD;
> +               break;
> +
> +       case POWER_SUPPLY_PROP_CURRENT_MAX:
> +               ret = regmap_read(axp20x_batt->regmap, AXP20X_CHRG_CTRL1, &reg);
> +               if (ret)
> +                       return ret;
> +
> +               reg &= AXP20X_CHRG_CTRL1_TGT_CURR;
> +               val->intval = reg * 100000 + 300000;
> +               break;


This controls the charge current. I believe the correct property to use
is CONSTANT_CHARGE_CURRENT. And you should add CONSTANT_CHARGE_CURRENT_MAX
which returns the highest possible setting.

Also letting the user control this might not always be a good idea.
IIUC, LiPo batteries can only be charged at 1C, where C is the
rated capacity (X mAh).

> +
> +       case POWER_SUPPLY_PROP_CURRENT_NOW:
> +               ret = regmap_read(axp20x_batt->regmap, AXP20X_PWR_INPUT_STATUS,
> +                                 &reg);
> +               if (ret)
> +                       return ret;
> +
> +               if (reg & AXP20X_PWR_STATUS_BAT_CHARGING)
> +                       chan = axp20x_batt->batt_chrg_i;
> +               else
> +                       chan = axp20x_batt->batt_dischrg_i;
> +
> +               ret = iio_read_channel_processed(chan, &val->intval);
> +               if (ret)
> +                       return ret;
> +
> +               /*
> +                * IIO framework gives mV but Power Supply framework gives µV.
> +                */
> +               val->intval *= 1000;
> +               break;
> +
> +       case POWER_SUPPLY_PROP_CAPACITY:
> +               /* When no battery is present, return capacity is 100% */
> +               ret = regmap_read(axp20x_batt->regmap, AXP20X_PWR_OP_MODE,
> +                                 &reg);
> +               if (ret)
> +                       return ret;
> +
> +               if (!(reg & AXP20X_PWR_OP_BATT_PRESENT)) {
> +                       val->intval = 100;
> +                       return 0;
> +               }
> +
> +               ret = regmap_read(axp20x_batt->regmap, AXP20X_FG_RES, &reg);
> +               if (ret)
> +                       return ret;
> +
> +               if (axp20x_batt->axp_id == AXP221_ID &&
> +                   !(reg & AXP22X_FG_VALID))
> +                       return -EINVAL;
> +
> +               /*
> +                * Fuel Gauge data takes 7 bits but the stored value seems to be
> +                * directly the raw percentage without any scaling to 7 bits.
> +                */
> +               val->intval = reg & AXP209_FG_PERCENT;
> +               break;
> +
> +       case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +               if (axp20x_batt->axp_id == AXP209_ID)
> +                       return axp20x_battery_get_max_voltage(axp20x_batt,
> +                                                             &val->intval);
> +               return axp22x_battery_get_max_voltage(axp20x_batt,
> +                                                     &val->intval);
> +
> +       case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +               ret = regmap_read(axp20x_batt->regmap, AXP20X_V_OFF, &reg);
> +               if (ret)
> +                       return ret;
> +
> +               val->intval = 2600000 + 100000 * (reg & AXP20X_V_OFF_MASK);
> +               break;
> +
> +       case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +               ret = iio_read_channel_processed(axp20x_batt->batt_v,
> +                                                &val->intval);
> +               if (ret)
> +                       return ret;
> +
> +               /*
> +                * IIO framework gives mV but Power Supply framework gives µV.
> +                */
> +               val->intval *= 1000;
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int axp20x_battery_set_max_voltage(struct axp20x_batt_ps *axp20x_batt,
> +                                         int val)
> +{
> +       switch (val) {
> +       case 4100000:
> +               return regmap_update_bits(axp20x_batt->regmap,
> +                                         AXP20X_CHRG_CTRL1,
> +                                         AXP20X_CHRG_CTRL1_TGT_VOLT,
> +                                         AXP20X_CHRG_CTRL1_TGT_4_1V);
> +       case 4150000:
> +               if (axp20x_batt->axp_id == AXP221_ID)
> +                       return -EINVAL;
> +
> +               return regmap_update_bits(axp20x_batt->regmap,
> +                                         AXP20X_CHRG_CTRL1,
> +                                         AXP20X_CHRG_CTRL1_TGT_VOLT,
> +                                         AXP20X_CHRG_CTRL1_TGT_4_15V);
> +       case 4200000:
> +               return regmap_update_bits(axp20x_batt->regmap,
> +                                         AXP20X_CHRG_CTRL1,
> +                                         AXP20X_CHRG_CTRL1_TGT_VOLT,
> +                                         AXP20X_CHRG_CTRL1_TGT_4_2V);
> +       default:
> +               /*
> +                * AXP20x max voltage can be set to 4.36V and AXP22X max voltage
> +                * can be set to 4.22V and 4.24V, but these voltages are too
> +                * high for Lithium based batteries (AXP PMICs are supposed to
> +                * be used with these kinds of battery).
> +                */
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int axp20x_battery_set_prop(struct power_supply *psy,
> +                                  enum power_supply_property psp,
> +                                  const union power_supply_propval *val)
> +{
> +       struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
> +       int ret = 0, val1;
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +               val1 = (val->intval - 2600000) / 100000;
> +               if (val1 < 0 || val1 > AXP20X_V_OFF_MASK)
> +                       return -EINVAL;
> +
> +               return regmap_update_bits(axp20x_batt->regmap, AXP20X_V_OFF,
> +                                         AXP20X_V_OFF_MASK, val1);
> +
> +       case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +               return axp20x_battery_set_max_voltage(axp20x_batt, val->intval);
> +
> +       case POWER_SUPPLY_PROP_CURRENT_MAX:
> +               if (axp20x_batt->axp_id == AXP209_ID)
> +                       val1 = (val->intval - 300000) / 100000;
> +               else
> +                       val1 = (val->intval - 300000) / 150000;
> +
> +               if (val1 > AXP20X_CHRG_CTRL1_TGT_CURR || val1 < 0)
> +                       return -EINVAL;
> +
> +               return regmap_update_bits(axp20x_batt->regmap,
> +                                         AXP20X_CHRG_CTRL1,
> +                                         AXP20X_CHRG_CTRL1_TGT_CURR, val1);
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static enum power_supply_property axp20x_battery_props[] = {
> +       POWER_SUPPLY_PROP_PRESENT,
> +       POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_STATUS,
> +       POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +       POWER_SUPPLY_PROP_CURRENT_NOW,
> +       POWER_SUPPLY_PROP_CURRENT_MAX,
> +       POWER_SUPPLY_PROP_HEALTH,
> +       POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +       POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +       POWER_SUPPLY_PROP_CAPACITY,

You can also add POWER_SUPPLY_PROP_TECHNOLOGY, which would return
POWER_SUPPLY_TECHNOLOGY_LIPO.

It is also possible to do POWER_SUPPLY_PROP_CHARGE_TYPE. According
to the manual, if the battery is charging, it is in constant current
mode (POWER_SUPPLY_CHARGE_TYPE_FAST) when V_battery < V_target.
When V_battery == V_target, it is in constant voltage mode, though
I don't think this is the same as POWER_SUPPLY_CHARGE_TYPE_TRICKLE.
When it is not charging, you can return POWER_SUPPLY_CHARGE_TYPE_NONE.

Regards
ChenYu

> +};
> +
> +static int axp20x_battery_prop_writeable(struct power_supply *psy,
> +                                        enum power_supply_property psp)
> +{
> +       return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
> +              psp == POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
> +              psp == POWER_SUPPLY_PROP_CURRENT_MAX;
> +}
> +
> +static const struct power_supply_desc axp20x_batt_ps_desc = {
> +       .name = "axp20x-battery",
> +       .type = POWER_SUPPLY_TYPE_BATTERY,
> +       .properties = axp20x_battery_props,
> +       .num_properties = ARRAY_SIZE(axp20x_battery_props),
> +       .property_is_writeable = axp20x_battery_prop_writeable,
> +       .get_property = axp20x_battery_get_prop,
> +       .set_property = axp20x_battery_set_prop,
> +};
> +
> +static const struct of_device_id axp20x_battery_ps_id[] = {
> +       {
> +               .compatible = "x-powers,axp209-battery-power-supply",
> +               .data = (void *)AXP209_ID,
> +       }, {
> +               .compatible = "x-powers,axp221-battery-power-supply",
> +               .data = (void *)AXP221_ID,
> +       }, { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
> +
> +static int axp20x_power_probe(struct platform_device *pdev)
> +{
> +       struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> +       struct axp20x_batt_ps *axp20x_batt;
> +       struct power_supply_config psy_cfg = {};
> +
> +       axp20x_batt = devm_kzalloc(&pdev->dev, sizeof(*axp20x_batt),
> +                                  GFP_KERNEL);
> +       if (!axp20x_batt)
> +               return -ENOMEM;
> +
> +       axp20x_batt->batt_v = devm_iio_channel_get(&pdev->dev, "batt_v");
> +       if (IS_ERR(axp20x_batt->batt_v)) {
> +               if (PTR_ERR(axp20x_batt->batt_v) == -ENODEV)
> +                       return -EPROBE_DEFER;
> +               return PTR_ERR(axp20x_batt->batt_v);
> +       }
> +
> +       axp20x_batt->batt_chrg_i = devm_iio_channel_get(&pdev->dev,
> +                                                       "batt_chrg_i");
> +       if (IS_ERR(axp20x_batt->batt_chrg_i)) {
> +               if (PTR_ERR(axp20x_batt->batt_chrg_i) == -ENODEV)
> +                       return -EPROBE_DEFER;
> +               return PTR_ERR(axp20x_batt->batt_chrg_i);
> +       }
> +
> +       axp20x_batt->batt_dischrg_i = devm_iio_channel_get(&pdev->dev,
> +                                                          "batt_dischrg_i");
> +       if (IS_ERR(axp20x_batt->batt_dischrg_i)) {
> +               if (PTR_ERR(axp20x_batt->batt_dischrg_i) == -ENODEV)
> +                       return -EPROBE_DEFER;
> +               return PTR_ERR(axp20x_batt->batt_dischrg_i);
> +       }
> +
> +       axp20x_batt->regmap = axp20x->regmap;
> +       platform_set_drvdata(pdev, axp20x_batt);
> +
> +       psy_cfg.drv_data = axp20x_batt;
> +       psy_cfg.of_node = pdev->dev.of_node;
> +
> +       axp20x_batt->axp_id = (int)of_device_get_match_data(&pdev->dev);
> +
> +       axp20x_batt->batt = devm_power_supply_register(&pdev->dev,
> +                                                      &axp20x_batt_ps_desc,
> +                                                      &psy_cfg);
> +       return PTR_ERR_OR_ZERO(axp20x_batt->batt);
> +}
> +
> +static struct platform_driver axp20x_batt_driver = {
> +       .probe    = axp20x_power_probe,
> +       .driver   = {
> +               .name  = "axp20x-battery-power-supply",
> +               .of_match_table = axp20x_battery_ps_id,
> +       },
> +};
> +
> +module_platform_driver(axp20x_batt_driver);
> +
> +MODULE_DESCRIPTION("Battery power supply driver for AXP20X and AXP22X PMICs");
> +MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.9.3
>
