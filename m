Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48681 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218Ab2FOR1L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 15 Jun 2012 13:27:11 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio staging: fix typos in simple dummy driver
Date: Fri, 15 Jun 2012 19:27:10 +0200
Message-Id: <1339781230-2783-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 drivers/staging/iio/iio_simple_dummy.c        |   10 +++++-----
 drivers/staging/iio/iio_simple_dummy_buffer.c |    4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 3104119..155a49a 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -27,7 +27,7 @@
 
 /*
  * A few elements needed to fake a bus for this driver
- * Note instances parmeter controls how many of these
+ * Note instances parameter controls how many of these
  * dummy devices are registered.
  */
 static unsigned instances = 1;
@@ -178,7 +178,7 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		.scan_index = accelx,
 		.scan_type = { /* Description of storage in buffer */
 			.sign = 's', /* signed */
-			.realbits = 16, /* 12 bits */
+			.realbits = 16, /* 16 bits */
 			.storagebits = 16, /* 16 bits used for storage */
 			.shift = 0, /* zero shift */
 		},
@@ -285,9 +285,9 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
  * iio_dummy_write_raw() - data write function.
  * @indio_dev:	the struct iio_dev associated with this device instance
  * @chan:	the channel whose data is to be read
- * @val:	first element of returned value (typically INT)
- * @val2:	second element of returned value (typically MICRO)
- * @mask:	what we actually want to read. 0 is the channel, everything else
+ * @val:	first element of value to set (typically INT)
+ * @val2:	second element of value to set (typically MICRO)
+ * @mask:	what we actually want to write. 0 is the channel, everything else
  *		is as per the info_mask in iio_chan_spec.
  *
  * Note that all raw writes are assumed IIO_VAL_INT and info mask elements
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index fdfc873..3e43025 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -67,8 +67,8 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 		 * software culled hardware scans:
 		 *   occasionally a driver may process the nearest hardware
 		 *   scan to avoid storing elements that are not desired. This
-		 *   is the fidliest option by far.
-		 * Here lets pretend we have random access. And the values are
+		 *   is the fiddliest option by far.
+		 * Here let's pretend we have random access. And the values are
 		 * in the constant table fakedata.
 		 */
 		int i, j;
-- 
1.7.9.5

