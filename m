Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-201.synserver.de ([212.40.185.201]:1230 "EHLO
	smtp-out-200.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753200Ab2KMLtQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Nov 2012 06:49:16 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: Fix iio_buffer_register stub signature
Date: Tue, 13 Nov 2012 12:48:58 +0100
Message-Id: <1352807338-31896-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Match the iio_buffer_register stub signature up to the real function and make
the second parameter const. This fixes a the following warnings if
CONFIG_IIO_BUFFER is disabled:

	drivers/staging/iio/accel/adis16201_core.c: In function ‘adis16201_probe’:
	drivers/staging/iio/accel/adis16201_core.c:536: warning: passing argument 2 of ‘iio_buffer_register’ discards qualifiers from pointer target type
	drivers/staging/iio/accel/adis16203_core.c: In function ‘adis16203_probe’:
	drivers/staging/iio/accel/adis16203_core.c:468: warning: passing argument 2 of ‘iio_buffer_register’ discards qualifiers from pointer target type
	drivers/staging/iio/accel/adis16204_core.c: In function ‘adis16204_probe’:
	drivers/staging/iio/accel/adis16204_core.c:527: warning: passing argument 2 of ‘iio_buffer_register’ discards qualifiers from pointer target type
	drivers/staging/iio/accel/adis16209_core.c: In function ‘adis16209_probe’:
	drivers/staging/iio/accel/adis16209_core.c:542: warning: passing argument 2 of ‘iio_buffer_register’ discards qualifiers from pointer target type
	drivers/staging/iio/accel/adis16240_core.c: In function ‘adis16240_probe’:
	drivers/staging/iio/accel/adis16240_core.c:588: warning: passing argument 2 of ‘iio_buffer_register’ discards qualifiers from pointer target type

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/iio/buffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 0270405..f3eea18 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -195,7 +195,7 @@ bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 #else /* CONFIG_IIO_BUFFER */
 
 static inline int iio_buffer_register(struct iio_dev *indio_dev,
-					   struct iio_chan_spec *channels,
+					   const struct iio_chan_spec *channels,
 					   int num_channels)
 {
 	return 0;
-- 
1.8.0

