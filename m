Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33950 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932959AbdCUQNB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 12:13:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id o126so22669171pfb.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2017 09:13:01 -0700 (PDT)
From: Gargi Sharma <gs051095@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Gargi Sharma <gs051095@gmail.com>
Subject: [RESEND PATCH] staging: adis16203: Remove locking on raw reads of IIO_CHAN_INFO_CALIBBIAS
Date: Tue, 21 Mar 2017 21:32:06 +0530
Message-Id: <1490112126-30265-1-git-send-email-gs051095@gmail.com>
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

