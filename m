Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35708 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdCRM6r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2017 08:58:47 -0400
Received: by mail-pg0-f66.google.com with SMTP id g2so13493198pge.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2017 05:58:41 -0700 (PDT)
Date: Sat, 18 Mar 2017 03:13:56 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: [PATCH v3] staging: iio: accel: adis16201: remove iio_dev mlock
Message-ID: <20170317214356.GA8369@aishwarya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In the driver adis16201 read raw does not require an iio_dev->mlock for
reads. It can run concurrently as adis_read_reg_16() is protected by a
transaction lock.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

---
Changes in v3:
	-- Fix change log format
	-- Send patch to linuc-iio
Changes in v2:
	-- Remove read lock

 drivers/staging/iio/accel/adis16201.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index d6c8658..fd2baf2 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -223,17 +223,13 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		mutex_lock(&indio_dev->mlock);
 		addr = adis16201_addresses[chan->scan_index];
 		ret = adis_read_reg_16(st, addr, &val16);
-		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
+		if (ret)
 			return ret;
-		}
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
-		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
 	}
 	return -EINVAL;
-- 
2.7.4

