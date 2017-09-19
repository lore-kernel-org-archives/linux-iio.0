Return-Path: <SRS0=gvug=AU=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 3/4] iio: light: vl6180: Cleanup als_gain lookup, avoid register readback
Date: Tue, 19 Sep 2017 05:11:43 +0200
Message-ID: <20170919031144.4968-4-stefan.bruens@rwth-aachen.de>
In-Reply-To: <20170919031144.4968-1-stefan.bruens@rwth-aachen.de>
References: <20170919031144.4968-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Instead of manually iterating the array of allowed gain values, use
find_closest. Storing the current gain setting avoids accessing the
hardware on each query.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---
 drivers/iio/light/vl6180.c | 85 ++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index ae768c832d66..fcd8ef511bdc 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/delay.h>
+#include <linux/util_macros.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -86,6 +87,7 @@
 struct vl6180_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	unsigned int als_gain_milli;
 	unsigned int als_it_ms;
 };
 
@@ -276,19 +278,17 @@ static const struct iio_chan_spec vl6180_channels[] = {
 };
 
 /*
- * Columns 3 & 4 represent the same value in decimal and hex notations.
- * Kept in order to avoid the datatype conversion while reading the
- * hardware_gain.
+ * Available Ambient Light Sensor gain settings, 1/1000th, and
+ * corresponding setting for the VL6180_ALS_GAIN register
  */
-static const int vl6180_als_gain[8][4] = {
-	{ 1,	0,	70,	VL6180_ALS_GAIN_1 },
-	{ 1,    250000, 69,	VL6180_ALS_GAIN_1_25 },
-	{ 1,    670000, 68,	VL6180_ALS_GAIN_1_67 },
-	{ 2,    500000, 67,	VL6180_ALS_GAIN_2_5 },
-	{ 5,    0,      66,	VL6180_ALS_GAIN_5 },
-	{ 10,   0,      65,	VL6180_ALS_GAIN_10 },
-	{ 20,   0,      64,	VL6180_ALS_GAIN_20 },
-	{ 40,   0,      71,	VL6180_ALS_GAIN_40 }
+static const int vl6180_als_gain_tab[8] = {
+	1000, 1250, 1670, 2500, 5000, 10000, 20000, 40000
+};
+static const u8 vl6180_als_gain_tab_bits[8] = {
+	VL6180_ALS_GAIN_1,    VL6180_ALS_GAIN_1_25,
+	VL6180_ALS_GAIN_1_67, VL6180_ALS_GAIN_2_5,
+	VL6180_ALS_GAIN_5,    VL6180_ALS_GAIN_10,
+	VL6180_ALS_GAIN_20,   VL6180_ALS_GAIN_40
 };
 
 static int vl6180_read_raw(struct iio_dev *indio_dev,
@@ -296,7 +296,7 @@ static int vl6180_read_raw(struct iio_dev *indio_dev,
 				int *val, int *val2, long mask)
 {
 	struct vl6180_data *data = iio_priv(indio_dev);
-	int ret, i;
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -328,17 +328,11 @@ static int vl6180_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_HARDWAREGAIN:
-		ret = vl6180_read_byte(data->client, VL6180_ALS_GAIN);
-		if (ret < 0)
-			return -EINVAL;
-		for (i = 0; i < ARRAY_SIZE(vl6180_als_gain); i++) {
-			if (ret == vl6180_als_gain[i][2]) {
-				*val = vl6180_als_gain[i][0];
-				*val2 = vl6180_als_gain[i][1];
-			}
-		}
+		*val = data->als_gain_milli;
+		*val2 = 1000;
+
+		return IIO_VAL_FRACTIONAL;
 
-		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -364,25 +358,33 @@ static int vl6180_hold(struct vl6180_data *data, bool hold)
 
 static int vl6180_set_als_gain(struct vl6180_data *data, int val, int val2)
 {
-	int i, ret;
-
-	for (i = 0; i < ARRAY_SIZE(vl6180_als_gain); i++) {
-		if (val == vl6180_als_gain[i][0] &&
-			val2 == vl6180_als_gain[i][1]) {
-			mutex_lock(&data->lock);
-			ret = vl6180_hold(data, true);
-			if (ret < 0)
-				goto fail;
-			ret = vl6180_write_byte(data->client, VL6180_ALS_GAIN,
-				vl6180_als_gain[i][3]);
-fail:
-			vl6180_hold(data, false);
-			mutex_unlock(&data->lock);
-			return ret;
-		}
-	}
+	int i, ret, gain;
+
+	if (val < 1 || val > 40)
+		return -EINVAL;
+
+	gain = (val * 1000000 + val2)/1000;
+	if (gain < 1 || gain > 40000)
+		return -EINVAL;
+
+	i = find_closest(gain, vl6180_als_gain_tab,
+			 ARRAY_SIZE(vl6180_als_gain_tab));
+
+	mutex_lock(&data->lock);
+	ret = vl6180_hold(data, true);
+	if (ret < 0)
+		goto fail;
 
-	return -EINVAL;
+	ret = vl6180_write_byte(data->client, VL6180_ALS_GAIN,
+				vl6180_als_gain_tab_bits[i]);
+
+	if (ret >= 0)
+		data->als_gain_milli = vl6180_als_gain_tab[i];
+
+fail:
+	vl6180_hold(data, false);
+	mutex_unlock(&data->lock);
+	return ret;
 }
 
 static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
@@ -480,6 +482,7 @@ static int vl6180_init(struct vl6180_data *data)
 		return ret;
 
 	/* ALS gain: 1 */
+	data->als_gain_milli = 1000;
 	ret = vl6180_write_byte(client, VL6180_ALS_GAIN, VL6180_ALS_GAIN_1);
 	if (ret < 0)
 		return ret;
-- 
2.14.1
