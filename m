Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-241.synserver.de ([212.40.185.241]:1123 "EHLO
	smtp-out-240.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752431Ab3JDLFR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Oct 2013 07:05:17 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 5/5] iio:buffer: Ignore noop requests for iio_update_buffers()
Date: Fri,  4 Oct 2013 13:07:02 +0200
Message-Id: <1380884822-17035-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1380884822-17035-1-git-send-email-lars@metafoo.de>
References: <1380884822-17035-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since the kernel now disables all buffers when a device is unregistered it might
happen that a in-kernel consumer tries to disable that buffer again. So ignore
requests where the buffer already is in the desired state.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
No changes since v1
---
 drivers/iio/industrialio-buffer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index d6a5455..fd3f3af 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -681,9 +681,23 @@ int iio_update_buffers(struct iio_dev *indio_dev,
 {
 	int ret;
 
+	if (insert_buffer == remove_buffer)
+		return 0;
+
 	mutex_lock(&indio_dev->info_exist_lock);
 	mutex_lock(&indio_dev->mlock);
 
+	if (insert_buffer && iio_buffer_is_active(insert_buffer))
+		insert_buffer = NULL;
+
+	if (remove_buffer && !iio_buffer_is_active(remove_buffer))
+		remove_buffer = NULL;
+
+	if (!insert_buffer && !remove_buffer) {
+		ret = 0;
+		goto out_unlock;
+	}
+
 	if (indio_dev->info == NULL) {
 		ret = -ENODEV;
 		goto out_unlock;
-- 
1.8.0

