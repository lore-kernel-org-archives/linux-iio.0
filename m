Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-137.synserver.de ([212.40.185.137]:1154 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750793Ab2GBMt3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jul 2012 08:49:29 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: iio_buffer_register: Use correct channel when calculating masklength
Date: Mon,  2 Jul 2012 14:52:56 +0200
Message-Id: <1341233576-9082-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The channel set assigned to the iio device is not necessarily the same has the
channel set passed to iio_buffer_register. So to avoid possible complications
always work with the channel set pass to iio_buffer_register and ignore the
channel set assigned to the iio device.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index bb88377..d074051 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -292,7 +292,7 @@ int iio_buffer_register(struct iio_dev *indio_dev,
 			if (channels[i].scan_index >
 			    (int)indio_dev->masklength - 1)
 				indio_dev->masklength
-					= indio_dev->channels[i].scan_index + 1;
+					= channels[i].scan_index + 1;
 
 			ret = iio_buffer_add_channel_sysfs(indio_dev,
 							 &channels[i]);
-- 
1.7.10

