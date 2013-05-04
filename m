Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:34129 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758971Ab3EDN1n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 4 May 2013 09:27:43 -0400
Message-Id: <79b3b255142a0ec0ab891d0b4bb0dbc9a2532e74.1367671597.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] iio: buffer: cleanup messages in iio_update_buffers()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Date: Sat,  4 May 2013 15:19:35 +0200 (CEST)
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

1. make messages grepable (in one line)
2. include returned errno in them

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
Please ignore checkpatch long lines warning.

 drivers/iio/industrialio-buffer.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index aaadd32..e73033f 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -542,8 +542,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		ret = indio_dev->setup_ops->preenable(indio_dev);
 		if (ret) {
 			printk(KERN_ERR
-			       "Buffer not started:"
-			       "buffer preenable failed\n");
+			       "Buffer not started: buffer preenable failed (%d)\n", ret);
 			goto error_remove_inserted;
 		}
 	}
@@ -556,8 +555,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 			ret = buffer->access->request_update(buffer);
 			if (ret) {
 				printk(KERN_INFO
-				       "Buffer not started:"
-				       "buffer parameter update failed\n");
+				       "Buffer not started: buffer parameter update failed (%d)\n", ret);
 				goto error_run_postdisable;
 			}
 		}
@@ -566,7 +564,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 			->update_scan_mode(indio_dev,
 					   indio_dev->active_scan_mask);
 		if (ret < 0) {
-			printk(KERN_INFO "update scan mode failed\n");
+			printk(KERN_INFO "Buffer not started: update scan mode failed (%d)\n", ret);
 			goto error_run_postdisable;
 		}
 	}
@@ -590,7 +588,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 		ret = indio_dev->setup_ops->postenable(indio_dev);
 		if (ret) {
 			printk(KERN_INFO
-			       "Buffer not started: postenable failed\n");
+			       "Buffer not started: postenable failed (%d)\n", ret);
 			indio_dev->currentmode = INDIO_DIRECT_MODE;
 			if (indio_dev->setup_ops->postdisable)
 				indio_dev->setup_ops->postdisable(indio_dev);
-- 
1.7.10.4

