Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:44605 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934374Ab2JXHNW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Oct 2012 03:13:22 -0400
Date: Wed, 24 Oct 2012 10:13:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [patch] iio:dac:ad5449: unlock on error path
Message-ID: <20121024071307.GC2536@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is an unlock missing on this error path.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Only needed in linux-next.

diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index 5b43030..0ee6f8e 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -124,12 +124,13 @@ static int ad5449_read(struct iio_dev *indio_dev, unsigned int addr,
 
 	ret = spi_sync(st->spi, &msg);
 	if (ret < 0)
-		return ret;
+		goto out_unlock;
 
 	*val = be16_to_cpu(st->data[1]);
-	mutex_unlock(&indio_dev->mlock);
 
-	return 0;
+out_unlock:
+	mutex_unlock(&indio_dev->mlock);
+	return ret;
 }
 
 static int ad5449_read_raw(struct iio_dev *indio_dev,
