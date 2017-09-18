Return-Path: <SRS0=FLeV=AT=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@st.com>,
        <benjamin.gaignard@linaro.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: [PATCH 2/3] iio: trigger: stm32-timer: fix a corner case to write preset
Date: Mon, 18 Sep 2017 12:05:31 +0200
Message-ID: <1505729132-1369-3-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1505729132-1369-1-git-send-email-fabrice.gasnier@st.com>
References: <1505729132-1369-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Balance timer start routine that sets ARPE: clear it in stop routine.
This fixes a corner case, when timer is used successively as trigger
(with sampling_frequency start/stop routines), then as a counter
(with preset).

Fixes: 93fbe91b5521 ("iio: Add STM32 timer trigger driver")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 34cc25b..eb212f8c 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -174,6 +174,7 @@ static void stm32_timer_stop(struct stm32_timer_trigger *priv)
 		clk_disable(priv->clk);
 
 	/* Stop timer */
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
 	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
 	regmap_write(priv->regmap, TIM_PSC, 0);
 	regmap_write(priv->regmap, TIM_ARR, 0);
-- 
1.9.1
