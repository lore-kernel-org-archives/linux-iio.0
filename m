Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-233.synserver.de ([212.40.185.233]:1093 "EHLO
	smtp-out-233.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760581Ab2IGMoK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Sep 2012 08:44:10 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/10] staging:iio:ad7476: Use be16_to_cpup instead of open-coding it
Date: Fri,  7 Sep 2012 14:44:28 +0200
Message-Id: <1347021872-7885-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1347021872-7885-1-git-send-email-lars@metafoo.de>
References: <1347021872-7885-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7476.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7476.c b/drivers/staging/iio/adc/ad7476.c
index 13aed0e..845bd28 100644
--- a/drivers/staging/iio/adc/ad7476.c
+++ b/drivers/staging/iio/adc/ad7476.c
@@ -109,7 +109,7 @@ static int ad7476_scan_direct(struct ad7476_state *st)
 	if (ret)
 		return ret;
 
-	return (st->data[0] << 8) | st->data[1];
+	return be16_to_cpup((__be16 *)st->data);
 }
 
 static int ad7476_read_raw(struct iio_dev *indio_dev,
-- 
1.7.10.4

