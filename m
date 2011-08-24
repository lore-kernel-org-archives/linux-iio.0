Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 3/5] iio: ad7152: update scale handling
Date: Wed, 24 Aug 2011 14:45:54 +0200
Message-ID: <1314189956-26511-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314189956-26511-1-git-send-email-michael.hennerich@analog.com>
References: <1314189956-26511-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Add scale_available attribute.
fix ad7152_scale_table, values are not sorted descending.
Use IIO_VAL_INT_PLUS_NANO, to increase granularity.
Update scale handling accordingly.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7152.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index 0f653f5..d3ffcdf 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -190,12 +190,16 @@ static IIO_DEV_ATTR_FILTER_RATE_SETUP(S_IRUGO | S_IWUSR,
 		ad7152_show_filter_rate_setup,
 		ad7152_store_filter_rate_setup);
 
+static IIO_CONST_ATTR(in_capacitance_scale_available,
+		      "0.000061050 0.000030525 0.000015263 0.000007631");
+
 static struct attribute *ad7152_attributes[] = {
 	&iio_dev_attr_filter_rate_setup.dev_attr.attr,
 	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
 	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
 	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
 	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
+	&iio_const_attr_in_capacitance_scale_available.dev_attr.attr,
 	NULL,
 };
 
@@ -210,9 +214,9 @@ static const u8 ad7152_addresses[][4] = {
 	  AD7152_REG_CH2_GAIN_HIGH, AD7152_REG_CH2_SETUP },
 };
 
-/* Values are micro relative to pf base. */
+/* Values are nano relative to pf base. */
 static const int ad7152_scale_table[] = {
-	488, 244, 122, 61
+	30525, 7631, 15263, 61050
 };
 
 static int ad7152_write_raw(struct iio_dev *dev_info,
@@ -253,7 +257,7 @@ static int ad7152_write_raw(struct iio_dev *dev_info,
 		if (val != 0)
 			return -EINVAL;
 		for (i = 0; i < ARRAY_SIZE(ad7152_scale_table); i++)
-			if (val2 <= ad7152_scale_table[i])
+			if (val2 == ad7152_scale_table[i])
 				break;
 
 		chip->setup[chan->channel] &= ~AD7152_SETUP_RANGE_4pF;
@@ -345,15 +349,29 @@ static int ad7152_read_raw(struct iio_dev *dev_info,
 		*val = 0;
 		*val2 = ad7152_scale_table[ret >> 6];
 
-		return IIO_VAL_INT_PLUS_MICRO;
+		return IIO_VAL_INT_PLUS_NANO;
 	default:
 		return -EINVAL;
 	};
 }
+
+static int ad7152_write_raw_get_fmt(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       long mask)
+{
+	switch (mask) {
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
 static const struct iio_info ad7152_info = {
 	.attrs = &ad7152_attribute_group,
 	.read_raw = &ad7152_read_raw,
 	.write_raw = &ad7152_write_raw,
+	.write_raw_get_fmt = &ad7152_write_raw_get_fmt,
 	.driver_module = THIS_MODULE,
 };
 
-- 
1.7.0.4
