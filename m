Return-Path: <karniksayli1995@gmail.com>
Date: Thu, 6 Oct 2016 21:32:17 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH] staging: iio: meter: ade7754: Implement
 IIO_CHAN_INFO_SAMP_FREQ
Message-ID: <20161006160217.GA21538@sayli-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Attributes that were once privately defined become standard with time
and hence a special global define is used. Hence update driver ade7754 to use
IIO_CHAN_INFO_SAMP_FREQ which is a global define instead of
IIO_DEV_ATTR_SAMP_FREQ.
Move functionality from IIO_DEV_ATTR_SAMP_FREQ attribute into
IIO_CHAN_INFO_SAMP_FREQ to implement the sampling_frequency attribute.
Add ade7754_read_raw() and ade7754_write_raw() to allow reading and
writing the element as well.
Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
 drivers/staging/iio/meter/ade7754.c | 155 +++++++++++++++++++++---------------
 1 file changed, 89 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 1730959..8043539 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -395,81 +395,15 @@ err_ret:
 	return ret;
 }
 
-static ssize_t ade7754_read_frequency(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
-{
-	int ret;
-	u8 t;
-	int sps;
-
-	ret = ade7754_spi_read_reg_8(dev, ADE7754_WAVMODE, &t);
-	if (ret)
-		return ret;
-
-	t = (t >> 3) & 0x3;
-	sps = 26000 / (1 + t);
-
-	return sprintf(buf, "%d\n", sps);
-}
-
-static ssize_t ade7754_write_frequency(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf,
-				       size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ade7754_state *st = iio_priv(indio_dev);
-	u16 val;
-	int ret;
-	u8 reg, t;
-
-	ret = kstrtou16(buf, 10, &val);
-	if (ret)
-		return ret;
-	if (!val)
-		return -EINVAL;
-
-	mutex_lock(&indio_dev->mlock);
-
-	t = 26000 / val;
-	if (t > 0)
-		t--;
-
-	if (t > 1)
-		st->us->max_speed_hz = ADE7754_SPI_SLOW;
-	else
-		st->us->max_speed_hz = ADE7754_SPI_FAST;
-
-	ret = ade7754_spi_read_reg_8(dev, ADE7754_WAVMODE, &reg);
-	if (ret)
-		goto out;
-
-	reg &= ~(3 << 3);
-	reg |= t << 3;
-
-	ret = ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
-
-out:
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret ? ret : len;
-}
 static IIO_DEV_ATTR_TEMP_RAW(ade7754_read_8bit);
 static IIO_CONST_ATTR(in_temp_offset, "129 C");
 static IIO_CONST_ATTR(in_temp_scale, "4 C");
-
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-		ade7754_read_frequency,
-		ade7754_write_frequency);
-
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26000 13000 65000 33000");
 
 static struct attribute *ade7754_attributes[] = {
 	&iio_dev_attr_in_temp_raw.dev_attr.attr,
 	&iio_const_attr_in_temp_offset.dev_attr.attr,
 	&iio_const_attr_in_temp_scale.dev_attr.attr,
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_aenergy.dev_attr.attr,
 	&iio_dev_attr_laenergy.dev_attr.attr,
@@ -505,6 +439,93 @@ static struct attribute *ade7754_attributes[] = {
 	NULL,
 };
 
+static int read_raw_samp_freq(struct device *dev, int *val)
+{
+	int ret;
+	u8 t;
+
+	ret = ade7754_spi_read_reg_8(dev, ADE7754_WAVMODE, &t);
+	if (ret)
+		return ret;
+
+	t = (t >> 3) & 0x3;
+	*val = 26000 / (1 + t);
+
+	return 0;
+}
+
+static int write_raw_samp_freq(struct device *dev, int val)
+{
+	struct ade7754_state *st = iio_priv(dev_to_iio_dev(dev));
+	int ret;
+	u8 reg, t;
+
+	if (!val)
+		return -EINVAL;
+
+	t = 26000 / val;
+	if (t > 0)
+		t--;
+
+	if (t > 1)
+		st->us->max_speed_hz = ADE7754_SPI_SLOW;
+	else
+		st->us->max_speed_hz = ADE7754_SPI_FAST;
+
+	ret = ade7754_spi_read_reg_8(dev, ADE7754_WAVMODE, &reg);
+	if (ret)
+		return ret;
+
+	reg &= ~(3 << 3);
+	reg |= t << 3;
+
+	ret = ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
+
+	return ret;
+}
+
+static int ade7754_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2)
+			return -EINVAL;
+		mutex_lock(&indio_dev->mlock);
+		ret = read_raw_samp_freq(&indio_dev->dev, val);
+		mutex_unlock(&indio_dev->mlock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int ade7754_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2)
+			return -EINVAL;
+		mutex_lock(&indio_dev->mlock);
+		ret = write_raw_samp_freq(&indio_dev->dev, val);
+		mutex_unlock(&indio_dev->mlock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static const struct attribute_group ade7754_attribute_group = {
 	.attrs = ade7754_attributes,
 };
@@ -512,6 +533,8 @@ static const struct attribute_group ade7754_attribute_group = {
 static const struct iio_info ade7754_info = {
 	.attrs = &ade7754_attribute_group,
 	.driver_module = THIS_MODULE,
+	.read_raw = &ade7754_read_raw,
+	.write_raw = &ade7754_write_raw,
 };
 
 static int ade7754_probe(struct spi_device *spi)
-- 
2.7.4
