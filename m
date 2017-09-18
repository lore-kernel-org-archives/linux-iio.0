Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44744 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755990AbdIRQZQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2017 12:25:16 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <benjamin.gaignard@linaro.org>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>
Subject: [PATCH] iio: adc: stm32: fix bad error check on max_channels
Date: Mon, 18 Sep 2017 18:24:15 +0200
Message-ID: <1505751855-15490-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix a bad error check when counting 'st,adc-channels' array elements.
This is seen when all channels are in use simultaneously.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index e3c15f8..4df32cf 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1666,7 +1666,7 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
 
 	num_channels = of_property_count_u32_elems(node, "st,adc-channels");
 	if (num_channels < 0 ||
-	    num_channels >= adc_info->max_channels) {
+	    num_channels > adc_info->max_channels) {
 		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");
 		return num_channels < 0 ? num_channels : -EINVAL;
 	}
-- 
1.9.1

