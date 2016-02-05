Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36311 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbcBEDxv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2016 22:53:51 -0500
From: Bhumika Goyal <bhumirks@gmail.com>
To: gregkh@linuxfoundation.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] Staging:iio:Remove exceptional & on function name
Date: Fri,  5 Feb 2016 09:23:32 +0530
Message-Id: <1454644412-6861-1-git-send-email-bhumirks@gmail.com>
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

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 10c43dda..d1218d8 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -558,7 +558,7 @@ out:
 }
 
 static const struct iio_info ad5933_info = {
-	.read_raw = &ad5933_read_raw,
+	.read_raw = ad5933_read_raw,
 	.attrs = &ad5933_attribute_group,
 	.driver_module = THIS_MODULE,
 };
@@ -616,9 +616,9 @@ static int ad5933_ring_postdisable(struct iio_dev *indio_dev)
 }
 
 static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
-	.preenable = &ad5933_ring_preenable,
-	.postenable = &ad5933_ring_postenable,
-	.postdisable = &ad5933_ring_postdisable,
+	.preenable = ad5933_ring_preenable,
+	.postenable = ad5933_ring_postenable,
+	.postdisable = ad5933_ring_postdisable,
 };
 
 static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
-- 
1.9.1

