Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: sr@denx.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5/5] iio:adc:spear_adc move out of staging
Date: Tue, 11 Mar 2014 20:36:59 +0000
Message-Id: <1394570219-7672-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1394570219-7672-1-git-send-email-jic23@kernel.org>
References: <1394570219-7672-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

This simple driver is ready to move out of staging.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/Kconfig             |   8 +
 drivers/iio/adc/Makefile            |   1 +
 drivers/iio/adc/spear_adc.c         | 429 ++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/Kconfig     |   8 -
 drivers/staging/iio/adc/Makefile    |   1 -
 drivers/staging/iio/adc/spear_adc.c | 429 ------------------------------------
 6 files changed, 438 insertions(+), 438 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5553206..2e3e1b0 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -164,6 +164,14 @@ config NAU7802
 	  To compile this driver as a module, choose M here: the
 	  module will be called nau7802.
 
+config SPEAR_ADC
+	tristate "ST SPEAr ADC"
+	depends on PLAT_SPEAR || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say yes here to build support for the integrated ADC inside the
+	  ST SPEAr SoC. Provides direct access via sysfs.
+
 config TI_ADC081C
 	tristate "Texas Instruments ADC081C021/027"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 89f1216..8378fb2 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
 obj-$(CONFIG_NAU7802) += nau7802.o
+obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
 obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
 obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
new file mode 100644
index 0000000..d8232f1
--- /dev/null
+++ b/drivers/iio/adc/spear_adc.c
@@ -0,0 +1,429 @@
+/*
+ * ST SPEAr ADC driver
+ *
+ * Copyright 2012 Stefan Roese <sr@denx.de>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/completion.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/* SPEAR registers definitions */
+#define SPEAR600_ADC_SCAN_RATE_LO(x)	((x) & 0xFFFF)
+#define SPEAR600_ADC_SCAN_RATE_HI(x)	(((x) >> 0x10) & 0xFFFF)
+#define SPEAR_ADC_CLK_LOW(x)		(((x) & 0xf) << 0)
+#define SPEAR_ADC_CLK_HIGH(x)		(((x) & 0xf) << 4)
+
+/* Bit definitions for SPEAR_ADC_STATUS */
+#define SPEAR_ADC_STATUS_START_CONVERSION	(1 << 0)
+#define SPEAR_ADC_STATUS_CHANNEL_NUM(x)		((x) << 1)
+#define SPEAR_ADC_STATUS_ADC_ENABLE		(1 << 4)
+#define SPEAR_ADC_STATUS_AVG_SAMPLE(x)		((x) << 5)
+#define SPEAR_ADC_STATUS_VREF_INTERNAL		(1 << 9)
+
+#define SPEAR_ADC_DATA_MASK		0x03ff
+#define SPEAR_ADC_DATA_BITS		10
+
+#define SPEAR_ADC_MOD_NAME "spear-adc"
+
+#define SPEAR_ADC_CHANNEL_NUM		8
+
+#define SPEAR_ADC_CLK_MIN			2500000
+#define SPEAR_ADC_CLK_MAX			20000000
+
+struct adc_regs_spear3xx {
+	u32 status;
+	u32 average;
+	u32 scan_rate;
+	u32 clk;	/* Not avail for 1340 & 1310 */
+	u32 ch_ctrl[SPEAR_ADC_CHANNEL_NUM];
+	u32 ch_data[SPEAR_ADC_CHANNEL_NUM];
+};
+
+struct chan_data {
+	u32 lsb;
+	u32 msb;
+};
+
+struct adc_regs_spear6xx {
+	u32 status;
+	u32 pad[2];
+	u32 clk;
+	u32 ch_ctrl[SPEAR_ADC_CHANNEL_NUM];
+	struct chan_data ch_data[SPEAR_ADC_CHANNEL_NUM];
+	u32 scan_rate_lo;
+	u32 scan_rate_hi;
+	struct chan_data average;
+};
+
+struct spear_adc_info;
+
+struct spear_adc_ops {
+	u32 (*get_average)(struct spear_adc_info *info);
+	void (*set_scanrate)(struct spear_adc_info *info, u32 rate);
+};
+
+struct spear_adc_info {
+	struct device_node *np;
+	union {
+		struct adc_regs_spear3xx __iomem *adc_base_spear3xx;
+		struct adc_regs_spear6xx __iomem *adc_base_spear6xx;
+	};
+	const struct spear_adc_ops *ops;
+	struct clk *clk;
+	struct completion completion;
+	u32 current_clk;
+	u32 sampling_freq;
+	u32 avg_samples;
+	u32 vref_external;
+	u32 value;
+};
+
+static void spear_adc_set_status(struct spear_adc_info *info, u32 val)
+{
+	__raw_writel(val, &info->adc_base_spear6xx->status);
+}
+
+static void spear_adc_set_clk(struct spear_adc_info *info, u32 val)
+{
+	u32 clk_high, clk_low, count;
+	u32 apb_clk = clk_get_rate(info->clk);
+
+	count = (apb_clk + val - 1) / val;
+	clk_low = count / 2;
+	clk_high = count - clk_low;
+	info->current_clk = apb_clk / count;
+
+	__raw_writel(SPEAR_ADC_CLK_LOW(clk_low) | SPEAR_ADC_CLK_HIGH(clk_high),
+		     &info->adc_base_spear6xx->clk);
+}
+
+static void spear_adc_set_ctrl(struct spear_adc_info *info, int n,
+			       u32 val)
+{
+	__raw_writel(val, &info->adc_base_spear6xx->ch_ctrl[n]);
+}
+
+static u32 spear600_adc_get_average(struct spear_adc_info *info)
+{
+	return __raw_readl(&info->adc_base_spear6xx->average.msb) &
+		SPEAR_ADC_DATA_MASK;
+}
+
+static u32 spear300_adc_get_average(struct spear_adc_info *info)
+{
+	return __raw_readl(&info->adc_base_spear3xx->average) &
+		SPEAR_ADC_DATA_MASK;
+}
+
+static void spear600_adc_set_scanrate(struct spear_adc_info *info, u32 rate)
+{
+	__raw_writel(SPEAR600_ADC_SCAN_RATE_LO(rate),
+		&info->adc_base_spear6xx->scan_rate_lo);
+	__raw_writel(SPEAR600_ADC_SCAN_RATE_HI(rate),
+		&info->adc_base_spear6xx->scan_rate_hi);
+}
+
+static void spear300_adc_set_scanrate(struct spear_adc_info *info, u32 rate)
+{
+	__raw_writel(rate, &info->adc_base_spear3xx->scan_rate);
+}
+
+static const struct spear_adc_ops spear600_adc_ops = {
+	.get_average = &spear600_adc_get_average,
+	.set_scanrate = &spear600_adc_set_scanrate,
+};
+
+static const struct spear_adc_ops spear300_adc_ops = {
+	.get_average = &spear300_adc_get_average,
+	.set_scanrate = &spear300_adc_set_scanrate,
+};
+
+static int spear_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  int *val,
+			  int *val2,
+			  long mask)
+{
+	struct spear_adc_info *info = iio_priv(indio_dev);
+	u32 status;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&indio_dev->mlock);
+
+		status = SPEAR_ADC_STATUS_CHANNEL_NUM(chan->channel) |
+			SPEAR_ADC_STATUS_AVG_SAMPLE(info->avg_samples) |
+			SPEAR_ADC_STATUS_START_CONVERSION |
+			SPEAR_ADC_STATUS_ADC_ENABLE;
+		if (info->vref_external == 0)
+			status |= SPEAR_ADC_STATUS_VREF_INTERNAL;
+
+		spear_adc_set_status(info, status);
+		wait_for_completion(&info->completion); /* set by ISR */
+		*val = info->value;
+
+		mutex_unlock(&indio_dev->mlock);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = info->vref_external;
+		*val2 = SPEAR_ADC_DATA_BITS;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = info->current_clk;
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int spear_adc_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	struct spear_adc_info *info = iio_priv(indio_dev);
+	u32 clk_high, clk_low, count;
+	u32 apb_clk = clk_get_rate(info->clk);
+	int ret = 0;
+
+	mutex_lock(&indio_dev->mlock);
+
+	if ((val < SPEAR_ADC_CLK_MIN) ||
+		(val > SPEAR_ADC_CLK_MAX) ||
+		(val2 != 0)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	count = (apb_clk + val - 1) / val;
+	clk_low = count / 2;
+	clk_high = count - clk_low;
+	info->current_clk = apb_clk / count;
+	spear_adc_set_clk(info, val);
+
+out:
+	mutex_unlock(&indio_dev->mlock);
+	return ret;
+}
+
+#define SPEAR_ADC_CHAN(idx) {				\
+	.type = IIO_VOLTAGE,				\
+	.indexed = 1,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+	.channel = idx,					\
+}
+
+static const struct iio_chan_spec spear_adc_iio_channels[] = {
+	SPEAR_ADC_CHAN(0),
+	SPEAR_ADC_CHAN(1),
+	SPEAR_ADC_CHAN(2),
+	SPEAR_ADC_CHAN(3),
+	SPEAR_ADC_CHAN(4),
+	SPEAR_ADC_CHAN(5),
+	SPEAR_ADC_CHAN(6),
+	SPEAR_ADC_CHAN(7),
+};
+
+static irqreturn_t spear_adc_isr(int irq, void *dev_id)
+{
+	struct spear_adc_info *info = (struct spear_adc_info *)dev_id;
+
+	/* Read value to clear IRQ */
+	info->value = info->ops->get_average(info);
+	complete(&info->completion);
+
+	return IRQ_HANDLED;
+}
+
+static int spear_adc_configure(struct spear_adc_info *info)
+{
+	int i;
+
+	/* Reset ADC core */
+	spear_adc_set_status(info, 0);
+	__raw_writel(0, &info->adc_base_spear6xx->clk);
+	for (i = 0; i < 8; i++)
+		spear_adc_set_ctrl(info, i, 0);
+	info->ops->set_scanrate(info, 0);
+
+	spear_adc_set_clk(info, info->sampling_freq);
+
+	return 0;
+}
+
+static const struct iio_info spear_adc_iio_info = {
+	.read_raw = &spear_read_raw,
+	.write_raw = &spear_adc_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static int spear_adc_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct spear_adc_info *info;
+	struct iio_dev *iodev = NULL;
+	int ret = -ENODEV;
+	int irq;
+
+	iodev = devm_iio_device_alloc(dev, sizeof(struct spear_adc_info));
+	if (!iodev) {
+		dev_err(dev, "failed allocating iio device\n");
+		return -ENOMEM;
+	}
+
+	info = iio_priv(iodev);
+	info->np = np;
+
+	/*
+	 * SPEAr600 has a different register layout than other SPEAr SoC's
+	 * (e.g. SPEAr3xx). Let's provide two register base addresses
+	 * to support multi-arch kernels.
+	 */
+	if (of_device_is_compatible(info->np, "st,spear600-adc")) {
+		info->adc_base_spear6xx = of_iomap(np, 0);
+		if (!info->adc_base_spear6xx) {
+			dev_err(dev, "failed mapping memory\n");
+			return -ENOMEM;
+		}
+		info->ops = &spear600_adc_ops;
+	} else {
+		info->adc_base_spear3xx = of_iomap(np, 0);
+		if (!info->adc_base_spear3xx) {
+			dev_err(dev, "failed mapping memory\n");
+			return -ENOMEM;
+		}
+		info->ops = &spear300_adc_ops;
+	}
+
+	info->clk = clk_get(dev, NULL);
+	if (IS_ERR(info->clk)) {
+		dev_err(dev, "failed getting clock\n");
+		goto errout1;
+	}
+
+	ret = clk_prepare_enable(info->clk);
+	if (ret) {
+		dev_err(dev, "failed enabling clock\n");
+		goto errout2;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		dev_err(dev, "failed getting interrupt resource\n");
+		ret = -EINVAL;
+		goto errout3;
+	}
+
+	ret = devm_request_irq(dev, irq, spear_adc_isr, 0, SPEAR_ADC_MOD_NAME,
+			info);
+	if (ret < 0) {
+		dev_err(dev, "failed requesting interrupt\n");
+		goto errout3;
+	}
+
+	if (of_property_read_u32(np, "sampling-frequency",
+				 &info->sampling_freq)) {
+		dev_err(dev, "sampling-frequency missing in DT\n");
+		ret = -EINVAL;
+		goto errout3;
+	}
+
+	/*
+	 * Optional avg_samples defaults to 0, resulting in single data
+	 * conversion
+	 */
+	of_property_read_u32(np, "average-samples", &info->avg_samples);
+
+	/*
+	 * Optional vref_external defaults to 0, resulting in internal vref
+	 * selection
+	 */
+	of_property_read_u32(np, "vref-external", &info->vref_external);
+
+	spear_adc_configure(info);
+
+	platform_set_drvdata(pdev, iodev);
+
+	init_completion(&info->completion);
+
+	iodev->name = SPEAR_ADC_MOD_NAME;
+	iodev->dev.parent = dev;
+	iodev->info = &spear_adc_iio_info;
+	iodev->modes = INDIO_DIRECT_MODE;
+	iodev->channels = spear_adc_iio_channels;
+	iodev->num_channels = ARRAY_SIZE(spear_adc_iio_channels);
+
+	ret = iio_device_register(iodev);
+	if (ret)
+		goto errout3;
+
+	dev_info(dev, "SPEAR ADC driver loaded, IRQ %d\n", irq);
+
+	return 0;
+
+errout3:
+	clk_disable_unprepare(info->clk);
+errout2:
+	clk_put(info->clk);
+errout1:
+	iounmap(info->adc_base_spear6xx);
+	return ret;
+}
+
+static int spear_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *iodev = platform_get_drvdata(pdev);
+	struct spear_adc_info *info = iio_priv(iodev);
+
+	iio_device_unregister(iodev);
+	clk_disable_unprepare(info->clk);
+	clk_put(info->clk);
+	iounmap(info->adc_base_spear6xx);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id spear_adc_dt_ids[] = {
+	{ .compatible = "st,spear600-adc", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, spear_adc_dt_ids);
+#endif
+
+static struct platform_driver spear_adc_driver = {
+	.probe		= spear_adc_probe,
+	.remove		= spear_adc_remove,
+	.driver		= {
+		.name	= SPEAR_ADC_MOD_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(spear_adc_dt_ids),
+	},
+};
+
+module_platform_driver(spear_adc_driver);
+
+MODULE_AUTHOR("Stefan Roese <sr@denx.de>");
+MODULE_DESCRIPTION("SPEAr ADC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 3633298..a37d001 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -126,12 +126,4 @@ config MXS_LRADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called mxs-lradc.
 
-config SPEAR_ADC
-	tristate "ST SPEAr ADC"
-	depends on PLAT_SPEAR || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Say yes here to build support for the integrated ADC inside the
-	  ST SPEAr SoC. Provides direct access via sysfs.
-
 endmenu
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index 3e9fb14..b5915c1 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -19,4 +19,3 @@ obj-$(CONFIG_AD7192) += ad7192.o
 obj-$(CONFIG_AD7280) += ad7280a.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
 obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
-obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
deleted file mode 100644
index d8232f1..0000000
--- a/drivers/staging/iio/adc/spear_adc.c
+++ /dev/null
@@ -1,429 +0,0 @@
-/*
- * ST SPEAr ADC driver
- *
- * Copyright 2012 Stefan Roese <sr@denx.de>
- *
- * Licensed under the GPL-2.
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/completion.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-
-/* SPEAR registers definitions */
-#define SPEAR600_ADC_SCAN_RATE_LO(x)	((x) & 0xFFFF)
-#define SPEAR600_ADC_SCAN_RATE_HI(x)	(((x) >> 0x10) & 0xFFFF)
-#define SPEAR_ADC_CLK_LOW(x)		(((x) & 0xf) << 0)
-#define SPEAR_ADC_CLK_HIGH(x)		(((x) & 0xf) << 4)
-
-/* Bit definitions for SPEAR_ADC_STATUS */
-#define SPEAR_ADC_STATUS_START_CONVERSION	(1 << 0)
-#define SPEAR_ADC_STATUS_CHANNEL_NUM(x)		((x) << 1)
-#define SPEAR_ADC_STATUS_ADC_ENABLE		(1 << 4)
-#define SPEAR_ADC_STATUS_AVG_SAMPLE(x)		((x) << 5)
-#define SPEAR_ADC_STATUS_VREF_INTERNAL		(1 << 9)
-
-#define SPEAR_ADC_DATA_MASK		0x03ff
-#define SPEAR_ADC_DATA_BITS		10
-
-#define SPEAR_ADC_MOD_NAME "spear-adc"
-
-#define SPEAR_ADC_CHANNEL_NUM		8
-
-#define SPEAR_ADC_CLK_MIN			2500000
-#define SPEAR_ADC_CLK_MAX			20000000
-
-struct adc_regs_spear3xx {
-	u32 status;
-	u32 average;
-	u32 scan_rate;
-	u32 clk;	/* Not avail for 1340 & 1310 */
-	u32 ch_ctrl[SPEAR_ADC_CHANNEL_NUM];
-	u32 ch_data[SPEAR_ADC_CHANNEL_NUM];
-};
-
-struct chan_data {
-	u32 lsb;
-	u32 msb;
-};
-
-struct adc_regs_spear6xx {
-	u32 status;
-	u32 pad[2];
-	u32 clk;
-	u32 ch_ctrl[SPEAR_ADC_CHANNEL_NUM];
-	struct chan_data ch_data[SPEAR_ADC_CHANNEL_NUM];
-	u32 scan_rate_lo;
-	u32 scan_rate_hi;
-	struct chan_data average;
-};
-
-struct spear_adc_info;
-
-struct spear_adc_ops {
-	u32 (*get_average)(struct spear_adc_info *info);
-	void (*set_scanrate)(struct spear_adc_info *info, u32 rate);
-};
-
-struct spear_adc_info {
-	struct device_node *np;
-	union {
-		struct adc_regs_spear3xx __iomem *adc_base_spear3xx;
-		struct adc_regs_spear6xx __iomem *adc_base_spear6xx;
-	};
-	const struct spear_adc_ops *ops;
-	struct clk *clk;
-	struct completion completion;
-	u32 current_clk;
-	u32 sampling_freq;
-	u32 avg_samples;
-	u32 vref_external;
-	u32 value;
-};
-
-static void spear_adc_set_status(struct spear_adc_info *info, u32 val)
-{
-	__raw_writel(val, &info->adc_base_spear6xx->status);
-}
-
-static void spear_adc_set_clk(struct spear_adc_info *info, u32 val)
-{
-	u32 clk_high, clk_low, count;
-	u32 apb_clk = clk_get_rate(info->clk);
-
-	count = (apb_clk + val - 1) / val;
-	clk_low = count / 2;
-	clk_high = count - clk_low;
-	info->current_clk = apb_clk / count;
-
-	__raw_writel(SPEAR_ADC_CLK_LOW(clk_low) | SPEAR_ADC_CLK_HIGH(clk_high),
-		     &info->adc_base_spear6xx->clk);
-}
-
-static void spear_adc_set_ctrl(struct spear_adc_info *info, int n,
-			       u32 val)
-{
-	__raw_writel(val, &info->adc_base_spear6xx->ch_ctrl[n]);
-}
-
-static u32 spear600_adc_get_average(struct spear_adc_info *info)
-{
-	return __raw_readl(&info->adc_base_spear6xx->average.msb) &
-		SPEAR_ADC_DATA_MASK;
-}
-
-static u32 spear300_adc_get_average(struct spear_adc_info *info)
-{
-	return __raw_readl(&info->adc_base_spear3xx->average) &
-		SPEAR_ADC_DATA_MASK;
-}
-
-static void spear600_adc_set_scanrate(struct spear_adc_info *info, u32 rate)
-{
-	__raw_writel(SPEAR600_ADC_SCAN_RATE_LO(rate),
-		&info->adc_base_spear6xx->scan_rate_lo);
-	__raw_writel(SPEAR600_ADC_SCAN_RATE_HI(rate),
-		&info->adc_base_spear6xx->scan_rate_hi);
-}
-
-static void spear300_adc_set_scanrate(struct spear_adc_info *info, u32 rate)
-{
-	__raw_writel(rate, &info->adc_base_spear3xx->scan_rate);
-}
-
-static const struct spear_adc_ops spear600_adc_ops = {
-	.get_average = &spear600_adc_get_average,
-	.set_scanrate = &spear600_adc_set_scanrate,
-};
-
-static const struct spear_adc_ops spear300_adc_ops = {
-	.get_average = &spear300_adc_get_average,
-	.set_scanrate = &spear300_adc_set_scanrate,
-};
-
-static int spear_read_raw(struct iio_dev *indio_dev,
-			  struct iio_chan_spec const *chan,
-			  int *val,
-			  int *val2,
-			  long mask)
-{
-	struct spear_adc_info *info = iio_priv(indio_dev);
-	u32 status;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&indio_dev->mlock);
-
-		status = SPEAR_ADC_STATUS_CHANNEL_NUM(chan->channel) |
-			SPEAR_ADC_STATUS_AVG_SAMPLE(info->avg_samples) |
-			SPEAR_ADC_STATUS_START_CONVERSION |
-			SPEAR_ADC_STATUS_ADC_ENABLE;
-		if (info->vref_external == 0)
-			status |= SPEAR_ADC_STATUS_VREF_INTERNAL;
-
-		spear_adc_set_status(info, status);
-		wait_for_completion(&info->completion); /* set by ISR */
-		*val = info->value;
-
-		mutex_unlock(&indio_dev->mlock);
-
-		return IIO_VAL_INT;
-
-	case IIO_CHAN_INFO_SCALE:
-		*val = info->vref_external;
-		*val2 = SPEAR_ADC_DATA_BITS;
-		return IIO_VAL_FRACTIONAL_LOG2;
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = info->current_clk;
-		return IIO_VAL_INT;
-	}
-
-	return -EINVAL;
-}
-
-static int spear_adc_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
-{
-	struct spear_adc_info *info = iio_priv(indio_dev);
-	u32 clk_high, clk_low, count;
-	u32 apb_clk = clk_get_rate(info->clk);
-	int ret = 0;
-
-	mutex_lock(&indio_dev->mlock);
-
-	if ((val < SPEAR_ADC_CLK_MIN) ||
-		(val > SPEAR_ADC_CLK_MAX) ||
-		(val2 != 0)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	count = (apb_clk + val - 1) / val;
-	clk_low = count / 2;
-	clk_high = count - clk_low;
-	info->current_clk = apb_clk / count;
-	spear_adc_set_clk(info, val);
-
-out:
-	mutex_unlock(&indio_dev->mlock);
-	return ret;
-}
-
-#define SPEAR_ADC_CHAN(idx) {				\
-	.type = IIO_VOLTAGE,				\
-	.indexed = 1,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
-	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
-	.channel = idx,					\
-}
-
-static const struct iio_chan_spec spear_adc_iio_channels[] = {
-	SPEAR_ADC_CHAN(0),
-	SPEAR_ADC_CHAN(1),
-	SPEAR_ADC_CHAN(2),
-	SPEAR_ADC_CHAN(3),
-	SPEAR_ADC_CHAN(4),
-	SPEAR_ADC_CHAN(5),
-	SPEAR_ADC_CHAN(6),
-	SPEAR_ADC_CHAN(7),
-};
-
-static irqreturn_t spear_adc_isr(int irq, void *dev_id)
-{
-	struct spear_adc_info *info = (struct spear_adc_info *)dev_id;
-
-	/* Read value to clear IRQ */
-	info->value = info->ops->get_average(info);
-	complete(&info->completion);
-
-	return IRQ_HANDLED;
-}
-
-static int spear_adc_configure(struct spear_adc_info *info)
-{
-	int i;
-
-	/* Reset ADC core */
-	spear_adc_set_status(info, 0);
-	__raw_writel(0, &info->adc_base_spear6xx->clk);
-	for (i = 0; i < 8; i++)
-		spear_adc_set_ctrl(info, i, 0);
-	info->ops->set_scanrate(info, 0);
-
-	spear_adc_set_clk(info, info->sampling_freq);
-
-	return 0;
-}
-
-static const struct iio_info spear_adc_iio_info = {
-	.read_raw = &spear_read_raw,
-	.write_raw = &spear_adc_write_raw,
-	.driver_module = THIS_MODULE,
-};
-
-static int spear_adc_probe(struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	struct device *dev = &pdev->dev;
-	struct spear_adc_info *info;
-	struct iio_dev *iodev = NULL;
-	int ret = -ENODEV;
-	int irq;
-
-	iodev = devm_iio_device_alloc(dev, sizeof(struct spear_adc_info));
-	if (!iodev) {
-		dev_err(dev, "failed allocating iio device\n");
-		return -ENOMEM;
-	}
-
-	info = iio_priv(iodev);
-	info->np = np;
-
-	/*
-	 * SPEAr600 has a different register layout than other SPEAr SoC's
-	 * (e.g. SPEAr3xx). Let's provide two register base addresses
-	 * to support multi-arch kernels.
-	 */
-	if (of_device_is_compatible(info->np, "st,spear600-adc")) {
-		info->adc_base_spear6xx = of_iomap(np, 0);
-		if (!info->adc_base_spear6xx) {
-			dev_err(dev, "failed mapping memory\n");
-			return -ENOMEM;
-		}
-		info->ops = &spear600_adc_ops;
-	} else {
-		info->adc_base_spear3xx = of_iomap(np, 0);
-		if (!info->adc_base_spear3xx) {
-			dev_err(dev, "failed mapping memory\n");
-			return -ENOMEM;
-		}
-		info->ops = &spear300_adc_ops;
-	}
-
-	info->clk = clk_get(dev, NULL);
-	if (IS_ERR(info->clk)) {
-		dev_err(dev, "failed getting clock\n");
-		goto errout1;
-	}
-
-	ret = clk_prepare_enable(info->clk);
-	if (ret) {
-		dev_err(dev, "failed enabling clock\n");
-		goto errout2;
-	}
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "failed getting interrupt resource\n");
-		ret = -EINVAL;
-		goto errout3;
-	}
-
-	ret = devm_request_irq(dev, irq, spear_adc_isr, 0, SPEAR_ADC_MOD_NAME,
-			info);
-	if (ret < 0) {
-		dev_err(dev, "failed requesting interrupt\n");
-		goto errout3;
-	}
-
-	if (of_property_read_u32(np, "sampling-frequency",
-				 &info->sampling_freq)) {
-		dev_err(dev, "sampling-frequency missing in DT\n");
-		ret = -EINVAL;
-		goto errout3;
-	}
-
-	/*
-	 * Optional avg_samples defaults to 0, resulting in single data
-	 * conversion
-	 */
-	of_property_read_u32(np, "average-samples", &info->avg_samples);
-
-	/*
-	 * Optional vref_external defaults to 0, resulting in internal vref
-	 * selection
-	 */
-	of_property_read_u32(np, "vref-external", &info->vref_external);
-
-	spear_adc_configure(info);
-
-	platform_set_drvdata(pdev, iodev);
-
-	init_completion(&info->completion);
-
-	iodev->name = SPEAR_ADC_MOD_NAME;
-	iodev->dev.parent = dev;
-	iodev->info = &spear_adc_iio_info;
-	iodev->modes = INDIO_DIRECT_MODE;
-	iodev->channels = spear_adc_iio_channels;
-	iodev->num_channels = ARRAY_SIZE(spear_adc_iio_channels);
-
-	ret = iio_device_register(iodev);
-	if (ret)
-		goto errout3;
-
-	dev_info(dev, "SPEAR ADC driver loaded, IRQ %d\n", irq);
-
-	return 0;
-
-errout3:
-	clk_disable_unprepare(info->clk);
-errout2:
-	clk_put(info->clk);
-errout1:
-	iounmap(info->adc_base_spear6xx);
-	return ret;
-}
-
-static int spear_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *iodev = platform_get_drvdata(pdev);
-	struct spear_adc_info *info = iio_priv(iodev);
-
-	iio_device_unregister(iodev);
-	clk_disable_unprepare(info->clk);
-	clk_put(info->clk);
-	iounmap(info->adc_base_spear6xx);
-
-	return 0;
-}
-
-#ifdef CONFIG_OF
-static const struct of_device_id spear_adc_dt_ids[] = {
-	{ .compatible = "st,spear600-adc", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, spear_adc_dt_ids);
-#endif
-
-static struct platform_driver spear_adc_driver = {
-	.probe		= spear_adc_probe,
-	.remove		= spear_adc_remove,
-	.driver		= {
-		.name	= SPEAR_ADC_MOD_NAME,
-		.owner	= THIS_MODULE,
-		.of_match_table = of_match_ptr(spear_adc_dt_ids),
-	},
-};
-
-module_platform_driver(spear_adc_driver);
-
-MODULE_AUTHOR("Stefan Roese <sr@denx.de>");
-MODULE_DESCRIPTION("SPEAr ADC driver");
-MODULE_LICENSE("GPL");
-- 
1.9.0
