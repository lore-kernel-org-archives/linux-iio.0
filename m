Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33950 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753248AbdIRKGr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2017 06:06:47 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <benjamin.gaignard@linaro.org>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>
Subject: [PATCH 1/3] iio: trigger: stm32-timer: preset shouldn't be buffered
Date: Mon, 18 Sep 2017 12:05:30 +0200
Message-ID: <1505729132-1369-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1505729132-1369-1-git-send-email-fabrice.gasnier@st.com>
References: <1505729132-1369-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently, setting preset value (ARR) will update directly 'Auto reload
value' only on 1st write access. But then, ARPE is set. This makes
ARR a shadow register. Preset value should be updated upon each
write request: ensure ARPE is 0. This fixes successive writes to
preset attribute.

Fixes: 4adec7da0536 ("iio: stm32 trigger: Add quadrature encoder device")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 9b90534..34cc25b 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -715,8 +715,9 @@ static ssize_t stm32_count_set_preset(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
+	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
 	regmap_write(priv->regmap, TIM_ARR, preset);
-	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, TIM_CR1_ARPE);
 
 	return len;
 }
-- 
1.9.1

