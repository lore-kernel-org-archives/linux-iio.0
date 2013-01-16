Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1088 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587Ab3APMsI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:08 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/15] staging:iio:adis16400: Don't pass 0 to ilog2
Date: Wed, 16 Jan 2013 13:48:37 +0100
Message-Id: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ilog2 is not defined for 0, so we need to handle the case where the requested
frequency is larger than the base sampling rate. In this case we'll round down
and set the sampling rate to the base sampling rate.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 9c8f5ab..cb66225 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -178,7 +178,11 @@ static int adis16334_set_freq(struct iio_dev *indio_dev, unsigned int freq)
 {
 	unsigned int t;
 
-	t = ilog2(8192 / (freq * 10));
+	freq *= 10;
+	if (freq < 8192)
+		t = ilog2(8192 / freq);
+	else
+		t = 0;
 
 	if (t > 0x31)
 		t = 0x31;
-- 
1.8.0

