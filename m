Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-100.synserver.de ([212.40.185.100]:1092 "EHLO
	smtp-out-100.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab2JOJek (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Oct 2012 05:34:40 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 11/11] staging:iio:adis16400: Fixup adis16336 temp channel attributes
Date: Mon, 15 Oct 2012 11:35:34 +0200
Message-Id: <1350293734-21951-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1350293734-21951-1-git-send-email-lars@metafoo.de>
References: <1350293734-21951-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The temperature channel has a calibbias attribute which it should not have, but
the offset attribute is missing.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index eaed87f..3144a7b 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1037,7 +1037,7 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = temp0,
 		.scan_index = ADIS16400_SCAN_TEMP,
-- 
1.7.10.4

