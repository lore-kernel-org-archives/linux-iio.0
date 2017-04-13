Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:61202 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751250AbdDMNvy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 Apr 2017 09:51:54 -0400
From: =?UTF-8?q?Ren=C3=A9=20Hickersberger?= <renehickersberger@gmx.net>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Hickersberger=3F=3D?=
        <renehickersberger@gmx.net>
Subject: [PATCH] Staging: iio: accel: adis16203: fixed a brace coding style issue
Date: Thu, 13 Apr 2017 15:51:37 +0200
Message-Id: <20170413135137.4494-1-renehickersberger@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: René Hickersberger?= <renehickersberger@gmx.net>

Fixed a brace coding style issue.

Signed-off-by: René Hickersberger <renehickersberger@gmx.net>
---
 drivers/staging/iio/accel/adis16203.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index faa2869..4e3fa75 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -205,9 +205,8 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 		bits = 14;
 		addr = adis16203_addresses[chan->scan_index];
 		ret = adis_read_reg_16(st, addr, &val16);
-		if (ret) {
+		if (ret)
 			return ret;
-		}
 		val16 &= (1 << bits) - 1;
 		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
 		*val = val16;
-- 
2.9.3

