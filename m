Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34484 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755686AbdCKO1G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 09:27:06 -0500
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH v1 04/10] staging: iio: cdc: ad7152: Remove exceptional & on function name
Date: Sat, 11 Mar 2017 19:56:38 +0530
Message-Id: <1489242404-12352-5-git-send-email-singhalsimran0@gmail.com>
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
 drivers/staging/iio/cdc/ad7152.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index e8609b8..59ef93c 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -441,9 +441,9 @@ static int ad7152_write_raw_get_fmt(struct iio_dev *indio_dev,
 
 static const struct iio_info ad7152_info = {
 	.attrs = &ad7152_attribute_group,
-	.read_raw = &ad7152_read_raw,
-	.write_raw = &ad7152_write_raw,
-	.write_raw_get_fmt = &ad7152_write_raw_get_fmt,
+	.read_raw = ad7152_read_raw,
+	.write_raw = ad7152_write_raw,
+	.write_raw_get_fmt = ad7152_write_raw_get_fmt,
 	.driver_module = THIS_MODULE,
 };
 
-- 
2.7.4

