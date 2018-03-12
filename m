Return-Path: <SRS0=EG61=GC=analog.com=alexandru.Ardelean@kernel.org>
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <michael.hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] iio: adc: ad7791: implement IIO_CHAN_INFO_SAMP_FREQ
Date: Mon, 12 Mar 2018 14:06:54 +0200
Message-ID: <20180312120654.1806-2-alexandru.ardelean@analog.com>
In-Reply-To: <20180312120654.1806-1-alexandru.ardelean@analog.com>
References: <20180312120654.1806-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Now that the old read/write frequency sysfs attrs have been removed, we
have a clean slate to implement IIO_CHAN_INFO_SAMP_FREQ.

This driver also pre-dates IIO_CHAN_INFO_SAMP_FREQ, and this change
implements this behavior.

The `ad7791_write_raw` would have overlapped quite a bit with the old
read/write frequency functions, making things a bit harder to follow.

Fixes: a13e831fcaa7 ("staging: iio: ad7192: implement
IIO_CHAN_INFO_SAMP_FREQ")

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/ad7791.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 03a5f7d6cb0c..a9ff0695ddf7 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -153,6 +153,17 @@ struct ad7791_state {
 	const struct ad7791_chip_info *info;
 };
 
+static const int ad7791_sample_freq_avail[8][2] = {
+	[AD7791_FILTER_RATE_120] =  { 120, 0 },
+	[AD7791_FILTER_RATE_100] =  { 100, 0 },
+	[AD7791_FILTER_RATE_33_3] = { 33,  300000 },
+	[AD7791_FILTER_RATE_20] =   { 20,  0 },
+	[AD7791_FILTER_RATE_16_6] = { 16,  600000 },
+	[AD7791_FILTER_RATE_16_7] = { 16,  700000 },
+	[AD7791_FILTER_RATE_13_3] = { 13,  300000 },
+	[AD7791_FILTER_RATE_9_5] =  { 9,   500000 },
+};
+
 static struct ad7791_state *ad_sigma_delta_to_ad7791(struct ad_sigma_delta *sd)
 {
 	return container_of(sd, struct ad7791_state, sd);
@@ -202,6 +213,7 @@ static int ad7791_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad7791_state *st = iio_priv(indio_dev);
 	bool unipolar = !!(st->mode & AD7791_MODE_UNIPOLAR);
+	unsigned int rate;
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
@@ -239,11 +251,53 @@ static int ad7791_read_raw(struct iio_dev *indio_dev,
 			*val2 = chan->scan_type.realbits - 1;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		rate = st->filter & AD7791_FILTER_RATE_MASK;
+		*val = ad7791_sample_freq_avail[rate][0];
+		*val2 = ad7791_sample_freq_avail[rate][1];
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 
 	return -EINVAL;
 }
 
+static int ad7791_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+	struct ad7791_state *st = iio_priv(indio_dev);
+	int ret, i;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (i = 0; i < ARRAY_SIZE(ad7791_sample_freq_avail); i++) {
+			if (ad7791_sample_freq_avail[i][0] == val &&
+			    ad7791_sample_freq_avail[i][1] == val2)
+				break;
+		}
+
+		if (i == ARRAY_SIZE(ad7791_sample_freq_avail)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		st->filter &= ~AD7791_FILTER_RATE_MASK;
+		st->filter |= i;
+		ad_sd_write_reg(&st->sd, AD7791_REG_FILTER,
+				sizeof(st->filter),
+				st->filter);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	iio_device_release_direct_mode(indio_dev);
+	return ret;
+}
+
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("120 100 33.3 20 16.7 16.6 13.3 9.5");
 
 static struct attribute *ad7791_attributes[] = {
@@ -257,12 +311,14 @@ static const struct attribute_group ad7791_attribute_group = {
 
 static const struct iio_info ad7791_info = {
 	.read_raw = &ad7791_read_raw,
+	.write_raw = &ad7791_write_raw,
 	.attrs = &ad7791_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
 };
 
 static const struct iio_info ad7791_no_filter_info = {
 	.read_raw = &ad7791_read_raw,
+	.write_raw = &ad7791_write_raw,
 	.validate_trigger = ad_sd_validate_trigger,
 };
 
-- 
2.14.1
