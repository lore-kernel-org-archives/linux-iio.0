Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35655 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755684AbdCKO05 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 09:26:57 -0500
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v1 02/10] staging: iio: ad7780: Remove exceptional & on function name
Date: Sat, 11 Mar 2017 19:56:36 +0530
Message-Id: <1489242404-12352-3-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1489242404-12352-1-git-send-email-singhalsimran0@gmail.com>
References: <1489242404-12352-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove & from function pointers to conform to the style found elsewhere
in the file.  Done using the following semantic patch

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
 drivers/staging/iio/adc/ad7780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index e149600..dec3ba6 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -154,7 +154,7 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 };
 
 static const struct iio_info ad7780_info = {
-	.read_raw = &ad7780_read_raw,
+	.read_raw = ad7780_read_raw,
 	.driver_module = THIS_MODULE,
 };
 
-- 
2.7.4

