Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-194.synserver.de ([212.40.185.194]:1029 "EHLO
	smtp-out-194.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3JOIgd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2013 04:36:33 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:buffer: Free active scan mask in iio_disable_all_buffers()
Date: Tue, 15 Oct 2013 10:38:32 +0200
Message-Id: <1381826312-26546-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Usually the active scan mask is freed in __iio_update_buffers() when the buffer
is disabled. But when the device is still sampling when it is removed we'll end
up disabling the buffers in iio_disable_all_buffers(). So we also need to free
the active scan mask here, otherwise it will be leaked.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 796376a..1c72080 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -490,6 +490,9 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev)
 	indio_dev->currentmode = INDIO_DIRECT_MODE;
 	if (indio_dev->setup_ops->postdisable)
 		indio_dev->setup_ops->postdisable(indio_dev);
+
+	if (indio_dev->available_scan_masks == NULL)
+		kfree(indio_dev->active_scan_mask);
 }
 
 static int __iio_update_buffers(struct iio_dev *indio_dev,
-- 
1.8.0

