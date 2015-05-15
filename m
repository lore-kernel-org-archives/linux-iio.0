Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-168.synserver.de ([212.40.185.168]:1046 "EHLO
	smtp-out-168.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932529AbbEOPSn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 May 2015 11:18:43 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] iio: adis16400: Report pressure channel scale
Date: Fri, 15 May 2015 17:18:34 +0200
Message-Id: <1431703118-32676-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1431703118-32676-1-git-send-email-lars@metafoo.de>
References: <1431703118-32676-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add the scale for the pressure channel, which is currently missing.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Fixes: 76ada52f7f5d ("iio:adis16400: Add support for the adis16448")
---
 drivers/iio/imu/adis16400_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index fa795dc..8de6427 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -405,6 +405,11 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 			*val = st->variant->temp_scale_nano / 1000000;
 			*val2 = (st->variant->temp_scale_nano % 1000000);
 			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_PRESSURE:
+			/* 20 uBar = 0.002kPascal */
+			*val = 0;
+			*val2 = 2000;
+			return IIO_VAL_INT_PLUS_MICRO;
 		default:
 			return -EINVAL;
 		}
-- 
1.8.0

