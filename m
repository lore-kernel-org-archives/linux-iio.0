Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db8lp0189.outbound.messaging.microsoft.com ([213.199.154.189]:7683
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752389Ab3KYJ7S (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2013 04:59:18 -0500
From: Fugang Duan <B38611@freescale.com>
To: <jic23@kernel.org>, <sachin.kamat@linaro.org>
CC: <shawn.guo@linaro.org>, <b20596@freescale.com>,
	<linux-iio@vger.kernel.org>
Subject: [PATCH v1 2/3] iio:adc:imx: add Freescale Vybrid board adc driver
Date: Mon, 25 Nov 2013 17:34:30 +0800
Message-ID: <1385372071-5108-3-git-send-email-B38611@freescale.com>
In-Reply-To: <1385372071-5108-1-git-send-email-B38611@freescale.com>
References: <1385372071-5108-1-git-send-email-B38611@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add Freescale Vybrid board adc driver.

Freescale Vybrid vf610 and i.MX6slx and i.MX7 serial sillicons
use the same ADC IP, naming for the ADC driver as imx_adc.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 drivers/iio/adc/Kconfig   |   10 +
 drivers/iio/adc/Makefile  |    1 +
 drivers/iio/adc/imx_adc.c |  747 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 758 insertions(+), 0 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 2209f28..18ecc6a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -204,4 +204,14 @@ config VIPERBOARD_ADC
 	  Say yes here to access the ADC part of the Nano River
 	  Technologies Viperboard.
 
+config IMX_ADC
+	tristate "Freescale vf610/i.MX6slx ADC driver"
+	help
+	  Say yes here if you want support for the Vybrid board
+	  analog-to-digital converter.
+	  This driver is for Vybrid board.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called imx_adc.
+
 endmenu
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ba9a10a..2f5b889 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
 obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
 obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
+obj-$(CONFIG_IMX_ADC) += imx_adc.o
diff --git a/drivers/iio/adc/imx_adc.c b/drivers/iio/adc/imx_adc.c
new file mode 100644
index 0000000..45e699e
--- /dev/null
+++ b/drivers/iio/adc/imx_adc.c
@@ -0,0 +1,747 @@
+/*
+ * Freescale Faraday and IMX ADC driver
+ *
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/regulator/consumer.h>
+#include <linux/of_platform.h>
+#include <linux/err.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/machine.h>
+#include <linux/iio/driver.h>
+
+/* This will be the driver name the kernel reports */
+#define DRIVER_NAME "imx-adc"
+
+/* Vybrid/IMX ADC registers */
+#define ADC_HC0		0x00
+#define ADC_HC1		0x04
+#define ADC_HS		0x08
+#define ADC_R0		0x0c
+#define ADC_R1		0x10
+#define ADC_CFG		0x14
+#define ADC_GC		0x18
+#define ADC_GS		0x1c
+#define ADC_CV		0x20
+#define ADC_OFS		0x24
+#define ADC_CAL		0x28
+#define ADC_PCTL	0x30
+
+/* Configuration register field define */
+#define IMX_ADC_MODE_BIT8	0x00
+#define IMX_ADC_MODE_BIT10	0x04
+#define IMX_ADC_MODE_BIT12	0x08
+#define IMX_ADC_DATA_BIT8_MASK	0xFF
+#define IMX_ADC_DATA_BIT10_MASK	0x3FF
+#define IMX_ADC_DATA_BIT12_MASK	0xFFF
+#define IMX_ADC_BUSCLK2_SEL	0x01
+#define IMX_ADC_ALTCLK_SEL	0x02
+#define IMX_ADC_ADACK_SEL	0x03
+#define IMX_ADC_CLK_DIV2	0x20
+#define IMX_ADC_CLK_DIV4	0x40
+#define IMX_ADC_CLK_DIV8	0x60
+#define IMX_ADC_ADLSMP_LONG	0x10
+#define IMX_ADC_ADSTS_SHORT	0x100
+#define IMX_ADC_ADSTS_NORMAL	0x200
+#define IMX_ADC_ADSTS_LONG	0x300
+#define IMX_ADC_ADLPC_EN	0x80
+#define IMX_ADC_ADHSC_EN	0x400
+#define IMX_ADC_REFSEL_VALT	0x100
+#define IMX_ADC_REFSEL_VBG	0x1000
+#define IMX_ADC_ADTRG_HARD	0x2000
+#define IMX_ADC_AVGS_8		0x4000
+#define IMX_ADC_AVGS_16		0x8000
+#define IMX_ADC_AVGS_32		0xC000
+#define IMX_ADC_OVWREN		0x10000
+
+/* General control register field define */
+#define IMX_ADC_ADACKEN		0x1
+#define IMX_ADC_DMAEN		0x2
+#define IMX_ADC_ACREN		0x4
+#define IMX_ADC_ACFGT		0x8
+#define IMX_ADC_ACFE		0x10
+#define IMX_ADC_AVGEN		0x20
+#define IMX_ADC_ADCON		0x40
+#define IMX_ADC_CAL		0x80
+
+/* Other field define */
+#define IMX_ADC_IOPCTL5		0x20
+#define IMX_ADC_ADCHC(x)	((x) & 0xF)
+#define IMX_ADC_AIEN		(1 << 7)
+#define IMX_ADC_CONV_DISABLE	0x1F
+#define IMX_ADC_HS_COCO0	0x1
+#define IMX_ADC_CALF		0x2
+#define IMX_ADC_MAX_CHANS_NUM	16
+#define IMX_ADC_TIMEOUT		(msecs_to_jiffies(1000))
+
+enum clk_sel {
+	ADCIOC_BUSCLK_SET,
+	ADCIOC_ALTCLK_SET,
+	ADCIOC_ADACK_SET,
+};
+
+enum vol_ref {
+	IMX_ADCIOC_VR_VREF_SET,
+	IMX_ADCIOC_VR_VALT_SET,
+	IMX_ADCIOC_VR_VBG_SET,
+};
+
+enum imx_adc_id {
+	VF610_ADC,
+	IMX6SLX_ADC,
+};
+
+struct imx_adc_feature {
+        enum clk_sel clk_sel;
+        enum vol_ref vol_ref;
+
+	int pctl;
+        int clk_div_num;
+        int res_mode;
+        int sam_time;
+        int hw_sam;
+
+	bool calibration;
+        bool cc_en;
+        bool dataov_en;
+        bool hw_average;
+        bool tri_hw;
+        bool hs_oper;
+        bool lpm;
+        bool dma_en;
+        bool ac_clk_en;
+        bool cmp_func_en;
+        bool cmp_range_en;
+        bool cmp_greater_en;
+};
+
+struct imx_adc {
+	struct device           *dev;
+	void __iomem            *regs;
+	struct clk              *clk;
+	unsigned int            irq;
+
+	u32			vref_uv;
+	u32			value;
+	struct regulator        *vref;
+	struct imx_adc_feature	adc_feature;
+
+	struct completion       completion;
+};
+
+#define IMX_ADC_CHAN(_idx, _chan_type) {			\
+	.type = (_chan_type),					\
+	.indexed = 1,						\
+	.channel = _idx,					\
+	.address = _idx,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+}
+
+static const struct iio_chan_spec imx_adc_iio_channels[] = {
+	IMX_ADC_CHAN(0, IIO_VOLTAGE),
+	IMX_ADC_CHAN(1, IIO_VOLTAGE),
+	IMX_ADC_CHAN(2, IIO_VOLTAGE),
+	IMX_ADC_CHAN(3, IIO_VOLTAGE),
+	IMX_ADC_CHAN(4, IIO_VOLTAGE),
+	IMX_ADC_CHAN(5, IIO_VOLTAGE),
+	IMX_ADC_CHAN(6, IIO_VOLTAGE),
+	IMX_ADC_CHAN(7, IIO_VOLTAGE),
+	IMX_ADC_CHAN(8, IIO_VOLTAGE),
+	IMX_ADC_CHAN(9, IIO_VOLTAGE),
+	IMX_ADC_CHAN(10, IIO_VOLTAGE),
+	IMX_ADC_CHAN(11, IIO_VOLTAGE),
+	IMX_ADC_CHAN(12, IIO_VOLTAGE),
+	IMX_ADC_CHAN(13, IIO_VOLTAGE),
+	IMX_ADC_CHAN(14, IIO_VOLTAGE),
+	IMX_ADC_CHAN(15, IIO_VOLTAGE),
+};
+
+static void imx_adc_cfg_of_init(struct imx_adc *info)
+{
+	struct device_node *np = info->dev->of_node;
+
+	/*
+	 * set default Configuration for ADC controller
+	 * This config may upgrade to require from DT
+	 */
+	info->adc_feature.clk_sel = ADCIOC_BUSCLK_SET;
+	info->adc_feature.vol_ref = IMX_ADCIOC_VR_VREF_SET;
+	info->adc_feature.calibration = true;
+	info->adc_feature.tri_hw = false;
+	info->adc_feature.dataov_en = true;
+	info->adc_feature.ac_clk_en = false;
+	info->adc_feature.dma_en = false;
+	info->adc_feature.cc_en = false;
+	info->adc_feature.cmp_func_en = false;
+	info->adc_feature.cmp_range_en = false;
+	info->adc_feature.cmp_greater_en = false;
+
+	if (of_property_read_u32(np, "imx,adc-io-pinctl",
+			&info->adc_feature.pctl)) {
+		info->adc_feature.pctl = IMX_ADC_IOPCTL5;
+		dev_info(info->dev,
+			"Miss adc-io-pinctl in dt, enable pin SE5.\n");
+	}
+
+	if (info->vref)
+		info->vref_uv = regulator_get_voltage(info->vref);
+	else if (of_property_read_u32(np, "imx,adc-vref", &info->vref_uv)) {
+		dev_err(info->dev,
+			"Miss adc-vref property or vref regulator in the DT.\n");
+	}
+
+	if (of_property_read_u32(np, "imx,adc-clk-div",
+			&info->adc_feature.clk_div_num)) {
+		info->adc_feature.clk_div_num = 2;
+		dev_info(info->dev,
+			"Miss adc-clk-div in dt, set divider to 2.\n");
+	}
+
+	if (of_property_read_u32(np, "imx,adc-res",
+			&info->adc_feature.res_mode)) {
+		info->adc_feature.res_mode = 12;
+		dev_info(info->dev,
+			"Miss adc-res property in dt, use 8bit mode.\n");
+	}
+
+	if (of_property_read_u32(np, "imx,adc-sam-time",
+			&info->adc_feature.sam_time)) {
+		info->adc_feature.sam_time = 4;
+		dev_info(info->dev,
+			"Miss adc-sam-time property in dt, set to 4.\n");
+	}
+
+	info->adc_feature.hw_average = of_property_read_bool(np,
+					"imx,adc-hw-aver-en");
+	if (info->adc_feature.hw_average &&
+		 of_property_read_u32(np, "imx,adc-aver-sam-sel",
+				&info->adc_feature.hw_sam)) {
+		info->adc_feature.hw_sam = 4;
+		dev_info(info->dev,
+			"Miss adc-aver-sam-sel property in dt, set to 4.\n");
+	}
+
+	info->adc_feature.lpm = of_property_read_bool(np, "imx,adc-low-power-mode");
+	info->adc_feature.hs_oper = of_property_read_bool(np, "imx,adc-high-speed-conv");
+}
+
+static inline void imx_adc_cfg_post_set(struct imx_adc *info)
+{
+	struct imx_adc_feature *adc_feature = &(info->adc_feature);
+	int cfg_data = 0;
+	int gc_data = 0;
+
+	/* clock select and clock devider */
+	switch (adc_feature->clk_div_num) {
+	case 1:
+		break;
+	case 2:
+		cfg_data |= IMX_ADC_CLK_DIV2;
+		break;
+	case 4:
+		cfg_data |= IMX_ADC_CLK_DIV4;
+		break;
+	case 8:
+		cfg_data |= IMX_ADC_CLK_DIV8;
+		break;
+	case 16:
+		switch (adc_feature->clk_sel) {
+		case ADCIOC_BUSCLK_SET:
+			cfg_data |= IMX_ADC_BUSCLK2_SEL | IMX_ADC_CLK_DIV8;
+			break;
+		default:
+			dev_err(info->dev, "error clk divider\n");
+			break;
+		}
+		break;
+	}
+
+	switch (adc_feature->clk_sel) {
+	case ADCIOC_ALTCLK_SET:
+		cfg_data |= IMX_ADC_ALTCLK_SEL;
+		break;
+	case ADCIOC_ADACK_SET:
+		cfg_data |= IMX_ADC_ADACK_SEL;
+		break;
+	default:
+		break;
+	}
+
+	/* resolution mode */
+	switch (adc_feature->res_mode) {
+	case 8:
+		cfg_data |= IMX_ADC_MODE_BIT8;
+		break;
+	case 10:
+		cfg_data |= IMX_ADC_MODE_BIT10;
+		break;
+	case 12:
+		cfg_data |= IMX_ADC_MODE_BIT12;
+		break;
+	default:
+		dev_err(info->dev, "error resolution mode\n");
+		break;
+	}
+
+	/* Defines the sample time duration */
+	switch (adc_feature->sam_time) {
+	case 2:
+		break;
+	case 4:
+		cfg_data |= IMX_ADC_ADSTS_SHORT;
+		break;
+	case 6:
+		cfg_data |= IMX_ADC_ADSTS_NORMAL;
+		break;
+	case 8:
+		cfg_data |= IMX_ADC_ADSTS_LONG;
+		break;
+	case 12:
+		cfg_data |= IMX_ADC_ADLSMP_LONG;
+		break;
+	case 16:
+		cfg_data |= IMX_ADC_ADLSMP_LONG | IMX_ADC_ADSTS_SHORT;
+		break;
+	case 20:
+		cfg_data |= IMX_ADC_ADLSMP_LONG | IMX_ADC_ADSTS_NORMAL;
+		break;
+	case 24:
+		cfg_data |= IMX_ADC_ADLSMP_LONG | IMX_ADC_ADSTS_LONG;
+		break;
+	default:
+		dev_err(info->dev, "error sample duration\n");
+		break;
+	}
+
+	/* low power configuration */
+	cfg_data |= IMX_ADC_ADLPC_EN;
+
+	/* high speed operation */
+	cfg_data |= IMX_ADC_ADHSC_EN;
+
+	/* voltage reference*/
+	switch (adc_feature->vol_ref) {
+	case IMX_ADCIOC_VR_VREF_SET:
+		break;
+	case IMX_ADCIOC_VR_VALT_SET:
+		cfg_data |= IMX_ADC_REFSEL_VALT;
+		break;
+	case IMX_ADCIOC_VR_VBG_SET:
+		cfg_data |= IMX_ADC_REFSEL_VBG;
+		break;
+	default:
+		dev_err(info->dev, "error voltage reference\n");
+	}
+
+	/* trigger select */
+	if (adc_feature->tri_hw)
+		cfg_data |= IMX_ADC_ADTRG_HARD;
+
+	/* hardware average select */
+	if (adc_feature->hw_average) {
+		switch (adc_feature->hw_sam) {
+		case 4:
+			break;
+		case 8:
+			cfg_data |= IMX_ADC_AVGS_8;
+			break;
+		case 16:
+			cfg_data |= IMX_ADC_AVGS_16;
+			break;
+		case 32:
+			cfg_data |= IMX_ADC_AVGS_32;
+			break;
+		default:
+			dev_err(info->dev,
+			"error hardware sample average select\n");
+		}
+
+		gc_data |= IMX_ADC_AVGEN;
+	}
+
+	/* data overwrite enable */
+	if (adc_feature->dataov_en)
+		cfg_data |= IMX_ADC_OVWREN;
+
+	/* Asynchronous clock output enable */
+	if (adc_feature->ac_clk_en)
+		gc_data |= IMX_ADC_ADACKEN;
+
+	/* dma enable */
+	if (adc_feature->dma_en)
+		gc_data |= IMX_ADC_DMAEN;
+
+	/* continue function enable */
+	if (adc_feature->cc_en)
+		gc_data |= IMX_ADC_ADCON;
+
+	/* compare function enable */
+	if (adc_feature->cmp_func_en)
+		gc_data |= IMX_ADC_ACFE;
+
+	/* greater than enable */
+	if (adc_feature->cmp_greater_en)
+		gc_data |= IMX_ADC_ACFGT;
+
+	/* range enable */
+	if (adc_feature->cmp_range_en)
+		gc_data |= IMX_ADC_ACREN;
+
+	writel(cfg_data, info->regs + ADC_CFG);
+	writel(gc_data, info->regs + ADC_GC);
+}
+
+static void imx_adc_calibration(struct imx_adc *info)
+{
+	int adc_gc, hc_cfg;
+	int timeout;
+
+	if (!info->adc_feature.calibration)
+		return;
+
+	/* enable calibration interrupt */
+	hc_cfg = IMX_ADC_AIEN | IMX_ADC_CONV_DISABLE;
+	writel(hc_cfg, info->regs + ADC_HC0);
+
+	adc_gc = readl(info->regs + ADC_GC);
+	writel(adc_gc | IMX_ADC_CAL, info->regs + ADC_GC);
+
+	timeout = wait_for_completion_interruptible_timeout
+			(&info->completion, IMX_ADC_TIMEOUT);
+	if (timeout == 0)
+		dev_err(info->dev, "Timeout for adc calibration\n");
+
+	adc_gc = readl(info->regs + ADC_GS);
+	if (adc_gc & IMX_ADC_CALF)
+		dev_err(info->dev, "ADC calibration failed\n");
+
+	info->adc_feature.calibration = false;
+}
+
+static inline void imx_adc_cfg_set(struct imx_adc *info)
+{
+	struct imx_adc_feature *adc_feature = &(info->adc_feature);
+	int cfg_data = 0;
+
+	cfg_data = readl(info->regs + ADC_CFG);
+
+	/* low power configuration */
+	if (!adc_feature->lpm)
+		cfg_data &= ~IMX_ADC_ADLPC_EN;
+
+	/* high speed operation */
+	if (!adc_feature->hs_oper)
+		cfg_data &= ~IMX_ADC_ADHSC_EN;
+
+	/* trigger select */
+	if (adc_feature->tri_hw)
+		cfg_data |= IMX_ADC_ADTRG_HARD;
+
+	writel(cfg_data, info->regs + ADC_CFG);
+}
+
+static void imx_adc_hw_init(struct imx_adc *info)
+{
+	/* pin control for Sliding rheostat */
+	writel(info->adc_feature.pctl, info->regs + ADC_PCTL);
+
+	/* CFG: Feature set */
+	imx_adc_cfg_post_set(info);
+
+	/* adc calibration */
+	imx_adc_calibration(info);
+
+	/* CFG: power and speed set */
+	imx_adc_cfg_set(info);
+}
+
+static inline int imx_adc_read_data(struct imx_adc *info)
+{
+	int result;
+
+	result = readl(info->regs + ADC_R0);
+	return result;
+
+	switch (info->adc_feature.res_mode) {
+	case 8:
+		result &= IMX_ADC_DATA_BIT8_MASK;
+		break;
+	case 10:
+		result &= IMX_ADC_DATA_BIT10_MASK;
+		break;
+	case 12:
+		result &= IMX_ADC_DATA_BIT12_MASK;
+		break;
+	default:
+		dev_err(info->dev, "error resolution mode\n");
+		break;
+	}
+
+	return result;
+}
+
+static irqreturn_t imx_adc_isr(int irq, void *dev_id)
+{
+	struct imx_adc *info = (struct imx_adc *)dev_id;
+	int coco;
+
+	coco = readl(info->regs + ADC_HS);
+	if (coco & IMX_ADC_HS_COCO0) {
+		info->value = imx_adc_read_data(info);
+		complete(&info->completion);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int imx_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val,
+			int *val2,
+			long mask)
+{
+	struct imx_adc *info = iio_priv(indio_dev);
+	unsigned int hc_cfg;
+	unsigned long timeout;
+
+	/* Check for invalid channel */
+	if (chan->channel > IMX_ADC_MAX_CHANS_NUM)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&indio_dev->mlock);
+
+		hc_cfg = IMX_ADC_ADCHC(chan->channel);
+		hc_cfg |= IMX_ADC_AIEN;
+		writel(hc_cfg, info->regs + ADC_HC0);
+		timeout = wait_for_completion_interruptible_timeout
+				(&info->completion, IMX_ADC_TIMEOUT);
+		*val = info->value;
+
+		mutex_unlock(&indio_dev->mlock);
+
+		if (timeout == 0)
+			return -ETIMEDOUT;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = info->vref_uv >> info->adc_feature.res_mode;
+		*val2 = 0;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int imx_adc_reg_access(struct iio_dev *indio_dev,
+			unsigned reg, unsigned writeval,
+			unsigned *readval)
+{
+	struct imx_adc *info = iio_priv(indio_dev);
+
+	if (readval == NULL)
+		return -EINVAL;
+
+	*readval = readl(info->regs + reg);
+
+	return 0;
+}
+
+static const struct iio_info imx_adc_iio_info = {
+	.read_raw = &imx_read_raw,
+	.debugfs_reg_access = &imx_adc_reg_access,
+	.driver_module = THIS_MODULE,
+};
+
+static const struct of_device_id imx_adc_match[] = {
+	{ .compatible = "fsl,vf610-adc", .data = (void *)VF610_ADC, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_adc_dt_ids);
+
+static int imx_adc_probe(struct platform_device *pdev)
+{
+	struct imx_adc *info = NULL;
+	struct device_node *np = pdev->dev.of_node;
+	struct iio_dev *indio_dev;
+	struct resource *mem;
+	int ret = -ENODEV;
+
+	if (!np)
+		return ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct imx_adc));
+	if (!indio_dev) {
+		dev_err(&pdev->dev, "Failed allocating iio device\n");
+		return -ENOMEM;
+	}
+
+	info = iio_priv(indio_dev);
+	info->dev = &pdev->dev;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	info->regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(info->regs))
+		return PTR_ERR(info->regs);
+
+	info->irq = platform_get_irq(pdev, 0);
+	if (info->irq < 0) {
+		dev_err(&pdev->dev, "no irq resource?\n");
+		return -EINVAL;
+	}
+
+	ret = devm_request_irq(info->dev, info->irq,
+				imx_adc_isr, 0,
+				dev_name(&pdev->dev), info);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
+							info->irq);
+		return ret;
+	}
+
+	info->clk = devm_clk_get(&pdev->dev, "adc");
+	if (IS_ERR(info->clk)) {
+		dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
+						PTR_ERR(info->clk));
+		ret = PTR_ERR(info->clk);
+		return ret;
+	}
+
+	info->vref = devm_regulator_get(&pdev->dev, "vref");
+	if (!IS_ERR(info->vref)) {
+		ret = regulator_enable(info->vref);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to enable vref regulator: %d\n", ret);
+			return ret;
+		}
+	} else {
+		info->vref = NULL;
+	}
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	init_completion(&info->completion);
+
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->dev.of_node = pdev->dev.of_node;
+	indio_dev->info = &imx_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = imx_adc_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(imx_adc_iio_channels);
+
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	clk_prepare_enable(info->clk);
+
+	imx_adc_cfg_of_init(info);
+	imx_adc_hw_init(info);
+
+	return 0;
+}
+
+static int imx_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct imx_adc *info = iio_priv(indio_dev);
+
+	if (info->vref)
+		regulator_disable(info->vref);
+	clk_disable_unprepare(info->clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int imx_adc_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct imx_adc *info = iio_priv(indio_dev);
+	int hc_cfg;
+
+	/* enter to stop mode */
+	hc_cfg = readl(info->regs + ADC_HC0);
+	hc_cfg |= IMX_ADC_CONV_DISABLE;
+	writel(hc_cfg, info->regs + ADC_HC0);
+
+	clk_disable_unprepare(info->clk);
+	if (info->vref)
+		regulator_disable(info->vref);
+
+	return 0;
+}
+
+static int imx_adc_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct imx_adc *info = iio_priv(indio_dev);
+	int ret;
+
+	if (info->vref) {
+		ret = regulator_enable(info->vref);
+		if (ret)
+			return ret;
+	}
+
+	clk_prepare_enable(info->clk);
+	imx_adc_hw_init(info);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(imx_adc_pm_ops,
+			imx_adc_suspend,
+			imx_adc_resume);
+
+static struct platform_driver imx_adc_driver = {
+	.probe          = imx_adc_probe,
+	.remove         = imx_adc_remove,
+	.driver         = {
+		.name   = DRIVER_NAME,
+		.owner  = THIS_MODULE,
+		.of_match_table = imx_adc_match,
+		.pm     = &imx_adc_pm_ops,
+	},
+};
+
+module_platform_driver(imx_adc_driver);
+
+MODULE_AUTHOR("Fugang Duan <B38611@freescale.com>");
+MODULE_DESCRIPTION("Freescale Faraday and i.MX6 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.2.rc3


