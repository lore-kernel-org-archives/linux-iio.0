Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1033 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab3GQOoJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 10:44:09 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/15] staging:iio:adis16260: Remove 'SPS' suffix from samplerate attribute
Date: Wed, 17 Jul 2013 16:44:34 +0200
Message-Id: <1374072279-7140-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-1-git-send-email-lars@metafoo.de>
References: <1374072279-7140-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is not part of the ABI.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 4b62000..a140d73 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -135,7 +135,7 @@ static ssize_t adis16260_read_frequency(struct device *dev,
 	else
 		sps = (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 66 : 2048;
 	sps /= (t & ADIS16260_SMPL_PRD_DIV_MASK) + 1;
-	len = sprintf(buf, "%d SPS\n", sps);
+	len = sprintf(buf, "%d\n", sps);
 	return len;
 }
 
-- 
1.8.0

