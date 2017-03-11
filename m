Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35964 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933425AbdCKDet (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Mar 2017 22:34:49 -0500
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 03/10] staging: iio: cdc: ad7746: Remove exceptional & on function name
Date: Sat, 11 Mar 2017 09:06:34 +0530
Message-Id: <1489203401-17518-4-git-send-email-singhalsimran0@gmail.com>
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
 drivers/staging/iio/cdc/ad7746.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 81f8b9e..6294de7 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -664,8 +664,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info ad7746_info = {
 	.attrs = &ad7746_attribute_group,
-	.read_raw = &ad7746_read_raw,
-	.write_raw = &ad7746_write_raw,
+	.read_raw = ad7746_read_raw,
+	.write_raw = ad7746_write_raw,
 	.driver_module = THIS_MODULE,
 };
 
-- 
2.7.4

