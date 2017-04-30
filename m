Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34375 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2992958AbdD3XRV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 19:17:21 -0400
Received: by mail-qt0-f193.google.com with SMTP id y33so15006918qta.1
        for <linux-iio@vger.kernel.org>; Sun, 30 Apr 2017 16:17:21 -0700 (PDT)
From: Quentin Swain <dudebrobro179@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        apw@canonical.com, joe@perches.com,
        Quentin Swain <dudebrobro179@gmail.com>
Subject: [PATCH 4/5] iio: ade7758: Convert symbolic permissions to octal
Date: Sun, 30 Apr 2017 19:17:01 -0400
Message-Id: <20170430231702.377-5-dudebrobro179@gmail.com>
In-Reply-To: <20170430231702.377-1-dudebrobro179@gmail.com>
References: <20170430231702.377-1-dudebrobro179@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Convert symbolic S_IRUGO and S_IWUSR macros to octal permissions to
fix warnings reported by checkpatch.pl

Signed-off-by: Quentin Swain <dudebrobro179@gmail.com>
---
 drivers/staging/iio/meter/ade7758_core.c | 50 ++++++++++++++++----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 99c89e6..40498af 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -301,103 +301,103 @@ static int ade7758_reset(struct device *dev)
 	return ret;
 }
 
-static IIO_DEV_ATTR_VPEAK(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_VPEAK(0644,
 		ade7758_read_8bit,
 		ade7758_write_8bit,
 		ADE7758_VPEAK);
-static IIO_DEV_ATTR_IPEAK(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_IPEAK(0644,
 		ade7758_read_8bit,
 		ade7758_write_8bit,
 		ADE7758_VPEAK);
-static IIO_DEV_ATTR_APHCAL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_APHCAL(0644,
 		ade7758_read_8bit,
 		ade7758_write_8bit,
 		ADE7758_APHCAL);
-static IIO_DEV_ATTR_BPHCAL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_BPHCAL(0644,
 		ade7758_read_8bit,
 		ade7758_write_8bit,
 		ADE7758_BPHCAL);
-static IIO_DEV_ATTR_CPHCAL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CPHCAL(0644,
 		ade7758_read_8bit,
 		ade7758_write_8bit,
 		ADE7758_CPHCAL);
-static IIO_DEV_ATTR_WDIV(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_WDIV(0644,
 		ade7758_read_8bit,
 		ade7758_write_8bit,
 		ADE7758_WDIV);
-static IIO_DEV_ATTR_VADIV(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_VADIV(0644,
 		ade7758_read_8bit,
 		ade7758_write_8bit,
 		ADE7758_VADIV);
-static IIO_DEV_ATTR_AIRMS(S_IRUGO,
+static IIO_DEV_ATTR_AIRMS(0444,
 		ade7758_read_24bit,
 		NULL,
 		ADE7758_AIRMS);
-static IIO_DEV_ATTR_BIRMS(S_IRUGO,
+static IIO_DEV_ATTR_BIRMS(0444,
 		ade7758_read_24bit,
 		NULL,
 		ADE7758_BIRMS);
-static IIO_DEV_ATTR_CIRMS(S_IRUGO,
+static IIO_DEV_ATTR_CIRMS(0444,
 		ade7758_read_24bit,
 		NULL,
 		ADE7758_CIRMS);
-static IIO_DEV_ATTR_AVRMS(S_IRUGO,
+static IIO_DEV_ATTR_AVRMS(0444,
 		ade7758_read_24bit,
 		NULL,
 		ADE7758_AVRMS);
-static IIO_DEV_ATTR_BVRMS(S_IRUGO,
+static IIO_DEV_ATTR_BVRMS(0444,
 		ade7758_read_24bit,
 		NULL,
 		ADE7758_BVRMS);
-static IIO_DEV_ATTR_CVRMS(S_IRUGO,
+static IIO_DEV_ATTR_CVRMS(0444,
 		ade7758_read_24bit,
 		NULL,
 		ADE7758_CVRMS);
-static IIO_DEV_ATTR_AIRMSOS(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_AIRMSOS(0644,
 		ade7758_read_16bit,
 		ade7758_write_16bit,
 		ADE7758_AIRMSOS);
-static IIO_DEV_ATTR_BIRMSOS(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_BIRMSOS(0644,
 		ade7758_read_16bit,
 		ade7758_write_16bit,
 		ADE7758_BIRMSOS);
-static IIO_DEV_ATTR_CIRMSOS(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CIRMSOS(0644,
 		ade7758_read_16bit,
 		ade7758_write_16bit,
 		ADE7758_CIRMSOS);
-static IIO_DEV_ATTR_AVRMSOS(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_AVRMSOS(0644,
 		ade7758_read_16bit,
 		ade7758_write_16bit,
 		ADE7758_AVRMSOS);
-static IIO_DEV_ATTR_BVRMSOS(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_BVRMSOS(0644,
 		ade7758_read_16bit,
 		ade7758_write_16bit,
 		ADE7758_BVRMSOS);
-static IIO_DEV_ATTR_CVRMSOS(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CVRMSOS(0644,
 		ade7758_read_16bit,
 		ade7758_write_16bit,
 		ADE7758_CVRMSOS);
-static IIO_DEV_ATTR_AIGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_AIGAIN(0644,
 		ade7758_read_16bit,
 		ade7758_write_16bit,
 		ADE7758_AIGAIN);
-static IIO_DEV_ATTR_BIGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_BIGAIN(0644,
 		ade7758_read_16bit,
 		ade7758_write_16bit,
 		ADE7758_BIGAIN);
-static IIO_DEV_ATTR_CIGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CIGAIN(0644,
 		ade7758_read_16bit,
 		ade7758_write_16bit,
 		ADE7758_CIGAIN);
-static IIO_DEV_ATTR_AVRMSGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_AVRMSGAIN(0644,
 		ade7758_read_16bit,
 		ade7758_write_16bit,
 		ADE7758_AVRMSGAIN);
-static IIO_DEV_ATTR_BVRMSGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_BVRMSGAIN(0644,
 		ade7758_read_16bit,
 		ade7758_write_16bit,
 		ADE7758_BVRMSGAIN);
-static IIO_DEV_ATTR_CVRMSGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CVRMSGAIN(0644,
 		ade7758_read_16bit,
 		ade7758_write_16bit,
 		ADE7758_CVRMSGAIN);
-- 
2.10.2

