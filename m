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
Subject: [PATCH v3 3/5] max44000: Support controlling LED current output
Date: Mon, 18 Apr 2016 17:31:55 +0300
Message-Id: <630a03ff02d238793019267f0e144f08665104a5.1460989642.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1460989642.git.leonard.crestez@intel.com>
References: <cover.1460989642.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1460989642.git.leonard.crestez@intel.com>
References: <cover.1460989642.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This is exposed as an output channel with "led" as an extend_name.

Other sensors also have support for controlling an external LED. It's
not clear that simply exposing an undecorated output channel is the
correct approach.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/light/max44000.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index dc63de2..0ccd110 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -85,6 +85,13 @@ static const struct iio_chan_spec max44000_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
 	},
+	{
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.extend_name = "led",
+		.output = 1,
+	},
 };
 
 static int max44000_read_alsval(struct max44000_data *data)
@@ -125,6 +132,20 @@ static int max44000_write_led_current_raw(struct max44000_data *data, int val)
 				 MAX44000_LED_CURRENT_MASK, val);
 }
 
+static int max44000_read_led_current_raw(struct max44000_data *data)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, MAX44000_REG_CFG_TX, &regval);
+	if (ret < 0)
+		return ret;
+	regval &= MAX44000_LED_CURRENT_MASK;
+	if (regval >= 8)
+		regval -= 4;
+	return regval;
+}
+
 static int max44000_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int *val, int *val2, long mask)
@@ -154,12 +175,26 @@ static int max44000_read_raw(struct iio_dev *indio_dev,
 			*val = regval;
 			return IIO_VAL_INT;
 
+		case IIO_CURRENT:
+			mutex_lock(&data->lock);
+			ret = max44000_read_led_current_raw(data);
+			mutex_unlock(&data->lock);
+			if (ret < 0)
+				return ret;
+			*val = ret;
+			return IIO_VAL_INT;
+
 		default:
 			return -EINVAL;
 		}
 
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
+		case IIO_CURRENT:
+			/* Output register is in 10s of miliamps */
+			*val = 10;
+			return IIO_VAL_INT;
+
 		case IIO_LIGHT:
 			*val = 1;
 			*val2 = MAX44000_ALS_TO_LUX_DEFAULT_FRACTION_LOG2;
@@ -174,9 +209,27 @@ static int max44000_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int max44000_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct max44000_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (mask == IIO_CHAN_INFO_RAW && chan->type == IIO_CURRENT) {
+		mutex_lock(&data->lock);
+		ret = max44000_write_led_current_raw(data, val);
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
 static const struct iio_info max44000_info = {
 	.driver_module		= THIS_MODULE,
 	.read_raw		= max44000_read_raw,
+	.write_raw		= max44000_write_raw,
 };
 
 static bool max44000_readable_reg(struct device *dev, unsigned int reg)
-- 
2.5.5
