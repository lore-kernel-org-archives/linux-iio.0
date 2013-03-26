Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-011.synserver.de ([212.40.185.11]:1050 "EHLO
	smtp-out-226.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932374Ab3CZSlJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Mar 2013 14:41:09 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/6] staging:iio:ad799x: Add helper macro for channel initialization
Date: Tue, 26 Mar 2013 19:43:02 +0100
Message-Id: <1364323384-30863-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1364323384-30863-1-git-send-email-lars@metafoo.de>
References: <1364323384-30863-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad779x channels all follow the same pattern. Add a helper macro to
initialize the channel spec, this allows us to drop quite a few lines.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad799x_core.c | 386 +++++-----------------------------
 1 file changed, 56 insertions(+), 330 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 8d2012c..49972e1 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -460,145 +460,55 @@ static const struct iio_info ad7993_4_7_8_info = {
 #define AD799X_EV_MASK (IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) | \
 			IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
 
+#define AD799X_CHANNEL(_index, _realbits, _evmask) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.channel = (_index), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.scan_index = (_index), \
+	.scan_type = IIO_ST('u', _realbits, 16, 12 - (_realbits)), \
+	.event_mask = (_evmask), \
+}
+
 static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	[ad7991] = {
 		.channel = {
-			[0] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 0,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 0,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-			},
-			[1] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 1,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 1,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-			},
-			[2] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 2,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 2,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-			},
-			[3] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 3,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 3,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-			},
-			[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
+			AD799X_CHANNEL(0, 12, 0),
+			AD799X_CHANNEL(1, 12, 0),
+			AD799X_CHANNEL(2, 12, 0),
+			AD799X_CHANNEL(3, 12, 0),
+			IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
 		.info = &ad7991_info,
 	},
 	[ad7995] = {
 		.channel = {
-			[0] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 0,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 0,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-			},
-			[1] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 1,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 1,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-			},
-			[2] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 2,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 2,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-			},
-			[3] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 3,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 3,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-			},
-			[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
+			AD799X_CHANNEL(0, 10, 0),
+			AD799X_CHANNEL(1, 10, 0),
+			AD799X_CHANNEL(2, 10, 0),
+			AD799X_CHANNEL(3, 10, 0),
+			IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
 		.info = &ad7991_info,
 	},
 	[ad7999] = {
 		.channel = {
-			[0] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 0,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 0,
-				.scan_type = IIO_ST('u', 8, 16, 4),
-			},
-			[1] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 1,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 1,
-				.scan_type = IIO_ST('u', 8, 16, 4),
-			},
-			[2] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 2,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 2,
-				.scan_type = IIO_ST('u', 8, 16, 4),
-			},
-			[3] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 3,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 3,
-				.scan_type = IIO_ST('u', 8, 16, 4),
-			},
-			[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
+			AD799X_CHANNEL(0, 8, 0),
+			AD799X_CHANNEL(1, 8, 0),
+			AD799X_CHANNEL(2, 8, 0),
+			AD799X_CHANNEL(3, 8, 0),
+			IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
 		.info = &ad7991_info,
 	},
 	[ad7992] = {
 		.channel = {
-			[0] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 0,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 0,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[1] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 1,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 1,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
+			AD799X_CHANNEL(0, 12, AD799X_EV_MASK),
+			AD799X_CHANNEL(1, 12, AD799X_EV_MASK),
+			IIO_CHAN_SOFT_TIMESTAMP(3),
 		},
 		.num_channels = 3,
 		.default_config = AD7998_ALERT_EN,
@@ -606,43 +516,11 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7993] = {
 		.channel = {
-			[0] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 0,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 0,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[1] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 1,
-				.scan_index = 1,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_type = IIO_ST('u', 10, 16, 2),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[2] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 2,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 2,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[3] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 3,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 3,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
+			AD799X_CHANNEL(0, 10, AD799X_EV_MASK),
+			AD799X_CHANNEL(1, 10, AD799X_EV_MASK),
+			AD799X_CHANNEL(2, 10, AD799X_EV_MASK),
+			AD799X_CHANNEL(3, 10, AD799X_EV_MASK),
+			IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
 		.default_config = AD7998_ALERT_EN,
@@ -650,43 +528,11 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7994] = {
 		.channel = {
-			[0] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 0,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 0,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[1] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 1,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 1,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[2] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 2,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 2,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[3] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 3,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 3,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
+			AD799X_CHANNEL(0, 12, AD799X_EV_MASK),
+			AD799X_CHANNEL(1, 12, AD799X_EV_MASK),
+			AD799X_CHANNEL(2, 12, AD799X_EV_MASK),
+			AD799X_CHANNEL(3, 12, AD799X_EV_MASK),
+			IIO_CHAN_SOFT_TIMESTAMP(4),
 		},
 		.num_channels = 5,
 		.default_config = AD7998_ALERT_EN,
@@ -694,75 +540,15 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7997] = {
 		.channel = {
-			[0] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 0,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 0,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[1] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 1,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 1,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[2] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 2,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 2,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[3] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 3,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 3,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[4] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 4,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 4,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-			},
-			[5] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 5,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 5,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-			},
-			[6] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 6,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 6,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-			},
-			[7] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 7,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 7,
-				.scan_type = IIO_ST('u', 10, 16, 2),
-			},
-			[8] = IIO_CHAN_SOFT_TIMESTAMP(8),
+			AD799X_CHANNEL(0, 10, AD799X_EV_MASK),
+			AD799X_CHANNEL(1, 10, AD799X_EV_MASK),
+			AD799X_CHANNEL(2, 10, AD799X_EV_MASK),
+			AD799X_CHANNEL(3, 10, AD799X_EV_MASK),
+			AD799X_CHANNEL(4, 10, 0),
+			AD799X_CHANNEL(5, 10, 0),
+			AD799X_CHANNEL(6, 10, 0),
+			AD799X_CHANNEL(7, 10, 0),
+			IIO_CHAN_SOFT_TIMESTAMP(8),
 		},
 		.num_channels = 9,
 		.default_config = AD7998_ALERT_EN,
@@ -770,75 +556,15 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 	[ad7998] = {
 		.channel = {
-			[0] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 0,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 0,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[1] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 1,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 1,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[2] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 2,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 2,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[3] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 3,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 3,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-				.event_mask = AD799X_EV_MASK,
-			},
-			[4] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 4,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 4,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-			},
-			[5] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 5,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 5,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-			},
-			[6] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 6,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 6,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-			},
-			[7] = {
-				.type = IIO_VOLTAGE,
-				.indexed = 1,
-				.channel = 7,
-				.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-				.scan_index = 7,
-				.scan_type = IIO_ST('u', 12, 16, 0),
-			},
-			[8] = IIO_CHAN_SOFT_TIMESTAMP(8),
+			AD799X_CHANNEL(0, 12, AD799X_EV_MASK),
+			AD799X_CHANNEL(1, 12, AD799X_EV_MASK),
+			AD799X_CHANNEL(2, 12, AD799X_EV_MASK),
+			AD799X_CHANNEL(3, 12, AD799X_EV_MASK),
+			AD799X_CHANNEL(4, 12, 0),
+			AD799X_CHANNEL(5, 12, 0),
+			AD799X_CHANNEL(6, 12, 0),
+			AD799X_CHANNEL(7, 12, 0),
+			IIO_CHAN_SOFT_TIMESTAMP(8),
 		},
 		.num_channels = 9,
 		.default_config = AD7998_ALERT_EN,
-- 
1.8.0

