Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36356 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755666AbdCKO0y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 09:26:54 -0500
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v1 01/10] staging: iio: ad7192: Remove exceptional & on function name
Date: Sat, 11 Mar 2017 19:56:35 +0530
Message-Id: <1489242404-12352-2-git-send-email-singhalsimran0@gmail.com>
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
 drivers/staging/iio/adc/ad7192.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 4fc8588..d11c6de 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -564,18 +564,18 @@ static int ad7192_write_raw_get_fmt(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ad7192_info = {
-	.read_raw = &ad7192_read_raw,
-	.write_raw = &ad7192_write_raw,
-	.write_raw_get_fmt = &ad7192_write_raw_get_fmt,
+	.read_raw = ad7192_read_raw,
+	.write_raw = ad7192_write_raw,
+	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
 	.attrs = &ad7192_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
 	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad7195_info = {
-	.read_raw = &ad7192_read_raw,
-	.write_raw = &ad7192_write_raw,
-	.write_raw_get_fmt = &ad7192_write_raw_get_fmt,
+	.read_raw = ad7192_read_raw,
+	.write_raw = ad7192_write_raw,
+	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
 	.attrs = &ad7195_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
 	.driver_module = THIS_MODULE,
-- 
2.7.4

