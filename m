Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:59999 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757147AbcJSRHU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 13:07:20 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/13] staging:iio:ad7606: Remove out-of-band error reporting
Date: Wed, 19 Oct 2016 19:06:59 +0200
Message-Id: <1476896828-10544-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1476896828-10544-1-git-send-email-lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently the ad7606 driver prints a error message to the kernel log when
an application writes an invalid value to a sysfs attribute. While for
initial driver development and testing this might be useful it is quite
disadvantageous in a production environment. The write() call to the sysfs
attribute will already return an error if the value was invalid so the
application is aware that the operation failed. And generally speaking it
is impossible for an application to reliably match a log message in the
kernel log to a specific operation it performed, so the message becomes
just noise and might distract from more critical messages.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606_core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index a16c6f5..d3a3551 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -132,10 +132,9 @@ static ssize_t ad7606_store_range(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (!(lval == 5000 || lval == 10000)) {
-		dev_err(dev, "range is not supported\n");
+	if (!(lval == 5000 || lval == 10000))
 		return -EINVAL;
-	}
+
 	mutex_lock(&indio_dev->mlock);
 	gpio_set_value(st->pdata->gpio_range, lval == 10000);
 	st->range = lval;
@@ -174,11 +173,8 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		if (val2)
 			return -EINVAL;
 		ret = ad7606_oversampling_get_index(val);
-		if (ret < 0) {
-			dev_err(st->dev, "oversampling %d is not supported\n",
-				val);
+		if (ret < 0)
 			return ret;
-		}
 
 		mutex_lock(&indio_dev->mlock);
 		gpio_set_value(st->pdata->gpio_os0, (ret >> 0) & 1);
-- 
2.1.4

