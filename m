Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32987 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751237AbdHCJXN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Aug 2017 05:23:13 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <benjamin.gaignard@linaro.org>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>
Subject: [PATCH] iio: trigger: stm32-timer: fix get trigger mode
Date: Thu, 3 Aug 2017 11:22:17 +0200
Message-ID: <1501752137-14534-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix reading trigger mode, when other bit-fields are set. SMCR register
value must be masked to read SMS (slave mode selection) only.

Fixes: 9eba381 ("iio: make stm32 trigger driver use
INDIO_HARDWARE_TRIGGERED mode")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 14e6eb0..25ad6ab 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -485,7 +485,7 @@ static int stm32_get_trigger_mode(struct iio_dev *indio_dev,
 
 	regmap_read(priv->regmap, TIM_SMCR, &smcr);
 
-	return smcr == TIM_SMCR_SMS ? 0 : -EINVAL;
+	return (smcr & TIM_SMCR_SMS) == TIM_SMCR_SMS ? 0 : -EINVAL;
 }
 
 static const struct iio_enum stm32_trigger_mode_enum = {
-- 
1.9.1

