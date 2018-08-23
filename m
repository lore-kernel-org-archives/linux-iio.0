Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:53166 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeHXA4N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Aug 2018 20:56:13 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] iio: light: isl29501: Simplify code to kill compiler warning
Date: Thu, 23 Aug 2018 23:24:35 +0200
Message-Id: <20180823212436.17423-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

With gcc 4.1.2:

    drivers/iio/proximity/isl29501.c: In function ‘isl29501_register_write’:
    drivers/iio/proximity/isl29501.c:235: warning: ‘msb’ may be used uninitialized in this function

While this is a false positive, it can easily be avoided by removing the
"msb" intermediate variable.
Remove the "lsb" intermediate variable for consistency.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
---
 drivers/iio/proximity/isl29501.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index e5e94540f404dd2c..5ae549075b27c50d 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -232,7 +232,6 @@ static u32 isl29501_register_write(struct isl29501_private *isl29501,
 				   u32 value)
 {
 	const struct isl29501_register_desc *reg = &isl29501_registers[name];
-	u8 msb, lsb;
 	int ret;
 
 	if (!reg->msb && value > U8_MAX)
@@ -241,22 +240,15 @@ static u32 isl29501_register_write(struct isl29501_private *isl29501,
 	if (value > U16_MAX)
 		return -ERANGE;
 
-	if (!reg->msb) {
-		lsb = value & 0xFF;
-	} else {
-		msb = (value >> 8) & 0xFF;
-		lsb = value & 0xFF;
-	}
-
 	mutex_lock(&isl29501->lock);
 	if (reg->msb) {
 		ret = i2c_smbus_write_byte_data(isl29501->client,
-						reg->msb, msb);
+						reg->msb, value >> 8);
 		if (ret < 0)
 			goto err;
 	}
 
-	ret = i2c_smbus_write_byte_data(isl29501->client, reg->lsb, lsb);
+	ret = i2c_smbus_write_byte_data(isl29501->client, reg->lsb, value);
 
 err:
 	mutex_unlock(&isl29501->lock);
-- 
2.17.1
