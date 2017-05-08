Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35112 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdEHEQV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2017 00:16:21 -0400
From: Harinath Nampally <harinath922@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: meter: This patch fixes warnings found in ade7753.c
Date: Mon,  8 May 2017 00:16:17 -0400
Message-Id: <1494216977-26852-1-git-send-email-harinath922@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

All below warnings are found and fixed by checkpatch.pl:
CHECK: struct mutex definition without comment
CHECK: Alignment should match open parenthesis
WARNING: Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred.

Below errors are false positives:
ade7753.c:382: ERROR: Use 4 digit octal (0777) not decimal permissions
ade7753.c:386: ERROR: Use 4 digit octal (0777) not decimal permissions

Signed-off-by: Harinath Nampally <harinath922@gmail.com>
---
 drivers/staging/iio/meter/ade7753.c | 104 ++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index b71fbd3..2534bd0 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -78,12 +78,13 @@
 /**
  * struct ade7753_state - device instance specific data
  * @us:         actual spi_device
+ * @buf_lock:       mutex to protect tx and rx
  * @tx:         transmit buffer
  * @rx:         receive buffer
- * @buf_lock:       mutex to protect tx and rx
  **/
 struct ade7753_state {
 	struct spi_device   *us;
+ /* mutex to protect tx and rx */
 	struct mutex        buf_lock;
 	u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
 	u8          rx[ADE7753_MAX_RX];
@@ -107,9 +108,8 @@ static int ade7753_spi_write_reg_8(struct device *dev,
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
@@ -126,8 +126,8 @@ static int ade7753_spi_write_reg_16(struct device *dev,
 }
 
 static int ade7753_spi_read_reg_8(struct device *dev,
-		u8 reg_address,
-		u8 *val)
+				  u8 reg_address,
+				  u8 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7753_state *st = iio_priv(indio_dev);
@@ -136,7 +136,7 @@ static int ade7753_spi_read_reg_8(struct device *dev,
 	ret = spi_w8r8(st->us, ADE7753_READ_REG(reg_address));
 	if (ret < 0) {
 		dev_err(&st->us->dev, "problem when reading 8 bit register 0x%02X",
-				reg_address);
+			reg_address);
 		return ret;
 	}
 	*val = ret;
@@ -145,8 +145,8 @@ static int ade7753_spi_read_reg_8(struct device *dev,
 }
 
 static int ade7753_spi_read_reg_16(struct device *dev,
-		u8 reg_address,
-		u16 *val)
+				   u8 reg_address,
+				   u16 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7753_state *st = iio_priv(indio_dev);
@@ -165,8 +165,8 @@ static int ade7753_spi_read_reg_16(struct device *dev,
 }
 
 static int ade7753_spi_read_reg_24(struct device *dev,
-		u8 reg_address,
-		u32 *val)
+				   u8 reg_address,
+				   u32 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7753_state *st = iio_priv(indio_dev);
@@ -189,7 +189,7 @@ static int ade7753_spi_read_reg_24(struct device *dev,
 	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
 		dev_err(&st->us->dev, "problem when reading 24 bit register 0x%02X",
-				reg_address);
+			reg_address);
 		goto error_ret;
 	}
 	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
@@ -200,8 +200,8 @@ static int ade7753_spi_read_reg_24(struct device *dev,
 }
 
 static ssize_t ade7753_read_8bit(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				 struct device_attribute *attr,
+				 char *buf)
 {
 	int ret;
 	u8 val;
@@ -215,8 +215,8 @@ static ssize_t ade7753_read_8bit(struct device *dev,
 }
 
 static ssize_t ade7753_read_16bit(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				  struct device_attribute *attr,
+				  char *buf)
 {
 	int ret;
 	u16 val;
@@ -230,8 +230,8 @@ static ssize_t ade7753_read_16bit(struct device *dev,
 }
 
 static ssize_t ade7753_read_24bit(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				  struct device_attribute *attr,
+				  char *buf)
 {
 	int ret;
 	u32 val;
@@ -245,9 +245,9 @@ static ssize_t ade7753_read_24bit(struct device *dev,
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
@@ -263,9 +263,9 @@ static ssize_t ade7753_write_8bit(struct device *dev,
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
@@ -298,92 +298,92 @@ static IIO_DEV_ATTR_AENERGY(ade7753_read_24bit, ADE7753_AENERGY);
 static IIO_DEV_ATTR_LAENERGY(ade7753_read_24bit, ADE7753_LAENERGY);
 static IIO_DEV_ATTR_VAENERGY(ade7753_read_24bit, ADE7753_VAENERGY);
 static IIO_DEV_ATTR_LVAENERGY(ade7753_read_24bit, ADE7753_LVAENERGY);
-static IIO_DEV_ATTR_CFDEN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CFDEN(0644,
 		ade7753_read_16bit,
 		ade7753_write_16bit,
 		ADE7753_CFDEN);
-static IIO_DEV_ATTR_CFNUM(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CFNUM(0644,
 		ade7753_read_8bit,
 		ade7753_write_8bit,
 		ADE7753_CFNUM);
 static IIO_DEV_ATTR_CHKSUM(ade7753_read_8bit, ADE7753_CHKSUM);
-static IIO_DEV_ATTR_PHCAL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_PHCAL(0644,
 		ade7753_read_16bit,
 		ade7753_write_16bit,
 		ADE7753_PHCAL);
-static IIO_DEV_ATTR_APOS(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_APOS(0644,
 		ade7753_read_16bit,
 		ade7753_write_16bit,
 		ADE7753_APOS);
-static IIO_DEV_ATTR_SAGCYC(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_SAGCYC(0644,
 		ade7753_read_8bit,
 		ade7753_write_8bit,
 		ADE7753_SAGCYC);
-static IIO_DEV_ATTR_SAGLVL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_SAGLVL(0644,
 		ade7753_read_8bit,
 		ade7753_write_8bit,
 		ADE7753_SAGLVL);
-static IIO_DEV_ATTR_LINECYC(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_LINECYC(0644,
 		ade7753_read_8bit,
 		ade7753_write_8bit,
 		ADE7753_LINECYC);
-static IIO_DEV_ATTR_WDIV(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_WDIV(0644,
 		ade7753_read_8bit,
 		ade7753_write_8bit,
 		ADE7753_WDIV);
-static IIO_DEV_ATTR_IRMS(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_IRMS(0644,
 		ade7753_read_24bit,
 		NULL,
 		ADE7753_IRMS);
-static IIO_DEV_ATTR_VRMS(S_IRUGO,
+static IIO_DEV_ATTR_VRMS(0444,
 		ade7753_read_24bit,
 		NULL,
 		ADE7753_VRMS);
-static IIO_DEV_ATTR_IRMSOS(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_IRMSOS(0644,
 		ade7753_read_16bit,
 		ade7753_write_16bit,
 		ADE7753_IRMSOS);
-static IIO_DEV_ATTR_VRMSOS(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_VRMSOS(0644,
 		ade7753_read_16bit,
 		ade7753_write_16bit,
 		ADE7753_VRMSOS);
-static IIO_DEV_ATTR_WGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_WGAIN(0644,
 		ade7753_read_16bit,
 		ade7753_write_16bit,
 		ADE7753_WGAIN);
-static IIO_DEV_ATTR_VAGAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_VAGAIN(0644,
 		ade7753_read_16bit,
 		ade7753_write_16bit,
 		ADE7753_VAGAIN);
-static IIO_DEV_ATTR_PGA_GAIN(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_PGA_GAIN(0644,
 		ade7753_read_16bit,
 		ade7753_write_16bit,
 		ADE7753_GAIN);
-static IIO_DEV_ATTR_IPKLVL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_IPKLVL(0644,
 		ade7753_read_8bit,
 		ade7753_write_8bit,
 		ADE7753_IPKLVL);
-static IIO_DEV_ATTR_VPKLVL(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_VPKLVL(0644,
 		ade7753_read_8bit,
 		ade7753_write_8bit,
 		ADE7753_VPKLVL);
-static IIO_DEV_ATTR_IPEAK(S_IRUGO,
+static IIO_DEV_ATTR_IPEAK(0444,
 		ade7753_read_24bit,
 		NULL,
 		ADE7753_IPEAK);
-static IIO_DEV_ATTR_VPEAK(S_IRUGO,
+static IIO_DEV_ATTR_VPEAK(0444,
 		ade7753_read_24bit,
 		NULL,
 		ADE7753_VPEAK);
-static IIO_DEV_ATTR_VPERIOD(S_IRUGO,
+static IIO_DEV_ATTR_VPERIOD(0444,
 		ade7753_read_16bit,
 		NULL,
 		ADE7753_PERIOD);
-static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CH_OFF(1, 0644,
 		ade7753_read_8bit,
 		ade7753_write_8bit,
 		ADE7753_CH1OS);
-static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_CH_OFF(2, 0644,
 		ade7753_read_8bit,
 		ade7753_write_8bit,
 		ADE7753_CH2OS);
@@ -450,8 +450,8 @@ static int ade7753_initial_setup(struct iio_dev *indio_dev)
 }
 
 static ssize_t ade7753_read_frequency(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				      struct device_attribute *attr,
+				      char *buf)
 {
 	int ret;
 	u16 t;
@@ -468,9 +468,9 @@ static ssize_t ade7753_read_frequency(struct device *dev,
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
@@ -514,7 +514,7 @@ static IIO_DEV_ATTR_TEMP_RAW(ade7753_read_8bit);
 static IIO_CONST_ATTR(in_temp_offset, "-25 C");
 static IIO_CONST_ATTR(in_temp_scale, "0.67 C");
 
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+static IIO_DEV_ATTR_SAMP_FREQ(0644,
 		ade7753_read_frequency,
 		ade7753_write_frequency);
 
-- 
2.7.4

