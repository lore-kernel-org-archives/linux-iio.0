Return-Path: <SRS0=+L0w=EA=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: [PATCH] iio: adc: stm32: fix scan of multiple channels with DMA
Date: Fri, 5 Jan 2018 15:34:54 +0100
Message-ID: <1515162894-11637-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

By default, watermark is set to '1'. Watermark is used to fine tune
cyclic dma buffer period. In case watermark is left untouched (e.g. 1)
and several channels are being scanned, buffer period is wrongly set
(e.g. to 1 sample). As a consequence, data is never pushed to upper layer.
Fix buffer period size, by taking scan channels number into account.

Fixes: 2763ea0585c9 ("iio: adc: stm32: add optional dma support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index c9d96f9..cecf1e5 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1315,6 +1315,7 @@ static int stm32_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	unsigned int watermark = STM32_DMA_BUFFER_SIZE / 2;
+	unsigned int rx_buf_sz = STM32_DMA_BUFFER_SIZE;
 
 	/*
 	 * dma cyclic transfers are used, buffer is split into two periods.
@@ -1323,7 +1324,7 @@ static int stm32_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
 	 * - one buffer (period) driver can push with iio_trigger_poll().
 	 */
 	watermark = min(watermark, val * (unsigned)(sizeof(u16)));
-	adc->rx_buf_sz = watermark * 2;
+	adc->rx_buf_sz = min(rx_buf_sz, watermark * 2 * adc->num_conv);
 
 	return 0;
 }
-- 
1.9.1
