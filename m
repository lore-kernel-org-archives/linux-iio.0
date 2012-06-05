Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-128.synserver.de ([212.40.185.128]:1060 "EHLO
	smtp-out-123.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753262Ab2FEQVG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jun 2012 12:21:06 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: iio_enum_available_read: Prevent possible buffer overflow
Date: Tue,  5 Jun 2012 18:24:12 +0200
Message-Id: <1338913452-26786-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use scnprint instead of snprintf, because snprintf returns the number of bytes
that would have been written to the buffer if there was enough space, and as a
result writing to buf[len-1] might cause a access beyond the buffers limits.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 56a3c0b..cf9ecd0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -300,7 +300,7 @@ ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
 		return 0;
 
 	for (i = 0; i < e->num_items; ++i)
-		len += snprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
 
 	/* replace last space with a newline */
 	buf[len - 1] = '\n';
-- 
1.7.10

