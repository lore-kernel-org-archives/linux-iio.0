Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 5 Sep 2013 21:16:39 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>,
        =?iso-8859-1?Q?J=FCrgen?= Beisert <jbe@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <rob.herring@calxeda.com>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <fabio.estevam@freescale.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org
Subject: [patch] iio: mxs-lradc: use helper functions to simplify the code
Message-ID: <20130905181639.GA19090@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201309051216.18305.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

I have introduced lradc_reg_set() and lradc_reg_clear().  It simplifies
the callers and makes the lines shorter.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index a08c173..da5d04b 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -228,6 +228,16 @@ struct mxs_lradc {
 #define LRADC_RESOLUTION			12
 #define LRADC_SINGLE_SAMPLE_MASK		((1 << LRADC_RESOLUTION) - 1)
 
+static void lradc_reg_set(struct mxs_lradc *lradc, u32 val, size_t chan)
+{
+	writel(val, lradc->base + chan + STMP_OFFSET_REG_SET);
+}
+
+static void lradc_reg_clear(struct mxs_lradc *lradc, u32 val, size_t chan)
+{
+	writel(val, lradc->base + chan + STMP_OFFSET_REG_CLR);
+}
+
 /*
  * Raw I/O operations
  */
@@ -262,21 +272,18 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
 	 * Virtual channel 0 is always used here as the others are always not
 	 * used if doing raw sampling.
 	 */
-	writel(LRADC_CTRL1_LRADC_IRQ_EN_MASK,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
-	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+	lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ_EN_MASK, LRADC_CTRL1);
+	lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
 
 	/* Clean the slot's previous content, then set new one. */
-	writel(LRADC_CTRL4_LRADCSELECT_MASK(0),
-		lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_CLR);
-	writel(chan->channel, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
+	lradc_reg_clear(lradc, LRADC_CTRL4_LRADCSELECT_MASK(0), LRADC_CTRL4);
+	lradc_reg_set(lradc, chan->channel, LRADC_CTRL4);
 
 	writel(0, lradc->base + LRADC_CH(0));
 
 	/* Enable the IRQ and start sampling the channel. */
-	writel(LRADC_CTRL1_LRADC_IRQ_EN(0),
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
-	writel(1 << 0, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	lradc_reg_set(lradc, LRADC_CTRL1_LRADC_IRQ_EN(0), LRADC_CTRL1);
+	lradc_reg_set(lradc, 1 << 0, LRADC_CTRL0);
 
 	/* Wait for completion on the channel, 1 second max. */
 	ret = wait_for_completion_killable_timeout(&lradc->completion, HZ);
@@ -290,8 +297,7 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
 	ret = IIO_VAL_INT;
 
 err:
-	writel(LRADC_CTRL1_LRADC_IRQ_EN(0),
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ_EN(0), LRADC_CTRL1);
 
 	mutex_unlock(&lradc->lock);
 
@@ -317,10 +323,8 @@ static int mxs_lradc_ts_touched(struct mxs_lradc *lradc)
 	uint32_t reg;
 
 	/* Enable touch detection. */
-	writel(LRADC_CTRL0_PLATE_MASK,
-		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
-	writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
-		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	lradc_reg_clear(lradc, LRADC_CTRL0_PLATE_MASK, LRADC_CTRL0);
+	lradc_reg_set(lradc, LRADC_CTRL0_TOUCH_DETECT_ENABLE, LRADC_CTRL0);
 
 	msleep(LRADC_TS_SAMPLE_DELAY_MS);
 
@@ -379,18 +383,18 @@ static int32_t mxs_lradc_ts_sample(struct mxs_lradc *lradc,
 	}
 
 	if (change) {
-		writel(LRADC_CTRL0_PLATE_MASK,
-			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
-		writel(ctrl0, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
-
-		writel(LRADC_CTRL4_LRADCSELECT_MASK(slot),
-			lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_CLR);
-		writel(chan << LRADC_CTRL4_LRADCSELECT_OFFSET(slot),
-			lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
+		lradc_reg_clear(lradc, LRADC_CTRL0_PLATE_MASK, LRADC_CTRL0);
+		lradc_reg_set(lradc, ctrl0, LRADC_CTRL0);
+
+		lradc_reg_clear(lradc, LRADC_CTRL4_LRADCSELECT_MASK(slot),
+				LRADC_CTRL4);
+		lradc_reg_set(lradc,
+			      chan << LRADC_CTRL4_LRADCSELECT_OFFSET(slot),
+			      LRADC_CTRL4);
 	}
 
-	writel(0xffffffff, lradc->base + LRADC_CH(slot) + STMP_OFFSET_REG_CLR);
-	writel(1 << slot, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	lradc_reg_clear(lradc, 0xffffffff, LRADC_CH(slot));
+	lradc_reg_set(lradc, 1 << slot, LRADC_CTRL0);
 
 	delay = jiffies + msecs_to_jiffies(LRADC_TS_SAMPLE_DELAY_MS);
 	do {
@@ -400,8 +404,7 @@ static int32_t mxs_lradc_ts_sample(struct mxs_lradc *lradc,
 			break;
 	} while (time_before(jiff, delay));
 
-	writel(LRADC_CTRL1_LRADC_IRQ(slot),
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ(slot), LRADC_CTRL1);
 
 	if (time_after_eq(jiff, delay))
 		return -ETIMEDOUT;
@@ -440,8 +443,8 @@ static void mxs_lradc_ts_work(struct work_struct *ts_work)
 
 	while (mxs_lradc_ts_touched(lradc)) {
 		/* Disable touch detector so we can sample the touchscreen. */
-		writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
-			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+		lradc_reg_clear(lradc, LRADC_CTRL0_TOUCH_DETECT_ENABLE,
+				LRADC_CTRL0);
 
 		if (likely(valid)) {
 			input_report_abs(lradc->ts_input, ABS_X, val_x);
@@ -475,10 +478,8 @@ static void mxs_lradc_ts_work(struct work_struct *ts_work)
 		return;
 
 	/* Restart the touchscreen interrupts. */
-	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
-	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
+	lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
+	lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
 }
 
 static int mxs_lradc_ts_open(struct input_dev *dev)
@@ -489,12 +490,10 @@ static int mxs_lradc_ts_open(struct input_dev *dev)
 	lradc->stop_touchscreen = false;
 
 	/* Enable the touch-detect circuitry. */
-	writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
-		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	lradc_reg_set(lradc, LRADC_CTRL0_TOUCH_DETECT_ENABLE, LRADC_CTRL0);
 
 	/* Enable the touch-detect IRQ. */
-	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
+	lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
 
 	return 0;
 }
@@ -511,12 +510,10 @@ static void mxs_lradc_ts_close(struct input_dev *dev)
 	cancel_work_sync(&lradc->ts_work);
 
 	/* Disable touchscreen touch-detect IRQ. */
-	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
 
 	/* Power-down touchscreen touch-detect circuitry. */
-	writel(LRADC_CTRL0_TOUCH_DETECT_ENABLE,
-		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+	lradc_reg_clear(lradc, LRADC_CTRL0_TOUCH_DETECT_ENABLE, LRADC_CTRL0);
 }
 
 static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
@@ -588,8 +585,7 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
 	 * it ASAP
 	 */
 	if (reg & LRADC_CTRL1_TOUCH_DETECT_IRQ) {
-		writel(ts_irq_mask,
-			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+		lradc_reg_clear(lradc, ts_irq_mask, LRADC_CTRL1);
 		if (!lradc->stop_touchscreen)
 			schedule_work(&lradc->ts_work);
 	}
@@ -599,8 +595,7 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
 	else if (reg & LRADC_CTRL1_LRADC_IRQ(0))
 		complete(&lradc->completion);
 
-	writel(reg & LRADC_CTRL1_LRADC_IRQ_MASK,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	lradc_reg_clear(lradc, reg & LRADC_CTRL1_LRADC_IRQ_MASK, LRADC_CTRL1);
 
 	return IRQ_HANDLED;
 }
@@ -642,9 +637,11 @@ static int mxs_lradc_configure_trigger(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *iio = iio_trigger_get_drvdata(trig);
 	struct mxs_lradc *lradc = iio_priv(iio);
-	const uint32_t st = state ? STMP_OFFSET_REG_SET : STMP_OFFSET_REG_CLR;
 
-	writel(LRADC_DELAY_KICK, lradc->base + LRADC_DELAY(0) + st);
+	if (state)
+		lradc_reg_set(lradc, LRADC_DELAY_KICK, LRADC_DELAY(0));
+	else
+		lradc_reg_clear(lradc, LRADC_DELAY_KICK,  LRADC_DELAY(0));
 
 	return 0;
 }
@@ -720,9 +717,8 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
 	if (ret < 0)
 		goto err_buf;
 
-	writel(LRADC_CTRL1_LRADC_IRQ_EN_MASK,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
-	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+	lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ_EN_MASK, LRADC_CTRL1);
+	lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
 
 	for_each_set_bit(chan, iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS) {
 		ctrl4_set |= chan << LRADC_CTRL4_LRADCSELECT_OFFSET(ofs);
@@ -733,16 +729,17 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
 		ofs++;
 	}
 
-	writel(LRADC_DELAY_TRIGGER_LRADCS_MASK | LRADC_DELAY_KICK,
-		lradc->base + LRADC_DELAY(0) + STMP_OFFSET_REG_CLR);
+	lradc_reg_clear(lradc,
+			LRADC_DELAY_TRIGGER_LRADCS_MASK | LRADC_DELAY_KICK,
+			LRADC_DELAY(0));
 
-	writel(ctrl4_clr, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_CLR);
-	writel(ctrl4_set, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
+	lradc_reg_clear(lradc, ctrl4_clr, LRADC_CTRL4);
+	lradc_reg_set(lradc, ctrl4_set, LRADC_CTRL4);
 
-	writel(ctrl1_irq, lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
+	lradc_reg_set(lradc, ctrl1_irq, LRADC_CTRL1);
 
-	writel(enable << LRADC_DELAY_TRIGGER_LRADCS_OFFSET,
-		lradc->base + LRADC_DELAY(0) + STMP_OFFSET_REG_SET);
+	lradc_reg_set(lradc, enable << LRADC_DELAY_TRIGGER_LRADCS_OFFSET,
+		      LRADC_DELAY(0));
 
 	return 0;
 
@@ -757,12 +754,12 @@ static int mxs_lradc_buffer_postdisable(struct iio_dev *iio)
 {
 	struct mxs_lradc *lradc = iio_priv(iio);
 
-	writel(LRADC_DELAY_TRIGGER_LRADCS_MASK | LRADC_DELAY_KICK,
-		lradc->base + LRADC_DELAY(0) + STMP_OFFSET_REG_CLR);
+	lradc_reg_clear(lradc,
+			LRADC_DELAY_TRIGGER_LRADCS_MASK | LRADC_DELAY_KICK,
+			LRADC_DELAY(0));
 
-	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
-	writel(LRADC_CTRL1_LRADC_IRQ_EN_MASK,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
+	lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ_EN_MASK, LRADC_CTRL1);
 
 	kfree(lradc->buffer);
 	mutex_unlock(&lradc->lock);
@@ -865,12 +862,11 @@ static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
 	writel(0, lradc->base + LRADC_DELAY(3));
 
 	/* Configure the touchscreen type */
-	writel(LRADC_CTRL0_TOUCH_SCREEN_TYPE,
-		lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+	lradc_reg_clear(lradc, LRADC_CTRL0_TOUCH_SCREEN_TYPE, LRADC_CTRL0);
 
 	if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE) {
-		writel(LRADC_CTRL0_TOUCH_SCREEN_TYPE,
-			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+		lradc_reg_set(lradc, LRADC_CTRL0_TOUCH_SCREEN_TYPE,
+			      LRADC_CTRL0);
 	}
 
 	/* Start internal temperature sensing. */
@@ -883,8 +879,7 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
 {
 	int i;
 
-	writel(LRADC_CTRL1_LRADC_IRQ_EN_MASK,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ_EN_MASK, LRADC_CTRL1);
 
 	for (i = 0; i < LRADC_MAX_DELAY_CHANS; i++)
 		writel(0, lradc->base + LRADC_DELAY(i));
