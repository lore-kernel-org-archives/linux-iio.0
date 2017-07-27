Return-Path: <SRS0=L35J=66=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <benjamin.gaignard@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>
Subject: [PATCH 4/4] iio: trigger: stm32-timer: add enable attribute
Date: Thu, 27 Jul 2017 18:19:00 +0200
Message-ID: <1501172340-8448-5-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
References: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

In order to use encoder mode, timers needs to be enabled (e.g. CEN bit)
along with peripheral clock.
Add IIO_CHAN_INFO_ENABLE attribute to handle this.
Also, in triggered mode, CEN bit is set automatically in hardware.
Then clock must be enabled before starting triggered mode.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 55 +++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index d28aa02..14e6eb0 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -366,34 +366,32 @@ static int stm32_counter_read_raw(struct iio_dev *indio_dev,
 				  int *val, int *val2, long mask)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+	u32 dat;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-	{
-		u32 cnt;
-
-		regmap_read(priv->regmap, TIM_CNT, &cnt);
-		*val = cnt;
+		regmap_read(priv->regmap, TIM_CNT, &dat);
+		*val = dat;
+		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_ENABLE:
+		regmap_read(priv->regmap, TIM_CR1, &dat);
+		*val = (dat & TIM_CR1_CEN) ? 1 : 0;
 		return IIO_VAL_INT;
-	}
-	case IIO_CHAN_INFO_SCALE:
-	{
-		u32 smcr;
 
-		regmap_read(priv->regmap, TIM_SMCR, &smcr);
-		smcr &= TIM_SMCR_SMS;
+	case IIO_CHAN_INFO_SCALE:
+		regmap_read(priv->regmap, TIM_SMCR, &dat);
+		dat &= TIM_SMCR_SMS;
 
 		*val = 1;
 		*val2 = 0;
 
 		/* in quadrature case scale = 0.25 */
-		if (smcr == 3)
+		if (dat == 3)
 			*val2 = 2;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
-	}
 
 	return -EINVAL;
 }
@@ -403,6 +401,7 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 				   int val, int val2, long mask)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+	u32 dat;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -411,6 +410,22 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		/* fixed scale */
 		return -EINVAL;
+
+	case IIO_CHAN_INFO_ENABLE:
+		if (val) {
+			regmap_read(priv->regmap, TIM_CR1, &dat);
+			if (!(dat & TIM_CR1_CEN))
+				clk_enable(priv->clk);
+			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
+					   TIM_CR1_CEN);
+		} else {
+			regmap_read(priv->regmap, TIM_CR1, &dat);
+			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
+					   0);
+			if (dat & TIM_CR1_CEN)
+				clk_disable(priv->clk);
+		}
+		return 0;
 	}
 
 	return -EINVAL;
@@ -506,9 +521,19 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	int sms = stm32_enable_mode2sms(mode);
+	u32 val;
 
 	if (sms < 0)
 		return sms;
+	/*
+	 * Triggered mode sets CEN bit automatically by hardware. So, first
+	 * enable counter clock, so it can use it. Keeps it in sync with CEN.
+	 */
+	if (sms == 6) {
+		regmap_read(priv->regmap, TIM_CR1, &val);
+		if (!(val & TIM_CR1_CEN))
+			clk_enable(priv->clk);
+	}
 
 	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
 
@@ -681,7 +706,9 @@ static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
 static const struct iio_chan_spec stm32_trigger_channel = {
 	.type = IIO_COUNT,
 	.channel = 0,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_ENABLE) |
+			      BIT(IIO_CHAN_INFO_SCALE),
 	.ext_info = stm32_trigger_count_info,
 	.indexed = 1
 };
-- 
1.9.1
