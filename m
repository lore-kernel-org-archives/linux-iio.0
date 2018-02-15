Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:50003 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754805AbeBOH2s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Feb 2018 02:28:48 -0500
From: Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, ppmeerw@pmeerw.net,
        linux-iio@vger.kernel.org,
        Stefan Windfeldt-Prytz <stefanw@axis.com>
Subject: [PATCHv2] iio: buffer: check if a buffer has been set up when poll is called
Date: Thu, 15 Feb 2018 08:28:41 +0100
Message-Id: <1518679721-17415-1-git-send-email-stefan.windfeldt@axis.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If no iio buffer has been set up and poll is called return 0.

Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt@axis.com>
---
Changes in v2:
- Removed Change-Id

 drivers/iio/industrialio-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 79abf70..cd5bfe3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -175,7 +175,7 @@ __poll_t iio_buffer_poll(struct file *filp,
 	struct iio_dev *indio_dev = filp->private_data;
 	struct iio_buffer *rb = indio_dev->buffer;
 
-	if (!indio_dev->info)
+	if (!indio_dev->info || rb == NULL)
 		return 0;
 
 	poll_wait(filp, &rb->pollq, wait);
-- 
2.1.4

