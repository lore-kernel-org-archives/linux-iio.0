Return-Path: <SRS0=FLeV=AT=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@st.com>,
        <benjamin.gaignard@linaro.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: [PATCH 3/3] iio: trigger: stm32-timer: enable clock when in master mode
Date: Mon, 18 Sep 2017 12:05:32 +0200
Message-ID: <1505729132-1369-4-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1505729132-1369-1-git-send-email-fabrice.gasnier@st.com>
References: <1505729132-1369-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Clock should be enabled as soon as using master mode, even before
enabling timer. Or, this may provoke bad behavior on the other end
(slave timer). Then, introduce 'clk_enabled' flag, instead of relying
on CR1 EN bit, to keep track of clock being enabled.
Propagate this anywhere else in the driver.

Also add 'remove' routine to stop timer and disable clock in case it
has been left enabled.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 60 +++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index eb212f8c..5a6509c 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -79,6 +79,7 @@ struct stm32_timer_trigger {
 	struct device *dev;
 	struct regmap *regmap;
 	struct clk *clk;
+	bool clk_enabled;
 	u32 max_arr;
 	const void *triggers;
 	const void *valids;
@@ -106,7 +107,7 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 {
 	unsigned long long prd, div;
 	int prescaler = 0;
-	u32 ccer, cr1;
+	u32 ccer;
 
 	/* Period and prescaler values depends of clock rate */
 	div = (unsigned long long)clk_get_rate(priv->clk);
@@ -136,9 +137,10 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 	if (ccer & TIM_CCER_CCXE)
 		return -EBUSY;
 
-	regmap_read(priv->regmap, TIM_CR1, &cr1);
-	if (!(cr1 & TIM_CR1_CEN))
+	if (!priv->clk_enabled) {
+		priv->clk_enabled = true;
 		clk_enable(priv->clk);
+	}
 
 	regmap_write(priv->regmap, TIM_PSC, prescaler);
 	regmap_write(priv->regmap, TIM_ARR, prd - 1);
@@ -163,16 +165,12 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
 
 static void stm32_timer_stop(struct stm32_timer_trigger *priv)
 {
-	u32 ccer, cr1;
+	u32 ccer;
 
 	regmap_read(priv->regmap, TIM_CCER, &ccer);
 	if (ccer & TIM_CCER_CCXE)
 		return;
 
-	regmap_read(priv->regmap, TIM_CR1, &cr1);
-	if (cr1 & TIM_CR1_CEN)
-		clk_disable(priv->clk);
-
 	/* Stop timer */
 	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
 	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
@@ -181,6 +179,11 @@ static void stm32_timer_stop(struct stm32_timer_trigger *priv)
 
 	/* Make sure that registers are updated */
 	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
+
+	if (priv->clk_enabled) {
+		priv->clk_enabled = false;
+		clk_disable(priv->clk);
+	}
 }
 
 static ssize_t stm32_tt_store_frequency(struct device *dev,
@@ -295,6 +298,11 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
 	for (i = 0; i <= master_mode_max; i++) {
 		if (!strncmp(master_mode_table[i], buf,
 			     strlen(master_mode_table[i]))) {
+			if (!priv->clk_enabled) {
+				/* Clock should be enabled first */
+				priv->clk_enabled = true;
+				clk_enable(priv->clk);
+			}
 			regmap_update_bits(priv->regmap, TIM_CR2, mask,
 					   i << shift);
 			/* Make sure that registers are updated */
@@ -438,7 +446,6 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 				   int val, int val2, long mask)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
-	u32 dat;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -450,17 +457,19 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_ENABLE:
 		if (val) {
-			regmap_read(priv->regmap, TIM_CR1, &dat);
-			if (!(dat & TIM_CR1_CEN))
+			if (!priv->clk_enabled) {
+				priv->clk_enabled = true;
 				clk_enable(priv->clk);
+			}
 			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
 					   TIM_CR1_CEN);
 		} else {
-			regmap_read(priv->regmap, TIM_CR1, &dat);
 			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
 					   0);
-			if (dat & TIM_CR1_CEN)
+			if (priv->clk_enabled) {
+				priv->clk_enabled = false;
 				clk_disable(priv->clk);
+			}
 		}
 		return 0;
 	}
@@ -558,7 +567,6 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	int sms = stm32_enable_mode2sms(mode);
-	u32 val;
 
 	if (sms < 0)
 		return sms;
@@ -566,10 +574,9 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 	 * Triggered mode sets CEN bit automatically by hardware. So, first
 	 * enable counter clock, so it can use it. Keeps it in sync with CEN.
 	 */
-	if (sms == 6) {
-		regmap_read(priv->regmap, TIM_CR1, &val);
-		if (!(val & TIM_CR1_CEN))
-			clk_enable(priv->clk);
+	if (sms == 6 && !priv->clk_enabled) {
+		clk_enable(priv->clk);
+		priv->clk_enabled = true;
 	}
 
 	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
@@ -848,6 +855,22 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int stm32_timer_trigger_remove(struct platform_device *pdev)
+{
+	struct stm32_timer_trigger *priv = platform_get_drvdata(pdev);
+	u32 val;
+
+	/* Check if nobody else use the timer, then disable it */
+	regmap_read(priv->regmap, TIM_CCER, &val);
+	if (!(val & TIM_CCER_CCXE))
+		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
+
+	if (priv->clk_enabled)
+		clk_disable(priv->clk);
+
+	return 0;
+}
+
 static const struct stm32_timer_trigger_cfg stm32_timer_trg_cfg = {
 	.valids_table = valids_table,
 	.num_valids_table = ARRAY_SIZE(valids_table),
@@ -872,6 +895,7 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
 
 static struct platform_driver stm32_timer_trigger_driver = {
 	.probe = stm32_timer_trigger_probe,
+	.remove = stm32_timer_trigger_remove,
 	.driver = {
 		.name = "stm32-timer-trigger",
 		.of_match_table = stm32_trig_of_match,
-- 
1.9.1
