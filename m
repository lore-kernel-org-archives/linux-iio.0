Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58637 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933860AbaFCWm0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Jun 2014 18:42:26 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 07/15] iio:adc:ad799x: Only expose event interface when IRQ is available
Date: Wed,  4 Jun 2014 00:42:07 +0200
Message-Id: <1401835335-29969-8-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

an IRQ is necessary to handle the ALERT condition; without
IRQ, the IIO event interface serves no purpose

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad799x.c | 263 +++++++++++++++++++++++++++++++----------------
 1 file changed, 177 insertions(+), 86 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 572c32a..eb49ac1 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -101,22 +101,32 @@ enum {
 };
 
 /**
- * struct ad799x_chip_info - chip specific information
+ * struct ad799x_chip_config - chip specific information
  * @channel:		channel specification
- * @num_channels:	number of channels
  * @default_config:	device default configuration
  * @info:		pointer to iio_info struct
  */
-struct ad799x_chip_info {
+struct ad799x_chip_config {
 	struct iio_chan_spec		channel[9];
-	int				num_channels;
 	u16				default_config;
 	const struct iio_info		*info;
 };
 
+/**
+ * struct ad799x_chip_info - chip specific information
+ * @num_channels:	number of channels
+ * @noirq_config:	device configuration w/o IRQ
+ * @irq_config:		device configuration w/IRQ
+ */
+struct ad799x_chip_info {
+	int				num_channels;
+	const struct ad799x_chip_config	noirq_config;
+	const struct ad799x_chip_config	irq_config;
+};
+
 struct ad799x_state {
 	struct i2c_client		*client;
-	const struct ad799x_chip_info	*chip_info;
+	const struct ad799x_chip_config	*chip_config;
 	struct regulator		*reg;
 	struct regulator		*vref;
 	unsigned			id;
@@ -441,7 +451,13 @@ static const struct iio_info ad7991_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static const struct iio_info ad7993_4_7_8_info = {
+static const struct iio_info ad7993_4_7_8_noirq_info = {
+	.read_raw = &ad799x_read_raw,
+	.driver_module = THIS_MODULE,
+	.update_scan_mode = ad7997_8_update_scan_mode,
+};
+
+static const struct iio_info ad7993_4_7_8_irq_info = {
 	.read_raw = &ad799x_read_raw,
 	.event_attrs = &ad799x_event_attrs_group,
 	.read_event_config = &ad799x_read_event_config,
@@ -496,103 +512,175 @@ static const struct iio_event_spec ad799x_events[] = {
 
 static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	[ad7991] = {
-		.channel = {
-			AD799X_CHANNEL(0, 12),
-			AD799X_CHANNEL(1, 12),
-			AD799X_CHANNEL(2, 12),
-			AD799X_CHANNEL(3, 12),
-			IIO_CHAN_SOFT_TIMESTAMP(4),
-		},
 		.num_channels = 5,
-		.info = &ad7991_info,
+		.noirq_config = {
+			.channel = {
+				AD799X_CHANNEL(0, 12),
+				AD799X_CHANNEL(1, 12),
+				AD799X_CHANNEL(2, 12),
+				AD799X_CHANNEL(3, 12),
+				IIO_CHAN_SOFT_TIMESTAMP(4),
+			},
+			.info = &ad7991_info,
+		},
 	},
 	[ad7995] = {
-		.channel = {
-			AD799X_CHANNEL(0, 10),
-			AD799X_CHANNEL(1, 10),
-			AD799X_CHANNEL(2, 10),
-			AD799X_CHANNEL(3, 10),
-			IIO_CHAN_SOFT_TIMESTAMP(4),
-		},
 		.num_channels = 5,
-		.info = &ad7991_info,
+		.noirq_config = {
+			.channel = {
+				AD799X_CHANNEL(0, 10),
+				AD799X_CHANNEL(1, 10),
+				AD799X_CHANNEL(2, 10),
+				AD799X_CHANNEL(3, 10),
+				IIO_CHAN_SOFT_TIMESTAMP(4),
+			},
+			.info = &ad7991_info,
+		},
 	},
 	[ad7999] = {
-		.channel = {
-			AD799X_CHANNEL(0, 8),
-			AD799X_CHANNEL(1, 8),
-			AD799X_CHANNEL(2, 8),
-			AD799X_CHANNEL(3, 8),
-			IIO_CHAN_SOFT_TIMESTAMP(4),
-		},
 		.num_channels = 5,
-		.info = &ad7991_info,
+		.noirq_config = {
+			.channel = {
+				AD799X_CHANNEL(0, 8),
+				AD799X_CHANNEL(1, 8),
+				AD799X_CHANNEL(2, 8),
+				AD799X_CHANNEL(3, 8),
+				IIO_CHAN_SOFT_TIMESTAMP(4),
+			},
+			.info = &ad7991_info,
+		},
 	},
 	[ad7992] = {
-		.channel = {
-			AD799X_CHANNEL_WITH_EVENTS(0, 12),
-			AD799X_CHANNEL_WITH_EVENTS(1, 12),
-			IIO_CHAN_SOFT_TIMESTAMP(3),
-		},
 		.num_channels = 3,
-		.default_config = AD7998_ALERT_EN,
-		.info = &ad7993_4_7_8_info,
+		.noirq_config = {
+			.channel = {
+				AD799X_CHANNEL(0, 12),
+				AD799X_CHANNEL(1, 12),
+				IIO_CHAN_SOFT_TIMESTAMP(3),
+			},
+			.info = &ad7993_4_7_8_noirq_info,
+		},
+		.irq_config = {
+			.channel = {
+				AD799X_CHANNEL_WITH_EVENTS(0, 12),
+				AD799X_CHANNEL_WITH_EVENTS(1, 12),
+				IIO_CHAN_SOFT_TIMESTAMP(3),
+			},
+			.default_config = AD7998_ALERT_EN,
+			.info = &ad7993_4_7_8_irq_info,
+		},
 	},
 	[ad7993] = {
-		.channel = {
-			AD799X_CHANNEL_WITH_EVENTS(0, 10),
-			AD799X_CHANNEL_WITH_EVENTS(1, 10),
-			AD799X_CHANNEL_WITH_EVENTS(2, 10),
-			AD799X_CHANNEL_WITH_EVENTS(3, 10),
-			IIO_CHAN_SOFT_TIMESTAMP(4),
-		},
 		.num_channels = 5,
-		.default_config = AD7998_ALERT_EN,
-		.info = &ad7993_4_7_8_info,
+		.noirq_config = {
+			.channel = {
+				AD799X_CHANNEL(0, 10),
+				AD799X_CHANNEL(1, 10),
+				AD799X_CHANNEL(2, 10),
+				AD799X_CHANNEL(3, 10),
+				IIO_CHAN_SOFT_TIMESTAMP(4),
+			},
+			.info = &ad7993_4_7_8_noirq_info,
+		},
+		.irq_config = {
+			.channel = {
+				AD799X_CHANNEL_WITH_EVENTS(0, 10),
+				AD799X_CHANNEL_WITH_EVENTS(1, 10),
+				AD799X_CHANNEL_WITH_EVENTS(2, 10),
+				AD799X_CHANNEL_WITH_EVENTS(3, 10),
+				IIO_CHAN_SOFT_TIMESTAMP(4),
+			},
+			.default_config = AD7998_ALERT_EN,
+			.info = &ad7993_4_7_8_irq_info,
+		},
 	},
 	[ad7994] = {
-		.channel = {
-			AD799X_CHANNEL_WITH_EVENTS(0, 12),
-			AD799X_CHANNEL_WITH_EVENTS(1, 12),
-			AD799X_CHANNEL_WITH_EVENTS(2, 12),
-			AD799X_CHANNEL_WITH_EVENTS(3, 12),
-			IIO_CHAN_SOFT_TIMESTAMP(4),
-		},
 		.num_channels = 5,
-		.default_config = AD7998_ALERT_EN,
-		.info = &ad7993_4_7_8_info,
+		.noirq_config = {
+			.channel = {
+				AD799X_CHANNEL(0, 12),
+				AD799X_CHANNEL(1, 12),
+				AD799X_CHANNEL(2, 12),
+				AD799X_CHANNEL(3, 12),
+				IIO_CHAN_SOFT_TIMESTAMP(4),
+			},
+			.info = &ad7993_4_7_8_noirq_info,
+		},
+		.irq_config = {
+			.channel = {
+				AD799X_CHANNEL_WITH_EVENTS(0, 12),
+				AD799X_CHANNEL_WITH_EVENTS(1, 12),
+				AD799X_CHANNEL_WITH_EVENTS(2, 12),
+				AD799X_CHANNEL_WITH_EVENTS(3, 12),
+				IIO_CHAN_SOFT_TIMESTAMP(4),
+			},
+			.default_config = AD7998_ALERT_EN,
+			.info = &ad7993_4_7_8_irq_info,
+		},
 	},
 	[ad7997] = {
-		.channel = {
-			AD799X_CHANNEL_WITH_EVENTS(0, 10),
-			AD799X_CHANNEL_WITH_EVENTS(1, 10),
-			AD799X_CHANNEL_WITH_EVENTS(2, 10),
-			AD799X_CHANNEL_WITH_EVENTS(3, 10),
-			AD799X_CHANNEL(4, 10),
-			AD799X_CHANNEL(5, 10),
-			AD799X_CHANNEL(6, 10),
-			AD799X_CHANNEL(7, 10),
-			IIO_CHAN_SOFT_TIMESTAMP(8),
-		},
 		.num_channels = 9,
-		.default_config = AD7998_ALERT_EN,
-		.info = &ad7993_4_7_8_info,
+		.noirq_config = {
+			.channel = {
+				AD799X_CHANNEL(0, 10),
+				AD799X_CHANNEL(1, 10),
+				AD799X_CHANNEL(2, 10),
+				AD799X_CHANNEL(3, 10),
+				AD799X_CHANNEL(4, 10),
+				AD799X_CHANNEL(5, 10),
+				AD799X_CHANNEL(6, 10),
+				AD799X_CHANNEL(7, 10),
+				IIO_CHAN_SOFT_TIMESTAMP(8),
+			},
+			.info = &ad7993_4_7_8_noirq_info,
+		},
+		.irq_config = {
+			.channel = {
+				AD799X_CHANNEL_WITH_EVENTS(0, 10),
+				AD799X_CHANNEL_WITH_EVENTS(1, 10),
+				AD799X_CHANNEL_WITH_EVENTS(2, 10),
+				AD799X_CHANNEL_WITH_EVENTS(3, 10),
+				AD799X_CHANNEL(4, 10),
+				AD799X_CHANNEL(5, 10),
+				AD799X_CHANNEL(6, 10),
+				AD799X_CHANNEL(7, 10),
+				IIO_CHAN_SOFT_TIMESTAMP(8),
+			},
+			.default_config = AD7998_ALERT_EN,
+			.info = &ad7993_4_7_8_irq_info,
+		},
 	},
 	[ad7998] = {
-		.channel = {
-			AD799X_CHANNEL_WITH_EVENTS(0, 12),
-			AD799X_CHANNEL_WITH_EVENTS(1, 12),
-			AD799X_CHANNEL_WITH_EVENTS(2, 12),
-			AD799X_CHANNEL_WITH_EVENTS(3, 12),
-			AD799X_CHANNEL(4, 12),
-			AD799X_CHANNEL(5, 12),
-			AD799X_CHANNEL(6, 12),
-			AD799X_CHANNEL(7, 12),
-			IIO_CHAN_SOFT_TIMESTAMP(8),
-		},
 		.num_channels = 9,
-		.default_config = AD7998_ALERT_EN,
-		.info = &ad7993_4_7_8_info,
+		.noirq_config = {
+			.channel = {
+				AD799X_CHANNEL(0, 12),
+				AD799X_CHANNEL(1, 12),
+				AD799X_CHANNEL(2, 12),
+				AD799X_CHANNEL(3, 12),
+				AD799X_CHANNEL(4, 12),
+				AD799X_CHANNEL(5, 12),
+				AD799X_CHANNEL(6, 12),
+				AD799X_CHANNEL(7, 12),
+				IIO_CHAN_SOFT_TIMESTAMP(8),
+			},
+			.info = &ad7993_4_7_8_noirq_info,
+		},
+		.irq_config = {
+			.channel = {
+				AD799X_CHANNEL_WITH_EVENTS(0, 12),
+				AD799X_CHANNEL_WITH_EVENTS(1, 12),
+				AD799X_CHANNEL_WITH_EVENTS(2, 12),
+				AD799X_CHANNEL_WITH_EVENTS(3, 12),
+				AD799X_CHANNEL(4, 12),
+				AD799X_CHANNEL(5, 12),
+				AD799X_CHANNEL(6, 12),
+				AD799X_CHANNEL(7, 12),
+				IIO_CHAN_SOFT_TIMESTAMP(8),
+			},
+			.default_config = AD7998_ALERT_EN,
+			.info = &ad7993_4_7_8_irq_info,
+		},
 	},
 };
 
@@ -602,6 +690,8 @@ static int ad799x_probe(struct i2c_client *client,
 	int ret;
 	struct ad799x_state *st;
 	struct iio_dev *indio_dev;
+	const struct ad799x_chip_info *chip_info =
+		&ad799x_chip_info_tbl[id->driver_data];
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
 	if (indio_dev == NULL)
@@ -612,8 +702,9 @@ static int ad799x_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 
 	st->id = id->driver_data;
-	st->chip_info = &ad799x_chip_info_tbl[st->id];
-	st->config = st->chip_info->default_config;
+	st->chip_config = (client->irq > 0 && chip_info->irq_config.info) ?
+		&chip_info->irq_config : &chip_info->noirq_config;
+	st->config = st->chip_config->default_config;
 
 	/* TODO: Add pdata options for filtering and bit delay */
 
@@ -636,11 +727,11 @@ static int ad799x_probe(struct i2c_client *client,
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = id->name;
-	indio_dev->info = st->chip_info->info;
+	indio_dev->info = st->chip_config->info;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channel;
-	indio_dev->num_channels = st->chip_info->num_channels;
+	indio_dev->channels = st->chip_config->channel;
+	indio_dev->num_channels = chip_info->num_channels;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		&ad799x_trigger_handler, NULL);
-- 
1.9.1

