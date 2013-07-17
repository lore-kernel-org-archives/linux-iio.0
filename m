Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1063 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738Ab3GQOoI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 10:44:08 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/15] staging:iio:adis16260: Fix minor style issue
Date: Wed, 17 Jul 2013 16:44:33 +0200
Message-Id: <1374072279-7140-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-1-git-send-email-lars@metafoo.de>
References: <1374072279-7140-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Delete some extra whitespace.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index c70094f..4b62000 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -131,9 +131,9 @@ static ssize_t adis16260_read_frequency(struct device *dev,
 		return ret;
 
 	if (spi_get_device_id(adis->spi)->driver_data) /* If an adis16251 */
-		sps =  (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 8 : 256;
+		sps = (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 8 : 256;
 	else
-		sps =  (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 66 : 2048;
+		sps = (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 66 : 2048;
 	sps /= (t & ADIS16260_SMPL_PRD_DIV_MASK) + 1;
 	len = sprintf(buf, "%d SPS\n", sps);
 	return len;
-- 
1.8.0

