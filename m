Return-Path: <jbe@pengutronix.de>
From: Juergen Beisert <jbe@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devel@driverdev.osuosl.org,
	Marek Vasut <marex@denx.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/5] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Wed,  4 Sep 2013 15:01:45 +0200
Message-Id: <1378299706-6742-5-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

For battery driven systems it is a very bad idea to collect the touchscreen
data within a kernel busy loop.

This change uses the features of the hardware to delay and accumulate samples in
hardware to avoid a high interrupt and CPU load.

Note: this is only tested on a i.MX23 SoC yet.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org
CC: devel@driverdev.osuosl.org
CC: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <fabio.estevam@freescale.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/mxs-lradc.c | 609 ++++++++++++++++++++++++++++++++----
 1 file changed, 542 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 681ffd4..9462af0 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -129,6 +129,17 @@ enum mxs_lradc_ts {
 	MXS_LRADC_TOUCHSCREEN_5WIRE,
 };
 
+/*
+ * Touchscreen handling
+ */
+enum lradc_ts_plate {
+	LRADC_TOUCH = 0,
+	LRADC_SAMPLE_X,
+	LRADC_SAMPLE_Y,
+	LRADC_SAMPLE_PRESSURE,
+	LRADC_SAMPLE_VALID,
+};
+
 struct mxs_lradc {
 	struct device		*dev;
 	void __iomem		*base;
@@ -169,13 +180,25 @@ struct mxs_lradc {
 #define CHAN_MASK_TOUCHSCREEN_4WIRE	(0xf << 2)
 #define CHAN_MASK_TOUCHSCREEN_5WIRE	(0x1f << 2)
 	enum mxs_lradc_ts	use_touchscreen;
-	bool			stop_touchscreen;
 	bool			use_touchbutton;
 
 	struct input_dev	*ts_input;
 	struct work_struct	ts_work;
 
 	enum mxs_lradc_id	soc;
+	enum lradc_ts_plate	cur_plate; /* statemachine */
+	bool			ts_valid;
+	unsigned		ts_x_pos;
+	unsigned		ts_y_pos;
+	unsigned		ts_pressure;
+
+	/* handle touchscreen's physical behaviour */
+	/* samples per coordinate */
+	unsigned		over_sample_cnt;
+	/* time clocks between samples */
+	unsigned		over_sample_delay;
+	/* time in clocks to wait after the plates where switched */
+	unsigned		settling_delay;
 };
 
 #define	LRADC_CTRL0				0x00
@@ -227,19 +250,33 @@ struct mxs_lradc {
 #define	LRADC_CH_ACCUMULATE			(1 << 29)
 #define	LRADC_CH_NUM_SAMPLES_MASK		(0x1f << 24)
 #define	LRADC_CH_NUM_SAMPLES_OFFSET		24
+#define	LRADC_CH_NUM_SAMPLES(x) \
+				((x) << LRADC_CH_NUM_SAMPLES_OFFSET)
 #define	LRADC_CH_VALUE_MASK			0x3ffff
 #define	LRADC_CH_VALUE_OFFSET			0
 
 #define	LRADC_DELAY(n)				(0xd0 + (0x10 * (n)))
 #define	LRADC_DELAY_TRIGGER_LRADCS_MASK		(0xff << 24)
 #define	LRADC_DELAY_TRIGGER_LRADCS_OFFSET	24
+#define	LRADC_DELAY_TRIGGER(x) \
+				(((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSET) & \
+				LRADC_DELAY_TRIGGER_LRADCS_MASK)
 #define	LRADC_DELAY_KICK			(1 << 20)
 #define	LRADC_DELAY_TRIGGER_DELAYS_MASK		(0xf << 16)
 #define	LRADC_DELAY_TRIGGER_DELAYS_OFFSET	16
+#define	LRADC_DELAY_TRIGGER_DELAYS(x) \
+				(((x) << LRADC_DELAY_TRIGGER_DELAYS_OFFSET) & \
+				LRADC_DELAY_TRIGGER_DELAYS_MASK)
 #define	LRADC_DELAY_LOOP_COUNT_MASK		(0x1f << 11)
 #define	LRADC_DELAY_LOOP_COUNT_OFFSET		11
+#define	LRADC_DELAY_LOOP(x) \
+				(((x) << LRADC_DELAY_LOOP_COUNT_OFFSET) & \
+				LRADC_DELAY_LOOP_COUNT_MASK)
 #define	LRADC_DELAY_DELAY_MASK			0x7ff
 #define	LRADC_DELAY_DELAY_OFFSET		0
+#define	LRADC_DELAY_DELAY(x) \
+				(((x) << LRADC_DELAY_DELAY_OFFSET) & \
+				LRADC_DELAY_DELAY_MASK)
 
 #define	LRADC_CTRL4				0x140
 #define	LRADC_CTRL4_LRADCSELECT_MASK(n)		(0xf << ((n) * 4))
@@ -248,6 +285,466 @@ struct mxs_lradc {
 #define LRADC_RESOLUTION			12
 #define LRADC_SINGLE_SAMPLE_MASK		((1 << LRADC_RESOLUTION) - 1)
 
+static bool mxs_lradc_check_touch_event(struct mxs_lradc *lradc)
+{
+	return !!(readl(lradc->base + LRADC_STATUS) &
+					LRADC_STATUS_TOUCH_DETECT_RAW);
+}
+
+static void mxs_lradc_setup_ts_channel(struct mxs_lradc *lradc, unsigned ch)
+{
+	/*
+	 * prepare for oversampling conversion
+	 *
+	 * from the datasheet:
+	 * "The ACCUMULATE bit in the appropriate channel register
+	 * HW_LRADC_CHn must be set to 1 if NUM_SAMPLES is greater then 0;
+	 * otherwise, the IRQs will not fire."
+	 */
+	writel(LRADC_CH_ACCUMULATE |
+			LRADC_CH_NUM_SAMPLES(lradc->over_sample_cnt - 1),
+			lradc->base + LRADC_CH(ch));
+
+	/* from the datasheet:
+	 * "Software must clear this register in preparation for a
+	 * multi-cycle accumulation.
+	 */
+	writel(LRADC_CH_VALUE_MASK, lradc->base + LRADC_CH(ch) +
+							STMP_OFFSET_REG_CLR);
+
+	/* prepare the delay/loop unit according to the oversampling count */
+	writel(LRADC_DELAY_TRIGGER(1 << ch) |
+		LRADC_DELAY_TRIGGER_DELAYS(0) |
+		LRADC_DELAY_LOOP(lradc->over_sample_cnt - 1) |
+		LRADC_DELAY_DELAY(lradc->over_sample_delay - 1),
+			lradc->base + LRADC_DELAY(3));
+
+	writel(LRADC_CTRL1_LRADC_IRQ(2) | LRADC_CTRL1_LRADC_IRQ(3) |
+		LRADC_CTRL1_LRADC_IRQ(4) | LRADC_CTRL1_LRADC_IRQ(5),
+		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+
+	/* wake us again, when the complete conversion is done */
+	writel(LRADC_CTRL1_LRADC_IRQ_EN(ch),
+		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
+	/*
+	 * after changing the touchscreen plates setting
+	 * the signals need some initial time to settle. Start the
+	 * SoC's delay unit and start the conversion later
+	 * and automatically.
+	 */
+	writel(LRADC_DELAY_TRIGGER(0) | /* do not trigger an ADC channel */
+		LRADC_DELAY_TRIGGER_DELAYS(1 << 3) | /* trigger DELAY unit #3 */
+		LRADC_DELAY_KICK |
+		LRADC_DELAY_DELAY(lradc->settling_delay),
+			lradc->base + LRADC_DELAY(2));
+}
+
+/*
+ * Pressure detection is special:
+ * We want to do both required measurements for the pressure detection in
+ * one turn. Use the hardware features to chain both conversions and let the
+ * hardware report one interrupt if both conversions are done
+ */
+static void mxs_lradc_setup_ts_pressure(struct mxs_lradc *lradc, unsigned ch1,
+							unsigned ch2)
+{
+	u32 reg;
+
+	/*
+	 * prepare for oversampling conversion
+	 *
+	 * from the datasheet:
+	 * "The ACCUMULATE bit in the appropriate channel register
+	 * HW_LRADC_CHn must be set to 1 if NUM_SAMPLES is greater then 0;
+	 * otherwise, the IRQs will not fire."
+	 */
+	reg = LRADC_CH_ACCUMULATE |
+		LRADC_CH_NUM_SAMPLES(lradc->over_sample_cnt - 1);
+	writel(reg, lradc->base + LRADC_CH(ch1));
+	writel(reg, lradc->base + LRADC_CH(ch2));
+
+	/* from the datasheet:
+	 * "Software must clear this register in preparation for a
+	 * multi-cycle accumulation.
+	 */
+	writel(LRADC_CH_VALUE_MASK, lradc->base + LRADC_CH(ch1) +
+							STMP_OFFSET_REG_CLR);
+	writel(LRADC_CH_VALUE_MASK, lradc->base + LRADC_CH(ch2) +
+							STMP_OFFSET_REG_CLR);
+
+	/* prepare the delay/loop unit according to the oversampling count */
+	writel(LRADC_DELAY_TRIGGER(1 << ch1) |
+		LRADC_DELAY_TRIGGER(1 << ch2) | /* start both channels */
+		LRADC_DELAY_TRIGGER_DELAYS(0) |
+		LRADC_DELAY_LOOP(lradc->over_sample_cnt - 1) |
+		LRADC_DELAY_DELAY(lradc->over_sample_delay - 1),
+			lradc->base + LRADC_DELAY(3));
+
+	writel(LRADC_CTRL1_LRADC_IRQ(2) | LRADC_CTRL1_LRADC_IRQ(3) |
+		LRADC_CTRL1_LRADC_IRQ(4) | LRADC_CTRL1_LRADC_IRQ(5),
+		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+
+	/* wake us again, when the conversions are done */
+	writel(LRADC_CTRL1_LRADC_IRQ_EN(ch2),
+		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
+	/*
+	 * after changing the touchscreen plates setting
+	 * the signals need some initial time to settle. Start the
+	 * SoC's delay unit and start the conversion later
+	 * and automatically.
+	 */
+	writel(LRADC_DELAY_TRIGGER(0) | /* do not trigger an ADC channel */
+		LRADC_DELAY_TRIGGER_DELAYS(1 << 3) | /* trigger DELAY unit#3 */
+		LRADC_DELAY_KICK |
+		LRADC_DELAY_DELAY(lradc->settling_delay),
+			lradc->base + LRADC_DELAY(2));
+}
+
+static unsigned mxs_lradc_read_raw_channel(struct mxs_lradc *lradc,
+							unsigned channel)
+{
+	u32 reg;
+	unsigned num_samples, val;
+
+	reg = readl(lradc->base + LRADC_CH(channel));
+	if (reg & LRADC_CH_ACCUMULATE)
+		num_samples = lradc->over_sample_cnt;
+	else
+		num_samples = 1;
+
+	val = (reg & LRADC_CH_VALUE_MASK) >> LRADC_CH_VALUE_OFFSET;
+	return val / num_samples;
+}
+
+static unsigned mxs_lradc_read_ts_pressure(struct mxs_lradc *lradc,
+						unsigned ch1, unsigned ch2)
+{
+	u32 reg, mask;
+	unsigned pressure, m1, m2;
+
+	mask = LRADC_CTRL1_LRADC_IRQ(ch1) | LRADC_CTRL1_LRADC_IRQ(ch2);
+	reg = readl(lradc->base + LRADC_CTRL1) & mask;
+
+	while (reg != mask) {
+		reg = readl(lradc->base + LRADC_CTRL1) & mask;
+		dev_dbg(lradc->dev, "One channel is still busy: %X\n", reg);
+	}
+
+	m1 = mxs_lradc_read_raw_channel(lradc, ch1);
+	m2 = mxs_lradc_read_raw_channel(lradc, ch2);
+
+	if (m1 == 0) {
+		dev_warn(lradc->dev, "Cannot calculate pressure\n");
+		return 1 << (LRADC_RESOLUTION - 1);
+	}
+
+	/* simply scale the value from 0 ... max ADC resolution */
+	pressure = m1;
+	pressure *= (1 << LRADC_RESOLUTION);
+	pressure /= m2;
+
+	dev_dbg(lradc->dev, "Pressure = %u\n", pressure);
+	return pressure;
+}
+
+#define TS_CH_XP 2
+#define TS_CH_YP 3
+#define TS_CH_XM 4
+#define TS_CH_YM 5
+
+static int mxs_lradc_read_ts_channel(struct mxs_lradc *lradc)
+{
+	u32 reg;
+	int val;
+
+	reg = readl(lradc->base + LRADC_CTRL1);
+
+	/* only channels 3 to 5 are of interest here */
+	if (reg & LRADC_CTRL1_LRADC_IRQ(TS_CH_YP)) {
+		pr_devel("!3");
+		writel(LRADC_CTRL1_LRADC_IRQ_EN(TS_CH_YP) |
+			LRADC_CTRL1_LRADC_IRQ(TS_CH_YP),
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+		val = mxs_lradc_read_raw_channel(lradc, TS_CH_YP);
+	} else if (reg & LRADC_CTRL1_LRADC_IRQ(TS_CH_XM)) {
+		pr_devel("!4");
+		writel(LRADC_CTRL1_LRADC_IRQ_EN(TS_CH_XM) |
+			LRADC_CTRL1_LRADC_IRQ(TS_CH_XM),
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+		val = mxs_lradc_read_raw_channel(lradc, TS_CH_XM);
+	} else if (reg & LRADC_CTRL1_LRADC_IRQ(TS_CH_YM)) {
+		pr_devel("!5");
+		writel(LRADC_CTRL1_LRADC_IRQ_EN(TS_CH_YM) |
+			LRADC_CTRL1_LRADC_IRQ(TS_CH_YM),
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+		val = mxs_lradc_read_raw_channel(lradc, TS_CH_YM);
+	} else {
+		pr_devel("!?");
+		return -EIO;
+	}
+
+	writel(0, lradc->base + LRADC_DELAY(2));
+	writel(0, lradc->base + LRADC_DELAY(3));
+
+	return val;
+}
+
+/*
+ * YP(open)--+-------------+
+ *           |             |--+
+ *           |             |  |
+ *    YM(-)--+-------------+  |
+ *             +--------------+
+ *             |              |
+ *         XP(weak+)        XM(open)
+ *
+ * "weak+" means 200k Ohm VDDIO
+ * (-) means GND
+ */
+static void mxs_lradc_setup_touch_detection(struct mxs_lradc *lradc)
+{
+	/*
+	 * In order to detect a touch event the 'touch detect enable' bit
+	 * enables:
+	 *  - a weak pullup to the X+ connector
+	 *  - a strong ground at the Y- connector
+	 */
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
+	pr_devel(">T");
+}
+
+/*
+ * YP(meas)--+-------------+
+ *           |             |--+
+ *           |             |  |
+ * YM(open)--+-------------+  |
+ *             +--------------+
+ *             |              |
+ *           XP(+)          XM(-)
+ *
+ * (+) means here 1.85 V
+ * (-) means here GND
+ */
+static void mxs_lradc_prepare_x_pos(struct mxs_lradc *lradc)
+{
+	if (lradc->soc == IMX28_LRADC) {
+		writel(LRADC_CTRL0_MX28_PLATE_MASK,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+		writel(LRADC_CTRL0_MX28_XPPSW | LRADC_CTRL0_MX28_XNNSW,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	} else {
+		writel(LRADC_CTRL0_MX23_PLATE_MASK,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+		writel(LRADC_CTRL0_MX23_XP | LRADC_CTRL0_MX23_XM,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	}
+	lradc->cur_plate = LRADC_SAMPLE_X;
+	mxs_lradc_setup_ts_channel(lradc, TS_CH_YP);
+	pr_devel(">X");
+}
+
+/*
+ *   YP(+)--+-------------+
+ *          |             |--+
+ *          |             |  |
+ *   YM(-)--+-------------+  |
+ *            +--------------+
+ *            |              |
+ *         XP(open)        XM(meas)
+ *
+ * (+) means here 1.85 V
+ * (-) means here GND
+ */
+static void mxs_lradc_prepare_y_pos(struct mxs_lradc *lradc)
+{
+	if (lradc->soc == IMX28_LRADC) {
+		writel(LRADC_CTRL0_MX28_PLATE_MASK,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+		writel(LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_YNNSW,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	} else {
+		writel(LRADC_CTRL0_MX23_PLATE_MASK,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+		writel(LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_YM,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	}
+	lradc->cur_plate = LRADC_SAMPLE_Y;
+	mxs_lradc_setup_ts_channel(lradc, TS_CH_XM);
+	pr_devel(">Y");
+}
+
+/*
+ *    YP(+)--+-------------+
+ *           |             |--+
+ *           |             |  |
+ * YM(meas)--+-------------+  |
+ *             +--------------+
+ *             |              |
+ *          XP(meas)        XM(-)
+ *
+ * (+) means here 1.85 V
+ * (-) means here GND
+ */
+static void mxs_lradc_prepare_pressure(struct mxs_lradc *lradc)
+{
+	if (lradc->soc == IMX28_LRADC) {
+		writel(LRADC_CTRL0_MX28_PLATE_MASK,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+		writel(LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW, /* TODO */
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	} else {
+		writel(LRADC_CTRL0_MX23_PLATE_MASK,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
+		writel(LRADC_CTRL0_MX23_YP | LRADC_CTRL0_MX23_XM,
+			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
+	}
+	lradc->cur_plate = LRADC_SAMPLE_PRESSURE;
+	mxs_lradc_setup_ts_pressure(lradc, TS_CH_XP, TS_CH_YM);
+	pr_devel(">P");
+}
+
+static void mxs_lradc_enable_touch_detection(struct mxs_lradc *lradc)
+{
+	mxs_lradc_setup_touch_detection(lradc);
+	lradc->cur_plate = LRADC_TOUCH;
+	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ | LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
+}
+
+static void mxs_lradc_report_ts_event(struct mxs_lradc *lradc)
+{
+	input_report_abs(lradc->ts_input, ABS_X, lradc->ts_x_pos);
+	input_report_abs(lradc->ts_input, ABS_Y, lradc->ts_y_pos);
+	input_report_abs(lradc->ts_input, ABS_PRESSURE, lradc->ts_pressure);
+	input_report_key(lradc->ts_input, BTN_TOUCH, 1);
+	input_sync(lradc->ts_input);
+}
+
+static void mxs_lradc_complete_touch_event(struct mxs_lradc *lradc)
+{
+	mxs_lradc_setup_touch_detection(lradc);
+	lradc->cur_plate = LRADC_SAMPLE_VALID;
+	/*
+	 * start a dummy conversion to burn time to settle the signals
+	 * note: we are not interested in the conversion's value
+	 */
+	writel(0, lradc->base + LRADC_CH(5));
+	writel(LRADC_CTRL1_LRADC_IRQ(5),
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	writel(LRADC_CTRL1_LRADC_IRQ_EN(5),
+		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
+	writel(LRADC_DELAY_TRIGGER(1 << 5) |
+		LRADC_DELAY_KICK | LRADC_DELAY_DELAY(10), /* waste 5 ms */
+			lradc->base + LRADC_DELAY(2));
+}
+
+/*
+ * in order to avoid false measurements, report only samples where
+ * the surface is still touched after the position measurement
+ */
+static void mxs_lradc_finish_touch_event(struct mxs_lradc *lradc, bool valid)
+{
+	/* if it is still touched, report the sample */
+	if (valid && mxs_lradc_check_touch_event(lradc)) {
+		lradc->ts_valid = true;
+		mxs_lradc_report_ts_event(lradc);
+		pr_devel("**");
+	}
+
+	/* if it is even still touched, continue with the next measurement */
+	if (mxs_lradc_check_touch_event(lradc)) {
+		mxs_lradc_prepare_y_pos(lradc);
+		return;
+	}
+
+	if (lradc->ts_valid) {
+		/* signal the release */
+		lradc->ts_valid = false;
+		input_report_key(lradc->ts_input, BTN_TOUCH, 0);
+		input_sync(lradc->ts_input);
+	}
+
+	pr_devel("+P");
+	/* if it is released, wait for the next touch via IRQ */
+	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ,
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
+}
+
+/* touchscreen's state machine */
+static void mxs_lradc_handle_touch(struct mxs_lradc *lradc)
+{
+	int val;
+
+	pr_devel("#I");
+	switch (lradc->cur_plate) {
+	case LRADC_TOUCH:
+		pr_devel("#T");
+		/*
+		 * start with the Y-pos, because it uses nearly the same plate
+		 * settings like the touch detection
+		 */
+		if (mxs_lradc_check_touch_event(lradc)) {
+			pr_devel("-P");
+			writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
+					lradc->base + LRADC_CTRL1 +
+							STMP_OFFSET_REG_CLR);
+			mxs_lradc_prepare_y_pos(lradc);
+		}
+		writel(LRADC_CTRL1_TOUCH_DETECT_IRQ,
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+		return;
+
+	case LRADC_SAMPLE_Y:
+		pr_devel("#Y");
+		val = mxs_lradc_read_ts_channel(lradc);
+		if (val < 0) {
+			mxs_lradc_enable_touch_detection(lradc); /* re-start */
+			return;
+		}
+		lradc->ts_y_pos = val;
+		mxs_lradc_prepare_x_pos(lradc);
+		return;
+
+	case LRADC_SAMPLE_X:
+		pr_devel("#X");
+		val = mxs_lradc_read_ts_channel(lradc);
+		if (val < 0) {
+			mxs_lradc_enable_touch_detection(lradc); /* re-start */
+			return;
+		}
+		lradc->ts_x_pos = val;
+		mxs_lradc_prepare_pressure(lradc);
+		return;
+
+	case LRADC_SAMPLE_PRESSURE:
+		pr_devel("#P");
+		lradc->ts_pressure =
+			mxs_lradc_read_ts_pressure(lradc, TS_CH_XP, TS_CH_YM);
+		mxs_lradc_complete_touch_event(lradc);
+		return;
+
+	case LRADC_SAMPLE_VALID:
+		pr_devel("!C\n");
+		val = mxs_lradc_read_ts_channel(lradc); /* ignore the value */
+		mxs_lradc_finish_touch_event(lradc, 1);
+		break;
+	}
+}
+
 /*
  * Raw I/O operations
  */
@@ -324,15 +821,6 @@ static const struct iio_info mxs_lradc_iio_info = {
 	.read_raw		= mxs_lradc_read_raw,
 };
 
-/*
- * Touchscreen handling
- */
-enum lradc_ts_plate {
-	LRADC_SAMPLE_X,
-	LRADC_SAMPLE_Y,
-	LRADC_SAMPLE_PRESSURE,
-};
-
 static int mxs_lradc_ts_touched(struct mxs_lradc *lradc)
 {
 	uint32_t reg;
@@ -516,10 +1004,6 @@ static void mxs_lradc_ts_work(struct work_struct *ts_work)
 	input_report_key(lradc->ts_input, BTN_TOUCH, 0);
 	input_sync(lradc->ts_input);
 
-	/* Do not restart the TS IRQ if the driver is shutting down. */
-	if (lradc->stop_touchscreen)
-		return;
-
 	/* Restart the touchscreen interrupts. */
 	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ,
 		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
@@ -531,48 +1015,38 @@ static int mxs_lradc_ts_open(struct input_dev *dev)
 {
 	struct mxs_lradc *lradc = input_get_drvdata(dev);
 
-	/* The touchscreen is starting. */
-	lradc->stop_touchscreen = false;
-
 	/* Enable the touch-detect circuitry. */
-	if (lradc->soc == IMX28_LRADC)
-		writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
-			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
-	else
-		writel(LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE,
-			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_SET);
-
-	/* Enable the touch-detect IRQ. */
-	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_SET);
+	mxs_lradc_enable_touch_detection(lradc);
 
 	return 0;
 }
 
-static void mxs_lradc_ts_close(struct input_dev *dev)
+static void mxs_lradc_disable_ts(struct mxs_lradc *lradc)
 {
-	struct mxs_lradc *lradc = input_get_drvdata(dev);
-
-	/* Indicate the touchscreen is stopping. */
-	lradc->stop_touchscreen = true;
-	mb();
-
-	/* Wait until touchscreen thread finishes any possible remnants. */
-	cancel_work_sync(&lradc->ts_work);
-
-	/* Disable touchscreen touch-detect IRQ. */
-	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
-		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
+	/* stop all interrupts from firing */
+	writel(LRADC_CTRL1_TOUCH_DETECT_IRQ_EN | LRADC_CTRL1_LRADC_IRQ_EN(2) |
+		LRADC_CTRL1_LRADC_IRQ_EN(3) | LRADC_CTRL1_LRADC_IRQ_EN(4) |
+		LRADC_CTRL1_LRADC_IRQ_EN(5),
+			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
 
 	/* Power-down touchscreen touch-detect circuitry. */
 	if (lradc->soc == IMX28_LRADC)
-		writel(LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
+		writel(LRADC_CTRL0_MX28_PLATE_MASK |
+					LRADC_CTRL0_MX28_TOUCH_DETECT_ENABLE,
 			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
 	else
-		writel(LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE,
+		writel(LRADC_CTRL0_MX23_PLATE_MASK |
+					LRADC_CTRL0_MX23_TOUCH_DETECT_ENABLE,
 			lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
 }
 
+static void mxs_lradc_ts_close(struct input_dev *dev)
+{
+	struct mxs_lradc *lradc = input_get_drvdata(dev);
+
+	mxs_lradc_disable_ts(lradc);
+}
+
 static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
 {
 	struct input_dev *input;
@@ -618,6 +1092,7 @@ static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
 
 	cancel_work_sync(&lradc->ts_work);
 
+	mxs_lradc_disable_ts(lradc);
 	input_unregister_device(lradc->ts_input);
 }
 
@@ -630,8 +1105,11 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
 	struct mxs_lradc *lradc = iio_priv(iio);
 	unsigned long reg = readl(lradc->base + LRADC_CTRL1);
 	const uint32_t ts_irq_mask =
-		LRADC_CTRL1_TOUCH_DETECT_IRQ_EN |
-		LRADC_CTRL1_TOUCH_DETECT_IRQ;
+		LRADC_CTRL1_TOUCH_DETECT_IRQ |
+		LRADC_CTRL1_LRADC_IRQ(2) |
+		LRADC_CTRL1_LRADC_IRQ(3) |
+		LRADC_CTRL1_LRADC_IRQ(4) |
+		LRADC_CTRL1_LRADC_IRQ(5);
 
 	if (lradc->soc == IMX28_LRADC) {
 		if (!(reg & LRADC_CTRL1_MX28_LRADC_IRQ_MASK))
@@ -641,30 +1119,14 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
 			return IRQ_NONE;
 	}
 
-	/*
-	 * Touchscreen IRQ handling code has priority and therefore
-	 * is placed here. In case touchscreen IRQ arrives, disable
-	 * it ASAP
-	 */
-	if (reg & LRADC_CTRL1_TOUCH_DETECT_IRQ) {
-		writel(ts_irq_mask,
-			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
-		if (!lradc->stop_touchscreen)
-			schedule_work(&lradc->ts_work);
-	}
+	if (lradc->use_touchscreen && (reg & ts_irq_mask))
+		mxs_lradc_handle_touch(lradc);
 
 	if (iio_buffer_enabled(iio))
 		iio_trigger_poll(iio->trig, iio_get_time_ns());
 	else if (reg & LRADC_CTRL1_LRADC_IRQ(0))
 		complete(&lradc->completion);
 
-	if (lradc->soc == IMX28_LRADC)
-		writel(reg & LRADC_CTRL1_MX28_LRADC_IRQ_MASK,
-			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
-	else
-		writel(reg & LRADC_CTRL1_MX23_LRADC_IRQ_MASK,
-			lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
-
 	return IRQ_HANDLED;
 }
 
@@ -967,6 +1429,17 @@ static const struct of_device_id mxs_lradc_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
 
+static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
+						struct device_node *lradc_node)
+{
+	/* TODO retrieve from device tree */
+	lradc->over_sample_cnt = 4;
+	lradc->over_sample_delay = 2;
+	lradc->settling_delay = 10;
+
+	return 0;
+}
+
 static int mxs_lradc_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
@@ -979,7 +1452,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	struct iio_dev *iio;
 	struct resource *iores;
 	uint32_t ts_wires = 0;
-	int ret = 0;
+	int ret = 0, touch_ret;
 	int i;
 
 	/* Allocate the IIO device. */
@@ -999,7 +1472,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	if (IS_ERR(lradc->base))
 		return PTR_ERR(lradc->base);
 
-	INIT_WORK(&lradc->ts_work, mxs_lradc_ts_work);
+	touch_ret = mxs_lradc_probe_touchscreen(lradc, node);
 
 	/* Check if touchscreen is enabled in DT. */
 	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
@@ -1062,9 +1535,11 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 		goto err_dev;
 
 	/* Register the touchscreen input device. */
-	ret = mxs_lradc_ts_register(lradc);
-	if (ret)
-		goto err_dev;
+	if (touch_ret == 0) {
+		ret = mxs_lradc_ts_register(lradc);
+		if (ret)
+			goto err_dev;
+	}
 
 	/* Register IIO device. */
 	ret = iio_device_register(iio);
-- 
1.8.4.rc3
