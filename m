Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33908 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbbHCKid (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2015 06:38:33 -0400
Date: Mon, 3 Aug 2015 13:37:40 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH] iio: industrialio-buffer: Fix iio_buffer_poll return value
Message-ID: <4193254d1067149430a5a8d84a21def37f09bcec.1438598039.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Change return value to 0 if no device is bound since
unsigned int cannot support negative error codes.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index faed6ef..e8e87cf 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -155,7 +155,9 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
  *		a wait queue
  *
  * Return: (POLLIN | POLLRDNORM) if data is available for reading
- *	   or 0 for other cases
+ *	   and 0 for other cases, e.g. no device is bound or no
+ *	   hardware fifo flush could be triggered.
+ *
  */
 unsigned int iio_buffer_poll(struct file *filp,
 			     struct poll_table_struct *wait)
@@ -164,7 +166,7 @@ unsigned int iio_buffer_poll(struct file *filp,
 	struct iio_buffer *rb = indio_dev->buffer;
 
 	if (!indio_dev->info)
-		return -ENODEV;
+		return 0;
 
 	poll_wait(filp, &rb->pollq, wait);
 	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
-- 
1.9.1

