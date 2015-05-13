Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-163.synserver.de ([212.40.185.163]:1128 "EHLO
	smtp-out-163.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933470AbbEMOFA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2015 10:05:00 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/8] DO NOT APPLY! __iio_update_buffers error path testing
Date: Wed, 13 May 2015 16:04:51 +0200
Message-Id: <1431525891-19285-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1431525891-19285-1-git-send-email-lars@metafoo.de>
References: <1431525891-19285-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch is not meant to be applied. This is what I've been using to test
the error paths. I've included it in case somebody wants to re-test things
or future changes to __iio_update_buffers.

For testing I've basically kept the following script running for about 30
minutes:
	while true; do
		echo 1 > buffer/enable
		sleep 1
		echo 0.1 > buffer/enable
		sleep 0.1
	done;

After that I did set test_err_paths to 0 and things worked again as if
nothing happened. kmemleak didn't complain either.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 56 ++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 3a11a2a..13c45f6 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -13,6 +13,9 @@
  * - Better memory allocation techniques?
  * - Alternative access techniques?
  */
+
+#define DEBUG
+
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/device.h>
@@ -27,6 +30,29 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 
+#include <linux/module.h>
+#include <linux/random.h>
+
+static int test_err_path = 1;
+module_param(test_err_path, int, 0644);
+MODULE_PARM_DESC(test_err_path, "test");
+
+static int _random_err(const char *func)
+{
+	if (test_err_path && (prandom_u32() & 0xf) == 0) {
+		pr_info("Injected error for %s\n", func);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+#define random_err(x) (_random_err(#x) ?: (x))
+#define random_err_callback(x, ...) \
+	(_random_err(#x) ?: (x ? x(__VA_ARGS__) : 0))
+#define random_err_callback2(x, ...) \
+	((x ? (x(__VA_ARGS__) ?: _random_err(#x)) : _random_err(#x)))
+
 static const char * const iio_endian_prefix[] = {
 	[IIO_BE] = "be",
 	[IIO_LE] = "le",
@@ -568,15 +594,13 @@ static int iio_buffer_request_update(struct iio_dev *indio_dev,
 	int ret;
 
 	iio_buffer_update_bytes_per_datum(indio_dev, buffer);
-	if (buffer->access->request_update) {
-		ret = buffer->access->request_update(buffer);
+		ret = random_err_callback(buffer->access->request_update, buffer);
 		if (ret) {
 			dev_dbg(&indio_dev->dev,
 			       "Buffer not started: buffer parameter update failed (%d)\n",
 				ret);
 			return ret;
 		}
-	}
 
 	return 0;
 }
@@ -686,17 +710,13 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 	 * encountered.
 	 */
 
-	if (indio_dev->setup_ops->predisable) {
-		ret2 = indio_dev->setup_ops->predisable(indio_dev);
+		ret2 = random_err_callback2(indio_dev->setup_ops->predisable, indio_dev);
 		if (ret2 && !ret)
 			ret = ret2;
-	}
 
-	if (indio_dev->setup_ops->postdisable) {
-		ret = indio_dev->setup_ops->postdisable(indio_dev);
+		ret2 = random_err_callback2(indio_dev->setup_ops->postdisable, indio_dev);
 		if (ret2 && !ret)
 			ret = ret2;
-	}
 
 	indio_dev->currentmode = INDIO_DIRECT_MODE;
 	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
@@ -718,18 +738,15 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	iio_update_demux(indio_dev);
 
 	/* Wind up again */
-	if (indio_dev->setup_ops->preenable) {
-		ret = indio_dev->setup_ops->preenable(indio_dev);
+		ret = random_err_callback(indio_dev->setup_ops->preenable, indio_dev);
 		if (ret) {
 			dev_dbg(&indio_dev->dev,
 			       "Buffer not started: buffer preenable failed (%d)\n", ret);
 			goto err_undo_config;
 		}
-	}
 
-	if (indio_dev->info->update_scan_mode) {
-		ret = indio_dev->info
-			->update_scan_mode(indio_dev,
+		ret = random_err_callback(indio_dev->info
+			->update_scan_mode, indio_dev,
 					   indio_dev->active_scan_mask);
 		if (ret < 0) {
 			dev_dbg(&indio_dev->dev,
@@ -737,16 +754,13 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 				ret);
 			goto err_run_postdisable;
 		}
-	}
 
-	if (indio_dev->setup_ops->postenable) {
-		ret = indio_dev->setup_ops->postenable(indio_dev);
+		ret = random_err_callback(indio_dev->setup_ops->postenable, indio_dev);
 		if (ret) {
 			dev_dbg(&indio_dev->dev,
 			       "Buffer not started: postenable failed (%d)\n", ret);
 			goto err_run_postdisable;
 		}
-	}
 
 	return 0;
 
@@ -767,8 +781,8 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 	struct iio_device_config new_config;
 	int ret;
 
-	ret = iio_verify_update(indio_dev, insert_buffer, remove_buffer,
-		&new_config);
+	ret = random_err(iio_verify_update(indio_dev, insert_buffer, remove_buffer,
+		&new_config));
 	if (ret)
 		return ret;
 
-- 
1.8.0

