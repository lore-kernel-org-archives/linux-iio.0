Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH v3 4/5] max44000: Expose ambient sensor scaling
Date: Mon, 18 Apr 2016 17:31:56 +0300
Message-Id: <58f61cb552d6f8d30e55f36225e86eb76c954933.1460989642.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1460989642.git.leonard.crestez@intel.com>
References: <cover.1460989642.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1460989642.git.leonard.crestez@intel.com>
References: <cover.1460989642.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patch exposes ALSTIM as illuminance_integration_time and ALSPGA as
illuminance_scale.

Changing ALSTIM also changes the number of bits available in the data
register. This is handled inside raw value reading because:
* It's very easy to shift a few bits
* It allows SCALE and INT_TIME to be completely independent controls
* Buffer support requires constant scan_type.realbits per-channel

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/light/max44000.c | 167 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 162 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index 0ccd110..c58bb78 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -59,6 +59,12 @@
  */
 #define MAX44000_REG_CFG_RX_DEFAULT 0xf0
 
+/* REG_RX bits */
+#define MAX44000_CFG_RX_ALSTIM_MASK	0x0c
+#define MAX44000_CFG_RX_ALSTIM_SHIFT	2
+#define MAX44000_CFG_RX_ALSPGA_MASK	0x03
+#define MAX44000_CFG_RX_ALSPGA_SHIFT	0
+
 /* REG_TX bits */
 #define MAX44000_LED_CURRENT_MASK	0xf
 #define MAX44000_LED_CURRENT_MAX	11
@@ -74,11 +80,57 @@ struct max44000_data {
 /* Default scale is set to the minimum of 0.03125 or 1 / (1 << 5) lux */
 #define MAX44000_ALS_TO_LUX_DEFAULT_FRACTION_LOG2 5
 
+/* Scale can be multiplied by up to 128x via ALSPGA for measurement gain */
+static const int max44000_alspga_shift[] = {0, 2, 4, 7};
+#define MAX44000_ALSPGA_MAX_SHIFT 7
+
+/*
+ * Scale can be multiplied by up to 64x via ALSTIM because of lost resolution
+ *
+ * This scaling factor is hidden from userspace and instead accounted for when
+ * reading raw values from the device.
+ *
+ * This makes it possible to cleanly expose ALSPGA as IIO_CHAN_INFO_SCALE and
+ * ALSTIM as IIO_CHAN_INFO_INT_TIME without the values affecting each other.
+ *
+ * Handling this internally is also required for buffer support because the
+ * channel's scan_type can't be modified dynamically.
+ */
+static const int max44000_alstim_shift[] = {0, 2, 4, 6};
+#define MAX44000_ALSTIM_SHIFT(alstim) (2 * (alstim))
+
+/* Available integration times with pretty manual alignment: */
+static const int max44000_int_time_avail_ns_array[] = {
+	   100000000,
+	    25000000,
+	     6250000,
+	     1562500,
+};
+static const char max44000_int_time_avail_str[] =
+	"0.100 "
+	"0.025 "
+	"0.00625 "
+	"0.001625";
+
+/* Available scales (internal to ulux) with pretty manual alignment: */
+static const int max44000_scale_avail_ulux_array[] = {
+	    31250,
+	   125000,
+	   500000,
+	  4000000,
+};
+static const char max44000_scale_avail_str[] =
+	"0.03125 "
+	"0.125 "
+	"0.5 "
+	 "4";
+
 static const struct iio_chan_spec max44000_channels[] = {
 	{
 		.type = IIO_LIGHT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_INT_TIME),
 	},
 	{
 		.type = IIO_PROXIMITY,
@@ -94,15 +146,54 @@ static const struct iio_chan_spec max44000_channels[] = {
 	},
 };
 
+static int max44000_read_alstim(struct max44000_data *data)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(data->regmap, MAX44000_REG_CFG_RX, &val);
+	if (ret < 0)
+		return ret;
+	return (val & MAX44000_CFG_RX_ALSTIM_MASK) >> MAX44000_CFG_RX_ALSTIM_SHIFT;
+}
+
+static int max44000_write_alstim(struct max44000_data *data, int val)
+{
+	return regmap_write_bits(data->regmap, MAX44000_REG_CFG_RX,
+				 MAX44000_CFG_RX_ALSTIM_MASK,
+				 val << MAX44000_CFG_RX_ALSTIM_SHIFT);
+}
+
+static int max44000_read_alspga(struct max44000_data *data)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(data->regmap, MAX44000_REG_CFG_RX, &val);
+	if (ret < 0)
+		return ret;
+	return (val & MAX44000_CFG_RX_ALSPGA_MASK) >> MAX44000_CFG_RX_ALSPGA_SHIFT;
+}
+
+static int max44000_write_alspga(struct max44000_data *data, int val)
+{
+	return regmap_write_bits(data->regmap, MAX44000_REG_CFG_RX,
+				 MAX44000_CFG_RX_ALSPGA_MASK,
+				 val << MAX44000_CFG_RX_ALSPGA_SHIFT);
+}
+
 static int max44000_read_alsval(struct max44000_data *data)
 {
 	u16 regval;
-	int ret;
+	int alstim, ret;
 
 	ret = regmap_bulk_read(data->regmap, MAX44000_REG_ALS_DATA_HI,
 			       &regval, sizeof(regval));
 	if (ret < 0)
 		return ret;
+	alstim = ret = max44000_read_alstim(data);
+	if (ret < 0)
+		return ret;
 
 	regval = be16_to_cpu(regval);
 
@@ -118,7 +209,7 @@ static int max44000_read_alsval(struct max44000_data *data)
 	if (regval & MAX44000_ALSDATA_OVERFLOW)
 		return 0x3FFF;
 
-	return regval;
+	return regval << MAX44000_ALSTIM_SHIFT(alstim);
 }
 
 static int max44000_write_led_current_raw(struct max44000_data *data, int val)
@@ -151,6 +242,7 @@ static int max44000_read_raw(struct iio_dev *indio_dev,
 			     int *val, int *val2, long mask)
 {
 	struct max44000_data *data = iio_priv(indio_dev);
+	int alstim, alspga;
 	unsigned int regval;
 	int ret;
 
@@ -196,14 +288,34 @@ static int max44000_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT;
 
 		case IIO_LIGHT:
-			*val = 1;
-			*val2 = MAX44000_ALS_TO_LUX_DEFAULT_FRACTION_LOG2;
+			mutex_lock(&data->lock);
+			alspga = ret = max44000_read_alspga(data);
+			mutex_unlock(&data->lock);
+			if (ret < 0)
+				return ret;
+
+			/* Avoid negative shifts */
+			*val = (1 << MAX44000_ALSPGA_MAX_SHIFT);
+			*val2 = MAX44000_ALS_TO_LUX_DEFAULT_FRACTION_LOG2
+					+ MAX44000_ALSPGA_MAX_SHIFT
+					- max44000_alspga_shift[alspga];
 			return IIO_VAL_FRACTIONAL_LOG2;
 
 		default:
 			return -EINVAL;
 		}
 
+	case IIO_CHAN_INFO_INT_TIME:
+		mutex_lock(&data->lock);
+		alstim = ret = max44000_read_alstim(data);
+		mutex_unlock(&data->lock);
+
+		if (ret < 0)
+			return ret;
+		*val = 0;
+		*val2 = max44000_int_time_avail_ns_array[alstim];
+		return IIO_VAL_INT_PLUS_NANO;
+
 	default:
 		return -EINVAL;
 	}
@@ -221,15 +333,60 @@ static int max44000_write_raw(struct iio_dev *indio_dev,
 		ret = max44000_write_led_current_raw(data, val);
 		mutex_unlock(&data->lock);
 		return ret;
+	} else if (mask == IIO_CHAN_INFO_INT_TIME && chan->type == IIO_LIGHT) {
+		s64 valns = val * NSEC_PER_SEC + val2;
+		int alstim = find_closest_descending(valns,
+				max44000_int_time_avail_ns_array,
+				ARRAY_SIZE(max44000_int_time_avail_ns_array));
+		mutex_lock(&data->lock);
+		ret = max44000_write_alstim(data, alstim);
+		mutex_unlock(&data->lock);
+		return ret;
+	} else if (mask == IIO_CHAN_INFO_SCALE && chan->type == IIO_LIGHT) {
+		s64 valus = val * USEC_PER_SEC + val2;
+		int alspga = find_closest(valus,
+				max44000_scale_avail_ulux_array,
+				ARRAY_SIZE(max44000_scale_avail_ulux_array));
+		mutex_lock(&data->lock);
+		ret = max44000_write_alspga(data, alspga);
+		mutex_unlock(&data->lock);
+		return ret;
 	}
 
 	return -EINVAL;
 }
 
+static int max44000_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      long mask)
+{
+	if (mask == IIO_CHAN_INFO_INT_TIME && chan->type == IIO_LIGHT)
+		return IIO_VAL_INT_PLUS_NANO;
+	else if (mask == IIO_CHAN_INFO_SCALE && chan->type == IIO_LIGHT)
+		return IIO_VAL_INT_PLUS_MICRO;
+	else
+		return IIO_VAL_INT;
+}
+
+static IIO_CONST_ATTR(illuminance_integration_time_available, max44000_int_time_avail_str);
+static IIO_CONST_ATTR(illuminance_scale_available, max44000_scale_avail_str);
+
+static struct attribute *max44000_attributes[] = {
+	&iio_const_attr_illuminance_integration_time_available.dev_attr.attr,
+	&iio_const_attr_illuminance_scale_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group max44000_attribute_group = {
+	.attrs = max44000_attributes,
+};
+
 static const struct iio_info max44000_info = {
 	.driver_module		= THIS_MODULE,
 	.read_raw		= max44000_read_raw,
 	.write_raw		= max44000_write_raw,
+	.write_raw_get_fmt	= max44000_write_raw_get_fmt,
+	.attrs			= &max44000_attribute_group,
 };
 
 static bool max44000_readable_reg(struct device *dev, unsigned int reg)
-- 
2.5.5
