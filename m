Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41672 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbaDEQoP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Apr 2014 12:44:15 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, sr@denx.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/6] staging:iio:adc:spear rename device specific state structure to _state
Date: Sat,  5 Apr 2014 17:45:13 +0100
Message-Id: <1396716315-2465-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1396716315-2465-1-git-send-email-jic23@kernel.org>
References: <1396716315-2465-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Also rename instances of it to st.  This brings the driver inline with
the conventions of IIO and avoids some naming confusion with some IIO
structures which also use the _info postfix.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/spear_adc.c | 126 ++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 44a129f..3003e89 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -70,7 +70,7 @@ struct adc_regs_spear6xx {
 	struct chan_data average;
 };
 
-struct spear_adc_info {
+struct spear_adc_state {
 	struct device_node *np;
 	struct adc_regs_spear3xx __iomem *adc_base_spear3xx;
 	struct adc_regs_spear6xx __iomem *adc_base_spear6xx;
@@ -88,51 +88,51 @@ struct spear_adc_info {
  * static inline functions, because of different register offsets
  * on different SoC variants (SPEAr300 vs SPEAr600 etc).
  */
-static void spear_adc_set_status(struct spear_adc_info *info, u32 val)
+static void spear_adc_set_status(struct spear_adc_state *st, u32 val)
 {
-	__raw_writel(val, &info->adc_base_spear6xx->status);
+	__raw_writel(val, &st->adc_base_spear6xx->status);
 }
 
-static void spear_adc_set_clk(struct spear_adc_info *info, u32 val)
+static void spear_adc_set_clk(struct spear_adc_state *st, u32 val)
 {
 	u32 clk_high, clk_low, count;
-	u32 apb_clk = clk_get_rate(info->clk);
+	u32 apb_clk = clk_get_rate(st->clk);
 
 	count = (apb_clk + val - 1) / val;
 	clk_low = count / 2;
 	clk_high = count - clk_low;
-	info->current_clk = apb_clk / count;
+	st->current_clk = apb_clk / count;
 
 	__raw_writel(SPEAR_ADC_CLK_LOW(clk_low) | SPEAR_ADC_CLK_HIGH(clk_high),
-		     &info->adc_base_spear6xx->clk);
+		     &st->adc_base_spear6xx->clk);
 }
 
-static void spear_adc_set_ctrl(struct spear_adc_info *info, int n,
+static void spear_adc_set_ctrl(struct spear_adc_state *st, int n,
 			       u32 val)
 {
-	__raw_writel(val, &info->adc_base_spear6xx->ch_ctrl[n]);
+	__raw_writel(val, &st->adc_base_spear6xx->ch_ctrl[n]);
 }
 
-static u32 spear_adc_get_average(struct spear_adc_info *info)
+static u32 spear_adc_get_average(struct spear_adc_state *st)
 {
-	if (of_device_is_compatible(info->np, "st,spear600-adc")) {
-		return __raw_readl(&info->adc_base_spear6xx->average.msb) &
+	if (of_device_is_compatible(st->np, "st,spear600-adc")) {
+		return __raw_readl(&st->adc_base_spear6xx->average.msb) &
 			SPEAR_ADC_DATA_MASK;
 	} else {
-		return __raw_readl(&info->adc_base_spear3xx->average) &
+		return __raw_readl(&st->adc_base_spear3xx->average) &
 			SPEAR_ADC_DATA_MASK;
 	}
 }
 
-static void spear_adc_set_scanrate(struct spear_adc_info *info, u32 rate)
+static void spear_adc_set_scanrate(struct spear_adc_state *st, u32 rate)
 {
-	if (of_device_is_compatible(info->np, "st,spear600-adc")) {
+	if (of_device_is_compatible(st->np, "st,spear600-adc")) {
 		__raw_writel(SPEAR600_ADC_SCAN_RATE_LO(rate),
-			     &info->adc_base_spear6xx->scan_rate_lo);
+			     &st->adc_base_spear6xx->scan_rate_lo);
 		__raw_writel(SPEAR600_ADC_SCAN_RATE_HI(rate),
-			     &info->adc_base_spear6xx->scan_rate_hi);
+			     &st->adc_base_spear6xx->scan_rate_hi);
 	} else {
-		__raw_writel(rate, &info->adc_base_spear3xx->scan_rate);
+		__raw_writel(rate, &st->adc_base_spear3xx->scan_rate);
 	}
 }
 
@@ -142,7 +142,7 @@ static int spear_read_raw(struct iio_dev *indio_dev,
 			  int *val2,
 			  long mask)
 {
-	struct spear_adc_info *info = iio_priv(indio_dev);
+	struct spear_adc_state *st = iio_priv(indio_dev);
 	u32 status;
 
 	switch (mask) {
@@ -150,26 +150,26 @@ static int spear_read_raw(struct iio_dev *indio_dev,
 		mutex_lock(&indio_dev->mlock);
 
 		status = SPEAR_ADC_STATUS_CHANNEL_NUM(chan->channel) |
-			SPEAR_ADC_STATUS_AVG_SAMPLE(info->avg_samples) |
+			SPEAR_ADC_STATUS_AVG_SAMPLE(st->avg_samples) |
 			SPEAR_ADC_STATUS_START_CONVERSION |
 			SPEAR_ADC_STATUS_ADC_ENABLE;
-		if (info->vref_external == 0)
+		if (st->vref_external == 0)
 			status |= SPEAR_ADC_STATUS_VREF_INTERNAL;
 
-		spear_adc_set_status(info, status);
-		wait_for_completion(&info->completion); /* set by ISR */
-		*val = info->value;
+		spear_adc_set_status(st, status);
+		wait_for_completion(&st->completion); /* set by ISR */
+		*val = st->value;
 
 		mutex_unlock(&indio_dev->mlock);
 
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		*val = info->vref_external;
+		*val = st->vref_external;
 		*val2 = SPEAR_ADC_DATA_BITS;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = info->current_clk;
+		*val = st->current_clk;
 		return IIO_VAL_INT;
 	}
 
@@ -182,7 +182,7 @@ static int spear_adc_write_raw(struct iio_dev *indio_dev,
 			       int val2,
 			       long mask)
 {
-	struct spear_adc_info *info = iio_priv(indio_dev);
+	struct spear_adc_state *st = iio_priv(indio_dev);
 	int ret = 0;
 
 	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
@@ -197,7 +197,7 @@ static int spear_adc_write_raw(struct iio_dev *indio_dev,
 		goto out;
 	}
 
-	spear_adc_set_clk(info, val);
+	spear_adc_set_clk(st, val);
 
 out:
 	mutex_unlock(&indio_dev->mlock);
@@ -226,32 +226,32 @@ static const struct iio_chan_spec spear_adc_iio_channels[] = {
 
 static irqreturn_t spear_adc_isr(int irq, void *dev_id)
 {
-	struct spear_adc_info *info = (struct spear_adc_info *)dev_id;
+	struct spear_adc_state *st = (struct spear_adc_state *)dev_id;
 
 	/* Read value to clear IRQ */
-	info->value = spear_adc_get_average(info);
-	complete(&info->completion);
+	st->value = spear_adc_get_average(st);
+	complete(&st->completion);
 
 	return IRQ_HANDLED;
 }
 
-static int spear_adc_configure(struct spear_adc_info *info)
+static int spear_adc_configure(struct spear_adc_state *st)
 {
 	int i;
 
 	/* Reset ADC core */
-	spear_adc_set_status(info, 0);
-	__raw_writel(0, &info->adc_base_spear6xx->clk);
+	spear_adc_set_status(st, 0);
+	__raw_writel(0, &st->adc_base_spear6xx->clk);
 	for (i = 0; i < 8; i++)
-		spear_adc_set_ctrl(info, i, 0);
-	spear_adc_set_scanrate(info, 0);
+		spear_adc_set_ctrl(st, i, 0);
+	spear_adc_set_scanrate(st, 0);
 
-	spear_adc_set_clk(info, info->sampling_freq);
+	spear_adc_set_clk(st, st->sampling_freq);
 
 	return 0;
 }
 
-static const struct iio_info spear_adc_iio_info = {
+static const struct iio_info spear_adc_info = {
 	.read_raw = &spear_read_raw,
 	.write_raw = &spear_adc_write_raw,
 	.driver_module = THIS_MODULE,
@@ -261,40 +261,40 @@ static int spear_adc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
-	struct spear_adc_info *info;
+	struct spear_adc_state *st;
 	struct iio_dev *iodev = NULL;
 	int ret = -ENODEV;
 	int irq;
 
-	iodev = devm_iio_device_alloc(dev, sizeof(struct spear_adc_info));
+	iodev = devm_iio_device_alloc(dev, sizeof(struct spear_adc_state));
 	if (!iodev) {
 		dev_err(dev, "failed allocating iio device\n");
 		return -ENOMEM;
 	}
 
-	info = iio_priv(iodev);
-	info->np = np;
+	st = iio_priv(iodev);
+	st->np = np;
 
 	/*
 	 * SPEAr600 has a different register layout than other SPEAr SoC's
 	 * (e.g. SPEAr3xx). Let's provide two register base addresses
 	 * to support multi-arch kernels.
 	 */
-	info->adc_base_spear6xx = of_iomap(np, 0);
-	if (!info->adc_base_spear6xx) {
+	st->adc_base_spear6xx = of_iomap(np, 0);
+	if (!st->adc_base_spear6xx) {
 		dev_err(dev, "failed mapping memory\n");
 		return -ENOMEM;
 	}
-	info->adc_base_spear3xx =
-		(struct adc_regs_spear3xx __iomem *)info->adc_base_spear6xx;
+	st->adc_base_spear3xx =
+		(struct adc_regs_spear3xx __iomem *)st->adc_base_spear6xx;
 
-	info->clk = clk_get(dev, NULL);
-	if (IS_ERR(info->clk)) {
+	st->clk = clk_get(dev, NULL);
+	if (IS_ERR(st->clk)) {
 		dev_err(dev, "failed getting clock\n");
 		goto errout1;
 	}
 
-	ret = clk_prepare_enable(info->clk);
+	ret = clk_prepare_enable(st->clk);
 	if (ret) {
 		dev_err(dev, "failed enabling clock\n");
 		goto errout2;
@@ -308,14 +308,14 @@ static int spear_adc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(dev, irq, spear_adc_isr, 0, SPEAR_ADC_MOD_NAME,
-			       info);
+			       st);
 	if (ret < 0) {
 		dev_err(dev, "failed requesting interrupt\n");
 		goto errout3;
 	}
 
 	if (of_property_read_u32(np, "sampling-frequency",
-				 &info->sampling_freq)) {
+				 &st->sampling_freq)) {
 		dev_err(dev, "sampling-frequency missing in DT\n");
 		ret = -EINVAL;
 		goto errout3;
@@ -325,23 +325,23 @@ static int spear_adc_probe(struct platform_device *pdev)
 	 * Optional avg_samples defaults to 0, resulting in single data
 	 * conversion
 	 */
-	of_property_read_u32(np, "average-samples", &info->avg_samples);
+	of_property_read_u32(np, "average-samples", &st->avg_samples);
 
 	/*
 	 * Optional vref_external defaults to 0, resulting in internal vref
 	 * selection
 	 */
-	of_property_read_u32(np, "vref-external", &info->vref_external);
+	of_property_read_u32(np, "vref-external", &st->vref_external);
 
-	spear_adc_configure(info);
+	spear_adc_configure(st);
 
 	platform_set_drvdata(pdev, iodev);
 
-	init_completion(&info->completion);
+	init_completion(&st->completion);
 
 	iodev->name = SPEAR_ADC_MOD_NAME;
 	iodev->dev.parent = dev;
-	iodev->info = &spear_adc_iio_info;
+	iodev->info = &spear_adc_info;
 	iodev->modes = INDIO_DIRECT_MODE;
 	iodev->channels = spear_adc_iio_channels;
 	iodev->num_channels = ARRAY_SIZE(spear_adc_iio_channels);
@@ -355,23 +355,23 @@ static int spear_adc_probe(struct platform_device *pdev)
 	return 0;
 
 errout3:
-	clk_disable_unprepare(info->clk);
+	clk_disable_unprepare(st->clk);
 errout2:
-	clk_put(info->clk);
+	clk_put(st->clk);
 errout1:
-	iounmap(info->adc_base_spear6xx);
+	iounmap(st->adc_base_spear6xx);
 	return ret;
 }
 
 static int spear_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *iodev = platform_get_drvdata(pdev);
-	struct spear_adc_info *info = iio_priv(iodev);
+	struct spear_adc_state *st = iio_priv(iodev);
 
 	iio_device_unregister(iodev);
-	clk_disable_unprepare(info->clk);
-	clk_put(info->clk);
-	iounmap(info->adc_base_spear6xx);
+	clk_disable_unprepare(st->clk);
+	clk_put(st->clk);
+	iounmap(st->adc_base_spear6xx);
 
 	return 0;
 }
-- 
1.9.0

