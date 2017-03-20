Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32990 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752936AbdCTIdx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 04:33:53 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so9803200pgf.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Mar 2017 01:33:17 -0700 (PDT)
From: Gargi Sharma <gs051095@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Gargi Sharma <gs051095@gmail.com>
Subject: [PATCH] staging: adis16203: Remove locking on raw reads of IIO_CHAN_INFO_CALIBBIAS
Date: Mon, 20 Mar 2017 14:00:42 +0530
Message-Id: <1489998642-13796-1-git-send-email-gs051095@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

adis16203_read_raw does not need lock for IIO_CHAN_INFO_CALIBBIAS
since adis_read_reg_16 is already atomic and nothing else needs to be
protected.

Signed-off-by: Gargi Sharma <gs051095@gmail.com>
---
 drivers/staging/iio/accel/adis16203.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 68189ad..14fe2d3 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -203,17 +203,14 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		bits = 14;
-		mutex_lock(&indio_dev->mlock);
 		addr = adis16203_addresses[chan->scan_index];
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
 			return ret;
 		}
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
-		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
-- 
2.7.4

