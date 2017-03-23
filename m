Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21309 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752682AbdCWIGy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2017 04:06:54 -0400
From: Mark Stenglein <mark@stengle.in>
To: lars@metafoo.de
Cc: jic23@kernel.org, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Mark Stenglein <mark@stengle.in>
Subject: [PATCH] staging: iio: accel: remove unneeded braces around single statements
Date: Thu, 23 Mar 2017 02:18:12 -0400
Message-Id: <20170323061812.7316-1-mark@stengle.in>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes three checkpatch warnings due to braces used when single
statements are sufficient.

Signed-off-by: Mark Stenglein <mark@stengle.in>
---
 drivers/staging/iio/accel/adis16209.c | 3 +--
 drivers/staging/iio/accel/adis16240.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 52fa2e0511be..8485c024e3f5 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -255,9 +255,8 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 		}
 		addr = adis16209_addresses[chan->scan_index][0];
 		ret = adis_read_reg_16(st, addr, &val16);
-		if (ret) {
+		if (ret)
 			return ret;
-		}
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 6e3c95c9c3f6..109cd94b5ac3 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -290,9 +290,8 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		bits = 10;
 		addr = adis16240_addresses[chan->scan_index][0];
 		ret = adis_read_reg_16(st, addr, &val16);
-		if (ret) {
+		if (ret)
 			return ret;
-		}
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
@@ -301,9 +300,8 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		bits = 10;
 		addr = adis16240_addresses[chan->scan_index][1];
 		ret = adis_read_reg_16(st, addr, &val16);
-		if (ret) {
+		if (ret)
 			return ret;
-		}
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
-- 
2.12.1


