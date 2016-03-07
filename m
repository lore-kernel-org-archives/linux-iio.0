Return-Path: <ludovic.desroches@atmel.com>
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <nicolas.ferre@atmel.com>, Ludovic
 Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2 2/2] iio:adc:at91-sama5d2: add support for signed conversion
Date: Mon, 7 Mar 2016 15:29:57 +0100
Message-ID: <1457360997-29179-3-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1457360997-29179-1-git-send-email-ludovic.desroches@atmel.com>
References: <1457360997-29179-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The at91-sama5d2 ADC controller can achieve unsigned and signed
conversions. For each channel, a signed and an unsigned variant are
created.
Sign mode is a global configuration, it is not tied to a specific
channel. For this reason, the controller has to be configured upon
conversion request.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 125 ++++++++++++++++++++++++++++++-------
 1 file changed, 102 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 5bc038f..0370c4f 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -105,8 +105,26 @@
 #define AT91_SAMA5D2_LCCWR	0x38
 /* Overrun Status Register */
 #define AT91_SAMA5D2_OVER	0x3c
+
 /* Extended Mode Register */
 #define AT91_SAMA5D2_EMR	0x40
+/* Sign Mode */
+#define AT91_SAMA5D2_EMR_SIGNMODE(v)		((v) << 25)
+/*
+ * Single-Ended channels: Unsigned conversions.
+ * Differential channels: Signed conversions.
+ */
+#define AT91_SAMA5D2_EMR_SE_UNSG_DF_SIGN	0
+/*
+ * Single-Ended channels: Signed conversions.
+ * Differential channels: Unsigned conversions.
+ */
+#define AT91_SAMA5D2_EMR_SE_SIGN_DF_UNSG	1
+/* All channels: Unsigned conversions */
+#define AT91_SAMA5D2_EMR_ALL_UNSIGNED		2
+/* All channels: Signed conversions */
+#define AT91_SAMA5D2_EMR_ALL_SIGNED		3
+
 /* Compare Window Register */
 #define AT91_SAMA5D2_CWR	0x44
 /* Channel Gain Register */
@@ -140,22 +158,28 @@
 /* Version Register */
 #define AT91_SAMA5D2_VERSION	0xfc
 
-#define AT91_SAMA5D2_CHAN(num, addr)					\
+#define AT91_SAMA5D2_VOLTAGE_CHANNEL(num, addr, sign_mode)		\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.channel = num,						\
 		.address = addr,					\
 		.scan_type = {						\
-			.sign = 'u',					\
+			.sign = sign_mode,				\
 			.realbits = 12,					\
 		},							\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_separate = (sign_mode == 's') ? BIT(IIO_CHAN_INFO_SIGNED) : BIT(IIO_CHAN_INFO_RAW),		\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
 		.datasheet_name = "CH"#num,				\
 		.indexed = 1,						\
 	}
 
+#define AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(num, addr)		\
+	AT91_SAMA5D2_VOLTAGE_CHANNEL(num, addr, 's')
+
+#define AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(num, addr)	\
+	AT91_SAMA5D2_VOLTAGE_CHANNEL(num, addr, 'u')
+
 #define at91_adc_readl(st, reg)		readl_relaxed(st->base + reg)
 #define at91_adc_writel(st, reg, val)	writel_relaxed(val, st->base + reg)
 
@@ -185,18 +209,30 @@ struct at91_adc_state {
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
+	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(0, 0x50),
+	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(1, 0x54),
+	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(2, 0x58),
+	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(3, 0x5c),
+	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(4, 0x60),
+	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(5, 0x64),
+	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(6, 0x68),
+	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(7, 0x6c),
+	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(8, 0x70),
+	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(9, 0x74),
+	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(10, 0x78),
+	AT91_SAMA5D2_UNSIGNED_VOLTAGE_CHANNEL(11, 0x7c),
+	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(0, 0x50),
+	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(1, 0x54),
+	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(2, 0x58),
+	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(3, 0x5c),
+	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(4, 0x60),
+	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(5, 0x64),
+	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(6, 0x68),
+	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(7, 0x6c),
+	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(8, 0x70),
+	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(9, 0x74),
+	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(10, 0x78),
+	AT91_SAMA5D2_SIGNED_VOLTAGE_CHANNEL(11, 0x7c),
 };
 
 static unsigned at91_adc_startup_time(unsigned startup_time_min,
@@ -273,6 +309,38 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 	return IRQ_NONE;
 }
 
+static int at91_adc_read_conversion_value(struct at91_adc_state *st)
+{
+	u32 emr;
+	int ret;
+
+	/* Read EMR register and clear 'sign mode' field */
+	emr = at91_adc_readl(st, AT91_SAMA5D2_EMR)
+		& AT91_SAMA5D2_EMR_SIGNMODE(0);
+	/*
+	 * Check if the user requested a conversion on a signed or
+	 * unsigned channel.
+	 */
+	if (st->chan->scan_type.sign == 's')
+		emr |= AT91_SAMA5D2_EMR_SIGNMODE(AT91_SAMA5D2_EMR_ALL_SIGNED);
+	else
+		emr |= AT91_SAMA5D2_EMR_SIGNMODE(AT91_SAMA5D2_EMR_ALL_UNSIGNED);
+
+	at91_adc_writel(st, AT91_SAMA5D2_EMR, emr);
+	at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(st->chan->channel));
+	at91_adc_writel(st, AT91_SAMA5D2_IER, BIT(st->chan->channel));
+	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_START);
+
+	ret = wait_event_interruptible_timeout(st->wq_data_available,
+					       st->conversion_done,
+					       msecs_to_jiffies(1000));
+
+	at91_adc_writel(st, AT91_SAMA5D2_IDR, BIT(st->chan->channel));
+	at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(st->chan->channel));
+
+	return ret;
+}
+
 static int at91_adc_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int *val, int *val2, long mask)
@@ -286,13 +354,8 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 
 		st->chan = chan;
 
-		at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
-		at91_adc_writel(st, AT91_SAMA5D2_IER, BIT(chan->channel));
-		at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_START);
+		ret = at91_adc_read_conversion_value(st);
 
-		ret = wait_event_interruptible_timeout(st->wq_data_available,
-						       st->conversion_done,
-						       msecs_to_jiffies(1000));
 		if (ret == 0)
 			ret = -ETIMEDOUT;
 
@@ -302,8 +365,24 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 			st->conversion_done = false;
 		}
 
-		at91_adc_writel(st, AT91_SAMA5D2_IDR, BIT(chan->channel));
-		at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
+		mutex_unlock(&st->lock);
+		return ret;
+
+	case IIO_CHAN_INFO_SIGNED:
+		mutex_lock(&st->lock);
+
+		st->chan = chan;
+
+		ret = at91_adc_read_conversion_value(st);
+
+		if (ret == 0)
+			ret = -ETIMEDOUT;
+
+		if (ret > 0) {
+			*val = sign_extend32(st->conversion_value, 11);
+			ret = IIO_VAL_INT;
+			st->conversion_done = false;
+		}
 
 		mutex_unlock(&st->lock);
 		return ret;
-- 
2.5.0
