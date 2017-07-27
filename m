Return-Path: <SRS0=L35J=66=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <benjamin.gaignard@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>
Subject: [PATCH 1/4] iio: trigger: stm32-timer: fix quadrature mode get routine
Date: Thu, 27 Jul 2017 18:18:57 +0200
Message-ID: <1501172340-8448-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
References: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Fixes: 4adec7da0536 ("iio: stm32 trigger: Add quadrature encoder device")

SMS bitfiled is mode + 1. After reset, upon boot, SMS = 0. When reading
from sysfs, stm32_get_quadrature_mode() returns -1 (e.g. -EPERM) which is
wrong error code here. So, check SMS bitfiled matches valid encoder mode,
or return -EINVAL.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index d22bc56..6aa73d6 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -571,11 +571,14 @@ static int stm32_get_quadrature_mode(struct iio_dev *indio_dev,
 {
 	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
 	u32 smcr;
+	int mode;
 
 	regmap_read(priv->regmap, TIM_SMCR, &smcr);
-	smcr &= TIM_SMCR_SMS;
+	mode = (smcr & TIM_SMCR_SMS) - 1;
+	if ((mode < 0) || (mode > ARRAY_SIZE(stm32_quadrature_modes)))
+		return -EINVAL;
 
-	return smcr - 1;
+	return mode;
 }
 
 static const struct iio_enum stm32_quadrature_mode_enum = {
-- 
1.9.1
