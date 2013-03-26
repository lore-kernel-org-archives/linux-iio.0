Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-011.synserver.de ([212.40.185.11]:1124 "EHLO
	smtp-out-226.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932376Ab3CZSlJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Mar 2013 14:41:09 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/6] staging:iio:ad799x: Remove internal reference support
Date: Tue, 26 Mar 2013 19:43:00 +0100
Message-Id: <1364323384-30863-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1364323384-30863-1-git-send-email-lars@metafoo.de>
References: <1364323384-30863-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

None of the devices supported by this driver have an internal voltage reference,
so remove support for it from the driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad799x.h      |  2 --
 drivers/staging/iio/adc/ad799x_core.c | 16 ++++------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 9f50f93..82e83bb 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -87,7 +87,6 @@ struct ad799x_state;
  * struct ad799x_chip_info - chip specifc information
  * @channel:		channel specification
  * @num_channels:	number of channels
- * @int_vref_mv:	the internal reference voltage
  * @monitor_mode:	whether the chip supports monitor interrupts
  * @default_config:	device default configuration
  * @event_attrs:	pointer to the monitor event attribute group
@@ -96,7 +95,6 @@ struct ad799x_state;
 struct ad799x_chip_info {
 	struct iio_chan_spec		channel[9];
 	int				num_channels;
-	u16				int_vref_mv;
 	u16				default_config;
 	const struct iio_info		*info;
 };
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 40cc89a..d12a4b2 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -498,7 +498,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 			[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
-		.int_vref_mv = 4096,
 		.info = &ad7991_info,
 	},
 	[ad7995] = {
@@ -538,7 +537,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 			[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
-		.int_vref_mv = 1024,
 		.info = &ad7991_info,
 	},
 	[ad7999] = {
@@ -578,7 +576,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 			[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
-		.int_vref_mv = 1024,
 		.info = &ad7991_info,
 	},
 	[ad7992] = {
@@ -604,7 +601,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 			[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
 		},
 		.num_channels = 3,
-		.int_vref_mv = 4096,
 		.default_config = AD7998_ALERT_EN,
 		.info = &ad7992_info,
 	},
@@ -649,7 +645,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 			[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
-		.int_vref_mv = 1024,
 		.default_config = AD7998_ALERT_EN,
 		.info = &ad7993_4_7_8_info,
 	},
@@ -694,7 +689,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 			[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
-		.int_vref_mv = 4096,
 		.default_config = AD7998_ALERT_EN,
 		.info = &ad7993_4_7_8_info,
 	},
@@ -771,7 +765,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 			[8] = IIO_CHAN_SOFT_TIMESTAMP(8),
 		},
 		.num_channels = 9,
-		.int_vref_mv = 1024,
 		.default_config = AD7998_ALERT_EN,
 		.info = &ad7993_4_7_8_info,
 	},
@@ -848,7 +841,6 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 			[8] = IIO_CHAN_SOFT_TIMESTAMP(8),
 		},
 		.num_channels = 9,
-		.int_vref_mv = 4096,
 		.default_config = AD7998_ALERT_EN,
 		.info = &ad7993_4_7_8_info,
 	},
@@ -875,10 +867,10 @@ static int ad799x_probe(struct i2c_client *client,
 
 	/* TODO: Add pdata options for filtering and bit delay */
 
-	if (pdata)
-		st->int_vref_mv = pdata->vref_mv;
-	else
-		st->int_vref_mv = st->chip_info->int_vref_mv;
+	if (!pdata)
+		return -EINVAL;
+
+	st->int_vref_mv = pdata->vref_mv;
 
 	st->reg = regulator_get(&client->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
-- 
1.8.0

