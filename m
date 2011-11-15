Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:dac: Add helper function for formating scale
Date: Tue, 15 Nov 2011 17:30:05 +0100
Message-ID: <1321374605-16626-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

We basically use the same for formating the DACs scale in almost all DAC
drivers. So put this into a common helper function which does the job for us.
The helper function uses 64-bit math to be as accurate as possible to minimize
the error we get when multiplying out_voltage_scale with out_voltage_raw.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5064.c      |   15 ++++++---------
 drivers/staging/iio/dac/ad5360.c      |   15 ++++++---------
 drivers/staging/iio/dac/ad5446.c      |    7 +------
 drivers/staging/iio/dac/ad5504.c      |    7 +------
 drivers/staging/iio/dac/ad5624r_spi.c |    7 +------
 drivers/staging/iio/dac/ad5686.c      |    8 +-------
 drivers/staging/iio/dac/ad5791.c      |    4 +---
 drivers/staging/iio/dac/dac.h         |   24 ++++++++++++++++++++++++
 8 files changed, 41 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index 867e4ab..a3ffb4f 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -281,7 +281,7 @@ static int ad5064_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad5064_state *st = iio_priv(indio_dev);
 	unsigned int vref;
-	int scale_uv;
+	int vref_uv;
 
 	switch (m) {
 	case 0:
@@ -289,14 +289,11 @@ static int ad5064_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		vref = st->chip_info->shared_vref ? 0 : chan->channel;
-		scale_uv = regulator_get_voltage(st->vref_reg[vref].consumer);
-		if (scale_uv < 0)
-			return scale_uv;
-
-		scale_uv = (scale_uv * 100) >> chan->scan_type.realbits;
-		*val =  scale_uv / 100000;
-		*val2 = (scale_uv % 100000) * 10;
-		return IIO_VAL_INT_PLUS_MICRO;
+		vref_uv = regulator_get_voltage(st->vref_reg[vref].consumer);
+		if (vref_uv < 0)
+			return vref_uv;
+
+		return iio_dac_format_scale(vref_uv, chan, val, val2);
 	default:
 		break;
 	}
diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/ad5360.c
index 012d714..8fbd68b 100644
--- a/drivers/staging/iio/dac/ad5360.c
+++ b/drivers/staging/iio/dac/ad5360.c
@@ -372,7 +372,7 @@ static int ad5360_read_raw(struct iio_dev *indio_dev,
 {
 	struct ad5360_state *st = iio_priv(indio_dev);
 	unsigned int ofs_index;
-	int scale_uv;
+	int vref_uv;
 	int ret;
 
 	switch (m) {
@@ -385,14 +385,11 @@ static int ad5360_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* vout = 4 * vref * dac_code */
-		scale_uv = ad5360_get_channel_vref(st, chan->channel) * 4 * 100;
-		if (scale_uv < 0)
-			return scale_uv;
-
-		scale_uv >>= (chan->scan_type.realbits);
-		*val =  scale_uv / 100000;
-		*val2 = (scale_uv % 100000) * 10;
-		return IIO_VAL_INT_PLUS_MICRO;
+		vref_uv = ad5360_get_channel_vref(st, chan->channel) * 4 * 100;
+		if (vref_uv < 0)
+			return vref_uv;
+
+		return iio_dac_format_scale(vref_uv, chan, val, val2);
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = ad5360_read(indio_dev, AD5360_READBACK_OFFSET,
 			chan->address);
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index ef1ad11..6b0fe7f 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -278,15 +278,10 @@ static int ad5446_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
-	unsigned long scale_uv;
 
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
-		scale_uv = (st->vref_mv * 1000) >> chan->scan_type.realbits;
-		*val =  scale_uv / 1000;
-		*val2 = (scale_uv % 1000) * 1000;
-		return IIO_VAL_INT_PLUS_MICRO;
-
+		return iio_dac_format_scale(st->vref_mv * 1000, chan, val, val2);
 	}
 	return -EINVAL;
 }
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index f20a5dc..7021e83 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -77,7 +77,6 @@ static int ad5504_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad5504_state *st = iio_priv(indio_dev);
-	unsigned long scale_uv;
 	int ret;
 
 	switch (m) {
@@ -90,11 +89,7 @@ static int ad5504_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		scale_uv = (st->vref_mv * 1000) >> chan->scan_type.realbits;
-		*val =  scale_uv / 1000;
-		*val2 = (scale_uv % 1000) * 1000;
-		return IIO_VAL_INT_PLUS_MICRO;
-
+		return iio_dac_format_scale(st->vref_mv * 1000, chan, val, val2);
 	}
 	return -EINVAL;
 }
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 6cb00e1..76d6a34 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -99,15 +99,10 @@ static int ad5624r_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad5624r_state *st = iio_priv(indio_dev);
-	unsigned long scale_uv;
 
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
-		scale_uv = (st->vref_mv * 1000) >> chan->scan_type.realbits;
-		*val =  scale_uv / 1000;
-		*val2 = (scale_uv % 1000) * 1000;
-		return IIO_VAL_INT_PLUS_MICRO;
-
+		return iio_dac_format_scale(st->vref_mv * 1000, chan, val, val2);
 	}
 	return -EINVAL;
 }
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index bbaa928..845f79d 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -293,7 +293,6 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
-	unsigned long scale_uv;
 	int ret;
 
 	switch (m) {
@@ -307,12 +306,7 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
-		scale_uv = (st->vref_mv * 100000)
-			>> (chan->scan_type.realbits);
-		*val =  scale_uv / 100000;
-		*val2 = (scale_uv % 100000) * 10;
-		return IIO_VAL_INT_PLUS_MICRO;
-
+		return iio_dac_format_scale(st->vref_mv * 1000, chan, val, val2);
 	}
 	return -EINVAL;
 }
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index 79c4821..462c423 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -238,9 +238,7 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
 		*val >>= chan->scan_type.shift;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		*val2 = (((u64)st->vref_mv) * 1000000ULL) >> chan->scan_type.realbits;
-		return IIO_VAL_INT_PLUS_MICRO;
+		return iio_dac_format_scale(st->vref_mv * 1000, chan, val, val2);
 	case IIO_CHAN_INFO_OFFSET:
 		val64 = (((u64)st->vref_neg_mv) << chan->scan_type.realbits);
 		do_div(val64, st->vref_mv);
diff --git a/drivers/staging/iio/dac/dac.h b/drivers/staging/iio/dac/dac.h
index 0754d71..ad43e2f 100644
--- a/drivers/staging/iio/dac/dac.h
+++ b/drivers/staging/iio/dac/dac.h
@@ -2,5 +2,29 @@
  * dac.h - sysfs attributes associated with DACs
  */
 
+#include <linux/math64.h>
+
 #define IIO_DEV_ATTR_OUT_RAW(_num, _store, _addr)				\
 	IIO_DEVICE_ATTR(out_voltage##_num##_raw, S_IWUSR, NULL, _store, _addr)
+
+/* iio_dac_format_scale: Helper function for formating the scale attribute for a
+ * DAC.
+ *
+ * @vref_span_uv:	span of the reference voltage in microvolts
+ * @chan:			channel to format for
+ * @val:			val of iio raw_write callback
+ * @val2:			val2 of the iio raw_write callback
+ */
+static inline int iio_dac_format_scale(unsigned long vref_span_uv,
+	const struct iio_chan_spec *chan, unsigned int *val, unsigned int *val2)
+{
+	u64 result;
+	u32 _val2;
+
+	result = (((u64)vref_span_uv) * 1000) >> chan->scan_type.realbits;
+
+	*val = div_u64_rem(result, 1000000, &_val2);
+	*val2 = _val2;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
-- 
1.7.7.1
