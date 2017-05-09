Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33561 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdEIXl7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 May 2017 19:41:59 -0400
From: Harinath Nampally <harinath922@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] staging: iio: meter: Fix the identations for proper alignments.
Date: Tue,  9 May 2017 19:41:53 -0400
Message-Id: <39df9167707c234aeed4825e5aded97056d565c5.1494370925.git.harinath922@gmail.com>
In-Reply-To: <cover.1494370925.git.harinath922@gmail.com>
References: <20170509074617.x6bdqs7innxhrude@mwanda>
 <cover.1494370925.git.harinath922@gmail.com>
In-Reply-To: <cover.1494370925.git.harinath922@gmail.com>
References: <cover.1494370925.git.harinath922@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes below checkpatch.pl kind of warnings:
CHECK: Alignment should match open parenthesis

Signed-off-by: Harinath Nampally <harinath922@gmail.com>
---
Changes in v2:
 - None because only [PATCH v2 1/3] has improvement

 drivers/staging/iio/meter/ade7753.c | 55 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index cffe6bf..5d45a68 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -108,9 +108,8 @@ static int ade7753_spi_write_reg_8(struct device *dev,
 	return ret;
 }
 
-static int ade7753_spi_write_reg_16(struct device *dev,
-		u8 reg_address,
-		u16 value)
+static int ade7753_spi_write_reg_16(struct device *dev, u8 reg_address,
+				    u16 value)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -127,8 +126,8 @@ static int ade7753_spi_write_reg_16(struct device *dev,
 }
 
 static int ade7753_spi_read_reg_8(struct device *dev,
-		u8 reg_address,
-		u8 *val)
+				  u8 reg_address,
+				  u8 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7753_state *st = iio_priv(indio_dev);
@@ -137,7 +136,7 @@ static int ade7753_spi_read_reg_8(struct device *dev,
 	ret = spi_w8r8(st->us, ADE7753_READ_REG(reg_address));
 	if (ret < 0) {
 		dev_err(&st->us->dev, "problem when reading 8 bit register 0x%02X",
-				reg_address);
+			reg_address);
 		return ret;
 	}
 	*val = ret;
@@ -146,8 +145,8 @@ static int ade7753_spi_read_reg_8(struct device *dev,
 }
 
 static int ade7753_spi_read_reg_16(struct device *dev,
-		u8 reg_address,
-		u16 *val)
+				   u8 reg_address,
+				   u16 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7753_state *st = iio_priv(indio_dev);
@@ -166,8 +165,8 @@ static int ade7753_spi_read_reg_16(struct device *dev,
 }
 
 static int ade7753_spi_read_reg_24(struct device *dev,
-		u8 reg_address,
-		u32 *val)
+				   u8 reg_address,
+				   u32 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7753_state *st = iio_priv(indio_dev);
@@ -190,7 +189,7 @@ static int ade7753_spi_read_reg_24(struct device *dev,
 	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
 		dev_err(&st->us->dev, "problem when reading 24 bit register 0x%02X",
-				reg_address);
+			reg_address);
 		goto error_ret;
 	}
 	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
@@ -201,8 +200,8 @@ static int ade7753_spi_read_reg_24(struct device *dev,
 }
 
 static ssize_t ade7753_read_8bit(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				 struct device_attribute *attr,
+				 char *buf)
 {
 	int ret;
 	u8 val;
@@ -216,8 +215,8 @@ static ssize_t ade7753_read_8bit(struct device *dev,
 }
 
 static ssize_t ade7753_read_16bit(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				  struct device_attribute *attr,
+				  char *buf)
 {
 	int ret;
 	u16 val;
@@ -231,8 +230,8 @@ static ssize_t ade7753_read_16bit(struct device *dev,
 }
 
 static ssize_t ade7753_read_24bit(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				  struct device_attribute *attr,
+				  char *buf)
 {
 	int ret;
 	u32 val;
@@ -246,9 +245,9 @@ static ssize_t ade7753_read_24bit(struct device *dev,
 }
 
 static ssize_t ade7753_write_8bit(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t len)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
@@ -264,9 +263,9 @@ static ssize_t ade7753_write_8bit(struct device *dev,
 }
 
 static ssize_t ade7753_write_16bit(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t len)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
@@ -451,8 +450,8 @@ static int ade7753_initial_setup(struct iio_dev *indio_dev)
 }
 
 static ssize_t ade7753_read_frequency(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				      struct device_attribute *attr,
+				      char *buf)
 {
 	int ret;
 	u16 t;
@@ -469,9 +468,9 @@ static ssize_t ade7753_read_frequency(struct device *dev,
 }
 
 static ssize_t ade7753_write_frequency(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				       struct device_attribute *attr,
+				       const char *buf,
+				       size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7753_state *st = iio_priv(indio_dev);
-- 
2.7.4

