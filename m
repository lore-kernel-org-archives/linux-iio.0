Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1057 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757440Ab3APMsS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:18 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/15] staging:iio:adis16400: Remove unit suffix from samplerate attribute
Date: Wed, 16 Jan 2013 13:48:44 +0100
Message-Id: <1358340531-31350-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

To be compliant to the IIO specification we should not include the "SPS" suffix
in the "samplerate" attribute contents.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index aa4ffcf..9429072 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -116,7 +116,7 @@ static ssize_t adis16400_read_frequency(struct device *dev,
 	ret = st->variant->get_freq(st);
 	if (ret < 0)
 		return ret;
-	len = sprintf(buf, "%d SPS\n", ret);
+	len = sprintf(buf, "%d\n", ret);
 	return len;
 }
 
-- 
1.8.0

