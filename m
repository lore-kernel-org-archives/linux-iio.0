Return-Path: <todd.e.brandt@intel.com>
From: "Brandt, Todd E" <todd.e.brandt@intel.com>
To: Todd Brandt <todd.e.brandt@linux.intel.com>, "sre@kernel.org"
	<sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "Woodhouse,
 David" <david.woodhouse@intel.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
	"sameo@linux.intel.com" <sameo@linux.intel.com>, "lee.jones@linaro.org"
	<lee.jones@linaro.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"jic23@kernel.org" <jic23@kernel.org>
Subject: RE: [PATCH RESEND v3 3/3] X-Power AXP288 PMIC Fuel Gauge Driver
Date: Mon, 2 Feb 2015 20:57:35 +0000
Message-ID: <11E08D716F0541429B7042699DD5C1A170962C70@FMSMSX103.amr.corp.intel.com>
References: <cover.1422909564.git.todd.e.brandt@linux.intel.com>,<261ddb17dbc29e216575e337ff69ca5f8a340f28.1422909564.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <261ddb17dbc29e216575e337ff69ca5f8a340f28.1422909564.git.todd.e.brandt@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-7"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Dmitry and Sebastian, can we get this driver included for 3.20?=0A=
=0A=
Regards=0A=
Todd Brandt=0A=
=0A=
________________________________________=0A=
From: Todd Brandt [todd.e.brandt@linux.intel.com]=0A=
Sent: Monday, February 02, 2015 12:44 PM=0A=
To: sre@kernel.org; dbaryshkov@gmail.com; Woodhouse, David=0A=
Cc: linux-pm@vger.kernel.org; linux-iio@vger.kernel.org; linux-kernel@vger.=
kernel.org; todd.e.brandt@linux.intel.com; Brandt, Todd E; jacob.jun.pan@li=
nux.intel.com; sameo@linux.intel.com; lee.jones@linaro.org; dwmw2@infradead=
.org; jic23@kernel.org=0A=
Subject: [PATCH RESEND v3 3/3] X-Power AXP288 PMIC Fuel Gauge Driver=0A=
=0A=
New power_supply driver at driver/power which interfaces with the=0A=
axp20x mfd driver as a cell. Provides battery info, monitors for=0A=
changes, and generates alerts on temperature and capacity issues=0A=
=0A=
Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>=0A=
Acked-by:  Jacob Pan <jacob.jun.pan@linux.intel.com>=0A=
---=0A=
 drivers/power/Kconfig             |    9 +=0A=
 drivers/power/Makefile            |    1 +=0A=
 drivers/power/axp288_fuel_gauge.c | 1151 +++++++++++++++++++++++++++++++++=
++++=0A=
 3 files changed, 1161 insertions(+)=0A=
 create mode 100644 drivers/power/axp288_fuel_gauge.c=0A=
=0A=
v1: 01/07/14=0A=
v2: 01/22/14=0A=
- reformatted the commit text=0A=
- added IIO as driver dependency=0A=
- moved debug info to debugfs in file fuelgauge=0A=
- added HEALTH_COLD value to health calculation=0A=
- added better cleanup to remove call=0A=
        cancelling any delayed work calls=0A=
        unregistration of the power_supply=0A=
v3: 01/28/14=0A=
- moved debugs create and init config regs after error case=0A=
- freed the virqs in the remove function=0A=
- remove .owner field as it is populated automatically=0A=
=0A=
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig=0A=
index 0108c2a..a1166e0 100644=0A=
--- a/drivers/power/Kconfig=0A=
+++ b/drivers/power/Kconfig=0A=
@@ -192,6 +192,15 @@ config BATTERY_DA9052=0A=
          Say Y here to enable support for batteries charger integrated int=
o=0A=
          DA9052 PMIC.=0A=
=0A=
+config AXP288_FUEL_GAUGE=0A=
+       tristate "X-Powers AXP288 Fuel Gauge"=0A=
+       depends on MFD_AXP20X && IIO=0A=
+       help=0A=
+         Say yes here to have support for X-Power power management IC (PMI=
C)=0A=
+         Fuel Gauge. The device provides battery statistics and status=0A=
+         monitoring as well as alerts for battery over/under voltage and=
=0A=
+         over/under temperature.=0A=
+=0A=
 config BATTERY_MAX17040=0A=
        tristate "Maxim MAX17040 Fuel Gauge"=0A=
        depends on I2C=0A=
diff --git a/drivers/power/Makefile b/drivers/power/Makefile=0A=
index dfa8942..eb76b23 100644=0A=
--- a/drivers/power/Makefile=0A=
+++ b/drivers/power/Makefile=0A=
@@ -59,3 +59,4 @@ obj-$(CONFIG_POWER_AVS)               +=3D avs/=0A=
 obj-$(CONFIG_CHARGER_SMB347)   +=3D smb347-charger.o=0A=
 obj-$(CONFIG_CHARGER_TPS65090) +=3D tps65090-charger.o=0A=
 obj-$(CONFIG_POWER_RESET)      +=3D reset/=0A=
+obj-$(CONFIG_AXP288_FUEL_GAUGE) +=3D axp288_fuel_gauge.o=0A=
diff --git a/drivers/power/axp288_fuel_gauge.c b/drivers/power/axp288_fuel_=
gauge.c=0A=
new file mode 100644=0A=
index 0000000..c86e709=0A=
--- /dev/null=0A=
+++ b/drivers/power/axp288_fuel_gauge.c=0A=
@@ -0,0 +1,1151 @@=0A=
+/*=0A=
+ * axp288_fuel_gauge.c - Xpower AXP288 PMIC Fuel Gauge Driver=0A=
+ *=0A=
+ * Copyright (C) 2014 Intel Corporation=0A=
+ *=0A=
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or modify=0A=
+ * it under the terms of the GNU General Public License as published by=0A=
+ * the Free Software Foundation; version 2 of the License.=0A=
+ *=0A=
+ * This program is distributed in the hope that it will be useful, but=0A=
+ * WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.        See the GNU=
=0A=
+ * General Public License for more details.=0A=
+ *=0A=
+ */=0A=
+=0A=
+#include <linux/module.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/device.h>=0A=
+#include <linux/regmap.h>=0A=
+#include <linux/jiffies.h>=0A=
+#include <linux/interrupt.h>=0A=
+#include <linux/device.h>=0A=
+#include <linux/workqueue.h>=0A=
+#include <linux/mfd/axp20x.h>=0A=
+#include <linux/platform_device.h>=0A=
+#include <linux/power_supply.h>=0A=
+#include <linux/iio/consumer.h>=0A=
+#include <linux/debugfs.h>=0A=
+#include <linux/seq_file.h>=0A=
+=0A=
+#define CHRG_STAT_BAT_SAFE_MODE                (1 << 3)=0A=
+#define CHRG_STAT_BAT_VALID                    (1 << 4)=0A=
+#define CHRG_STAT_BAT_PRESENT          (1 << 5)=0A=
+#define CHRG_STAT_CHARGING                     (1 << 6)=0A=
+#define CHRG_STAT_PMIC_OTP                     (1 << 7)=0A=
+=0A=
+#define CHRG_CCCV_CC_MASK                      0xf     /* 4 bits */=0A=
+#define CHRG_CCCV_CC_BIT_POS           0=0A=
+#define CHRG_CCCV_CC_OFFSET                    200     /* 200mA */=0A=
+#define CHRG_CCCV_CC_LSB_RES           200     /* 200mA */=0A=
+#define CHRG_CCCV_ITERM_20P                    (1 << 4)    /* 20% of CC */=
=0A=
+#define CHRG_CCCV_CV_MASK                      0x60        /* 2 bits */=0A=
+#define CHRG_CCCV_CV_BIT_POS           5=0A=
+#define CHRG_CCCV_CV_4100MV                    0x0     /* 4.10V */=0A=
+#define CHRG_CCCV_CV_4150MV                    0x1     /* 4.15V */=0A=
+#define CHRG_CCCV_CV_4200MV                    0x2     /* 4.20V */=0A=
+#define CHRG_CCCV_CV_4350MV                    0x3     /* 4.35V */=0A=
+#define CHRG_CCCV_CHG_EN                       (1 << 7)=0A=
+=0A=
+#define CV_4100                                                4100    /* =
4100mV */=0A=
+#define CV_4150                                                4150    /* =
4150mV */=0A=
+#define CV_4200                                                4200    /* =
4200mV */=0A=
+#define CV_4350                                                4350    /* =
4350mV */=0A=
+=0A=
+#define TEMP_IRQ_CFG_QWBTU                     (1 << 0)=0A=
+#define TEMP_IRQ_CFG_WBTU                      (1 << 1)=0A=
+#define TEMP_IRQ_CFG_QWBTO                     (1 << 2)=0A=
+#define TEMP_IRQ_CFG_WBTO                      (1 << 3)=0A=
+#define TEMP_IRQ_CFG_MASK                      0xf=0A=
+=0A=
+#define FG_IRQ_CFG_LOWBATT_WL2         (1 << 0)=0A=
+#define FG_IRQ_CFG_LOWBATT_WL1         (1 << 1)=0A=
+#define FG_IRQ_CFG_LOWBATT_MASK                0x3=0A=
+#define LOWBAT_IRQ_STAT_LOWBATT_WL2    (1 << 0)=0A=
+#define LOWBAT_IRQ_STAT_LOWBATT_WL1    (1 << 1)=0A=
+=0A=
+#define FG_CNTL_OCV_ADJ_STAT           (1 << 2)=0A=
+#define FG_CNTL_OCV_ADJ_EN                     (1 << 3)=0A=
+#define FG_CNTL_CAP_ADJ_STAT           (1 << 4)=0A=
+#define FG_CNTL_CAP_ADJ_EN                     (1 << 5)=0A=
+#define FG_CNTL_CC_EN                          (1 << 6)=0A=
+#define FG_CNTL_GAUGE_EN                       (1 << 7)=0A=
+=0A=
+#define FG_REP_CAP_VALID                       (1 << 7)=0A=
+#define FG_REP_CAP_VAL_MASK                    0x7F=0A=
+=0A=
+#define FG_DES_CAP1_VALID                      (1 << 7)=0A=
+#define FG_DES_CAP1_VAL_MASK           0x7F=0A=
+#define FG_DES_CAP0_VAL_MASK           0xFF=0A=
+#define FG_DES_CAP_RES_LSB                     1456    /* 1.456mAhr */=0A=
+=0A=
+#define FG_CC_MTR1_VALID                       (1 << 7)=0A=
+#define FG_CC_MTR1_VAL_MASK                    0x7F=0A=
+#define FG_CC_MTR0_VAL_MASK                    0xFF=0A=
+#define FG_DES_CC_RES_LSB                      1456    /* 1.456mAhr */=0A=
+=0A=
+#define FG_OCV_CAP_VALID                       (1 << 7)=0A=
+#define FG_OCV_CAP_VAL_MASK                    0x7F=0A=
+#define FG_CC_CAP_VALID                                (1 << 7)=0A=
+#define FG_CC_CAP_VAL_MASK                     0x7F=0A=
+=0A=
+#define FG_LOW_CAP_THR1_MASK           0xf0    /* 5% tp 20% */=0A=
+#define FG_LOW_CAP_THR1_VAL                    0xa0    /* 15 perc */=0A=
+#define FG_LOW_CAP_THR2_MASK           0x0f    /* 0% to 15% */=0A=
+#define FG_LOW_CAP_WARN_THR                    14  /* 14 perc */=0A=
+#define FG_LOW_CAP_CRIT_THR                    4   /* 4 perc */=0A=
+#define FG_LOW_CAP_SHDN_THR                    0   /* 0 perc */=0A=
+=0A=
+#define STATUS_MON_DELAY_JIFFIES    (HZ * 60)   /*60 sec */=0A=
+#define NR_RETRY_CNT    3=0A=
+#define DEV_NAME       "axp288_fuel_gauge"=0A=
+=0A=
+/* 1.1mV per LSB expressed in uV */=0A=
+#define VOLTAGE_FROM_ADC(a)                    ((a * 11) / 10)=0A=
+/* properties converted to tenths of degrees, uV, uA, uW */=0A=
+#define PROP_TEMP(a)           ((a) * 10)=0A=
+#define UNPROP_TEMP(a)         ((a) / 10)=0A=
+#define PROP_VOLT(a)           ((a) * 1000)=0A=
+#define PROP_CURR(a)           ((a) * 1000)=0A=
+=0A=
+#define AXP288_FG_INTR_NUM     6=0A=
+enum {=0A=
+       QWBTU_IRQ =3D 0,=0A=
+       WBTU_IRQ,=0A=
+       QWBTO_IRQ,=0A=
+       WBTO_IRQ,=0A=
+       WL2_IRQ,=0A=
+       WL1_IRQ,=0A=
+};=0A=
+=0A=
+struct axp288_fg_info {=0A=
+       struct platform_device *pdev;=0A=
+       struct axp20x_fg_pdata *pdata;=0A=
+       struct regmap *regmap;=0A=
+       struct regmap_irq_chip_data *regmap_irqc;=0A=
+       int irq[AXP288_FG_INTR_NUM];=0A=
+       struct power_supply bat;=0A=
+       struct mutex lock;=0A=
+       int status;=0A=
+       struct delayed_work status_monitor;=0A=
+       struct dentry *debug_file;=0A=
+};=0A=
+=0A=
+static enum power_supply_property fuel_gauge_props[] =3D {=0A=
+       POWER_SUPPLY_PROP_STATUS,=0A=
+       POWER_SUPPLY_PROP_PRESENT,=0A=
+       POWER_SUPPLY_PROP_HEALTH,=0A=
+       POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,=0A=
+       POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,=0A=
+       POWER_SUPPLY_PROP_VOLTAGE_NOW,=0A=
+       POWER_SUPPLY_PROP_VOLTAGE_OCV,=0A=
+       POWER_SUPPLY_PROP_CURRENT_NOW,=0A=
+       POWER_SUPPLY_PROP_CAPACITY,=0A=
+       POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN,=0A=
+       POWER_SUPPLY_PROP_TEMP,=0A=
+       POWER_SUPPLY_PROP_TEMP_MAX,=0A=
+       POWER_SUPPLY_PROP_TEMP_MIN,=0A=
+       POWER_SUPPLY_PROP_TEMP_ALERT_MIN,=0A=
+       POWER_SUPPLY_PROP_TEMP_ALERT_MAX,=0A=
+       POWER_SUPPLY_PROP_TECHNOLOGY,=0A=
+       POWER_SUPPLY_PROP_CHARGE_FULL,=0A=
+       POWER_SUPPLY_PROP_CHARGE_NOW,=0A=
+       POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,=0A=
+       POWER_SUPPLY_PROP_MODEL_NAME,=0A=
+};=0A=
+=0A=
+static int fuel_gauge_reg_readb(struct axp288_fg_info *info, int reg)=0A=
+{=0A=
+       int ret, i;=0A=
+       unsigned int val;=0A=
+=0A=
+       for (i =3D 0; i < NR_RETRY_CNT; i++) {=0A=
+               ret =3D regmap_read(info->regmap, reg, &val);=0A=
+               if (ret =3D=3D -EBUSY)=0A=
+                       continue;=0A=
+               else=0A=
+                       break;=0A=
+       }=0A=
+=0A=
+       if (ret < 0)=0A=
+               dev_err(&info->pdev->dev, "axp288 reg read err:%d\n", ret);=
=0A=
+=0A=
+       return val;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_reg_writeb(struct axp288_fg_info *info, int reg, u8 =
val)=0A=
+{=0A=
+       int ret;=0A=
+=0A=
+       ret =3D regmap_write(info->regmap, reg, (unsigned int)val);=0A=
+=0A=
+       if (ret < 0)=0A=
+               dev_err(&info->pdev->dev, "axp288 reg write err:%d\n", ret)=
;=0A=
+=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static int pmic_read_adc_val(const char *name, int *raw_val,=0A=
+               struct axp288_fg_info *info)=0A=
+{=0A=
+       int ret, val =3D 0;=0A=
+       struct iio_channel *indio_chan;=0A=
+=0A=
+       indio_chan =3D iio_channel_get(NULL, name);=0A=
+       if (IS_ERR_OR_NULL(indio_chan)) {=0A=
+               ret =3D PTR_ERR(indio_chan);=0A=
+               goto exit;=0A=
+       }=0A=
+       ret =3D iio_read_channel_raw(indio_chan, &val);=0A=
+       if (ret < 0) {=0A=
+               dev_err(&info->pdev->dev,=0A=
+                       "IIO channel read error: %x, %x\n", ret, val);=0A=
+               goto err_exit;=0A=
+       }=0A=
+=0A=
+       dev_dbg(&info->pdev->dev, "adc raw val=3D%x\n", val);=0A=
+       *raw_val =3D val;=0A=
+=0A=
+err_exit:=0A=
+       iio_channel_release(indio_chan);=0A=
+exit:=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+#ifdef CONFIG_DEBUG_FS=0A=
+static int fuel_gauge_debug_show(struct seq_file *s, void *data)=0A=
+{=0A=
+       struct axp288_fg_info *info =3D s->private;=0A=
+       int raw_val, ret;=0A=
+=0A=
+       seq_printf(s, " PWR_STATUS[%02x] : %02x\n",=0A=
+               AXP20X_PWR_INPUT_STATUS,=0A=
+               fuel_gauge_reg_readb(info, AXP20X_PWR_INPUT_STATUS));=0A=
+       seq_printf(s, "PWR_OP_MODE[%02x] : %02x\n",=0A=
+               AXP20X_PWR_OP_MODE,=0A=
+               fuel_gauge_reg_readb(info, AXP20X_PWR_OP_MODE));=0A=
+       seq_printf(s, " CHRG_CTRL1[%02x] : %02x\n",=0A=
+               AXP20X_CHRG_CTRL1,=0A=
+               fuel_gauge_reg_readb(info, AXP20X_CHRG_CTRL1));=0A=
+       seq_printf(s, "       VLTF[%02x] : %02x\n",=0A=
+               AXP20X_V_LTF_DISCHRG,=0A=
+               fuel_gauge_reg_readb(info, AXP20X_V_LTF_DISCHRG));=0A=
+       seq_printf(s, "       VHTF[%02x] : %02x\n",=0A=
+               AXP20X_V_HTF_DISCHRG,=0A=
+               fuel_gauge_reg_readb(info, AXP20X_V_HTF_DISCHRG));=0A=
+       seq_printf(s, "    CC_CTRL[%02x] : %02x\n",=0A=
+               AXP20X_CC_CTRL,=0A=
+               fuel_gauge_reg_readb(info, AXP20X_CC_CTRL));=0A=
+       seq_printf(s, "BATTERY CAP[%02x] : %02x\n",=0A=
+               AXP20X_FG_RES,=0A=
+               fuel_gauge_reg_readb(info, AXP20X_FG_RES));=0A=
+       seq_printf(s, "    FG_RDC1[%02x] : %02x\n",=0A=
+               AXP288_FG_RDC1_REG,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_RDC1_REG));=0A=
+       seq_printf(s, "    FG_RDC0[%02x] : %02x\n",=0A=
+               AXP288_FG_RDC0_REG,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_RDC0_REG));=0A=
+       seq_printf(s, "    FG_OCVH[%02x] : %02x\n",=0A=
+               AXP288_FG_OCVH_REG,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_OCVH_REG));=0A=
+       seq_printf(s, "    FG_OCVL[%02x] : %02x\n",=0A=
+               AXP288_FG_OCVL_REG,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_OCVL_REG));=0A=
+       seq_printf(s, "FG_DES_CAP1[%02x] : %02x\n",=0A=
+               AXP288_FG_DES_CAP1_REG,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP1_REG));=0A=
+       seq_printf(s, "FG_DES_CAP0[%02x] : %02x\n",=0A=
+               AXP288_FG_DES_CAP0_REG,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP0_REG));=0A=
+       seq_printf(s, " FG_CC_MTR1[%02x] : %02x\n",=0A=
+               AXP288_FG_CC_MTR1_REG,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_CC_MTR1_REG));=0A=
+       seq_printf(s, " FG_CC_MTR0[%02x] : %02x\n",=0A=
+               AXP288_FG_CC_MTR0_REG,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_CC_MTR0_REG));=0A=
+       seq_printf(s, " FG_OCV_CAP[%02x] : %02x\n",=0A=
+               AXP288_FG_OCV_CAP_REG,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_OCV_CAP_REG));=0A=
+       seq_printf(s, "  FG_CC_CAP[%02x] : %02x\n",=0A=
+               AXP288_FG_CC_CAP_REG,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_CC_CAP_REG));=0A=
+       seq_printf(s, " FG_LOW_CAP[%02x] : %02x\n",=0A=
+               AXP288_FG_LOW_CAP_REG,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_LOW_CAP_REG));=0A=
+       seq_printf(s, "TUNING_CTL0[%02x] : %02x\n",=0A=
+               AXP288_FG_TUNE0,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_TUNE0));=0A=
+       seq_printf(s, "TUNING_CTL1[%02x] : %02x\n",=0A=
+               AXP288_FG_TUNE1,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_TUNE1));=0A=
+       seq_printf(s, "TUNING_CTL2[%02x] : %02x\n",=0A=
+               AXP288_FG_TUNE2,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_TUNE2));=0A=
+       seq_printf(s, "TUNING_CTL3[%02x] : %02x\n",=0A=
+               AXP288_FG_TUNE3,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_TUNE3));=0A=
+       seq_printf(s, "TUNING_CTL4[%02x] : %02x\n",=0A=
+               AXP288_FG_TUNE4,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_TUNE4));=0A=
+       seq_printf(s, "TUNING_CTL5[%02x] : %02x\n",=0A=
+               AXP288_FG_TUNE5,=0A=
+               fuel_gauge_reg_readb(info, AXP288_FG_TUNE5));=0A=
+=0A=
+       ret =3D pmic_read_adc_val("axp288-batt-temp", &raw_val, info);=0A=
+       if (ret >=3D 0)=0A=
+               seq_printf(s, "axp288-batttemp : %d\n", raw_val);=0A=
+       ret =3D pmic_read_adc_val("axp288-pmic-temp", &raw_val, info);=0A=
+       if (ret >=3D 0)=0A=
+               seq_printf(s, "axp288-pmictemp : %d\n", raw_val);=0A=
+       ret =3D pmic_read_adc_val("axp288-system-temp", &raw_val, info);=0A=
+       if (ret >=3D 0)=0A=
+               seq_printf(s, "axp288-systtemp : %d\n", raw_val);=0A=
+       ret =3D pmic_read_adc_val("axp288-chrg-curr", &raw_val, info);=0A=
+       if (ret >=3D 0)=0A=
+               seq_printf(s, "axp288-chrgcurr : %d\n", raw_val);=0A=
+       ret =3D pmic_read_adc_val("axp288-chrg-d-curr", &raw_val, info);=0A=
+       if (ret >=3D 0)=0A=
+               seq_printf(s, "axp288-dchrgcur : %d\n", raw_val);=0A=
+       ret =3D pmic_read_adc_val("axp288-batt-volt", &raw_val, info);=0A=
+       if (ret >=3D 0)=0A=
+               seq_printf(s, "axp288-battvolt : %d\n", raw_val);=0A=
+=0A=
+       return 0;=0A=
+}=0A=
+=0A=
+static int debug_open(struct inode *inode, struct file *file)=0A=
+{=0A=
+       return single_open(file, fuel_gauge_debug_show, inode->i_private);=
=0A=
+}=0A=
+=0A=
+static const struct file_operations fg_debug_fops =3D {=0A=
+       .open       =3D debug_open,=0A=
+       .read       =3D seq_read,=0A=
+       .llseek     =3D seq_lseek,=0A=
+       .release    =3D single_release,=0A=
+};=0A=
+=0A=
+static void fuel_gauge_create_debugfs(struct axp288_fg_info *info)=0A=
+{=0A=
+       info->debug_file =3D debugfs_create_file("fuelgauge", 0666, NULL,=
=0A=
+               info, &fg_debug_fops);=0A=
+}=0A=
+=0A=
+static void fuel_gauge_remove_debugfs(struct axp288_fg_info *info)=0A=
+{=0A=
+       debugfs_remove(info->debug_file);=0A=
+}=0A=
+#else=0A=
+static inline void fuel_gauge_create_debugfs(struct axp288_fg_info *info)=
=0A=
+{=0A=
+}=0A=
+static inline void fuel_gauge_remove_debugfs(struct axp288_fg_info *info)=
=0A=
+{=0A=
+}=0A=
+#endif=0A=
+=0A=
+static void fuel_gauge_get_status(struct axp288_fg_info *info)=0A=
+{=0A=
+       int pwr_stat, ret;=0A=
+       int charge, discharge;=0A=
+=0A=
+       pwr_stat =3D fuel_gauge_reg_readb(info, AXP20X_PWR_INPUT_STATUS);=
=0A=
+       if (pwr_stat < 0) {=0A=
+               dev_err(&info->pdev->dev,=0A=
+                       "PWR STAT read failed:%d\n", pwr_stat);=0A=
+               return;=0A=
+       }=0A=
+       ret =3D pmic_read_adc_val("axp288-chrg-curr", &charge, info);=0A=
+       if (ret < 0) {=0A=
+               dev_err(&info->pdev->dev,=0A=
+                       "ADC charge current read failed:%d\n", ret);=0A=
+               return;=0A=
+       }=0A=
+       ret =3D pmic_read_adc_val("axp288-chrg-d-curr", &discharge, info);=
=0A=
+       if (ret < 0) {=0A=
+               dev_err(&info->pdev->dev,=0A=
+                       "ADC discharge current read failed:%d\n", ret);=0A=
+               return;=0A=
+       }=0A=
+=0A=
+       if (charge > 0)=0A=
+               info->status =3D POWER_SUPPLY_STATUS_CHARGING;=0A=
+       else if (discharge > 0)=0A=
+               info->status =3D POWER_SUPPLY_STATUS_DISCHARGING;=0A=
+       else {=0A=
+               if (pwr_stat & CHRG_STAT_BAT_PRESENT)=0A=
+                       info->status =3D POWER_SUPPLY_STATUS_FULL;=0A=
+               else=0A=
+                       info->status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;=
=0A=
+       }=0A=
+}=0A=
+=0A=
+static int fuel_gauge_get_vbatt(struct axp288_fg_info *info, int *vbatt)=
=0A=
+{=0A=
+       int ret =3D 0, raw_val;=0A=
+=0A=
+       ret =3D pmic_read_adc_val("axp288-batt-volt", &raw_val, info);=0A=
+       if (ret < 0)=0A=
+               goto vbatt_read_fail;=0A=
+=0A=
+       *vbatt =3D VOLTAGE_FROM_ADC(raw_val);=0A=
+vbatt_read_fail:=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_get_current(struct axp288_fg_info *info, int *cur)=
=0A=
+{=0A=
+       int ret, value =3D 0;=0A=
+       int charge, discharge;=0A=
+=0A=
+       ret =3D pmic_read_adc_val("axp288-chrg-curr", &charge, info);=0A=
+       if (ret < 0)=0A=
+               goto current_read_fail;=0A=
+       ret =3D pmic_read_adc_val("axp288-chrg-d-curr", &discharge, info);=
=0A=
+       if (ret < 0)=0A=
+               goto current_read_fail;=0A=
+=0A=
+       if (charge > 0)=0A=
+               value =3D charge;=0A=
+       else if (discharge > 0)=0A=
+               value =3D -1 * discharge;=0A=
+=0A=
+       *cur =3D value;=0A=
+current_read_fail:=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static int temp_to_adc(struct axp288_fg_info *info, int tval)=0A=
+{=0A=
+       int rntc =3D 0, i, ret, adc_val;=0A=
+       int rmin, rmax, tmin, tmax;=0A=
+       int tcsz =3D info->pdata->tcsz;=0A=
+=0A=
+       /* get the Rntc resitance value for this temp */=0A=
+       if (tval > info->pdata->thermistor_curve[0][1]) {=0A=
+               rntc =3D info->pdata->thermistor_curve[0][0];=0A=
+       } else if (tval <=3D info->pdata->thermistor_curve[tcsz-1][1]) {=0A=
+               rntc =3D info->pdata->thermistor_curve[tcsz-1][0];=0A=
+       } else {=0A=
+               for (i =3D 1; i < tcsz; i++) {=0A=
+                       if (tval > info->pdata->thermistor_curve[i][1]) {=
=0A=
+                               rmin =3D info->pdata->thermistor_curve[i-1]=
[0];=0A=
+                               rmax =3D info->pdata->thermistor_curve[i][0=
];=0A=
+                               tmin =3D info->pdata->thermistor_curve[i-1]=
[1];=0A=
+                               tmax =3D info->pdata->thermistor_curve[i][1=
];=0A=
+                               rntc =3D rmin + ((rmax - rmin) *=0A=
+                                       (tval - tmin) / (tmax - tmin));=0A=
+                               break;=0A=
+                       }=0A=
+               }=0A=
+       }=0A=
+=0A=
+       /* we need the current to calculate the proper adc voltage */=0A=
+       ret =3D fuel_gauge_reg_readb(info, AXP20X_ADC_RATE);=0A=
+       if (ret < 0) {=0A=
+               dev_err(&info->pdev->dev, "%s:read err:%d\n", __func__, ret=
);=0A=
+               ret =3D 0x30;=0A=
+       }=0A=
+=0A=
+       /*=0A=
+        * temperature is proportional to NTS thermistor resistance=0A=
+        * ADC_RATE[5-4] determines current, 00=3D20uA,01=3D40uA,10=3D60uA,=
11=3D80uA=0A=
+        * [12-bit ADC VAL] =3D R_NTC(=D9) * current / 800=0A=
+        */=0A=
+       adc_val =3D rntc * (20 + (20 * ((ret >> 4) & 0x3))) / 800;=0A=
+=0A=
+       return adc_val;=0A=
+}=0A=
+=0A=
+static int adc_to_temp(struct axp288_fg_info *info, int adc_val)=0A=
+{=0A=
+       int ret, r, i, tval =3D 0;=0A=
+       int rmin, rmax, tmin, tmax;=0A=
+       int tcsz =3D info->pdata->tcsz;=0A=
+=0A=
+       ret =3D fuel_gauge_reg_readb(info, AXP20X_ADC_RATE);=0A=
+       if (ret < 0) {=0A=
+               dev_err(&info->pdev->dev, "%s:read err:%d\n", __func__, ret=
);=0A=
+               ret =3D 0x30;=0A=
+       }=0A=
+=0A=
+       /*=0A=
+        * temperature is proportional to NTS thermistor resistance=0A=
+        * ADC_RATE[5-4] determines current, 00=3D20uA,01=3D40uA,10=3D60uA,=
11=3D80uA=0A=
+        * R_NTC(=D9) =3D [12-bit ADC VAL] * 800 / current=0A=
+        */=0A=
+       r =3D adc_val * 800 / (20 + (20 * ((ret >> 4) & 0x3)));=0A=
+=0A=
+       if (r < info->pdata->thermistor_curve[0][0]) {=0A=
+               tval =3D info->pdata->thermistor_curve[0][1];=0A=
+       } else if (r >=3D info->pdata->thermistor_curve[tcsz-1][0]) {=0A=
+               tval =3D info->pdata->thermistor_curve[tcsz-1][1];=0A=
+       } else {=0A=
+               for (i =3D 1; i < tcsz; i++) {=0A=
+                       if (r < info->pdata->thermistor_curve[i][0]) {=0A=
+                               rmin =3D info->pdata->thermistor_curve[i-1]=
[0];=0A=
+                               rmax =3D info->pdata->thermistor_curve[i][0=
];=0A=
+                               tmin =3D info->pdata->thermistor_curve[i-1]=
[1];=0A=
+                               tmax =3D info->pdata->thermistor_curve[i][1=
];=0A=
+                               tval =3D tmin + ((tmax - tmin) *=0A=
+                                       (r - rmin) / (rmax - rmin));=0A=
+                               break;=0A=
+                       }=0A=
+               }=0A=
+       }=0A=
+=0A=
+       return tval;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_get_btemp(struct axp288_fg_info *info, int *btemp)=
=0A=
+{=0A=
+       int ret, raw_val =3D 0;=0A=
+=0A=
+       ret =3D pmic_read_adc_val("axp288-batt-temp", &raw_val, info);=0A=
+       if (ret < 0)=0A=
+               goto temp_read_fail;=0A=
+=0A=
+       *btemp =3D adc_to_temp(info, raw_val);=0A=
+=0A=
+temp_read_fail:=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_get_vocv(struct axp288_fg_info *info, int *vocv)=0A=
+{=0A=
+       int ret, value;=0A=
+=0A=
+       /* 12-bit data value, upper 8 in OCVH, lower 4 in OCVL */=0A=
+       ret =3D fuel_gauge_reg_readb(info, AXP288_FG_OCVH_REG);=0A=
+       if (ret < 0)=0A=
+               goto vocv_read_fail;=0A=
+       value =3D ret << 4;=0A=
+=0A=
+       ret =3D fuel_gauge_reg_readb(info, AXP288_FG_OCVL_REG);=0A=
+       if (ret < 0)=0A=
+               goto vocv_read_fail;=0A=
+       value |=3D (ret & 0xf);=0A=
+=0A=
+       *vocv =3D VOLTAGE_FROM_ADC(value);=0A=
+vocv_read_fail:=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_battery_health(struct axp288_fg_info *info)=0A=
+{=0A=
+       int temp, vocv;=0A=
+       int ret, health =3D POWER_SUPPLY_HEALTH_UNKNOWN;=0A=
+=0A=
+       ret =3D fuel_gauge_get_btemp(info, &temp);=0A=
+       if (ret < 0)=0A=
+               goto health_read_fail;=0A=
+=0A=
+       ret =3D fuel_gauge_get_vocv(info, &vocv);=0A=
+       if (ret < 0)=0A=
+               goto health_read_fail;=0A=
+=0A=
+       if (vocv > info->pdata->max_volt)=0A=
+               health =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;=0A=
+       else if (temp > info->pdata->max_temp)=0A=
+               health =3D POWER_SUPPLY_HEALTH_OVERHEAT;=0A=
+       else if (temp < info->pdata->min_temp)=0A=
+               health =3D POWER_SUPPLY_HEALTH_COLD;=0A=
+       else if (vocv < info->pdata->min_volt)=0A=
+               health =3D POWER_SUPPLY_HEALTH_DEAD;=0A=
+       else=0A=
+               health =3D POWER_SUPPLY_HEALTH_GOOD;=0A=
+=0A=
+health_read_fail:=0A=
+       return health;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_set_high_btemp_alert(struct axp288_fg_info *info)=0A=
+{=0A=
+       int ret, adc_val;=0A=
+=0A=
+       /* program temperature threshold as 1/16 ADC value */=0A=
+       adc_val =3D temp_to_adc(info, info->pdata->max_temp);=0A=
+       ret =3D fuel_gauge_reg_writeb(info, AXP20X_V_HTF_DISCHRG, adc_val >=
> 4);=0A=
+=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_set_low_btemp_alert(struct axp288_fg_info *info)=0A=
+{=0A=
+       int ret, adc_val;=0A=
+=0A=
+       /* program temperature threshold as 1/16 ADC value */=0A=
+       adc_val =3D temp_to_adc(info, info->pdata->min_temp);=0A=
+       ret =3D fuel_gauge_reg_writeb(info, AXP20X_V_LTF_DISCHRG, adc_val >=
> 4);=0A=
+=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_get_property(struct power_supply *ps,=0A=
+               enum power_supply_property prop,=0A=
+               union power_supply_propval *val)=0A=
+{=0A=
+       struct axp288_fg_info *info =3D container_of(ps,=0A=
+                       struct axp288_fg_info, bat);=0A=
+       int ret =3D 0, value;=0A=
+=0A=
+       mutex_lock(&info->lock);=0A=
+       switch (prop) {=0A=
+       case POWER_SUPPLY_PROP_STATUS:=0A=
+               fuel_gauge_get_status(info);=0A=
+               val->intval =3D info->status;=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_HEALTH:=0A=
+               val->intval =3D fuel_gauge_battery_health(info);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_VOLTAGE_NOW:=0A=
+               ret =3D fuel_gauge_get_vbatt(info, &value);=0A=
+               if (ret < 0)=0A=
+                       goto fuel_gauge_read_err;=0A=
+               val->intval =3D PROP_VOLT(value);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_VOLTAGE_OCV:=0A=
+               ret =3D fuel_gauge_get_vocv(info, &value);=0A=
+               if (ret < 0)=0A=
+                       goto fuel_gauge_read_err;=0A=
+               val->intval =3D PROP_VOLT(value);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_CURRENT_NOW:=0A=
+               ret =3D fuel_gauge_get_current(info, &value);=0A=
+               if (ret < 0)=0A=
+                       goto fuel_gauge_read_err;=0A=
+               val->intval =3D PROP_CURR(value);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_PRESENT:=0A=
+               ret =3D fuel_gauge_reg_readb(info, AXP20X_PWR_OP_MODE);=0A=
+               if (ret < 0)=0A=
+                       goto fuel_gauge_read_err;=0A=
+=0A=
+               if (ret & CHRG_STAT_BAT_PRESENT)=0A=
+                       val->intval =3D 1;=0A=
+               else=0A=
+                       val->intval =3D 0;=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_CAPACITY:=0A=
+               ret =3D fuel_gauge_reg_readb(info, AXP20X_FG_RES);=0A=
+               if (ret < 0)=0A=
+                       goto fuel_gauge_read_err;=0A=
+=0A=
+               if (!(ret & FG_REP_CAP_VALID))=0A=
+                       dev_err(&info->pdev->dev,=0A=
+                               "capacity measurement not valid\n");=0A=
+               val->intval =3D (ret & FG_REP_CAP_VAL_MASK);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:=0A=
+               ret =3D fuel_gauge_reg_readb(info, AXP288_FG_LOW_CAP_REG);=
=0A=
+               if (ret < 0)=0A=
+                       goto fuel_gauge_read_err;=0A=
+               val->intval =3D (ret & 0x0f);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_TEMP:=0A=
+               ret =3D fuel_gauge_get_btemp(info, &value);=0A=
+               if (ret < 0)=0A=
+                       goto fuel_gauge_read_err;=0A=
+               val->intval =3D PROP_TEMP(value);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_TEMP_MAX:=0A=
+       case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:=0A=
+               val->intval =3D PROP_TEMP(info->pdata->max_temp);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_TEMP_MIN:=0A=
+       case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:=0A=
+               val->intval =3D PROP_TEMP(info->pdata->min_temp);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_TECHNOLOGY:=0A=
+               val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_CHARGE_NOW:=0A=
+               ret =3D fuel_gauge_reg_readb(info, AXP288_FG_CC_MTR1_REG);=
=0A=
+               if (ret < 0)=0A=
+                       goto fuel_gauge_read_err;=0A=
+=0A=
+               value =3D (ret & FG_CC_MTR1_VAL_MASK) << 8;=0A=
+               ret =3D fuel_gauge_reg_readb(info, AXP288_FG_CC_MTR0_REG);=
=0A=
+               if (ret < 0)=0A=
+                       goto fuel_gauge_read_err;=0A=
+               value |=3D (ret & FG_CC_MTR0_VAL_MASK);=0A=
+               val->intval =3D value * FG_DES_CAP_RES_LSB;=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_CHARGE_FULL:=0A=
+               ret =3D fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP1_REG);=
=0A=
+               if (ret < 0)=0A=
+                       goto fuel_gauge_read_err;=0A=
+=0A=
+               value =3D (ret & FG_DES_CAP1_VAL_MASK) << 8;=0A=
+               ret =3D fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP0_REG);=
=0A=
+               if (ret < 0)=0A=
+                       goto fuel_gauge_read_err;=0A=
+               value |=3D (ret & FG_DES_CAP0_VAL_MASK);=0A=
+               val->intval =3D value * FG_DES_CAP_RES_LSB;=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:=0A=
+               val->intval =3D PROP_CURR(info->pdata->design_cap);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:=0A=
+               val->intval =3D PROP_VOLT(info->pdata->max_volt);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:=0A=
+               val->intval =3D PROP_VOLT(info->pdata->min_volt);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_MODEL_NAME:=0A=
+               val->strval =3D info->pdata->battid;=0A=
+               break;=0A=
+       default:=0A=
+               mutex_unlock(&info->lock);=0A=
+               return -EINVAL;=0A=
+       }=0A=
+=0A=
+       mutex_unlock(&info->lock);=0A=
+       return 0;=0A=
+=0A=
+fuel_gauge_read_err:=0A=
+       mutex_unlock(&info->lock);=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_set_property(struct power_supply *ps,=0A=
+               enum power_supply_property prop,=0A=
+               const union power_supply_propval *val)=0A=
+{=0A=
+       struct axp288_fg_info *info =3D container_of(ps,=0A=
+                               struct axp288_fg_info, bat);=0A=
+       int ret =3D 0;=0A=
+=0A=
+       mutex_lock(&info->lock);=0A=
+       switch (prop) {=0A=
+       case POWER_SUPPLY_PROP_STATUS:=0A=
+               info->status =3D val->intval;=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_TEMP_MIN:=0A=
+       case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:=0A=
+               if ((val->intval < PD_DEF_MIN_TEMP) ||=0A=
+                       (val->intval > PD_DEF_MAX_TEMP)) {=0A=
+                       ret =3D -EINVAL;=0A=
+                       break;=0A=
+               }=0A=
+               info->pdata->min_temp =3D UNPROP_TEMP(val->intval);=0A=
+               ret =3D fuel_gauge_set_low_btemp_alert(info);=0A=
+               if (ret < 0)=0A=
+                       dev_err(&info->pdev->dev,=0A=
+                               "temp alert min set fail:%d\n", ret);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_TEMP_MAX:=0A=
+       case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:=0A=
+               if ((val->intval < PD_DEF_MIN_TEMP) ||=0A=
+                       (val->intval > PD_DEF_MAX_TEMP)) {=0A=
+                       ret =3D -EINVAL;=0A=
+                       break;=0A=
+               }=0A=
+               info->pdata->max_temp =3D UNPROP_TEMP(val->intval);=0A=
+               ret =3D fuel_gauge_set_high_btemp_alert(info);=0A=
+               if (ret < 0)=0A=
+                       dev_err(&info->pdev->dev,=0A=
+                               "temp alert max set fail:%d\n", ret);=0A=
+               break;=0A=
+       case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:=0A=
+               if ((val->intval < 0) || (val->intval > 15)) {=0A=
+                       ret =3D -EINVAL;=0A=
+                       break;=0A=
+               }=0A=
+               ret =3D fuel_gauge_reg_readb(info, AXP288_FG_LOW_CAP_REG);=
=0A=
+               if (ret < 0)=0A=
+                       break;=0A=
+               ret &=3D 0xf0;=0A=
+               ret |=3D (val->intval & 0xf);=0A=
+               ret =3D fuel_gauge_reg_writeb(info, AXP288_FG_LOW_CAP_REG, =
ret);=0A=
+               break;=0A=
+       default:=0A=
+               ret =3D -EINVAL;=0A=
+               break;=0A=
+       }=0A=
+=0A=
+       mutex_unlock(&info->lock);=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_property_is_writeable(struct power_supply *psy,=0A=
+       enum power_supply_property psp)=0A=
+{=0A=
+       int ret;=0A=
+=0A=
+       switch (psp) {=0A=
+       case POWER_SUPPLY_PROP_STATUS:=0A=
+       case POWER_SUPPLY_PROP_TEMP_MIN:=0A=
+       case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:=0A=
+       case POWER_SUPPLY_PROP_TEMP_MAX:=0A=
+       case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:=0A=
+       case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:=0A=
+               ret =3D 1;=0A=
+               break;=0A=
+       default:=0A=
+               ret =3D 0;=0A=
+       }=0A=
+=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static void fuel_gauge_status_monitor(struct work_struct *work)=0A=
+{=0A=
+       struct axp288_fg_info *info =3D container_of(work,=0A=
+               struct axp288_fg_info, status_monitor.work);=0A=
+=0A=
+       fuel_gauge_get_status(info);=0A=
+       power_supply_changed(&info->bat);=0A=
+       schedule_delayed_work(&info->status_monitor, STATUS_MON_DELAY_JIFFI=
ES);=0A=
+}=0A=
+=0A=
+static irqreturn_t fuel_gauge_thread_handler(int irq, void *dev)=0A=
+{=0A=
+       struct axp288_fg_info *info =3D dev;=0A=
+       int i;=0A=
+=0A=
+       for (i =3D 0; i < AXP288_FG_INTR_NUM; i++) {=0A=
+               if (info->irq[i] =3D=3D irq)=0A=
+                       break;=0A=
+       }=0A=
+=0A=
+       if (i >=3D AXP288_FG_INTR_NUM) {=0A=
+               dev_warn(&info->pdev->dev, "spurious interrupt!!\n");=0A=
+               return IRQ_NONE;=0A=
+       }=0A=
+=0A=
+       switch (i) {=0A=
+       case QWBTU_IRQ:=0A=
+               dev_info(&info->pdev->dev,=0A=
+                       "Quit Battery under temperature in work mode IRQ (Q=
WBTU)\n");=0A=
+               break;=0A=
+       case WBTU_IRQ:=0A=
+               dev_info(&info->pdev->dev,=0A=
+                       "Battery under temperature in work mode IRQ (WBTU)\=
n");=0A=
+               break;=0A=
+       case QWBTO_IRQ:=0A=
+               dev_info(&info->pdev->dev,=0A=
+                       "Quit Battery over temperature in work mode IRQ (QW=
BTO)\n");=0A=
+               break;=0A=
+       case WBTO_IRQ:=0A=
+               dev_info(&info->pdev->dev,=0A=
+                       "Battery over temperature in work mode IRQ (WBTO)\n=
");=0A=
+               break;=0A=
+       case WL2_IRQ:=0A=
+               dev_info(&info->pdev->dev, "Low Batt Warning(2) INTR\n");=
=0A=
+               break;=0A=
+       case WL1_IRQ:=0A=
+               dev_info(&info->pdev->dev, "Low Batt Warning(1) INTR\n");=
=0A=
+               break;=0A=
+       default:=0A=
+               dev_warn(&info->pdev->dev, "Spurious Interrupt!!!\n");=0A=
+       }=0A=
+=0A=
+       power_supply_changed(&info->bat);=0A=
+       return IRQ_HANDLED;=0A=
+}=0A=
+=0A=
+static void fuel_gauge_external_power_changed(struct power_supply *psy)=0A=
+{=0A=
+       struct axp288_fg_info *info =3D container_of(psy,=0A=
+                               struct axp288_fg_info, bat);=0A=
+=0A=
+       power_supply_changed(&info->bat);=0A=
+}=0A=
+=0A=
+static int fuel_gauge_set_lowbatt_thresholds(struct axp288_fg_info *info)=
=0A=
+{=0A=
+       int ret;=0A=
+       u8 reg_val;=0A=
+=0A=
+       ret =3D fuel_gauge_reg_readb(info, AXP20X_FG_RES);=0A=
+       if (ret < 0) {=0A=
+               dev_err(&info->pdev->dev, "%s:read err:%d\n", __func__, ret=
);=0A=
+               return ret;=0A=
+       }=0A=
+       ret =3D (ret & FG_REP_CAP_VAL_MASK);=0A=
+=0A=
+       if (ret > FG_LOW_CAP_WARN_THR)=0A=
+               reg_val =3D FG_LOW_CAP_WARN_THR;=0A=
+       else if (ret > FG_LOW_CAP_CRIT_THR)=0A=
+               reg_val =3D FG_LOW_CAP_CRIT_THR;=0A=
+       else=0A=
+               reg_val =3D FG_LOW_CAP_SHDN_THR;=0A=
+=0A=
+       reg_val |=3D FG_LOW_CAP_THR1_VAL;=0A=
+       ret =3D fuel_gauge_reg_writeb(info, AXP288_FG_LOW_CAP_REG, reg_val)=
;=0A=
+       if (ret < 0)=0A=
+               dev_err(&info->pdev->dev, "%s:write err:%d\n", __func__, re=
t);=0A=
+=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_program_vbatt_full(struct axp288_fg_info *info)=0A=
+{=0A=
+       int ret;=0A=
+       u8 val;=0A=
+=0A=
+       ret =3D fuel_gauge_reg_readb(info, AXP20X_CHRG_CTRL1);=0A=
+       if (ret < 0)=0A=
+               goto fg_prog_ocv_fail;=0A=
+       else=0A=
+               val =3D (ret & ~CHRG_CCCV_CV_MASK);=0A=
+=0A=
+       switch (info->pdata->max_volt) {=0A=
+       case CV_4100:=0A=
+               val |=3D (CHRG_CCCV_CV_4100MV << CHRG_CCCV_CV_BIT_POS);=0A=
+               break;=0A=
+       case CV_4150:=0A=
+               val |=3D (CHRG_CCCV_CV_4150MV << CHRG_CCCV_CV_BIT_POS);=0A=
+               break;=0A=
+       case CV_4200:=0A=
+               val |=3D (CHRG_CCCV_CV_4200MV << CHRG_CCCV_CV_BIT_POS);=0A=
+               break;=0A=
+       case CV_4350:=0A=
+               val |=3D (CHRG_CCCV_CV_4350MV << CHRG_CCCV_CV_BIT_POS);=0A=
+               break;=0A=
+       default:=0A=
+               val |=3D (CHRG_CCCV_CV_4200MV << CHRG_CCCV_CV_BIT_POS);=0A=
+               break;=0A=
+       }=0A=
+=0A=
+       ret =3D fuel_gauge_reg_writeb(info, AXP20X_CHRG_CTRL1, val);=0A=
+fg_prog_ocv_fail:=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_program_design_cap(struct axp288_fg_info *info)=0A=
+{=0A=
+       int ret;=0A=
+=0A=
+       ret =3D fuel_gauge_reg_writeb(info,=0A=
+               AXP288_FG_DES_CAP1_REG, info->pdata->cap1);=0A=
+       if (ret < 0)=0A=
+               goto fg_prog_descap_fail;=0A=
+=0A=
+       ret =3D fuel_gauge_reg_writeb(info,=0A=
+               AXP288_FG_DES_CAP0_REG, info->pdata->cap0);=0A=
+=0A=
+fg_prog_descap_fail:=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_program_ocv_curve(struct axp288_fg_info *info)=0A=
+{=0A=
+       int ret =3D 0, i;=0A=
+=0A=
+       for (i =3D 0; i < OCV_CURVE_SIZE; i++) {=0A=
+               ret =3D fuel_gauge_reg_writeb(info,=0A=
+                       AXP288_FG_OCV_CURVE_REG + i, info->pdata->ocv_curve=
[i]);=0A=
+               if (ret < 0)=0A=
+                       goto fg_prog_ocv_fail;=0A=
+       }=0A=
+=0A=
+fg_prog_ocv_fail:=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static int fuel_gauge_program_rdc_vals(struct axp288_fg_info *info)=0A=
+{=0A=
+       int ret;=0A=
+=0A=
+       ret =3D fuel_gauge_reg_writeb(info,=0A=
+               AXP288_FG_RDC1_REG, info->pdata->rdc1);=0A=
+       if (ret < 0)=0A=
+               goto fg_prog_ocv_fail;=0A=
+=0A=
+       ret =3D fuel_gauge_reg_writeb(info,=0A=
+               AXP288_FG_RDC0_REG, info->pdata->rdc0);=0A=
+=0A=
+fg_prog_ocv_fail:=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static void fuel_gauge_init_config_regs(struct axp288_fg_info *info)=0A=
+{=0A=
+       int ret;=0A=
+=0A=
+       /*=0A=
+        * check if the config data is already=0A=
+        * programmed and if so just return.=0A=
+        */=0A=
+=0A=
+       ret =3D fuel_gauge_reg_readb(info, AXP288_FG_DES_CAP1_REG);=0A=
+       if (ret < 0) {=0A=
+               dev_warn(&info->pdev->dev, "CAP1 reg read err!!\n");=0A=
+       } else if (!(ret & FG_DES_CAP1_VALID)) {=0A=
+               dev_info(&info->pdev->dev, "FG data needs to be initialized=
\n");=0A=
+       } else {=0A=
+               dev_info(&info->pdev->dev, "FG data is already initialized\=
n");=0A=
+               return;=0A=
+       }=0A=
+=0A=
+       ret =3D fuel_gauge_program_vbatt_full(info);=0A=
+       if (ret < 0)=0A=
+               dev_err(&info->pdev->dev, "set vbatt full fail:%d\n", ret);=
=0A=
+=0A=
+       ret =3D fuel_gauge_program_design_cap(info);=0A=
+       if (ret < 0)=0A=
+               dev_err(&info->pdev->dev, "set design cap fail:%d\n", ret);=
=0A=
+=0A=
+       ret =3D fuel_gauge_program_rdc_vals(info);=0A=
+       if (ret < 0)=0A=
+               dev_err(&info->pdev->dev, "set rdc fail:%d\n", ret);=0A=
+=0A=
+       ret =3D fuel_gauge_program_ocv_curve(info);=0A=
+       if (ret < 0)=0A=
+               dev_err(&info->pdev->dev, "set ocv curve fail:%d\n", ret);=
=0A=
+=0A=
+       ret =3D fuel_gauge_set_lowbatt_thresholds(info);=0A=
+       if (ret < 0)=0A=
+               dev_err(&info->pdev->dev, "lowbatt thr set fail:%d\n", ret)=
;=0A=
+=0A=
+       ret =3D fuel_gauge_reg_writeb(info, AXP20X_CC_CTRL, 0xef);=0A=
+       if (ret < 0)=0A=
+               dev_err(&info->pdev->dev, "gauge cntl set fail:%d\n", ret);=
=0A=
+}=0A=
+=0A=
+static void fuel_gauge_init_irq(struct axp288_fg_info *info)=0A=
+{=0A=
+       int ret, i, pirq;=0A=
+=0A=
+       for (i =3D 0; i < AXP288_FG_INTR_NUM; i++) {=0A=
+               pirq =3D platform_get_irq(info->pdev, i);=0A=
+               info->irq[i] =3D regmap_irq_get_virq(info->regmap_irqc, pir=
q);=0A=
+               if (info->irq[i] < 0) {=0A=
+                       dev_warn(&info->pdev->dev,=0A=
+                               "regmap_irq get virq failed for IRQ %d: %d\=
n",=0A=
+                               pirq, info->irq[i]);=0A=
+                       info->irq[i] =3D -1;=0A=
+                       goto intr_failed;=0A=
+               }=0A=
+               ret =3D request_threaded_irq(info->irq[i],=0A=
+                               NULL, fuel_gauge_thread_handler,=0A=
+                               IRQF_ONESHOT, DEV_NAME, info);=0A=
+               if (ret) {=0A=
+                       dev_warn(&info->pdev->dev,=0A=
+                               "request irq failed for IRQ %d: %d\n",=0A=
+                               pirq, info->irq[i]);=0A=
+                       info->irq[i] =3D -1;=0A=
+                       goto intr_failed;=0A=
+               } else {=0A=
+                       dev_info(&info->pdev->dev, "HW IRQ %d -> VIRQ %d\n"=
,=0A=
+                               pirq, info->irq[i]);=0A=
+               }=0A=
+       }=0A=
+       return;=0A=
+=0A=
+intr_failed:=0A=
+       for (; i > 0; i--) {=0A=
+               free_irq(info->irq[i - 1], info);=0A=
+               info->irq[i - 1] =3D -1;=0A=
+       }=0A=
+}=0A=
+=0A=
+static void fuel_gauge_init_hw_regs(struct axp288_fg_info *info)=0A=
+{=0A=
+       int ret;=0A=
+       unsigned int val;=0A=
+=0A=
+       ret =3D fuel_gauge_set_high_btemp_alert(info);=0A=
+       if (ret < 0)=0A=
+               dev_err(&info->pdev->dev, "high batt temp set fail:%d\n", r=
et);=0A=
+=0A=
+       ret =3D fuel_gauge_set_low_btemp_alert(info);=0A=
+       if (ret < 0)=0A=
+               dev_err(&info->pdev->dev, "low batt temp set fail:%d\n", re=
t);=0A=
+=0A=
+       /* enable interrupts */=0A=
+       val =3D fuel_gauge_reg_readb(info, AXP20X_IRQ3_EN);=0A=
+       val |=3D TEMP_IRQ_CFG_MASK;=0A=
+       fuel_gauge_reg_writeb(info, AXP20X_IRQ3_EN, val);=0A=
+=0A=
+       val =3D fuel_gauge_reg_readb(info, AXP20X_IRQ4_EN);=0A=
+       val |=3D FG_IRQ_CFG_LOWBATT_MASK;=0A=
+       val =3D fuel_gauge_reg_writeb(info, AXP20X_IRQ4_EN, val);=0A=
+}=0A=
+=0A=
+static int axp288_fuel_gauge_probe(struct platform_device *pdev)=0A=
+{=0A=
+       int ret;=0A=
+       struct axp288_fg_info *info;=0A=
+       struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);=0A=
+=0A=
+       info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);=0A=
+       if (!info)=0A=
+               return -ENOMEM;=0A=
+=0A=
+       info->pdev =3D pdev;=0A=
+       info->regmap =3D axp20x->regmap;=0A=
+       info->regmap_irqc =3D axp20x->regmap_irqc;=0A=
+       info->status =3D POWER_SUPPLY_STATUS_UNKNOWN;=0A=
+       info->pdata =3D pdev->dev.platform_data;=0A=
+       if (!info->pdata)=0A=
+               return -ENODEV;=0A=
+=0A=
+       platform_set_drvdata(pdev, info);=0A=
+=0A=
+       mutex_init(&info->lock);=0A=
+       INIT_DELAYED_WORK(&info->status_monitor, fuel_gauge_status_monitor)=
;=0A=
+=0A=
+       info->bat.name =3D DEV_NAME;=0A=
+       info->bat.type =3D POWER_SUPPLY_TYPE_BATTERY;=0A=
+       info->bat.properties =3D fuel_gauge_props;=0A=
+       info->bat.num_properties =3D ARRAY_SIZE(fuel_gauge_props);=0A=
+       info->bat.get_property =3D fuel_gauge_get_property;=0A=
+       info->bat.set_property =3D fuel_gauge_set_property;=0A=
+       info->bat.property_is_writeable =3D fuel_gauge_property_is_writeabl=
e;=0A=
+       info->bat.external_power_changed =3D fuel_gauge_external_power_chan=
ged;=0A=
+       ret =3D power_supply_register(&pdev->dev, &info->bat);=0A=
+       if (ret) {=0A=
+               dev_err(&pdev->dev, "failed to register battery: %d\n", ret=
);=0A=
+               return ret;=0A=
+       }=0A=
+=0A=
+       fuel_gauge_create_debugfs(info);=0A=
+       fuel_gauge_init_config_regs(info);=0A=
+       fuel_gauge_init_irq(info);=0A=
+       fuel_gauge_init_hw_regs(info);=0A=
+       schedule_delayed_work(&info->status_monitor, STATUS_MON_DELAY_JIFFI=
ES);=0A=
+=0A=
+       return ret;=0A=
+}=0A=
+=0A=
+static struct platform_device_id axp288_fg_id_table[] =3D {=0A=
+       { .name =3D DEV_NAME },=0A=
+       {},=0A=
+};=0A=
+=0A=
+static int axp288_fuel_gauge_remove(struct platform_device *pdev)=0A=
+{=0A=
+       struct axp288_fg_info *info =3D platform_get_drvdata(pdev);=0A=
+       int i;=0A=
+=0A=
+       cancel_delayed_work_sync(&info->status_monitor);=0A=
+       power_supply_unregister(&info->bat);=0A=
+       fuel_gauge_remove_debugfs(info);=0A=
+=0A=
+       for (i =3D 0; i < AXP288_FG_INTR_NUM; i++)=0A=
+               if (info->irq[i] >=3D 0)=0A=
+                       free_irq(info->irq[i], info);=0A=
+=0A=
+       return 0;=0A=
+}=0A=
+=0A=
+static struct platform_driver axp288_fuel_gauge_driver =3D {=0A=
+       .probe =3D axp288_fuel_gauge_probe,=0A=
+       .remove =3D axp288_fuel_gauge_remove,=0A=
+       .id_table =3D axp288_fg_id_table,=0A=
+       .driver =3D {=0A=
+               .name =3D DEV_NAME,=0A=
+       },=0A=
+};=0A=
+=0A=
+module_platform_driver(axp288_fuel_gauge_driver);=0A=
+=0A=
+MODULE_AUTHOR("Todd Brandt <todd.e.brandt@linux.intel.com>");=0A=
+MODULE_DESCRIPTION("Xpower AXP288 Fuel Gauge Driver");=0A=
+MODULE_LICENSE("GPL");=0A=
--=0A=
1.9.1=0A=
=0A=
