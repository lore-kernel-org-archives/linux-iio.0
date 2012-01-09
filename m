Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay04-haj2.antispameurope.com ([83.246.65.54]:47335 "EHLO
	relay04-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932211Ab2AIQDY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2012 11:03:24 -0500
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: [PATCH 2/3] staging: iio: core: add missing spaces to error output
Date: Mon,  9 Jan 2012 17:02:53 +0100
Message-Id: <1326124974-7288-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1326124974-7288-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
References: <1326124974-7288-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
To: jic23@cam.ac.uk
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
 drivers/staging/iio/industrialio-buffer.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index a03a574..f5c4999 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -430,7 +430,7 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 			ret = indio_dev->setup_ops->preenable(indio_dev);
 			if (ret) {
 				printk(KERN_ERR
-				       "Buffer not started:"
+				       "Buffer not started: "
 				       "buffer preenable failed\n");
 				goto error_ret;
 			}
@@ -439,7 +439,7 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 			ret = buffer->access->request_update(buffer);
 			if (ret) {
 				printk(KERN_INFO
-				       "Buffer not started:"
+				       "Buffer not started: "
 				       "buffer parameter update failed\n");
 				goto error_ret;
 			}
@@ -468,7 +468,7 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 			ret = indio_dev->setup_ops->postenable(indio_dev);
 			if (ret) {
 				printk(KERN_INFO
-				       "Buffer not started:"
+				       "Buffer not started: "
 				       "postenable failed\n");
 				if (buffer->access->unmark_in_use)
 					buffer->access->unmark_in_use(buffer);
-- 
1.7.3.rc1

