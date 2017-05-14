Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.osadl.org ([62.245.132.105]:45017 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbdENIok (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 May 2017 04:44:40 -0400
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
Subject: [PATCH RFC] iio: pressure: zpa2326: report interrupted case as failure
Date: Sun, 14 May 2017 10:43:55 +0200
Message-Id: <1494751435-14189-1-git-send-email-der.herr@hofr.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the timeout-case prints a warning message then probably the interrupted
case should also. Further, wait_for_completion_interruptible_timeout()
returns long not int. 

Fixes: commit 03b262f2bbf4 ("iio:pressure: initial zpa2326 barometer support")
Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---

The original control-flow was technically not wrong just confusing and a bit 
complicated. Not clear if reporting the interrupted case actually is useful,
but given that the timeout is relatively long (200ms) it is not that unlikely
so differentiating the cases seems helpful.

Patch was compile-tested with: x86_64_defconfig + CONFIG_IIO=m, CONFIG_ZPA2326=m

Patch is against v4.11 (localversion-next is next-20170512)

 drivers/iio/pressure/zpa2326.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index e58a0ad..617926f 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -867,12 +867,13 @@ static int zpa2326_wait_oneshot_completion(const struct iio_dev   *indio_dev,
 {
 	int          ret;
 	unsigned int val;
+	long     timeout;
 
 	zpa2326_dbg(indio_dev, "waiting for one shot completion interrupt");
 
-	ret = wait_for_completion_interruptible_timeout(
+	timeout = wait_for_completion_interruptible_timeout(
 		&private->data_ready, ZPA2326_CONVERSION_JIFFIES);
-	if (ret > 0)
+	if (timeout > 0)
 		/*
 		 * Interrupt handler completed before timeout: return operation
 		 * status.
@@ -882,13 +883,15 @@ static int zpa2326_wait_oneshot_completion(const struct iio_dev   *indio_dev,
 	/* Clear all interrupts just to be sure. */
 	regmap_read(private->regmap, ZPA2326_INT_SOURCE_REG, &val);
 
-	if (!ret)
+	if (!timeout) {
 		/* Timed out. */
+		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%ld)",
+			     timeout);
 		ret = -ETIME;
-
-	if (ret != -ERESTARTSYS)
-		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%d)",
-			     ret);
+	} else if (timeout < 0) {
+		zpa2326_warn(indio_dev, "wait for one shot interrupt canceled");
+		ret = -ERESTARTSYS;
+	}
 
 	return ret;
 }
-- 
2.1.4

