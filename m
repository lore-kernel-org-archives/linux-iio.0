Return-Path: <SRS0=EPV4=BK=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>,
	<linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
	<jic23@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH v2 4/5] iio: adc: at91-sama5d2_adc: ack DRDY irq in direct mode
Date: Wed, 11 Oct 2017 09:35:31 +0300
Message-ID: <1507703732-29175-5-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1507703732-29175-1-git-send-email-eugen.hristev@microchip.com>
References: <1507703732-29175-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Need to acknowledge DRDY irq in direct mode/ software
triggered mode. Otherwise, on the next conversion, overrun
flag will be raised, which is not a correct state.
This doesn't affect the functionality, but will generate
possible incorrect overrun reports.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 7a9305a..7e51ecb 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -773,6 +773,9 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 		at91_adc_writel(st, AT91_SAMA5D2_IDR, BIT(chan->channel));
 		at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
 
+		/* Needed to ACK the DRDY interruption */
+		at91_adc_readl(st, AT91_SAMA5D2_LCDR);
+
 		mutex_unlock(&st->lock);
 
 		iio_device_release_direct_mode(indio_dev);
-- 
2.7.4
