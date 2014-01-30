Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:38755 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaA3L7U (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jan 2014 06:59:20 -0500
Date: Thu, 30 Jan 2014 14:59:14 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] iio:imu:adis16400 remove an unneeded check
Message-ID: <20140130115914.GJ12734@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We know "ret" is zero here so there is no need to check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index 368660dfe135..411586f49dae 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -281,7 +281,7 @@ static ssize_t adis16400_write_frequency(struct device *dev,
 	st->variant->set_freq(st, val);
 	mutex_unlock(&indio_dev->mlock);
 
-	return ret ? ret : len;
+	return len;
 }
 
 /* Power down the device */
