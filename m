Return-Path: <cmo@melexis.com>
From: Crt Mori <cmo@melexis.com>
To: Vianney le Clement de Saint-Marcq <vianney.leclement@essensium.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Crt Mori <cmo@melexis.com>
Subject: [PATCH v2] iio: mlx90614: Implement filter configuration
Date: Thu, 13 Aug 2015 11:23:55 +0200
Message-Id: <1439457835-13521-1-git-send-email-cmo@melexis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Implemented Low pass 3db frequency filter which configures
FIR and IIR values within the configuration register of EEPROM.
For more standardized interface we have fixed the FIR value
to 1024, while changes in IIR value are directly connected to
filter responses. The new datasheet version will provide a
simplified table (also in reStructured text format below) with
this change, to provide quick overview of possible settings.

Below sensor timings (bandwidth) are calculated for 3db frequency
low pass filter.

+--------------------+-----------------+
| Filter setting (%) | Band width (Hz) |
|  (rounded to 1.0)  |                 |
+====================+=================+
|         13         |      0.15       |
+--------------------+-----------------+
|         17         |      0.20       |
+--------------------+-----------------+
|         25         |      0.31       |
+--------------------+-----------------+
|         50         |      0.77       |
+--------------------+-----------------+
|         57         |      0.86       |
+--------------------+-----------------+
|         67         |      1.10       |
+--------------------+-----------------+
|         80         |      1.53       |
+--------------------+-----------------+
|        100         |      7.23       |
+--------------------+-----------------+

The diff is made towards togreg branch. Added myself to MAINTAINERS and
authors as per discussion with Jonathan.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 MAINTAINERS                        |  7 ++++
 drivers/iio/temperature/mlx90614.c | 79 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8133cef..f658890 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6739,6 +6739,13 @@ S:	Supported
 F:	include/linux/mlx5/
 F:	drivers/infiniband/hw/mlx5/
 
+MELEXIS MLX90614 DRIVER
+M:	Crt Mori <cmo@melexis.com>
+L:	linux-iio@vger.kernel.org
+W:	http://www.melexis.com
+S:	Supported
+F:	drivers/iio/temperature/mlx90614.c
+
 MN88472 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 5d033a5..3017dbc 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
  * Copyright (c) 2015 Essensium NV
+ * Copyright (c) 2015 Melexis
  *
  * This file is subject to the terms and conditions of version 2 of
  * the GNU General Public License.  See the file COPYING in the main
@@ -20,7 +21,6 @@
  * always has a pull-up so we do not need an extra GPIO to drive it high.  If
  * the "wakeup" GPIO is not given, power management will be disabled.
  *
- * TODO: filter configuration
  */
 
 #include <linux/err.h>
@@ -79,6 +79,26 @@ struct mlx90614_data {
 	unsigned long ready_timestamp; /* in jiffies */
 };
 
+/* Allowed percentage values for IIR filtering */
+static const u8 mlx90614_iir_values[] = {50, 25, 17, 13, 100, 80, 67, 57};
+
+/*
+ * Find the IIR value inside mlx90614_iir_values array and return its position
+ * which is equivalent to the bit value in sensor register
+ */
+static inline s32 mlx90614_iir_search(int value)
+{
+	u8 i;
+	if (value < 0 || value > 100)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(mlx90614_iir_values); ++i) {
+		if (value == mlx90614_iir_values[i])
+			return i;
+	}
+	return -EINVAL;
+}
+
 /*
  * Erase an address and write word.
  * The mutex must be locked before calling.
@@ -236,6 +256,19 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 			*val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
 		}
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR setting with
+							     FIR = 1024 */
+		mlx90614_power_get(data, false);
+		mutex_lock(&data->lock);
+		ret = i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
+		mutex_unlock(&data->lock);
+		mlx90614_power_put(data);
+
+		if (ret < 0)
+			return ret;
+
+		*val = mlx90614_iir_values[ret & MLX90614_CONFIG_IIR_MASK];
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -263,6 +296,41 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
 		mlx90614_power_put(data);
 
 		return ret;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR Filter setting */
+		mlx90614_power_get(data, false);
+		mutex_lock(&data->lock);
+
+		ret = mlx90614_iir_search(val);
+		if (ret >= 0) {
+			/*
+			 * If there is no error, then we have a sensor
+			 * equivalent value in ret. We need to store it
+			 * temporary to val, as we still have more data
+			 * to save in ret before we can actually write
+			 */
+			val = ret;
+
+			/*
+			 * CONFIG register values must not be changed so
+			 * we must read them before we actually write
+			 * changes
+			 */
+			ret = i2c_smbus_read_word_data(data->client,
+						       MLX90614_CONFIG);
+			if (ret >= 0) {
+				/* Write changed values */
+				ret = mlx90614_write_word(data->client,
+					MLX90614_CONFIG,
+					(val << MLX90614_CONFIG_IIR_SHIFT) |
+					(((u16) ((0x7 << MLX90614_CONFIG_FIR_SHIFT) |
+					((u16) ret & (~((u16) MLX90614_CONFIG_FIR_MASK))))) &
+					(~(u16) MLX90614_CONFIG_IIR_MASK)));
+			}
+		}
+		mutex_unlock(&data->lock);
+		mlx90614_power_put(data);
+
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -275,6 +343,8 @@ static int mlx90614_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBEMISSIVITY:
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -294,7 +364,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_TEMP_OBJECT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
+		    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		    BIT(IIO_CHAN_INFO_SCALE),
 	},
@@ -305,7 +376,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
 		.channel = 1,
 		.channel2 = IIO_MOD_TEMP_OBJECT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
+		    BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		    BIT(IIO_CHAN_INFO_SCALE),
 	},
@@ -569,5 +641,6 @@ module_i2c_driver(mlx90614_driver);
 
 MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
 MODULE_AUTHOR("Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>");
+MODULE_AUTHOR("Crt Mori <cmo@melexis.com>");
 MODULE_DESCRIPTION("Melexis MLX90614 contactless IR temperature sensor driver");
 MODULE_LICENSE("GPL");
-- 
2.1.4
