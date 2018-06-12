Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39361 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935040AbeFLQsp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jun 2018 12:48:45 -0400
From: Karim Eshapa <karim.eshapa@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] staging:iio:accel:adis16203: sign extend function rather code duplication
Date: Tue, 12 Jun 2018 18:48:38 +0200
Message-Id: <20180612164838.22961-1-karim.eshapa@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use sign_extend32 kernel function instead of code duplication.
This function is also safe for 16 bits.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/staging/iio/accel/adis16203.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index b3e4571340ab..5cc96c8086b5 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -168,7 +168,6 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 {
 	struct adis *st = iio_priv(indio_dev);
 	int ret;
-	int bits;
 	u8 addr;
 	s16 val16;
 
@@ -202,14 +201,11 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		bits = 14;
 		addr = adis16203_addresses[chan->scan_index];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, 13);
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
-- 
2.17.1

