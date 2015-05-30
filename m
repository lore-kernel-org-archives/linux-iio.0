Return-Path: <laurent.navet@gmail.com>
From: Laurent Navet <laurent.navet@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Laurent Navet <laurent.navet@gmail.com>
Subject: [PATCH] iio: buffer: remove unneeded test
Date: Sat, 30 May 2015 22:35:36 +0200
Message-Id: <1433018136-7108-1-git-send-email-laurent.navet@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The same code is executed regardless ret value, so this test
can be removed.
Also fix coverity scan CID 1268786.

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/iio/industrialio-buffer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index df919f4..e7fbcce 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -806,8 +806,6 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 		ret = __iio_update_buffers(indio_dev,
 					 NULL, indio_dev->buffer);
 
-	if (ret < 0)
-		goto done;
 done:
 	mutex_unlock(&indio_dev->mlock);
 	return (ret < 0) ? ret : len;
-- 
2.1.4
