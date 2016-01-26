Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21354 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965442AbcAZQzF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 26 Jan 2016 11:55:05 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de,
	ludovic.tancerel@maplehightech.com, tduszyns@gmail.com,
	akinobu.mita@gmail.com, daniel.baluta@intel.com,
	k.kozlowski@samsung.com, afd@ti.com, broonie@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lucas.demarchi@intel.com
Subject: [PATCH v2 1/2] iio: pressure: ms5611: Add IIO_CHAN_INFO_SCALE to mask
Date: Tue, 26 Jan 2016 18:57:20 +0200
Message-Id: <1453827441-25611-2-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1453827441-25611-1-git-send-email-daniel.baluta@intel.com>
References: <1453827441-25611-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This allows data exported via buffer interface to be converted
to standard units in userspace.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/pressure/ms5611_core.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 2f3d9b4..6cf0e55 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -201,6 +201,18 @@ static int ms5611_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_TEMP:
+			*val = 10;
+			return IIO_VAL_INT;
+		case IIO_PRESSURE:
+			*val = 0;
+			*val2 = 1000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
 	}
 
 	return -EINVAL;
@@ -218,11 +230,13 @@ static struct ms5611_chip_info chip_info_tbl[] = {
 static const struct iio_chan_spec ms5611_channels[] = {
 	{
 		.type = IIO_PRESSURE,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+			BIT(IIO_CHAN_INFO_SCALE),
 	},
 	{
 		.type = IIO_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+			BIT(IIO_CHAN_INFO_SCALE),
 	}
 };
 
-- 
2.5.0

