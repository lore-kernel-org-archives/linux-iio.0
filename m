Return-Path: <SRS0=L35J=66=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <benjamin.gaignard@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>
Subject: [PATCH 3/4] iio: trigger: stm32-timer: fix get/set down count direction
Date: Thu, 27 Jul 2017 18:18:59 +0200
Message-ID: <1501172340-8448-4-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
References: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Fixes: 4adec7da0536 ("iio: stm32 trigger: Add quadrature encoder device")

This fixes two issues:
- stm32_set_count_direction: to set down direction
- stm32_get_count_direction: to get down direction

IIO core provides/expects value to be an index of iio_enum items array.
This needs to be turned by these routines into TIM_CR1_DIR (e.g. BIT(4))
value.
Also, report error when attempting to write direction, when in encoder
mode: in this case, direction is read only (given by encoder inputs).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 107918b..d28aa02 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -594,13 +594,20 @@ static int stm32_get_quadrature_mode(struct iio_dev *indio_dev,
 
 static int stm32_set_count_direction(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
-				     unsigned int mode)
+				     unsigned int dir)
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
+	u32 val;
+	int mode;
 
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_DIR, mode);
+	/* In encoder mode, direction is RO (given by TI1/TI2 signals) */
+	regmap_read(priv->regmap, TIM_SMCR, &val);
+	mode = (val & TIM_SMCR_SMS) - 1;
+	if ((mode >= 0) || (mode < ARRAY_SIZE(stm32_quadrature_modes)))
+		return -EBUSY;
 
-	return 0;
+	return regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_DIR,
+				  dir ? TIM_CR1_DIR : 0);
 }
 
 static int stm32_get_count_direction(struct iio_dev *indio_dev,
@@ -611,7 +618,7 @@ static int stm32_get_count_direction(struct iio_dev *indio_dev,
 
 	regmap_read(priv->regmap, TIM_CR1, &cr1);
 
-	return (cr1 & TIM_CR1_DIR);
+	return ((cr1 & TIM_CR1_DIR) ? 1 : 0);
 }
 
 static const struct iio_enum stm32_count_direction_enum = {
-- 
1.9.1
