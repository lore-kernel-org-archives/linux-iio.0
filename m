Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f180.google.com ([209.85.210.180]:35783 "EHLO
        mail-wj0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbcLFNv0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2016 08:51:26 -0500
Received: by mail-wj0-f180.google.com with SMTP id v7so321602098wjy.2
        for <linux-iio@vger.kernel.org>; Tue, 06 Dec 2016 05:51:25 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 3/3] iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC
Date: Tue,  6 Dec 2016 14:51:19 +0100
Message-Id: <1481032279-27115-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Qualcomm PM8xxx PMICs contain a simpler ADC than its
successors (already in the kernel as qcom-spmi-adc.c):
the HK/XO ADC (Housekeeping/Chrystal oscillator ADC).

As far as I can understand this is equal to the PMICs
using SSBI transport and encompass PM8018, PM8038,
PM8058, PM8917 and PM8921, so this is shortly named
PM8xxx.

This ADC monitors a bunch of on-board voltages and the die
temperature of the PMIC itself, but it can also be routed
to convert a few external MPPs (multi-purpose pins). On
the APQ8060 DragonBoard this feature is used to let this
ADC convert an analog ALS (Ambient Light Sensor) voltage
signal from a Capella CM3605 ALS into a LUX value.

Developed and tested with APQ8060 DragonBoard based on
Ivan's driver. The SPMI VADC driver is quite different,
but share enough minor functionality that I have split
out to the common file in a previous patch.

Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: Ivan T. Ivanov <iivanov.xz@gmail.com>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/adc/Kconfig             |  10 +
 drivers/iio/adc/Makefile            |   1 +
 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 755 ++++++++++++++++++++++++++++++++++++
 3 files changed, 766 insertions(+)
 create mode 100644 drivers/iio/adc/qcom-pm8xxx-xoadc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7edcf3238620..f0b0cbdb9519 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -380,6 +380,16 @@ config PALMAS_GPADC
 	  is used in smartphones and tablets and supports a 16 channel
 	  general purpose ADC.
 
+config QCOM_PM8XXX_XOADC
+	tristate "Qualcomm SSBI PM8xxx PMIC XOADCs"
+	depends on MFD_PM8XXX
+	help
+	  ADC driver for the XOADC portions of the Qualcomm PM8xxx PMICs
+	  using SSBI transport: PM8018, PM8038, PM8058, PM8917, PM8921.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called qcom-pm8xxx-xoadc.
+
 config QCOM_SPMI_IADC
 	tristate "Qualcomm SPMI PMIC current ADC"
 	depends on SPMI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index f9468d228b1e..234d45c805f9 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
 obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
 qcom-vadc-y := qcom-vadc-common.o
 obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-vadc.o qcom-spmi-vadc.o
+obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-vadc.o qcom-pm8xxx-xoadc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_STX104) += stx104.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
new file mode 100644
index 000000000000..a045d260715b
--- /dev/null
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -0,0 +1,755 @@
+/*
+ * Qualcomm PM8xxx PMIC XOADC driver
+ *
+ * These ADCs are known as HK/XO (house keeping / chrystal oscillator)
+ * "XO" in "XOADC" means Chrystal Oscillator. It's a bunch of
+ * specific-purpose and general purpose ADC converters and channels.
+ *
+ * Copyright (C) 2016 Linaro Ltd.
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
+
+#include "qcom-vadc-common.h"
+
+/*
+ * Definitions for the "user processor" registers lifted from the v3.4
+ * Qualcomm tree. Their kernel has two out-of-tree drivers for the ADC:
+ * drivers/misc/pmic8058-xoadc.c
+ * drivers/hwmon/pm8xxx-adc.c
+ * None of them contain any complete register specification, so this is
+ * a best effort of combining the information.
+ */
+
+/* These appear to be "battery monitor" registers */
+#define ADC_ARB_BTM_CNTRL1			0x17e
+#define ADC_ARB_BTM_CNTRL1_EN_BTM		BIT(0)
+#define ADC_ARB_BTM_CNTRL1_SEL_OP_MODE		BIT(1)
+#define ADC_ARB_BTM_CNTRL1_MEAS_INTERVAL1	BIT(2)
+#define ADC_ARB_BTM_CNTRL1_MEAS_INTERVAL2	BIT(3)
+#define ADC_ARB_BTM_CNTRL1_MEAS_INTERVAL3	BIT(4)
+#define ADC_ARB_BTM_CNTRL1_MEAS_INTERVAL4	BIT(5)
+#define ADC_ARB_BTM_CNTRL1_EOC			BIT(6)
+#define ADC_ARB_BTM_CNTRL1_REQ			BIT(7)
+
+#define ADC_ARB_BTM_AMUX_CNTRL			0x17f
+#define ADC_ARB_BTM_ANA_PARAM			0x180
+#define ADC_ARB_BTM_DIG_PARAM			0x181
+#define ADC_ARB_BTM_RSV				0x182
+#define ADC_ARB_BTM_DATA1			0x183
+#define ADC_ARB_BTM_DATA0			0x184
+#define ADC_ARB_BTM_BAT_COOL_THR1		0x185
+#define ADC_ARB_BTM_BAT_COOL_THR0		0x186
+#define ADC_ARB_BTM_BAT_WARM_THR1		0x187
+#define ADC_ARB_BTM_BAT_WARM_THR0		0x188
+#define ADC_ARB_BTM_CNTRL2			0x18c
+
+/* Proper ADC registers */
+
+#define ADC_ARB_USRP_CNTRL			0x197
+#define ADC_ARB_USRP_CNTRL_EN_ARB		BIT(0)
+#define ADC_ARB_USRP_CNTRL_RSV1			BIT(1)
+#define ADC_ARB_USRP_CNTRL_RSV2			BIT(2)
+#define ADC_ARB_USRP_CNTRL_RSV3			BIT(3)
+#define ADC_ARB_USRP_CNTRL_RSV4			BIT(4)
+#define ADC_ARB_USRP_CNTRL_RSV5			BIT(5)
+#define ADC_ARB_USRP_CNTRL_EOC			BIT(6)
+#define ADC_ARB_USRP_CNTRL_REQ			BIT(7)
+
+#define ADC_ARB_USRP_AMUX_CNTRL			0x198
+#define ADC_ARB_USRP_AMUX_CNTRL_RSV0		BIT(0)
+#define ADC_ARB_USRP_AMUX_CNTRL_RSV1		BIT(1)
+#define ADC_ARB_USRP_AMUX_CNTRL_PREMUX0		BIT(2)
+#define ADC_ARB_USRP_AMUX_CNTRL_PREMUX1		BIT(3)
+#define ADC_ARB_USRP_AMUX_CNTRL_SEL0		BIT(4)
+#define ADC_ARB_USRP_AMUX_CNTRL_SEL1		BIT(5)
+#define ADC_ARB_USRP_AMUX_CNTRL_SEL2		BIT(6)
+#define ADC_ARB_USRP_AMUX_CNTRL_SEL3		BIT(7)
+#define ADC_AMUX_PREMUX_SHIFT			2
+#define ADC_AMUX_SEL_SHIFT			4
+
+/* We know very little about the bits in this register */
+#define ADC_ARB_USRP_ANA_PARAM			0x199
+#define ADC_ARB_USRP_ANA_PARAM_DIS		0xFE
+#define ADC_ARB_USRP_ANA_PARAM_EN		0xFF
+
+#define ADC_ARB_USRP_DIG_PARAM			0x19A
+#define ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT0	BIT(0)
+#define ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT1	BIT(1)
+#define ADC_ARB_USRP_DIG_PARAM_CLK_RATE0	BIT(2)
+#define ADC_ARB_USRP_DIG_PARAM_CLK_RATE1	BIT(3)
+#define ADC_ARB_USRP_DIG_PARAM_EOC		BIT(4)
+/*
+ * On a later ADC the decimation factors are defined as
+ * 00 = 512, 01 = 1024, 10 = 2048, 11 = 4096 so assume this
+ * holds also for this older XOADC.
+ */
+#define ADC_ARB_USRP_DIG_PARAM_DEC_RATE0	BIT(5)
+#define ADC_ARB_USRP_DIG_PARAM_DEC_RATE1	BIT(6)
+#define ADC_ARB_USRP_DIG_PARAM_EN		BIT(7)
+#define ADC_DIG_PARAM_DEC_SHIFT			5
+
+#define ADC_ARB_USRP_RSV			0x19B
+#define ADC_ARB_USRP_RSV_RST			BIT(0)
+#define ADC_ARB_USRP_RSV_DTEST0			BIT(1)
+#define ADC_ARB_USRP_RSV_DTEST1			BIT(2)
+#define ADC_ARB_USRP_RSV_OP			BIT(3)
+#define ADC_ARB_USRP_RSV_IP_SEL0		BIT(4)
+#define ADC_ARB_USRP_RSV_IP_SEL1		BIT(5)
+#define ADC_ARB_USRP_RSV_IP_SEL2		BIT(6)
+#define ADC_ARB_USRP_RSV_TRM			BIT(7)
+#define ADC_RSV_IP_SEL_SHIFT			4
+
+#define ADC_ARB_USRP_DATA0			0x19D
+#define ADC_ARB_USRP_DATA1			0x19C
+
+/* Physical channels. MPP = Multi-Purpose Pin */
+#define CHANNEL_VCOIN		0x0 /* Coincell */
+#define CHANNEL_VBAT		0x1 /* Battery voltage */
+#define CHANNEL_VCHG		0x2 /* Charger voltage */
+#define CHANNEL_CHG_MONITOR	0x3 /* Charger current monitor */
+#define CHANNEL_VPH_PWR		0x4 /* Main system power VPH */
+#define CHANNEL_MPP5		0x5 /* "Battery charge current" */
+#define CHANNEL_MPP6		0x6 /* "MPP1" */
+#define CHANNEL_MPP7		0x7 /* "MPP2" */
+#define CHANNEL_MPP8		0x8 /* Battery temperature */
+#define CHANNEL_MPP9		0x9 /* Battery detection */
+#define CHANNEL_USB_VBUS	0xa /* USB charger voltage */
+#define CHANNEL_DIE_TEMP	0xb /* PMIC die temperature */
+#define CHANNEL_INTERNAL	0xc /* 625mV reference channel */
+#define CHANNEL_125V		0xd /* 1.25V reference channel */
+#define CHANNEL_INTERNAL_2	0xe /* Charger temperature */
+#define CHANNEL_MUXOFF		0xf /* Channel to reduce input load on mux */
+
+#define XOADC_CHAN_MAX		15 /* 4 bits */
+
+/* MPP = Multi-Purpose Pins */
+#define PREMUX_MPP_SCALE_0 0x0 /* No scaling on the signal */
+#define PREMUX_MPP_SCALE_1 0x1 /* Unity scaling selected by the user */
+#define PREMUX_MPP_SCALE_1_DIV3 0x2 /* 1/3 prescaler on the input from MPP */
+
+/* Defines reference voltage for the XOADC */
+#define AMUX_RSV0 0x0 /* XO_IN/XOADC_GND */
+#define AMUX_RSV1 0x1 /* PMIC_IN/XOADC_GND */
+#define AMUX_RSV2 0x2 /* PMIC_IN/BMS_CSP */
+#define AMUX_RSV3 0x3 /* not used */
+#define AMUX_RSV4 0x4 /* XOADC_GND/XOADC_GND */
+#define AMUX_RSV5 0x5 /* XOADC_VREF/XOADC_GND */
+#define XOADC_RSV_MAX 5 /* 3 bits 0..7, 3 and 6,7 are invalid */
+
+/*
+ * The different channels have hard-coded prescale ratios defined
+ * by the hardware.
+ */
+static const struct vadc_prescale_ratio adc_prescale_ratios[] = {
+	{ .num = 1, .den = 2 }, /* CHANNEL_VCOIN */
+	{ .num = 1, .den = 3 }, /* CHANNEL_VBAT */
+	{ .num = 1, .den = 10 }, /* CHANNEL_VCHG */
+	{ .num = 1, .den = 1 }, /* CHANNEL_CHG_MONITOR */
+	{ .num =  1, .den = 3 }, /* CHANNEL_VPH_PWR */
+	{ .num =  1, .den = 1 }, /* CHANNEL_MPP5 */
+	{ .num =  1, .den = 1 }, /* CHANNEL_MPP6 */
+	{ .num =  1, .den = 2 }, /* CHANNEL_MPP7 */
+	{ .num =  1, .den = 2 }, /* CHANNEL_MPP8 */
+	{ .num =  1, .den = 3 }, /* CHANNEL_MPP9 */
+	{ .num =  1, .den = 3 }, /* CHANNEL_USB_VBUS */
+	{ .num =  1, .den = 1 }, /* CHANNEL_DIE_TEMP */
+	{ .num =  1, .den = 1 }, /* CHANNEL_INTERNAL */
+	{ .num =  1, .den = 1 }, /* CHANNEL_125V */
+	{ .num =  1, .den = 1 }, /* CHANNEL_INTERNAL_2 */
+	{ .num =  1, .den = 1 }, /* CHANNEL_MUXOFF */
+};
+
+/**
+ * struct pm8xxx_chan_info - ADC channel information
+ * @name: name of this channel
+ * @calibration: whether to use absolute or ratiometric calibration
+ * @amux_channel: channel 0..15
+ * @decimation: 0,1,2,3
+ * @amux_mpp_channel: MPP channel 0..3
+ * @amux_ip_rsv: ratiometric scale value if using ratiometric
+ * calibration: 0, 1, 2, 4, 5.
+ */
+struct pm8xxx_chan_info {
+	const char *name;
+	enum vadc_calibration calibration;
+	u8 amux_channel:4;
+	u8 decimation:2;
+	u8 amux_mpp_channel:2;
+	u8 amux_ip_rsv:3;
+};
+
+/**
+ * struct pm8xxx_xoadc - state container for the XOADC
+ * @dev: pointer to device
+ * @map: regmap to access registers
+ * @vref: reference voltage regulator
+ * @nchans: number of channels
+ * @chans: the channel information per-channel
+ * @iio_chans: IIO channel specifiers
+ * @graph: linear calibration parameters for absolute and
+ * ratiometric measurements
+ * @complete: completion to indicate end of conversion
+ */
+struct pm8xxx_xoadc {
+	struct device *dev;
+	struct regmap *map;
+	struct regulator *vref;
+	unsigned int nchans;
+	struct pm8xxx_chan_info *chans;
+	struct iio_chan_spec *iio_chans;
+	struct vadc_linear_graph graph[2];
+	struct completion complete;
+};
+
+static irqreturn_t pm8xxx_eoc_irq(int irq, void *d)
+{
+	struct iio_dev *indio_dev = d;
+	struct pm8xxx_xoadc *adc = iio_priv(indio_dev);
+
+	complete(&adc->complete);
+
+	return IRQ_HANDLED;
+}
+
+static struct pm8xxx_chan_info *
+pm8xxx_get_channel(struct pm8xxx_xoadc *adc, u8 chan)
+{
+	struct pm8xxx_chan_info *ch;
+	int i;
+
+	if (chan >= adc->nchans)
+		return NULL;
+
+	for (i = 0; i < adc->nchans; i++) {
+		ch = &adc->chans[i];
+		if (ch->amux_channel == chan)
+			break;
+	}
+	if (i == adc->nchans)
+		return NULL;
+
+	return ch;
+}
+
+static int pm8xxx_read_channel_rsv(struct pm8xxx_xoadc *adc,
+				   const struct pm8xxx_chan_info *ch,
+				   u8 rsv, u16 *adc_code)
+{
+	int ret;
+	unsigned int val;
+	u8 rsvmask, rsvval;
+	u8 lsb, msb;
+
+	dev_dbg(adc->dev, "read channel \"%s\", amux %d, mpp %d, rsv %d\n",
+		ch->name, ch->amux_channel, ch->amux_mpp_channel, rsv);
+
+	/* Mux in this channel */
+	ret = regmap_write(adc->map, ADC_ARB_USRP_AMUX_CNTRL,
+			   ch->amux_channel << ADC_AMUX_SEL_SHIFT |
+			   ch->amux_mpp_channel << ADC_AMUX_PREMUX_SHIFT);
+	if (ret)
+		return ret;
+
+	/* Set up ratiometric scale value */
+	rsvmask = (ADC_ARB_USRP_RSV_RST | ADC_ARB_USRP_RSV_DTEST0 |
+		   ADC_ARB_USRP_RSV_DTEST1 | ADC_ARB_USRP_RSV_OP);
+	if (ch->calibration == VADC_CALIB_RATIOMETRIC) {
+		if (rsv == 0xff)
+			rsvval = (ch->amux_ip_rsv << ADC_RSV_IP_SEL_SHIFT) |
+				ADC_ARB_USRP_RSV_TRM;
+		else
+			rsvval = (rsv << ADC_RSV_IP_SEL_SHIFT) |
+				ADC_ARB_USRP_RSV_TRM;
+	} else {
+		/* We are not ratiometric so turn this off */
+		rsvval = ADC_ARB_USRP_RSV_IP_SEL1;
+	}
+
+	ret = regmap_update_bits(adc->map,
+				 ADC_ARB_USRP_RSV,
+				 ~rsvmask,
+				 rsvval);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(adc->map, ADC_ARB_USRP_ANA_PARAM,
+			   ADC_ARB_USRP_ANA_PARAM_DIS);
+	if (ret)
+		return ret;
+
+	/* Decimation factor */
+	ret = regmap_write(adc->map, ADC_ARB_USRP_DIG_PARAM,
+			   ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT0 |
+			   ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT1 |
+			   ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(adc->map, ADC_ARB_USRP_ANA_PARAM,
+			   ADC_ARB_USRP_ANA_PARAM_EN);
+	if (ret)
+		return ret;
+
+	/* Enable the arbiter, the Qualcomm code does it twice like this */
+	ret = regmap_write(adc->map, ADC_ARB_USRP_CNTRL,
+			   ADC_ARB_USRP_CNTRL_EN_ARB);
+	if (ret)
+		return ret;
+	ret = regmap_write(adc->map, ADC_ARB_USRP_CNTRL,
+			   ADC_ARB_USRP_CNTRL_EN_ARB);
+	if (ret)
+		return ret;
+
+
+	/* Fire a request! */
+	reinit_completion(&adc->complete);
+	ret = regmap_write(adc->map, ADC_ARB_USRP_CNTRL,
+			   ADC_ARB_USRP_CNTRL_EN_ARB |
+			   ADC_ARB_USRP_CNTRL_REQ);
+	if (ret)
+		return ret;
+
+	/* Next the interrupt occurs */
+	ret = wait_for_completion_timeout(&adc->complete,
+					  VADC_CONV_TIME_MAX_US);
+	if (!ret) {
+		dev_err(adc->dev, "conversion timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	ret = regmap_read(adc->map, ADC_ARB_USRP_DATA0, &val);
+	if (ret)
+		return ret;
+	lsb = val;
+	ret = regmap_read(adc->map, ADC_ARB_USRP_DATA1, &val);
+	if (ret)
+		return ret;
+	msb = val;
+	*adc_code = (msb << 8) | lsb;
+
+	/* Turn off the ADC by setting the arbiter to 0 twice */
+	ret = regmap_write(adc->map, ADC_ARB_USRP_CNTRL, 0);
+	if (ret)
+		return ret;
+	ret = regmap_write(adc->map, ADC_ARB_USRP_CNTRL, 0);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int pm8xxx_read_channel(struct pm8xxx_xoadc *adc,
+			       const struct pm8xxx_chan_info *ch,
+			       u16 *adc_code)
+{
+	/*
+	 * Normally we just use the ratiometric scale value (RSV) predefined
+	 * for the channel, but during calibration we need to modify this
+	 * so this wrapper is a helper hiding the more complex version.
+	 */
+	return pm8xxx_read_channel_rsv(adc, ch, 0xff, adc_code);
+}
+
+static s32 pm8xxx_calibrate(struct pm8xxx_xoadc *adc,
+			    const struct pm8xxx_chan_info *ch,
+			    u16 adc_code)
+{
+	return qcom_vadc_calibrate(&adc_prescale_ratios[ch->amux_channel],
+				   &adc->graph[ch->calibration],
+				   (ch->calibration == VADC_CALIB_ABSOLUTE),
+				   adc_code);
+}
+
+static int pm8xxx_calibrate_device(struct pm8xxx_xoadc *adc)
+{
+	const struct pm8xxx_chan_info *ch;
+	u16 read_1250v;
+	u16 read_0625v;
+	u16 read_nomux_rsv5;
+	u16 read_nomux_rsv4;
+	int ret;
+
+
+	adc->graph[VADC_CALIB_ABSOLUTE].dx = VADC_ABSOLUTE_RANGE_UV;
+	adc->graph[VADC_CALIB_RATIOMETRIC].dx = VADC_RATIOMETRIC_RANGE_UV;
+
+	/* Common reference channel calibration */
+	ch = pm8xxx_get_channel(adc, CHANNEL_125V);
+	if (!ch)
+		return -ENODEV;
+	ret = pm8xxx_read_channel(adc, ch, &read_1250v);
+	if (ret) {
+		dev_err(adc->dev, "could not read 1.25V reference channel\n");
+		return -ENODEV;
+	}
+	ch = pm8xxx_get_channel(adc, CHANNEL_INTERNAL);
+	if (!ch)
+		return -ENODEV;
+	ret = pm8xxx_read_channel(adc, ch, &read_0625v);
+	if (ret) {
+		dev_err(adc->dev, "could not read 0.625V reference channel\n");
+		return -ENODEV;
+	}
+	if (read_1250v == read_0625v) {
+		dev_err(adc->dev, "read same ADC code for 1.25V and 0.625V\n");
+		return -ENODEV;
+	}
+
+	adc->graph[VADC_CALIB_ABSOLUTE].dy = read_1250v - read_0625v;
+	adc->graph[VADC_CALIB_ABSOLUTE].gnd = read_0625v;
+
+	dev_info(adc->dev, "absolute calibration dx = %d uV, dy = %d units\n",
+		 VADC_ABSOLUTE_RANGE_UV, adc->graph[VADC_CALIB_ABSOLUTE].dy);
+
+	/* Ratiometric calibration */
+	ch = pm8xxx_get_channel(adc, CHANNEL_MUXOFF);
+	if (!ch)
+		return -ENODEV;
+	ret = pm8xxx_read_channel_rsv(adc, ch, AMUX_RSV5, &read_nomux_rsv5);
+	if (ret) {
+		dev_err(adc->dev, "could not read MUXOFF reference channel\n");
+		return -ENODEV;
+	}
+	ret = pm8xxx_read_channel_rsv(adc, ch, AMUX_RSV4, &read_nomux_rsv4);
+	if (ret) {
+		dev_err(adc->dev, "could not read MUXOFF reference channel\n");
+		return -ENODEV;
+	}
+	adc->graph[VADC_CALIB_RATIOMETRIC].dy =
+		read_nomux_rsv5 - read_nomux_rsv4;
+	adc->graph[VADC_CALIB_RATIOMETRIC].gnd = read_nomux_rsv4;
+
+	dev_info(adc->dev, "ratiometric calibration dx = %d uV, dy = %d units\n",
+		 VADC_RATIOMETRIC_RANGE_UV,
+		 adc->graph[VADC_CALIB_RATIOMETRIC].dy);
+
+	return 0;
+}
+
+static int pm8xxx_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct pm8xxx_xoadc *adc = iio_priv(indio_dev);
+	const struct pm8xxx_chan_info *ch;
+	u16 adc_code;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		/* Only die temperature ends up here */
+		ch = pm8xxx_get_channel(adc, chan->address);
+		if (!ch) {
+			dev_err(adc->dev, "no such channel %lu\n",
+				chan->address);
+			return -EINVAL;
+		}
+		ret = pm8xxx_read_channel(adc, ch, &adc_code);
+		if (ret)
+			return ret;
+		*val = pm8xxx_calibrate(adc, ch, adc_code);
+		/* 2mV/K, return milli Celsius */
+		*val /= 2;
+		*val -= KELVINMIL_CELSIUSMIL;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			ch = pm8xxx_get_channel(adc, chan->address);
+			if (!ch) {
+				dev_err(adc->dev, "no such channel %lu\n",
+					chan->address);
+				return -EINVAL;
+			}
+			ret = pm8xxx_read_channel(adc, ch, &adc_code);
+			if (ret)
+				return ret;
+			*val = pm8xxx_calibrate(adc, ch, adc_code);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Applies to all voltage channels: we scale the microvolts
+		 * to millivolts as required by the userspace ABI.
+		 */
+		*val = 0;
+		*val2 = 1000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info pm8xxx_xoadc_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = pm8xxx_read_raw,
+};
+
+static int pm8xxx_xoadc_parse_channel(struct device *dev,
+				      struct device_node *np,
+				      struct pm8xxx_chan_info *ch)
+{
+	const char *name = np->name;
+	u32 chan, rsv, dec;
+	int ret;
+
+	ret = of_property_read_u32(np, "reg", &chan);
+	if (ret) {
+		dev_err(dev, "invalid channel number %s\n", name);
+		return ret;
+	}
+	if (chan > XOADC_CHAN_MAX) {
+		dev_err(dev, "%s too big channel number %d\n", name, chan);
+		return -EINVAL;
+	}
+
+	if (of_property_read_bool(np, "qcom,ratiometric")) {
+		ch->calibration = VADC_CALIB_RATIOMETRIC;
+		ret = of_property_read_u32(np, "qcom,ratiometric-ref", &rsv);
+		if (ret) {
+			dev_err(dev, "invalid RSV %s\n", name);
+			return ret;
+		}
+		if (rsv > XOADC_RSV_MAX) {
+			dev_err(dev, "%s too large RSV value %d\n", name, rsv);
+			return -EINVAL;
+		}
+		if (rsv == AMUX_RSV3) {
+			dev_err(dev, "%s invalid RSV value %d\n", name, rsv);
+			return -EINVAL;
+		}
+	} else {
+		ch->calibration = VADC_CALIB_ABSOLUTE;
+		rsv = 0;
+	}
+
+	ret = of_property_read_u32(np, "qcom,decimation", &dec);
+	if (!ret) {
+		/* It's OK to skip this ... */
+		ret = qcom_vadc_decimation_from_dt(dec);
+		if (ret < 0) {
+			dev_err(dev, "%s invalid decimation %d\n",
+				name, dec);
+			return ret;
+		}
+		ch->decimation = ret;
+	} else {
+		ch->decimation = VADC_DEF_DECIMATION;
+	}
+
+	ch->amux_channel = chan;
+	ch->name = name;
+	ch->amux_ip_rsv = rsv;
+	ch->amux_mpp_channel = PREMUX_MPP_SCALE_0; /* FIXME: get from DT */
+
+	dev_dbg(dev, "channel %d \"%s\" ref voltage: %d, decimation %d\n",
+		ch->amux_channel,
+		ch->name,
+		ch->amux_ip_rsv,
+		ch->decimation);
+	return 0;
+}
+
+static int pm8xxx_xoadc_parse_channels(struct pm8xxx_xoadc *adc,
+				       struct device_node *np)
+{
+	struct device_node *child;
+	struct pm8xxx_chan_info *ch;
+	int ret;
+	int i;
+
+	adc->nchans = of_get_available_child_count(np);
+	if (!adc->nchans) {
+		dev_err(adc->dev, "no channel children\n");
+		return -ENODEV;
+	}
+	dev_dbg(adc->dev, "found %d ADC channels\n", adc->nchans);
+
+	adc->iio_chans = devm_kcalloc(adc->dev, adc->nchans,
+				      sizeof(*adc->iio_chans), GFP_KERNEL);
+	if (!adc->iio_chans)
+		return -ENOMEM;
+
+	adc->chans = devm_kcalloc(adc->dev, adc->nchans,
+				  sizeof(*adc->chans), GFP_KERNEL);
+	if (!adc->chans)
+		return -ENOMEM;
+
+	i = 0;
+	for_each_available_child_of_node(np, child) {
+		struct iio_chan_spec *iio_chan;
+
+		ch = &adc->chans[i];
+		ret = pm8xxx_xoadc_parse_channel(adc->dev, child, ch);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+
+		iio_chan = &adc->iio_chans[i];
+		iio_chan->channel = ch->amux_channel;
+		iio_chan->datasheet_name = ch->name;
+		/* A single temperature channel, the rest are voltages */
+		if (ch->amux_channel == CHANNEL_DIE_TEMP) {
+			iio_chan->type = IIO_TEMP;
+			iio_chan->info_mask_separate =
+				BIT(IIO_CHAN_INFO_PROCESSED);
+		} else {
+			iio_chan->type = IIO_VOLTAGE;
+			iio_chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_SCALE);
+		}
+		iio_chan->indexed = 1;
+		iio_chan->address = ch->amux_channel;
+
+		i++;
+	}
+
+	/* Check for required channels */
+	ch = pm8xxx_get_channel(adc, CHANNEL_125V);
+	if (!ch) {
+		dev_err(adc->dev, "missing 1.25V reference channel\n");
+		return -ENODEV;
+	}
+	ch = pm8xxx_get_channel(adc, CHANNEL_INTERNAL);
+	if (!ch) {
+		dev_err(adc->dev, "missing 0.625V reference channel\n");
+		return -ENODEV;
+	}
+	ch = pm8xxx_get_channel(adc, CHANNEL_MUXOFF);
+	if (!ch) {
+		dev_err(adc->dev, "missing MUXOFF reference channel\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int pm8xxx_xoadc_probe(struct platform_device *pdev)
+{
+	struct pm8xxx_xoadc *adc;
+	struct iio_dev *indio_dev;
+	struct device_node *np = pdev->dev.of_node;
+	struct regmap *map;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
+	if (!indio_dev)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, indio_dev);
+
+	adc = iio_priv(indio_dev);
+	adc->dev = dev;
+	init_completion(&adc->complete);
+
+	ret = pm8xxx_xoadc_parse_channels(adc, np);
+	if (ret)
+		return ret;
+
+	map = dev_get_regmap(dev->parent, NULL);
+	if (!map) {
+		dev_err(dev, "Parent regmap unavailable.\n");
+		return -ENXIO;
+	}
+	adc->map = map;
+
+	/* Bring up regulator */
+	adc->vref = devm_regulator_get(dev, "xoadc-ref");
+	if (IS_ERR(adc->vref)) {
+		dev_err(dev, "failed to get XOADC VREF regulator\n");
+		return PTR_ERR(adc->vref);
+	}
+	/* We strictly require this voltage */
+	ret = regulator_set_voltage(adc->vref, 2200000, 2200000);
+	if (ret) {
+		dev_err(dev, "unable to set LDO18 voltage to 2.2V\n");
+		return ret;
+	}
+	ret = regulator_enable(adc->vref);
+	if (ret) {
+		dev_err(dev, "failed to enable XOADC VREF regulator\n");
+		return ret;
+	}
+
+	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0),
+			pm8xxx_eoc_irq, NULL, 0, "pm8xxx-adc", indio_dev);
+	if (ret) {
+		dev_err(dev, "unable to request IRQ\n");
+		goto out_disable_vref;
+	}
+
+	indio_dev->dev.parent = dev;
+	indio_dev->dev.of_node = np;
+	indio_dev->name = "pm8xxx-xoadc";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &pm8xxx_xoadc_info;
+	indio_dev->channels = adc->iio_chans;
+	indio_dev->num_channels = adc->nchans;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto out_disable_vref;
+
+	ret = pm8xxx_calibrate_device(adc);
+	if (ret)
+		goto out_unreg_device;
+
+	dev_info(dev, "PM8xxx XOADC driver enabled\n");
+
+	return 0;
+
+out_unreg_device:
+	iio_device_unregister(indio_dev);
+out_disable_vref:
+	regulator_disable(adc->vref);
+
+	return ret;
+}
+
+static int pm8xxx_xoadc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct pm8xxx_xoadc *adc = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	regulator_disable(adc->vref);
+
+	return 0;
+}
+
+static const struct of_device_id pm8xxx_xoadc_id_table[] = {
+	{
+		.compatible = "qcom,pm8058-adc",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pm8xxx_xoadc_id_table);
+
+static struct platform_driver pm8xxx_xoadc_driver = {
+	.driver		= {
+		.name	= "pm8xxx-adc",
+		.of_match_table = pm8xxx_xoadc_id_table,
+	},
+	.probe		= pm8xxx_xoadc_probe,
+	.remove		= pm8xxx_xoadc_remove,
+};
+module_platform_driver(pm8xxx_xoadc_driver);
+
+MODULE_DESCRIPTION("PM8xxx XOADC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:pm8xxx-xoadc");
-- 
2.7.4

