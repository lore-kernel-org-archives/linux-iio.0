Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.osadl.org ([62.245.132.105]:49429 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751264AbdECLxg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 May 2017 07:53:36 -0400
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        simran singhal <singhalsimran0@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <der.herr@hofr.at>
Subject: [BUG RFC] iio: pressure: zpa2326: incorrect condition or inconsistent return handling
Date: Wed,  3 May 2017 12:53:50 +0200
Message-Id: <1493808830-25837-1-git-send-email-der.herr@hofr.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

wait_for_completion_interruptible_timeout() returns -ERESTARTSYS, 0 or
remaining time in jiffies (atleast 1), thus the if (ret != -ERESTARTSYS)
case here is unreachable. 

As it is not clear from the warn message if this should simply be changed
to if (ret == -ERESTARTSYS), this needs a review by someone that knows
the intent of this condition. In any case the current treatment of the
return value of wait_for_completion_interruptible_timeout() is inconsistent
with the specification of the same.

Also wait_for_completion_interruptible_timeout() returns a long not int.

Problem was introduced in commit 03b262f2bbf4 ("iio:pressure: initial zpa2326 barometer support")

 drivers/iio/pressure/zpa2326.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index e58a0ad..80ca6ec 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -872,35 +872,35 @@ static int zpa2326_wait_oneshot_completion(const struct iio_dev   *indio_dev,
 
 	ret = wait_for_completion_interruptible_timeout(
 		&private->data_ready, ZPA2326_CONVERSION_JIFFIES);
 	if (ret > 0)
 		/*
 		 * Interrupt handler completed before timeout: return operation
 		 * status.
 		 */
 		return private->result;
 
 	/* Clear all interrupts just to be sure. */
 	regmap_read(private->regmap, ZPA2326_INT_SOURCE_REG, &val);
 
 	if (!ret)
 		/* Timed out. */
 		ret = -ETIME;
 
-	if (ret != -ERESTARTSYS)
+	if (ret == -ERESTARTSYS)
 		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%d)",
 			     ret);
 
 	return ret;
 }
 
 static int zpa2326_init_managed_irq(struct device          *parent,
 				    struct iio_dev         *indio_dev,
 				    struct zpa2326_private *private,
 				    int                     irq)
 {
 	int err;
 
 	private->irq = irq;
 
 	if (irq <= 0) {
 		/*
-- 
2.1.4

