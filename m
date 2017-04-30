Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36415 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2992958AbdD3XRW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 19:17:22 -0400
Received: by mail-qt0-f195.google.com with SMTP id t52so14989391qtb.3
        for <linux-iio@vger.kernel.org>; Sun, 30 Apr 2017 16:17:22 -0700 (PDT)
From: Quentin Swain <dudebrobro179@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        apw@canonical.com, joe@perches.com,
        Quentin Swain <dudebrobro179@gmail.com>
Subject: [PATCH 5/5] iio: ade7854: Convert symbolic permissions to octal
Date: Sun, 30 Apr 2017 19:17:02 -0400
Message-Id: <20170430231702.377-6-dudebrobro179@gmail.com>
In-Reply-To: <20170430231702.377-1-dudebrobro179@gmail.com>
References: <20170430231702.377-1-dudebrobro179@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Convert symbolic S_IRUGO and S_IWUSR macros to octal to fix
warnings reported by checkpatch.pl

Signed-off-by: Quentin Swain <dudebrobro179@gmail.com>
---
 drivers/staging/iio/meter/ade7854.c | 88 ++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index c6cffc1..70612da 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -186,127 +186,127 @@ static int ade7854_reset(struct device *dev)
 	return st->write_reg_16(dev, ADE7854_CONFIG, val);
 }
 
-static IIO_DEV_ATTR_AIGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_AIGAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_AIGAIN);
-static IIO_DEV_ATTR_BIGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_BIGAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_BIGAIN);
-static IIO_DEV_ATTR_CIGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CIGAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_CIGAIN);
-static IIO_DEV_ATTR_NIGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_NIGAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_NIGAIN);
-static IIO_DEV_ATTR_AVGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_AVGAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_AVGAIN);
-static IIO_DEV_ATTR_BVGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_BVGAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_BVGAIN);
-static IIO_DEV_ATTR_CVGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CVGAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_CVGAIN);
-static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_AVAGAIN);
-static IIO_DEV_ATTR_APPARENT_POWER_B_GAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_APPARENT_POWER_B_GAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_BVAGAIN);
-static IIO_DEV_ATTR_APPARENT_POWER_C_GAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_APPARENT_POWER_C_GAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_CVAGAIN);
-static IIO_DEV_ATTR_ACTIVE_POWER_A_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACTIVE_POWER_A_OFFSET(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_AWATTOS);
-static IIO_DEV_ATTR_ACTIVE_POWER_B_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACTIVE_POWER_B_OFFSET(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_BWATTOS);
-static IIO_DEV_ATTR_ACTIVE_POWER_C_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACTIVE_POWER_C_OFFSET(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_CWATTOS);
-static IIO_DEV_ATTR_REACTIVE_POWER_A_GAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_REACTIVE_POWER_A_GAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_AVARGAIN);
-static IIO_DEV_ATTR_REACTIVE_POWER_B_GAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_REACTIVE_POWER_B_GAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_BVARGAIN);
-static IIO_DEV_ATTR_REACTIVE_POWER_C_GAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_REACTIVE_POWER_C_GAIN(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_CVARGAIN);
-static IIO_DEV_ATTR_REACTIVE_POWER_A_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_REACTIVE_POWER_A_OFFSET(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_AVAROS);
-static IIO_DEV_ATTR_REACTIVE_POWER_B_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_REACTIVE_POWER_B_OFFSET(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_BVAROS);
-static IIO_DEV_ATTR_REACTIVE_POWER_C_OFFSET(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_REACTIVE_POWER_C_OFFSET(0644,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
 		ADE7854_CVAROS);
-static IIO_DEV_ATTR_VPEAK(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_VPEAK(0644,
 		ade7854_read_32bit,
 		ade7854_write_32bit,
 		ADE7854_VPEAK);
-static IIO_DEV_ATTR_IPEAK(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_IPEAK(0644,
 		ade7854_read_32bit,
 		ade7854_write_32bit,
 		ADE7854_VPEAK);
-static IIO_DEV_ATTR_APHCAL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_APHCAL(0644,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
 		ADE7854_APHCAL);
-static IIO_DEV_ATTR_BPHCAL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_BPHCAL(0644,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
 		ADE7854_BPHCAL);
-static IIO_DEV_ATTR_CPHCAL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CPHCAL(0644,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
 		ADE7854_CPHCAL);
-static IIO_DEV_ATTR_CF1DEN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CF1DEN(0644,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
 		ADE7854_CF1DEN);
-static IIO_DEV_ATTR_CF2DEN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CF2DEN(0644,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
 		ADE7854_CF2DEN);
-static IIO_DEV_ATTR_CF3DEN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CF3DEN(0644,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
 		ADE7854_CF3DEN);
-static IIO_DEV_ATTR_LINECYC(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_LINECYC(0644,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
 		ADE7854_LINECYC);
-static IIO_DEV_ATTR_SAGCYC(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_SAGCYC(0644,
 		ade7854_read_8bit,
 		ade7854_write_8bit,
 		ADE7854_SAGCYC);
-static IIO_DEV_ATTR_CFCYC(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CFCYC(0644,
 		ade7854_read_8bit,
 		ade7854_write_8bit,
 		ADE7854_CFCYC);
-static IIO_DEV_ATTR_PEAKCYC(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_PEAKCYC(0644,
 		ade7854_read_8bit,
 		ade7854_write_8bit,
 		ADE7854_PEAKCYC);
@@ -318,55 +318,55 @@ static IIO_DEV_ATTR_ANGLE1(ade7854_read_24bit,
 		ADE7854_ANGLE1);
 static IIO_DEV_ATTR_ANGLE2(ade7854_read_24bit,
 		ADE7854_ANGLE2);
-static IIO_DEV_ATTR_AIRMS(S_IRUGO,
+static IIO_DEV_ATTR_AIRMS(0444,
 		ade7854_read_24bit,
 		NULL,
 		ADE7854_AIRMS);
-static IIO_DEV_ATTR_BIRMS(S_IRUGO,
+static IIO_DEV_ATTR_BIRMS(0444,
 		ade7854_read_24bit,
 		NULL,
 		ADE7854_BIRMS);
-static IIO_DEV_ATTR_CIRMS(S_IRUGO,
+static IIO_DEV_ATTR_CIRMS(0444,
 		ade7854_read_24bit,
 		NULL,
 		ADE7854_CIRMS);
-static IIO_DEV_ATTR_NIRMS(S_IRUGO,
+static IIO_DEV_ATTR_NIRMS(0444,
 		ade7854_read_24bit,
 		NULL,
 		ADE7854_NIRMS);
-static IIO_DEV_ATTR_AVRMS(S_IRUGO,
+static IIO_DEV_ATTR_AVRMS(0444,
 		ade7854_read_24bit,
 		NULL,
 		ADE7854_AVRMS);
-static IIO_DEV_ATTR_BVRMS(S_IRUGO,
+static IIO_DEV_ATTR_BVRMS(0444,
 		ade7854_read_24bit,
 		NULL,
 		ADE7854_BVRMS);
-static IIO_DEV_ATTR_CVRMS(S_IRUGO,
+static IIO_DEV_ATTR_CVRMS(0444,
 		ade7854_read_24bit,
 		NULL,
 		ADE7854_CVRMS);
-static IIO_DEV_ATTR_AIRMSOS(S_IRUGO,
+static IIO_DEV_ATTR_AIRMSOS(0444,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
 		ADE7854_AIRMSOS);
-static IIO_DEV_ATTR_BIRMSOS(S_IRUGO,
+static IIO_DEV_ATTR_BIRMSOS(0444,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
 		ADE7854_BIRMSOS);
-static IIO_DEV_ATTR_CIRMSOS(S_IRUGO,
+static IIO_DEV_ATTR_CIRMSOS(0444,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
 		ADE7854_CIRMSOS);
-static IIO_DEV_ATTR_AVRMSOS(S_IRUGO,
+static IIO_DEV_ATTR_AVRMSOS(0444,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
 		ADE7854_AVRMSOS);
-static IIO_DEV_ATTR_BVRMSOS(S_IRUGO,
+static IIO_DEV_ATTR_BVRMSOS(0444,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
 		ADE7854_BVRMSOS);
-static IIO_DEV_ATTR_CVRMSOS(S_IRUGO,
+static IIO_DEV_ATTR_CVRMSOS(0444,
 		ade7854_read_16bit,
 		ade7854_write_16bit,
 		ADE7854_CVRMSOS);
-- 
2.10.2

