Return-Path: <SRS0=L35J=66=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <benjamin.gaignard@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>
Subject: [PATCH 2/4] iio: trigger: stm32-timer: fix write_raw return value
Date: Thu, 27 Jul 2017 18:18:58 +0200
Message-ID: <1501172340-8448-3-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
References: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Fixes: 4adec7da0536 ("iio: stm32 trigger: Add quadrature encoder device")

IIO core expects zero as return value for write_raw() callback
in case of success.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 6aa73d6..107918b 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -406,9 +406,8 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		regmap_write(priv->regmap, TIM_CNT, val);
+		return regmap_write(priv->regmap, TIM_CNT, val);
 
-		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* fixed scale */
 		return -EINVAL;
-- 
1.9.1
