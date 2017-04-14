Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34061 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdDNGWM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 02:22:12 -0400
Received: by mail-pg0-f45.google.com with SMTP id 21so40271310pgg.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2017 23:22:12 -0700 (PDT)
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>,
        George McCollister <george.mccollister@gmail.com>
Subject: [PATCH] iio: proximity: as3935: fix as3935_write
Date: Thu, 13 Apr 2017 23:21:56 -0700
Message-Id: <20170414062156.26782-1-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

AS3935_WRITE_DATA macro bit is incorrect and the actual write
sequence is two leading zeros.

Cc: George McCollister <george.mccollister@gmail.com>
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/as3935.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 5656deb17261..020459513384 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -50,7 +50,6 @@
 #define AS3935_TUNE_CAP		0x08
 #define AS3935_CALIBRATE	0x3D
 
-#define AS3935_WRITE_DATA	BIT(15)
 #define AS3935_READ_DATA	BIT(14)
 #define AS3935_ADDRESS(x)	((x) << 8)
 
@@ -105,7 +104,7 @@ static int as3935_write(struct as3935_state *st,
 {
 	u8 *buf = st->buf;
 
-	buf[0] = (AS3935_WRITE_DATA | AS3935_ADDRESS(reg)) >> 8;
+	buf[0] = AS3935_ADDRESS(reg) >> 8;
 	buf[1] = val;
 
 	return spi_write(st->spi, buf, 2);
-- 
2.11.0

