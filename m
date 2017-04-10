Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34667 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbdDJUUZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Apr 2017 16:20:25 -0400
Received: by mail-wr0-f195.google.com with SMTP id u18so22648421wrc.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2017 13:20:24 -0700 (PDT)
From: Nikola Jelic <nikola.jelic83@gmail.com>
To: jic23@kernel.org, gregkh@linuxfoundation.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, pmeerw@pmeerw.net
Subject: [PATCH] iio: meter: fix indentation and spacing errors
Date: Mon, 10 Apr 2017 22:19:58 +0200
Message-Id: <20170410201958.3816-1-nikola.jelic83@gmail.com>
In-Reply-To: <86c75d65-09e0-70ac-177b-c2ddea4478da@kernel.org>
References: <86c75d65-09e0-70ac-177b-c2ddea4478da@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A lot of function declarations and calls had wrong indentations for the
arguments. Also, there were unnecessary spaces after casts and within
pointer arguments, such as "int * name", etc.

Signed-off-by: Nikola Jelic <nikola.jelic83@gmail.com>
---
 drivers/staging/iio/meter/ade7759.c | 177 +++++++++++++++---------------------
 1 file changed, 73 insertions(+), 104 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 0b65f1847510..0943ccdeda59 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -65,15 +65,13 @@
  * @rx:			receive buffer
  **/
 struct ade7759_state {
-	struct spi_device	*us;
-	struct mutex		buf_lock;
-	u8			tx[ADE7759_MAX_TX] ____cacheline_aligned;
-	u8			rx[ADE7759_MAX_RX];
+	struct spi_device *us;
+	struct mutex buf_lock;
+	u8 tx[ADE7759_MAX_TX] ____cacheline_aligned;
+	u8 rx[ADE7759_MAX_RX];
 };
 
-static int ade7759_spi_write_reg_8(struct device *dev,
-		u8 reg_address,
-		u8 val)
+static int ade7759_spi_write_reg_8(struct device *dev, u8 reg_address, u8 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -90,8 +88,7 @@ static int ade7759_spi_write_reg_8(struct device *dev,
 }
 
 static int ade7759_spi_write_reg_16(struct device *dev,
-		u8 reg_address,
-		u16 value)
+				    u8 reg_address, u16 value)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
@@ -107,9 +104,7 @@ static int ade7759_spi_write_reg_16(struct device *dev,
 	return ret;
 }
 
-static int ade7759_spi_read_reg_8(struct device *dev,
-		u8 reg_address,
-		u8 *val)
+static int ade7759_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7759_state *st = iio_priv(indio_dev);
@@ -117,8 +112,9 @@ static int ade7759_spi_read_reg_8(struct device *dev,
 
 	ret = spi_w8r8(st->us, ADE7759_READ_REG(reg_address));
 	if (ret < 0) {
-		dev_err(&st->us->dev, "problem when reading 8 bit register 0x%02X",
-				reg_address);
+		dev_err(&st->us->dev,
+			"problem when reading 8 bit register 0x%02X",
+			reg_address);
 		return ret;
 	}
 	*val = ret;
@@ -127,8 +123,7 @@ static int ade7759_spi_read_reg_8(struct device *dev,
 }
 
 static int ade7759_spi_read_reg_16(struct device *dev,
-		u8 reg_address,
-		u16 *val)
+				   u8 reg_address, u16 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7759_state *st = iio_priv(indio_dev);
@@ -136,7 +131,8 @@ static int ade7759_spi_read_reg_16(struct device *dev,
 
 	ret = spi_w8r16be(st->us, ADE7759_READ_REG(reg_address));
 	if (ret < 0) {
-		dev_err(&st->us->dev, "problem when reading 16 bit register 0x%02X",
+		dev_err(&st->us->dev,
+			"problem when reading 16 bit register 0x%02X",
 			reg_address);
 		return ret;
 	}
@@ -147,19 +143,18 @@ static int ade7759_spi_read_reg_16(struct device *dev,
 }
 
 static int ade7759_spi_read_reg_40(struct device *dev,
-		u8 reg_address,
-		u64 *val)
+				   u8 reg_address, u64 *val)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7759_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
-			.tx_buf = st->tx,
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 6,
-		},
+		 .tx_buf = st->tx,
+		 .rx_buf = st->rx,
+		 .bits_per_word = 8,
+		 .len = 6,
+		 },
 	};
 
 	mutex_lock(&st->buf_lock);
@@ -168,21 +163,21 @@ static int ade7759_spi_read_reg_40(struct device *dev,
 
 	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
 	if (ret) {
-		dev_err(&st->us->dev, "problem when reading 40 bit register 0x%02X",
-				reg_address);
+		dev_err(&st->us->dev,
+			"problem when reading 40 bit register 0x%02X",
+			reg_address);
 		goto error_ret;
 	}
 	*val = ((u64)st->rx[1] << 32) | (st->rx[2] << 24) |
-		(st->rx[3] << 16) | (st->rx[4] << 8) | st->rx[5];
+	    (st->rx[3] << 16) | (st->rx[4] << 8) | st->rx[5];
 
-error_ret:
+ error_ret:
 	mutex_unlock(&st->buf_lock);
 	return ret;
 }
 
 static ssize_t ade7759_read_8bit(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				 struct device_attribute *attr, char *buf)
 {
 	int ret;
 	u8 val = 0;
@@ -196,8 +191,7 @@ static ssize_t ade7759_read_8bit(struct device *dev,
 }
 
 static ssize_t ade7759_read_16bit(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				  struct device_attribute *attr, char *buf)
 {
 	int ret;
 	u16 val = 0;
@@ -211,8 +205,7 @@ static ssize_t ade7759_read_16bit(struct device *dev,
 }
 
 static ssize_t ade7759_read_40bit(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				  struct device_attribute *attr, char *buf)
 {
 	int ret;
 	u64 val = 0;
@@ -226,9 +219,8 @@ static ssize_t ade7759_read_40bit(struct device *dev,
 }
 
 static ssize_t ade7759_write_8bit(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
@@ -239,14 +231,13 @@ static ssize_t ade7759_write_8bit(struct device *dev,
 		goto error_ret;
 	ret = ade7759_spi_write_reg_8(dev, this_attr->address, val);
 
-error_ret:
+ error_ret:
 	return ret ? ret : len;
 }
 
 static ssize_t ade7759_write_16bit(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
@@ -257,7 +248,7 @@ static ssize_t ade7759_write_16bit(struct device *dev,
 		goto error_ret;
 	ret = ade7759_spi_write_reg_16(dev, this_attr->address, val);
 
-error_ret:
+ error_ret:
 	return ret ? ret : len;
 }
 
@@ -266,65 +257,48 @@ static int ade7759_reset(struct device *dev)
 	int ret;
 	u16 val;
 
-	ret = ade7759_spi_read_reg_16(dev,
-			ADE7759_MODE,
-			&val);
+	ret = ade7759_spi_read_reg_16(dev, ADE7759_MODE, &val);
 	if (ret < 0)
 		return ret;
 
-	val |= BIT(6); /* Software Chip Reset */
-	return ade7759_spi_write_reg_16(dev,
-			ADE7759_MODE,
-			val);
+	val |= BIT(6);		/* Software Chip Reset */
+	return ade7759_spi_write_reg_16(dev, ADE7759_MODE, val);
 }
 
 static IIO_DEV_ATTR_AENERGY(ade7759_read_40bit, ADE7759_AENERGY);
 static IIO_DEV_ATTR_CFDEN(S_IWUSR | S_IRUGO,
-		ade7759_read_16bit,
-		ade7759_write_16bit,
-		ADE7759_CFDEN);
+			  ade7759_read_16bit,
+			  ade7759_write_16bit, ADE7759_CFDEN);
 static IIO_DEV_ATTR_CFNUM(S_IWUSR | S_IRUGO,
-		ade7759_read_8bit,
-		ade7759_write_8bit,
-		ADE7759_CFNUM);
+			  ade7759_read_8bit, ade7759_write_8bit, ADE7759_CFNUM);
 static IIO_DEV_ATTR_CHKSUM(ade7759_read_8bit, ADE7759_CHKSUM);
 static IIO_DEV_ATTR_PHCAL(S_IWUSR | S_IRUGO,
-		ade7759_read_16bit,
-		ade7759_write_16bit,
-		ADE7759_PHCAL);
+			  ade7759_read_16bit,
+			  ade7759_write_16bit, ADE7759_PHCAL);
 static IIO_DEV_ATTR_APOS(S_IWUSR | S_IRUGO,
-		ade7759_read_16bit,
-		ade7759_write_16bit,
-		ADE7759_APOS);
+			 ade7759_read_16bit, ade7759_write_16bit, ADE7759_APOS);
 static IIO_DEV_ATTR_SAGCYC(S_IWUSR | S_IRUGO,
-		ade7759_read_8bit,
-		ade7759_write_8bit,
-		ADE7759_SAGCYC);
+			   ade7759_read_8bit,
+			   ade7759_write_8bit, ADE7759_SAGCYC);
 static IIO_DEV_ATTR_SAGLVL(S_IWUSR | S_IRUGO,
-		ade7759_read_8bit,
-		ade7759_write_8bit,
-		ADE7759_SAGLVL);
+			   ade7759_read_8bit,
+			   ade7759_write_8bit, ADE7759_SAGLVL);
 static IIO_DEV_ATTR_LINECYC(S_IWUSR | S_IRUGO,
-		ade7759_read_8bit,
-		ade7759_write_8bit,
-		ADE7759_LINECYC);
+			    ade7759_read_8bit,
+			    ade7759_write_8bit, ADE7759_LINECYC);
 static IIO_DEV_ATTR_LENERGY(ade7759_read_40bit, ADE7759_LENERGY);
 static IIO_DEV_ATTR_PGA_GAIN(S_IWUSR | S_IRUGO,
-		ade7759_read_8bit,
-		ade7759_write_8bit,
-		ADE7759_GAIN);
+			     ade7759_read_8bit,
+			     ade7759_write_8bit, ADE7759_GAIN);
 static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(S_IWUSR | S_IRUGO,
-		ade7759_read_16bit,
-		ade7759_write_16bit,
-		ADE7759_APGAIN);
+				      ade7759_read_16bit,
+				      ade7759_write_16bit, ADE7759_APGAIN);
 static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
-		ade7759_read_8bit,
-		ade7759_write_8bit,
-		ADE7759_CH1OS);
+			   ade7759_read_8bit,
+			   ade7759_write_8bit, ADE7759_CH1OS);
 static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
-		ade7759_read_8bit,
-		ade7759_write_8bit,
-		ADE7759_CH2OS);
+			   ade7759_read_8bit,
+			   ade7759_write_8bit, ADE7759_CH2OS);
 
 static int ade7759_set_irq(struct device *dev, bool enable)
 {
@@ -336,15 +310,15 @@ static int ade7759_set_irq(struct device *dev, bool enable)
 		goto error_ret;
 
 	if (enable)
-		irqen |= BIT(3); /* Enables an interrupt when a data is
-				  * present in the waveform register
-				  */
+		irqen |= BIT(3);	/* Enables an interrupt when a data is
+					 * present in the waveform register
+					 */
 	else
 		irqen &= ~BIT(3);
 
 	ret = ade7759_spi_write_reg_8(dev, ADE7759_IRQEN, irqen);
 
-error_ret:
+ error_ret:
 	return ret;
 }
 
@@ -354,16 +328,14 @@ static int ade7759_stop_device(struct device *dev)
 	int ret;
 	u16 val;
 
-	ret = ade7759_spi_read_reg_16(dev,
-			ADE7759_MODE,
-			&val);
+	ret = ade7759_spi_read_reg_16(dev, ADE7759_MODE, &val);
 	if (ret < 0) {
 		dev_err(dev, "unable to power down the device, error: %d\n",
 			ret);
 		return ret;
 	}
 
-	val |= BIT(4);  /* AD converters can be turned off */
+	val |= BIT(4);		/* AD converters can be turned off */
 
 	return ade7759_spi_write_reg_16(dev, ADE7759_MODE, val);
 }
@@ -388,21 +360,18 @@ static int ade7759_initial_setup(struct iio_dev *indio_dev)
 	ade7759_reset(dev);
 	usleep_range(ADE7759_STARTUP_DELAY, ADE7759_STARTUP_DELAY + 100);
 
-err_ret:
+ err_ret:
 	return ret;
 }
 
 static ssize_t ade7759_read_frequency(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				      struct device_attribute *attr, char *buf)
 {
 	int ret;
 	u16 t;
 	int sps;
 
-	ret = ade7759_spi_read_reg_16(dev,
-			ADE7759_MODE,
-			&t);
+	ret = ade7759_spi_read_reg_16(dev, ADE7759_MODE, &t);
 	if (ret)
 		return ret;
 
@@ -413,9 +382,8 @@ static ssize_t ade7759_read_frequency(struct device *dev,
 }
 
 static ssize_t ade7759_write_frequency(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ade7759_state *st = iio_priv(indio_dev);
@@ -449,18 +417,18 @@ static ssize_t ade7759_write_frequency(struct device *dev,
 
 	ret = ade7759_spi_write_reg_16(dev, ADE7759_MODE, reg);
 
-out:
+ out:
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
 }
+
 static IIO_DEV_ATTR_TEMP_RAW(ade7759_read_8bit);
 static IIO_CONST_ATTR(in_temp_offset, "70 C");
 static IIO_CONST_ATTR(in_temp_scale, "1 C");
 
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-		ade7759_read_frequency,
-		ade7759_write_frequency);
+			      ade7759_read_frequency, ade7759_write_frequency);
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("27900 14000 7000 3500");
 
@@ -537,11 +505,12 @@ static int ade7759_remove(struct spi_device *spi)
 
 static struct spi_driver ade7759_driver = {
 	.driver = {
-		.name = "ade7759",
-	},
+		   .name = "ade7759",
+		   },
 	.probe = ade7759_probe,
 	.remove = ade7759_remove,
 };
+
 module_spi_driver(ade7759_driver);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-- 
2.11.0

