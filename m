Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: sr@denx.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/5] staging:iio:adc:spear adc rework so that device tree queries are all in probe
Date: Tue, 11 Mar 2014 20:36:56 +0000
Message-Id: <1394570219-7672-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1394570219-7672-1-git-send-email-jic23@kernel.org>
References: <1394570219-7672-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Previously the driver would query what type it was in very low level
functions.  This is unintuitive and probably rather inefficient.

Also combine the two structure pointers using an anonymous union given
only one should be set for a given device.

Clearly the of_device_is_compatible related logic in probe could assign only
one of the two pointers, but I feel it is clearer as done here.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/spear_adc.c | 89 ++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 9234e05..886d9db 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -70,10 +70,20 @@ struct adc_regs_spear6xx {
 	struct chan_data average;
 };
 
+struct spear_adc_info;
+
+struct spear_adc_ops {
+	u32 (*get_average)(struct spear_adc_info *info);
+	void (*set_scanrate)(struct spear_adc_info *info, u32 rate);
+};
+
 struct spear_adc_info {
 	struct device_node *np;
-	struct adc_regs_spear3xx __iomem *adc_base_spear3xx;
-	struct adc_regs_spear6xx __iomem *adc_base_spear6xx;
+	union {
+		struct adc_regs_spear3xx __iomem *adc_base_spear3xx;
+		struct adc_regs_spear6xx __iomem *adc_base_spear6xx;
+	};
+	const struct spear_adc_ops *ops;
 	struct clk *clk;
 	struct completion completion;
 	u32 current_clk;
@@ -83,11 +93,6 @@ struct spear_adc_info {
 	u32 value;
 };
 
-/*
- * Functions to access some SPEAr ADC register. Abstracted into
- * static inline functions, because of different register offsets
- * on different SoC variants (SPEAr300 vs SPEAr600 etc).
- */
 static void spear_adc_set_status(struct spear_adc_info *info, u32 val)
 {
 	__raw_writel(val, &info->adc_base_spear6xx->status);
@@ -113,29 +118,41 @@ static void spear_adc_set_ctrl(struct spear_adc_info *info, int n,
 	__raw_writel(val, &info->adc_base_spear6xx->ch_ctrl[n]);
 }
 
-static u32 spear_adc_get_average(struct spear_adc_info *info)
+static u32 spear600_adc_get_average(struct spear_adc_info *info)
 {
-	if (of_device_is_compatible(info->np, "st,spear600-adc")) {
-		return __raw_readl(&info->adc_base_spear6xx->average.msb) &
-			SPEAR_ADC_DATA_MASK;
-	} else {
-		return __raw_readl(&info->adc_base_spear3xx->average) &
-			SPEAR_ADC_DATA_MASK;
-	}
+	return __raw_readl(&info->adc_base_spear6xx->average.msb) &
+		SPEAR_ADC_DATA_MASK;
 }
 
-static void spear_adc_set_scanrate(struct spear_adc_info *info, u32 rate)
+static u32 spear300_adc_get_average(struct spear_adc_info *info)
 {
-	if (of_device_is_compatible(info->np, "st,spear600-adc")) {
-		__raw_writel(SPEAR600_ADC_SCAN_RATE_LO(rate),
-			     &info->adc_base_spear6xx->scan_rate_lo);
-		__raw_writel(SPEAR600_ADC_SCAN_RATE_HI(rate),
-			     &info->adc_base_spear6xx->scan_rate_hi);
-	} else {
-		__raw_writel(rate, &info->adc_base_spear3xx->scan_rate);
-	}
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
 }
 
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
 static int spear_read_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan,
 			  int *val,
@@ -201,7 +218,7 @@ static irqreturn_t spear_adc_isr(int irq, void *dev_id)
 	struct spear_adc_info *info = (struct spear_adc_info *)dev_id;
 
 	/* Read value to clear IRQ */
-	info->value = spear_adc_get_average(info);
+	info->value = info->ops->get_average(info);
 	complete(&info->completion);
 
 	return IRQ_HANDLED;
@@ -216,7 +233,7 @@ static int spear_adc_configure(struct spear_adc_info *info)
 	__raw_writel(0, &info->adc_base_spear6xx->clk);
 	for (i = 0; i < 8; i++)
 		spear_adc_set_ctrl(info, i, 0);
-	spear_adc_set_scanrate(info, 0);
+	info->ops->set_scanrate(info, 0);
 
 	spear_adc_set_clk(info, info->sampling_freq);
 
@@ -310,13 +327,21 @@ static int spear_adc_probe(struct platform_device *pdev)
 	 * (e.g. SPEAr3xx). Let's provide two register base addresses
 	 * to support multi-arch kernels.
 	 */
-	info->adc_base_spear6xx = of_iomap(np, 0);
-	if (!info->adc_base_spear6xx) {
-		dev_err(dev, "failed mapping memory\n");
-		return -ENOMEM;
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
 	}
-	info->adc_base_spear3xx =
-		(struct adc_regs_spear3xx __iomem *)info->adc_base_spear6xx;
 
 	info->clk = clk_get(dev, NULL);
 	if (IS_ERR(info->clk)) {
-- 
1.9.0
