Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:47506 "EHLO fe2.pruts.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161444AbcIZSkg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Sep 2016 14:40:36 -0400
From: Ico Doornekamp <ico@pruts.nl>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Ico Doornekamp <ico@pruts.nl>
Subject: [PATCH] io: accel: mma7666: declare mma7660_nscale as static
Date: Mon, 26 Sep 2016 20:40:27 +0200
Message-Id: <20160926184027.5356-1-ico@pruts.nl>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As reported by sparse

Signed-off-by: Ico Doornekamp <ico@pruts.nl>
---
 drivers/iio/accel/mma7660.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 03beadf..3a40774 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -39,7 +39,7 @@
 
 #define MMA7660_SCALE_AVAIL	"0.467142857"
 
-const int mma7660_nscale = 467142857;
+static const int mma7660_nscale = 467142857;
 
 #define MMA7660_CHANNEL(reg, axis) {	\
 	.type = IIO_ACCEL,	\
-- 
2.9.3

