Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nick.hrz.tu-chemnitz.de ([134.109.228.11]:50503 "EHLO
	nick.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab2LSSSa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Dec 2012 13:18:30 -0500
From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
To: linux-iio@vger.kernel.org
Cc: trivial@kernel.org, Jonathan Cameron <jic23@cam.ac.uk>,
	Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: [PATCH] iio: Fix some comments
Date: Wed, 19 Dec 2012 18:56:31 +0100
Message-Id: <1355939791-18814-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
---
 drivers/staging/iio/iio_simple_dummy.c        | 4 ++--
 drivers/staging/iio/iio_simple_dummy_buffer.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index a865adf..aee76c7 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -54,7 +54,7 @@ struct iio_dummy_accel_calibscale {
 static const struct iio_dummy_accel_calibscale dummy_scales[] = {
 	{ 0, 100, 0x8 }, /* 0.000100 */
 	{ 0, 133, 0x7 }, /* 0.000133 */
-	{ 733, 13, 0x9 }, /* 733.00013 */
+	{ 733, 13, 0x9 }, /* 733.000013 */
 };
 
 /*
@@ -284,7 +284,7 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
 /**
  * iio_dummy_write_raw() - data write function.
  * @indio_dev:	the struct iio_dev associated with this device instance
- * @chan:	the channel whose data is to be read
+ * @chan:	the channel whose data is to be written
  * @val:	first element of value to set (typically INT)
  * @val2:	second element of value to set (typically MICRO)
  * @mask:	what we actually want to write. 0 is the channel, everything else
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index dee16f0..72f400c 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -155,7 +155,7 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev,
 	 * occurs, this function is run. Typically this grabs data
 	 * from the device.
 	 *
-	 * NULL for the top half. This is normally implemented only if we
+	 * NULL for the bottom half. This is normally implemented only if we
 	 * either want to ping a capture now pin (no sleeping) or grab
 	 * a timestamp as close as possible to a data ready trigger firing.
 	 *
-- 
1.8.0.2

