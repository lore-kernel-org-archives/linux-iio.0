Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-177.synserver.de ([212.40.185.177]:1073 "EHLO
	smtp-out-166.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759721Ab2BJSXE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Feb 2012 13:23:04 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] staging:iio: Remove declaration for non existing function
Date: Fri, 10 Feb 2012 19:24:28 +0100
Message-Id: <1328898269-26197-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The declaration for iio_buffer_deinit has been around for quite some time, but
the function itself has never been added. So remove the declaration.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/buffer.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 6fb6e64..df2046d 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -91,8 +91,6 @@ struct iio_buffer {
  **/
 void iio_buffer_init(struct iio_buffer *buffer);
 
-void iio_buffer_deinit(struct iio_buffer *buffer);
-
 /**
  * __iio_update_buffer() - update common elements of buffers
  * @buffer:		buffer that is the event source
-- 
1.7.9

