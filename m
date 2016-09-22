Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36391 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933263AbcIVUov (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2016 16:44:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id n24so4230215pfb.3
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2016 13:44:51 -0700 (PDT)
Date: Fri, 23 Sep 2016 02:14:43 +0530
From: Sandhya Bankar <bankarsandhya512@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, linux-iio@vger.kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Subject: [PATCH] drivers: iio: mma7660: Fix sparse warning
Message-ID: <20160922204443.GA5786@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixing belows sparse warning :

drivers/iio/accel/mma7660.c:42:11: warning: symbol 'mma7660_nscale' 
was not declared. Should it be static?

Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
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
1.8.3.1

