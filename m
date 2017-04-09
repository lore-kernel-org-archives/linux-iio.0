Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpbg202.qq.com ([184.105.206.29]:48364 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbdDIEao (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Apr 2017 00:30:44 -0400
From: Chen Guanqiao <chen.chenchacha@foxmail.com>
To: pmeerw@pmeerw.net, jic23@kernel.org
Cc: Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        Chen Guanqiao <chen.chenchacha@foxmail.com>
Subject: [PATCH v3 1/2] iio:meter:ade7759: Removing use of deprecated macros (S_IRUGO, S_IWUSR, S_IXUGO)
Date: Sun,  9 Apr 2017 12:30:26 +0800
Message-Id: <20170409043027.13930-2-chen.chenchacha@foxmail.com>
In-Reply-To: <20170409043027.13930-1-chen.chenchacha@foxmail.com>
References: <260495ce-b068-a5ce-6ec3-a90fdd7e2510@foxmail.com>
 <20170409043027.13930-1-chen.chenchacha@foxmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Removing use of deprecated macros(S_IRUGO, S_IWUSR, S_IXUGO), and replace
with 4 digit octal.

Signed-off-by: Chen Guanqiao <chen.chenchacha@foxmail.com>
---
 drivers/staging/iio/meter/ade7759.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 0b65f1847510..68405046dae3 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -279,41 +279,41 @@ static int ade7759_reset(struct device *dev)
 }
 
 static IIO_DEV_ATTR_AENERGY(ade7759_read_40bit, ADE7759_AENERGY);
-static IIO_DEV_ATTR_CFDEN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CFDEN(0644,
 		ade7759_read_16bit,
 		ade7759_write_16bit,
 		ADE7759_CFDEN);
-static IIO_DEV_ATTR_CFNUM(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CFNUM(0644,
 		ade7759_read_8bit,
 		ade7759_write_8bit,
 		ADE7759_CFNUM);
 static IIO_DEV_ATTR_CHKSUM(ade7759_read_8bit, ADE7759_CHKSUM);
-static IIO_DEV_ATTR_PHCAL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_PHCAL(0644,
 		ade7759_read_16bit,
 		ade7759_write_16bit,
 		ADE7759_PHCAL);
-static IIO_DEV_ATTR_APOS(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_APOS(0644,
 		ade7759_read_16bit,
 		ade7759_write_16bit,
 		ADE7759_APOS);
-static IIO_DEV_ATTR_SAGCYC(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_SAGCYC(0644,
 		ade7759_read_8bit,
 		ade7759_write_8bit,
 		ADE7759_SAGCYC);
-static IIO_DEV_ATTR_SAGLVL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_SAGLVL(0644,
 		ade7759_read_8bit,
 		ade7759_write_8bit,
 		ADE7759_SAGLVL);
-static IIO_DEV_ATTR_LINECYC(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_LINECYC(0644,
 		ade7759_read_8bit,
 		ade7759_write_8bit,
 		ADE7759_LINECYC);
 static IIO_DEV_ATTR_LENERGY(ade7759_read_40bit, ADE7759_LENERGY);
-static IIO_DEV_ATTR_PGA_GAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_PGA_GAIN(0644,
 		ade7759_read_8bit,
 		ade7759_write_8bit,
 		ADE7759_GAIN);
-static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
 		ade7759_read_16bit,
 		ade7759_write_16bit,
 		ADE7759_APGAIN);
@@ -458,7 +458,7 @@ static IIO_DEV_ATTR_TEMP_RAW(ade7759_read_8bit);
 static IIO_CONST_ATTR(in_temp_offset, "70 C");
 static IIO_CONST_ATTR(in_temp_scale, "1 C");
 
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_SAMP_FREQ(0644,
 		ade7759_read_frequency,
 		ade7759_write_frequency);
 
-- 
2.11.0



