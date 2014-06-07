Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43281 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbaFGPbt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:31:49 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 10/13] iio:adc:ad799x: Write default config on probe and reset alert status on probe
Date: Sat,  7 Jun 2014 17:31:34 +0200
Message-Id: <1402155097-435-11-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

writing ALERT_EN and BUSY_ALERT to the chip config register clears
pending alerts, BUSY_ALERT is cleared when reading back the register

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad799x.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 4e7f6b3..a5d1a0a 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -596,7 +596,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				AD799X_CHANNEL_WITH_EVENTS(1, 12),
 				IIO_CHAN_SOFT_TIMESTAMP(3),
 			},
-			.default_config = AD7998_ALERT_EN,
+			.default_config = AD7998_ALERT_EN | AD7998_BUSY_ALERT,
 			.info = &ad7993_4_7_8_irq_info,
 		},
 	},
@@ -620,7 +620,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				AD799X_CHANNEL_WITH_EVENTS(3, 10),
 				IIO_CHAN_SOFT_TIMESTAMP(4),
 			},
-			.default_config = AD7998_ALERT_EN,
+			.default_config = AD7998_ALERT_EN | AD7998_BUSY_ALERT,
 			.info = &ad7993_4_7_8_irq_info,
 		},
 	},
@@ -644,7 +644,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				AD799X_CHANNEL_WITH_EVENTS(3, 12),
 				IIO_CHAN_SOFT_TIMESTAMP(4),
 			},
-			.default_config = AD7998_ALERT_EN,
+			.default_config = AD7998_ALERT_EN | AD7998_BUSY_ALERT,
 			.info = &ad7993_4_7_8_irq_info,
 		},
 	},
@@ -676,7 +676,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				AD799X_CHANNEL(7, 10),
 				IIO_CHAN_SOFT_TIMESTAMP(8),
 			},
-			.default_config = AD7998_ALERT_EN,
+			.default_config = AD7998_ALERT_EN | AD7998_BUSY_ALERT,
 			.info = &ad7993_4_7_8_irq_info,
 		},
 	},
@@ -708,7 +708,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 				AD799X_CHANNEL(7, 12),
 				IIO_CHAN_SOFT_TIMESTAMP(8),
 			},
-			.default_config = AD7998_ALERT_EN,
+			.default_config = AD7998_ALERT_EN | AD7998_BUSY_ALERT,
 			.info = &ad7993_4_7_8_irq_info,
 		},
 	},
@@ -736,7 +736,6 @@ static int ad799x_probe(struct i2c_client *client,
 		st->chip_config = &chip_info->irq_config;
 	else
 		st->chip_config = &chip_info->noirq_config;
-	st->config = st->chip_config->default_config;
 
 	/* TODO: Add pdata options for filtering and bit delay */
 
@@ -765,6 +764,14 @@ static int ad799x_probe(struct i2c_client *client,
 	indio_dev->channels = st->chip_config->channel;
 	indio_dev->num_channels = chip_info->num_channels;
 
+	ret = ad799x_write_config(st, st->chip_config->default_config);
+	if (ret < 0)
+		goto error_disable_reg;
+	ret = ad799x_read_config(st);
+	if (ret < 0)
+		goto error_disable_reg;
+	st->config = ret;
+
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		&ad799x_trigger_handler, NULL);
 	if (ret)
-- 
1.9.1

