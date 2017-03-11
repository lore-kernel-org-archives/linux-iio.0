Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36439 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755687AbdCKO1J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 09:27:09 -0500
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v1 05/10] staging: iio: adis16240: Remove exceptional & on function name
Date: Sat, 11 Mar 2017 19:56:39 +0530
Message-Id: <1489242404-12352-6-git-send-email-singhalsimran0@gmail.com>
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
 drivers/staging/iio/accel/adis16240.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 27d7f6a..37a29dc 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -373,8 +373,8 @@ static const struct attribute_group adis16240_attribute_group = {
 
 static const struct iio_info adis16240_info = {
 	.attrs = &adis16240_attribute_group,
-	.read_raw = &adis16240_read_raw,
-	.write_raw = &adis16240_write_raw,
+	.read_raw = adis16240_read_raw,
+	.write_raw = adis16240_write_raw,
 	.update_scan_mode = adis_update_scan_mode,
 	.driver_module = THIS_MODULE,
 };
-- 
2.7.4

