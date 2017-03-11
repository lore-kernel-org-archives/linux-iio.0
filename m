Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36042 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934237AbdCKDfM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Mar 2017 22:35:12 -0500
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 09/10] staging: iio: resolver: Remove exceptional & on function name
Date: Sat, 11 Mar 2017 09:06:40 +0530
Message-Id: <1489203401-17518-10-git-send-email-singhalsimran0@gmail.com>
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
 drivers/staging/iio/resolver/ad2s1200.c | 2 +-
 drivers/staging/iio/resolver/ad2s90.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 82b2d88..a37e199 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -97,7 +97,7 @@ static const struct iio_chan_spec ad2s1200_channels[] = {
 };
 
 static const struct iio_info ad2s1200_info = {
-	.read_raw = &ad2s1200_read_raw,
+	.read_raw = ad2s1200_read_raw,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 5b1c0db..b227090 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -47,7 +47,7 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ad2s90_info = {
-	.read_raw = &ad2s90_read_raw,
+	.read_raw = ad2s90_read_raw,
 	.driver_module = THIS_MODULE,
 };
 
-- 
2.7.4

