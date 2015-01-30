Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37334 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbbA3Iba (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jan 2015 03:31:30 -0500
Date: Fri, 30 Jan 2015 11:30:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [patch] iio: imu: adis16400: Fix sign extension
Message-ID: <20150130083058.GD21357@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Because of C's type promotion rules, the code shifts in
"((val16 & 0xFFF) << 4) >> 4;" cancel each other out and they're a
no-op.

The intention here was to sign-extend then 11th bit so we can use the
sign_extend32() function.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Please review this carefully.  I'm pretty sure it's correct but this is
the first time I've ever used the sign_extend32() function.

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index b70873d..ed636c9 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -414,7 +414,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&indio_dev->mlock);
 		if (ret)
 			return ret;
-		val16 = ((val16 & 0xFFF) << 4) >> 4;
+		val16 = sign_extend32(val16, 11);
 		*val = val16;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
