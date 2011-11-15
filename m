Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:4515 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756303Ab1KOPa6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2011 10:30:58 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	Michael Hennerich <michael.hennerich@analog.com>,
	<devel@driverdev.osuosl.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] staging:iio:dac:ad5504: Convert to channel spec
Date: Tue, 15 Nov 2011 16:31:23 +0100
Message-ID: <1321371084-21519-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1321371084-21519-1-git-send-email-lars@metafoo.de>
References: <1321371084-21519-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5504.c |  130 ++++++++++++++++++++-----------------
 drivers/staging/iio/dac/ad5504.h |    5 +-
 2 files changed, 71 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 72040cc..68a43cb 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -22,6 +22,23 @@
 #include "dac.h"
 #include "ad5504.h"
 
+#define AD5504_CHANNEL(_chan) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.output = 1, \
+	.channel = (_chan), \
+	.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT, \
+	.address = AD5504_ADDR_DAC(_chan), \
+	.scan_type = IIO_ST('u', 12, 16, 0), \
+}
+
+static const struct iio_chan_spec ad5504_channels[] = {
+	AD5504_CHANNEL(0),
+	AD5504_CHANNEL(1),
+	AD5504_CHANNEL(2),
+	AD5504_CHANNEL(3),
+};
+
 static int ad5504_spi_write(struct spi_device *spi, u8 addr, u16 val)
 {
 	u16 tmp = cpu_to_be16(AD5504_CMD_WRITE |
@@ -31,13 +48,14 @@ static int ad5504_spi_write(struct spi_device *spi, u8 addr, u16 val)
 	return spi_write(spi, (u8 *)&tmp, 2);
 }
 
-static int ad5504_spi_read(struct spi_device *spi, u8 addr, u16 *val)
+static int ad5504_spi_read(struct spi_device *spi, u8 addr)
 {
 	u16 tmp = cpu_to_be16(AD5504_CMD_READ | AD5504_ADDR(addr));
+	u16 val;
 	int ret;
 	struct spi_transfer	t = {
 			.tx_buf		= &tmp,
-			.rx_buf		= val,
+			.rx_buf		= &val,
 			.len		= 2,
 		};
 	struct spi_message	m;
@@ -46,44 +64,61 @@ static int ad5504_spi_read(struct spi_device *spi, u8 addr, u16 *val)
 	spi_message_add_tail(&t, &m);
 	ret = spi_sync(spi, &m);
 
-	*val = be16_to_cpu(*val) & AD5504_RES_MASK;
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	return be16_to_cpu(val) & AD5504_RES_MASK;
 }
 
-static ssize_t ad5504_write_dac(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t len)
+static int ad5504_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5504_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	long readin;
+	unsigned long scale_uv;
 	int ret;
 
-	ret = strict_strtol(buf, 10, &readin);
-	if (ret)
-		return ret;
+	switch (m) {
+	case 0:
+		ret = ad5504_spi_read(st->spi, chan->address);
+		if (ret < 0)
+			return ret;
 
-	ret = ad5504_spi_write(st->spi, this_attr->address, readin);
-	return ret ? ret : len;
+		*val = ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		scale_uv = (st->vref_mv * 1000) >> chan->scan_type.realbits;
+		*val =  scale_uv / 1000;
+		*val2 = (scale_uv % 1000) * 1000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	}
+	return -EINVAL;
 }
 
-static ssize_t ad5504_read_dac(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static int ad5504_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5504_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
-	u16 val;
 
-	ret = ad5504_spi_read(st->spi, this_attr->address, &val);
-	if (ret)
-		return ret;
+	switch (mask) {
+	case 0:
+		if (val >= (1 << chan->scan_type.realbits) || val < 0)
+			return -EINVAL;
 
-	return sprintf(buf, "%d\n", val);
+		return ad5504_spi_write(st->spi, chan->address, val);
+	default:
+		ret = -EINVAL;
+	}
+
+	return -EINVAL;
 }
 
 static ssize_t ad5504_read_powerdown_mode(struct device *dev,
@@ -158,32 +193,6 @@ static ssize_t ad5504_write_dac_powerdown(struct device *dev,
 	return ret ? ret : len;
 }
 
-static ssize_t ad5504_show_scale(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5504_state *st = iio_priv(indio_dev);
-	/* Corresponds to Vref / 2^(bits) */
-	unsigned int scale_uv = (st->vref_mv * 1000) >> AD5505_BITS;
-
-	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
-}
-static IIO_DEVICE_ATTR(out_voltage_scale, S_IRUGO, ad5504_show_scale, NULL, 0);
-
-#define IIO_DEV_ATTR_OUT_RW_RAW(_num, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(out_voltage##_num##_raw,			\
-			S_IRUGO | S_IWUSR, _show, _store, _addr)
-
-static IIO_DEV_ATTR_OUT_RW_RAW(0, ad5504_read_dac,
-	ad5504_write_dac, AD5504_ADDR_DAC0);
-static IIO_DEV_ATTR_OUT_RW_RAW(1, ad5504_read_dac,
-	ad5504_write_dac, AD5504_ADDR_DAC1);
-static IIO_DEV_ATTR_OUT_RW_RAW(2, ad5504_read_dac,
-	ad5504_write_dac, AD5504_ADDR_DAC2);
-static IIO_DEV_ATTR_OUT_RW_RAW(3, ad5504_read_dac,
-	ad5504_write_dac, AD5504_ADDR_DAC3);
-
 static IIO_DEVICE_ATTR(out_voltage_powerdown_mode, S_IRUGO |
 			S_IWUSR, ad5504_read_powerdown_mode,
 			ad5504_write_powerdown_mode, 0);
@@ -204,17 +213,12 @@ static IIO_DEV_ATTR_DAC_POWERDOWN(3, ad5504_read_dac_powerdown,
 				   ad5504_write_dac_powerdown, 3);
 
 static struct attribute *ad5504_attributes[] = {
-	&iio_dev_attr_out_voltage0_raw.dev_attr.attr,
-	&iio_dev_attr_out_voltage1_raw.dev_attr.attr,
-	&iio_dev_attr_out_voltage2_raw.dev_attr.attr,
-	&iio_dev_attr_out_voltage3_raw.dev_attr.attr,
 	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
 	&iio_dev_attr_out_voltage1_powerdown.dev_attr.attr,
 	&iio_dev_attr_out_voltage2_powerdown.dev_attr.attr,
 	&iio_dev_attr_out_voltage3_powerdown.dev_attr.attr,
 	&iio_dev_attr_out_voltage_powerdown_mode.dev_attr.attr,
 	&iio_const_attr_out_voltage_powerdown_mode_available.dev_attr.attr,
-	&iio_dev_attr_out_voltage_scale.dev_attr.attr,
 	NULL,
 };
 
@@ -223,11 +227,9 @@ static const struct attribute_group ad5504_attribute_group = {
 };
 
 static struct attribute *ad5501_attributes[] = {
-	&iio_dev_attr_out_voltage0_raw.dev_attr.attr,
 	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
 	&iio_dev_attr_out_voltage_powerdown_mode.dev_attr.attr,
 	&iio_const_attr_out_voltage_powerdown_mode_available.dev_attr.attr,
-	&iio_dev_attr_out_voltage_scale.dev_attr.attr,
 	NULL,
 };
 
@@ -262,12 +264,16 @@ static irqreturn_t ad5504_event_handler(int irq, void *private)
 }
 
 static const struct iio_info ad5504_info = {
+	.write_raw = ad5504_write_raw,
+	.read_raw = ad5504_read_raw,
 	.attrs = &ad5504_attribute_group,
 	.event_attrs = &ad5504_ev_attribute_group,
 	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad5501_info = {
+	.write_raw = ad5504_write_raw,
+	.read_raw = ad5504_read_raw,
 	.attrs = &ad5501_attribute_group,
 	.event_attrs = &ad5504_ev_attribute_group,
 	.driver_module = THIS_MODULE,
@@ -308,10 +314,14 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 	st->spi = spi;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(st->spi)->name;
-	if (spi_get_device_id(st->spi)->driver_data == ID_AD5501)
+	if (spi_get_device_id(st->spi)->driver_data == ID_AD5501) {
 		indio_dev->info = &ad5501_info;
-	else
+		indio_dev->num_channels = 1;
+	} else {
 		indio_dev->info = &ad5504_info;
+		indio_dev->num_channels = 4;
+	}
+	indio_dev->channels = ad5504_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (spi->irq) {
diff --git a/drivers/staging/iio/dac/ad5504.h b/drivers/staging/iio/dac/ad5504.h
index 85beb1d..afe0952 100644
--- a/drivers/staging/iio/dac/ad5504.h
+++ b/drivers/staging/iio/dac/ad5504.h
@@ -18,10 +18,7 @@
 
 /* Registers */
 #define AD5504_ADDR_NOOP		0
-#define AD5504_ADDR_DAC0		1
-#define AD5504_ADDR_DAC1		2
-#define AD5504_ADDR_DAC2		3
-#define AD5504_ADDR_DAC3		4
+#define AD5504_ADDR_DAC(x)		((x) + 1)
 #define AD5504_ADDR_ALL_DAC		5
 #define AD5504_ADDR_CTRL		7
 
-- 
1.7.7.1


