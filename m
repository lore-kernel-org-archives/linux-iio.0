Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:24049 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbcCVQJI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2016 12:09:08 -0400
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <jic23@kernel.org>
CC: <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nicolas.ferre@atmel.com>,
	<alexandre.belloni@free-electrons.com>,
	<linux-arm-kernel@lists.infradead.org>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 2/2] iio:adc:at91-sama5d2: add support for differential conversions
Date: Tue, 22 Mar 2016 17:08:46 +0100
Message-ID: <1458662926-8791-2-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1458662926-8791-1-git-send-email-ludovic.desroches@atmel.com>
References: <1458662926-8791-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add signed differential channels and update the voltage scale for
differential conversions.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

This patch is based on:
iio:adc:at91-sama5d2: fix identation
iio:adc:at91-sama5d2: fix typo

 drivers/iio/adc/at91-sama5d2_adc.c | 71 ++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 01ba106..07adb10 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -113,8 +113,11 @@
 #define AT91_SAMA5D2_CWR	0x44
 /* Channel Gain Register */
 #define AT91_SAMA5D2_CGR	0x48
+
 /* Channel Offset Register */
 #define AT91_SAMA5D2_COR	0x4c
+#define AT91_SAMA5D2_COR_DIFF_OFFSET	16
+
 /* Channel Data Register 0 */
 #define AT91_SAMA5D2_CDR0	0x50
 /* Analog Control Register */
@@ -142,7 +145,7 @@
 /* Version Register */
 #define AT91_SAMA5D2_VERSION	0xfc
 
-#define AT91_SAMA5D2_CHAN(num, addr)					\
+#define AT91_SAMA5D2_CHAN_SINGLE(num, addr)				\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.channel = num,						\
@@ -158,6 +161,24 @@
 		.indexed = 1,						\
 	}
 
+#define AT91_SAMA5D2_CHAN_DIFF(num, num2, addr)				\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.differential = 1,					\
+		.channel = num,						\
+		.channel2 = num2,					\
+		.address = addr,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 12,					\
+		},							\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+		.datasheet_name = "CH"#num"-CH"#num2,			\
+		.indexed = 1,						\
+	}
+
 #define at91_adc_readl(st, reg)		readl_relaxed(st->base + reg)
 #define at91_adc_writel(st, reg, val)	writel_relaxed(val, st->base + reg)
 
@@ -187,18 +208,24 @@ struct at91_adc_state {
 };
 
 static const struct iio_chan_spec at91_adc_channels[] = {
-	AT91_SAMA5D2_CHAN(0, 0x50),
-	AT91_SAMA5D2_CHAN(1, 0x54),
-	AT91_SAMA5D2_CHAN(2, 0x58),
-	AT91_SAMA5D2_CHAN(3, 0x5c),
-	AT91_SAMA5D2_CHAN(4, 0x60),
-	AT91_SAMA5D2_CHAN(5, 0x64),
-	AT91_SAMA5D2_CHAN(6, 0x68),
-	AT91_SAMA5D2_CHAN(7, 0x6c),
-	AT91_SAMA5D2_CHAN(8, 0x70),
-	AT91_SAMA5D2_CHAN(9, 0x74),
-	AT91_SAMA5D2_CHAN(10, 0x78),
-	AT91_SAMA5D2_CHAN(11, 0x7c),
+	AT91_SAMA5D2_CHAN_SINGLE(0, 0x50),
+	AT91_SAMA5D2_CHAN_SINGLE(1, 0x54),
+	AT91_SAMA5D2_CHAN_SINGLE(2, 0x58),
+	AT91_SAMA5D2_CHAN_SINGLE(3, 0x5c),
+	AT91_SAMA5D2_CHAN_SINGLE(4, 0x60),
+	AT91_SAMA5D2_CHAN_SINGLE(5, 0x64),
+	AT91_SAMA5D2_CHAN_SINGLE(6, 0x68),
+	AT91_SAMA5D2_CHAN_SINGLE(7, 0x6c),
+	AT91_SAMA5D2_CHAN_SINGLE(8, 0x70),
+	AT91_SAMA5D2_CHAN_SINGLE(9, 0x74),
+	AT91_SAMA5D2_CHAN_SINGLE(10, 0x78),
+	AT91_SAMA5D2_CHAN_SINGLE(11, 0x7c),
+	AT91_SAMA5D2_CHAN_DIFF(0, 1, 0x50),
+	AT91_SAMA5D2_CHAN_DIFF(2, 3, 0x58),
+	AT91_SAMA5D2_CHAN_DIFF(4, 5, 0x60),
+	AT91_SAMA5D2_CHAN_DIFF(6, 7, 0x68),
+	AT91_SAMA5D2_CHAN_DIFF(8, 9, 0x70),
+	AT91_SAMA5D2_CHAN_DIFF(10, 11, 0x78),
 };
 
 static unsigned at91_adc_startup_time(unsigned startup_time_min,
@@ -281,6 +308,7 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 			     int *val, int *val2, long mask)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
+	u32 cor = 0;
 	int ret;
 
 	switch (mask) {
@@ -289,6 +317,11 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 
 		st->chan = chan;
 
+		if (chan->differential)
+			cor = (BIT(chan->channel) | BIT(chan->channel2)) <<
+			      AT91_SAMA5D2_COR_DIFF_OFFSET;
+
+		at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
 		at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
 		at91_adc_writel(st, AT91_SAMA5D2_IER, BIT(chan->channel));
 		at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_START);
@@ -301,6 +334,8 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 
 		if (ret > 0) {
 			*val = st->conversion_value;
+			if (chan->scan_type.sign == 's')
+				*val = sign_extend32(*val, 11);
 			ret = IIO_VAL_INT;
 			st->conversion_done = false;
 		}
@@ -313,6 +348,8 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_uv / 1000;
+		if (chan->differential)
+			*val *= 2;
 		*val2 = chan->scan_type.realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 
@@ -447,8 +484,12 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
 	at91_adc_writel(st, AT91_SAMA5D2_IDR, 0xffffffff);
-	/* Transfer field must be set to 2 according to the datasheet. */
-	at91_adc_writel(st, AT91_SAMA5D2_MR, AT91_SAMA5D2_MR_TRANSFER(2));
+	/*
+	 * Transfer field must be set to 2 according to the datasheet and
+	 * allows different analog settings for each channel.
+	 */
+	at91_adc_writel(st, AT91_SAMA5D2_MR,
+			AT91_SAMA5D2_MR_TRANSFER(2) | AT91_SAMA5D2_MR_ANACH);
 
 	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
 
-- 
2.5.0

