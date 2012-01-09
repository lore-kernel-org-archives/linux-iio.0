Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay02-haj2.antispameurope.com ([83.246.65.52]:34289 "EHLO
	relay02-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932188Ab2AIQIq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2012 11:08:46 -0500
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: [PATCH 3/3] staging: iio: core: add error message when buffer length is zero
Date: Mon,  9 Jan 2012 17:02:54 +0100
Message-Id: <1326124974-7288-3-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1326124974-7288-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
References: <1326124974-7288-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
To: jic23@cam.ac.uk
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
 drivers/staging/iio/industrialio-buffer.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index f5c4999..c789d39 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -426,6 +426,17 @@ ssize_t iio_buffer_store_enable(struct device *dev,
 		goto done;
 	}
 	if (requested_state) {
+		if (buffer->access->get_length) {
+			ret = buffer->access->get_length(buffer);
+			if (ret <= 0) {
+				printk(KERN_INFO
+				       "Buffer not started: "
+				       "buffer length must be greater than zero\n");
+				ret = -EINVAL;
+				goto error_ret;
+			}
+		}
+
 		if (indio_dev->setup_ops->preenable) {
 			ret = indio_dev->setup_ops->preenable(indio_dev);
 			if (ret) {
-- 
1.7.3.rc1

