Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-222.synserver.de ([212.40.185.222]:1117 "EHLO
	smtp-out-222.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab2KUQ1U (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Nov 2012 11:27:20 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/11] staging:iio:ad7793: Use usleep_range instead of msleep
Date: Wed, 21 Nov 2012 17:27:08 +0100
Message-Id: <1353515236-21843-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1353515236-21843-1-git-send-email-lars@metafoo.de>
References: <1353515236-21843-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It is recommended to use usleep_range instead of msleep for durations smaller
than a 20ms.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7793.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 965e6ae..1c3d668 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -122,7 +122,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 	ret = spi_write(st->sd.spi, (u8 *)&ret, sizeof(ret));
 	if (ret < 0)
 		goto out;
-	msleep(1); /* Wait for at least 500us */
+	usleep_range(500, 2000); /* Wait for at least 500us */
 
 	/* write/read test for device presence */
 	ret = ad_sd_read_reg(&st->sd, AD7793_REG_ID, 1, &id);
-- 
1.8.0

