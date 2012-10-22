Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-125.synserver.de ([212.40.185.125]:1650 "EHLO
	smtp-out-125.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072Ab2JVJmg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Oct 2012 05:42:36 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] staging:iio:adt7410: Fix adt7410_set_mode return value
Date: Mon, 22 Oct 2012 11:42:21 +0200
Message-Id: <1350898942-29586-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The function is expected to return the number of bytes consumed and as long as
not all bytes have been consumed the function will be called again. Currently
the function returns 'ret', which will always be 0 in this case, so we end up in
a endless loop since the caller will assume that no bytes have been consumed. So
instead return len as it is supposed to.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/adt7410.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index 4157596..3cf5103 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -190,7 +190,7 @@ static ssize_t adt7410_store_mode(struct device *dev,
 
 	chip->config = config;
 
-	return ret;
+	return len;
 }
 
 static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
-- 
1.7.10.4

