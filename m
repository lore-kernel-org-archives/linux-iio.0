Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36120 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934298AbdCKDfP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Mar 2017 22:35:15 -0500
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 10/10] staging: iio: gyro: Remove exceptional & on function name
Date: Sat, 11 Mar 2017 09:06:41 +0530
Message-Id: <1489203401-17518-11-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1489203401-17518-1-git-send-email-singhalsimran0@gmail.com>
References: <1489203401-17518-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In this file,function names are otherwise used as pointers without &.
Found using coccinelle.
// <smpl>
@r@
identifier f;
@@

f(...) { ... }
@@
identifier r.f;
@@

- &f
+ f
// </smpl>

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/staging/iio/gyro/adis16060_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index ab816a2..c9d46e7 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -117,7 +117,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info adis16060_info = {
-	.read_raw = &adis16060_read_raw,
+	.read_raw = adis16060_read_raw,
 	.driver_module = THIS_MODULE,
 };
 
-- 
2.7.4

