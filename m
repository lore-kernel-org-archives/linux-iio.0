Return-Path: <jbe@pengutronix.de>
From: Juergen Beisert <jbe@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devel@driverdev.osuosl.org,
	Marek Vasut <marex@denx.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support to the LRADC driver
Date: Wed,  4 Sep 2013 15:01:44 +0200
Message-Id: <1378299706-6742-4-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Distinguish i.MX23 and i.MX28 at runtime and do the same for both SoC at least
for the 4 wire touchscreen.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org
CC: devel@driverdev.osuosl.org
CC: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <fabio.estevam@freescale.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/mxs-lradc.c | 134 +++++++++++++++++++++++++++---------
 1 file changed, 102 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 00e0c29..681ffd4 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -188,19 +188,33 @@ struct mxs_lradc {
 # define LRADC_CTRL0_MX28_XNPSW	/* XM */	(1 << 17)
 # define LRADC_CTRL0_MX28_XPPSW	/* XP */	(1 << 16)
 
+# define LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE	(1 << 20)
+# define LRADC_CTRL0_MX23_YM			(1 << 19)
+# define LRADC_CTRL0_MX23_XM			(1 << 18)
+# define LRADC_CTRL0_MX23_YP			(1 << 17)
+# define LRADC_CTRL0_MX23_XP			(1 << 16)
+
 #define	LRADC_CTRL0_MX28_PLATE_MASK \
+		LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE | \
 		LRADC_CTRL0_MX28_YNNSW | LRADC_CTRL0_MX28_YPNSW | \
 		LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW | \
 		LRADC_CTRL0_MX28_XNPSW | LRADC_CTRL0_MX28_XPPSW
 
+#define	LRADC_CTRL0_MX23_PLATE_MASK \
+		LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE | \
+		LRADC_CTRL0_MX23_YM | LRADC_CTRL0_MX23_XM | \
+		LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_XP
+
 #define	LRADC_CTRL1				0x10
 #define	LRADC_CTRL1_TOUCH_DETECT_IRQ_EN		(1 << 24)
 #define	LRADC_CTRL1_LRADC_IRQ_EN(n)		(1 << ((n) + 16))
 #define	LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK	(0x1fff << 16)
+#define	LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK	(0x01ff << 16)
 #define	LRADC_CTRL1_LRADC_IRQ_EN_OFFSET		16
 #define	LRADC_CTRL1_TOUCH_DETECT_IRQ		(1 << 8)
 #define	LRADC_CTRL1_LRADC_IRQ(n)		(1 << (n))
 #define	LRADC_CTRL1_MX28_LRADC_IRQ_MASK		0x1fff
+#define	LRADC_CTRL1_MX23_LRADC_IRQ_MASK		0x01ff
 #define	LRADC_CTRL1_LRADC_IRQ_OFFSET		0
 
 #define	LRADC_CTRL2				0x20
@@ -268,8 +282,9 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
 	 * Virtual channel 0 is always used here as the others are always not
 	 * used if doing raw sampling.
 	 */
-	writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	if (lradc->soc == IMX28_LRADC)
+		writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
 
 	/* Clean the slot's previous content, then set new one. */
@@ -323,10 +338,17 @@ static int mxs_lradc_ts_touched(struct mxs_lradc *lradc)
 	uint32_t reg;
 
 	/* Enable touch detection. */
-	writel(LRADC_CTRL0_MX28_PLATE_MASK,
-		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
-	writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
-		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	if (lradc->soc == IMX28_LRADC) {
+		writel(LRADC_CTRL0_MX28_PLATE_MASK,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+		writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	} else {
+		writel(LRADC_CTRL0_MX23_PLATE_MASK,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+		writel(LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	}
 
 	msleep(LRADC_TS_SAMPLE_DELAY_MS);
 
@@ -371,22 +393,36 @@ static int32_t mxs_lradc_ts_sample(struct mxs_lradc *lradc,
 	 */
 	switch (plate) {
 	case LRADC_SAMPLE_X:
-		ctrl0 = LRADC_CTRL0_MX28_XPPSW | LRADC_CTRL0_MX28_XNNSW;
+		if (lradc->soc == IMX28_LRADC)
+			ctrl0 = LRADC_CTRL0_MX28_XPPSW | LRADC_CTRL0_MX28_XNNSW;
+		else
+			ctrl0 = LRADC_CTRL0_MX23_XP | LRADC_CTRL0_MX23_XM;
 		chan = 3;
 		break;
 	case LRADC_SAMPLE_Y:
-		ctrl0 = LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_YNNSW;
+		if (lradc->soc == IMX28_LRADC)
+			ctrl0 = LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_YNNSW;
+		else
+			ctrl0 = LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_YM;
 		chan = 4;
 		break;
 	case LRADC_SAMPLE_PRESSURE:
-		ctrl0 = LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW;
+		if (lradc->soc == IMX28_LRADC)
+			ctrl0 = LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW;
+		else
+			ctrl0 = LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_XM;
 		chan = 5;
 		break;
 	}
 
 	if (change) {
-		writel(LRADC_CTRL0_MX28_PLATE_MASK,
-			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+		if (lradc->soc == IMX28_LRADC)
+			writel(LRADC_CTRL0_MX28_PLATE_MASK,
+				lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+		else
+			writel(LRADC_CTRL0_MX23_PLATE_MASK,
+				lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+
 		writel(ctrl0, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
 
 		writel(LRADC_CTRL4_LRADCSELECT_MASK(slot),
@@ -446,8 +482,12 @@ static void mxs_lradc_ts_work(struct work_struct *ts_work)
 
 	while (mxs_lradc_ts_touched(lradc)) {
 		/* Disable touch detector so we can sample the touchscreen. */
-		writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
-			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+		if (lradc->soc == IMX28_LRADC)
+			writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
+				lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+		else
+			writel(LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE,
+				lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
 
 		if (likely(valid)) {
 			input_report_abs(lradc->ts_input, ABS_X, val_x);
@@ -495,8 +535,12 @@ static int mxs_lradc_ts_open(struct input_dev *dev)
 	lradc->stop_touchscreen = false;
 
 	/* Enable the touch-detect circuitry. */
-	writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
-		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	if (lradc->soc == IMX28_LRADC)
+		writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	else
+		writel(LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
 
 	/* Enable the touch-detect IRQ. */
 	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
@@ -521,8 +565,12 @@ static void mxs_lradc_ts_close(struct input_dev *dev)
 		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 
 	/* Power-down touchscreen touch-detect circuitry. */
-	writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
-		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+	if (lradc->soc == IMX28_LRADC)
+		writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+	else
+		writel(LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
 }
 
 static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
@@ -585,8 +633,13 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
 		LRADC_CTRL1_TOUCH_DETECT_IRQ_EN |
 		LRADC_CTRL1_TOUCH_DETECT_IRQ;
 
-	if (!(reg & LRADC_CTRL1_MX28_LRADC_IRQ_MASK))
-		return IRQ_NONE;
+	if (lradc->soc == IMX28_LRADC) {
+		if (!(reg & LRADC_CTRL1_MX28_LRADC_IRQ_MASK))
+			return IRQ_NONE;
+	} else {
+		if (!(reg & LRADC_CTRL1_MX23_LRADC_IRQ_MASK))
+			return IRQ_NONE;
+	}
 
 	/*
 	 * Touchscreen IRQ handling code has priority and therefore
@@ -605,8 +658,12 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
 	else if (reg & LRADC_CTRL1_LRADC_IRQ(0))
 		complete(&lradc->completion);
 
-	writel(reg & LRADC_CTRL1_MX28_LRADC_IRQ_MASK,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	if (lradc->soc == IMX28_LRADC)
+		writel(reg & LRADC_CTRL1_MX28_LRADC_IRQ_MASK,
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	else
+		writel(reg & LRADC_CTRL1_MX23_LRADC_IRQ_MASK,
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 
 	return IRQ_HANDLED;
 }
@@ -726,8 +783,9 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
 	if (ret < 0)
 		goto err_buf;
 
-	writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	if (lradc->soc == IMX28_LRADC)
+		writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
 
 	for_each_set_bit(chan, iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS) {
@@ -767,8 +825,9 @@ static int mxs_lradc_buffer_postdisable(struct iio_dev *iio)
 		lradc->base + LRADC_DELAY(0) + STMP_OFFSET_REG_CLR);
 
 	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
-	writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	if (lradc->soc == IMX28_LRADC)
+		writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 
 	kfree(lradc->buffer);
 	mutex_unlock(&lradc->lock);
@@ -871,12 +930,13 @@ static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
 	writel(0, lradc->base + LRADC_DELAY(3));
 
 	/* Configure the touchscreen type */
-	writel(LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
-		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
-
-	if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE) {
+	if (lradc->soc == IMX28_LRADC) {
 		writel(LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
-			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+
+		if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE)
+			writel(LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
+				lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
 	}
 
 	/* Start internal temperature sensing. */
@@ -889,8 +949,12 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
 {
 	int i;
 
-	writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	if (lradc->soc == IMX28_LRADC)
+		writel(LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	else
+		writel(LRADC_CTRL1_MX23_LRADC_IRQ_EN_MASK,
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 
 	for (i = 0; i < LRADC_MAX_DELAY_CHANS; i++)
 		writel(0, lradc->base + LRADC_DELAY(i));
@@ -950,6 +1014,12 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 		dev_warn(dev, "Unsupported number of touchscreen wires (%d)\n",
 				ts_wires);
 
+	if ((lradc->soc == IMX23_LRADC) && (ts_wires == 5)) {
+		dev_warn(dev, "No support for 5 wire touches on i.MX23\n");
+		dev_warn(dev, "Falling back to 4 wire\n");
+		ts_wires = 4;
+	}
+
 	/* Grab all IRQ sources */
 	for (i = 0; i < of_cfg->irq_count; i++) {
 		lradc->irq[i] = platform_get_irq(pdev, i);
-- 
1.8.4.rc3
