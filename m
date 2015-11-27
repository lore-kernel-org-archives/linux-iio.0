Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-220.synserver.de ([212.40.185.220]:1174 "EHLO
	smtp-out-194.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754004AbbK0N4D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Nov 2015 08:56:03 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: adis_buffer: Fix out-of-bounds memory access
Date: Fri, 27 Nov 2015 14:55:56 +0100
Message-Id: <1448632556-13005-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The SPI tx and rx buffers are both supposed to be scan_bytes amount of
bytes large and a common allocation is used to allocate both buffers. This
puts the beginning of the tx buffer scan_bytes bytes after the rx buffer.
The initialization of the tx buffer pointer is done adding scan_bytes to
the beginning of the rx buffer, but since the rx buffer is of type __be16
this will actually add two times as much and the tx buffer ends up pointing
after the allocated buffer.

Fix this by using scan_count, which is scan_bytes / 2, instead of
scan_bytes when initializing the tx buffer pointer.

Fixes: aacff892cbd5 ("staging:iio:adis: Preallocate transfer message")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Apologies if you got this twice, forgot the mailinglist on the first try.
---
 drivers/iio/imu/adis_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index cb32b59..36607d5 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -43,7 +43,7 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 		return -ENOMEM;
 
 	rx = adis->buffer;
-	tx = rx + indio_dev->scan_bytes;
+	tx = rx + scan_count;
 
 	spi_message_init(&adis->msg);
 
-- 
2.1.4

