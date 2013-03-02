Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35722 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab3CBQRp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:45 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 55/67] staging:iio:gyro:adis16060 move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:17:12 +0000
Message-Id: <1362241044-3534-56-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Michael Hennerich <michael.hennerich@analog.com>
cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16060_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 687c151..c67d3a8 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -120,27 +120,26 @@ static const struct iio_chan_spec adis16060_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.address = ADIS16060_GYRO,
 	}, {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.address = ADIS16060_AIN1,
 	}, {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.address = ADIS16060_AIN2,
 	}, {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE),
 		.address = ADIS16060_TEMP_OUT,
 	}
 };
-- 
1.8.1.4

