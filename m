Return-Path: <SRS0=H85M=CN=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>,
	<linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
	<jic23@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH v3 4/4] iio: adc: at91-sama5d2_adc: ack DRDY irq in direct mode
Date: Wed, 15 Nov 2017 14:56:48 +0200
Message-ID: <1510750608-8697-5-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1510750608-8697-1-git-send-email-eugen.hristev@microchip.com>
References: <1510750608-8697-1-git-send-email-eugen.hristev@microchip.com>
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
index 11d34a8..274cb5e 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -787,6 +787,9 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 		at91_adc_writel(st, AT91_SAMA5D2_IDR, BIT(chan->channel));
 		at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
 
+		/* Needed to ACK the DRDY interruption */
+		at91_adc_readl(st, AT91_SAMA5D2_LCDR);
+
 		mutex_unlock(&st->lock);
 
 		iio_device_release_direct_mode(indio_dev);
-- 
2.7.4
