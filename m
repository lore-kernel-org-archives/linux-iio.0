Return-Path: <spk.linux@gmail.com>
Sender: Sachin Kamat <spk.linux@gmail.com>
From: Sachin Kamat <sachin.kamat@samsung.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	spk.linux@gmail.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/7] iio: hid-sensor-press: Fix return values
Date: Thu,  3 Jul 2014 12:14:06 +0530
Message-Id: <1404369852-3255-1-git-send-email-sachin.kamat@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

IIO_CHAN_INFO_SAMP_FREQ and IIO_CHAN_INFO_HYSTERESIS cases ignored
the actual return values (which could be -EINVAL) and instead
returned IIO_VAL_INT_PLUS_MICRO always. Return the actual value
obtained from the functions. Both functions return IIO_VAL_INT_PLUS_MICRO
upon success.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/pressure/hid-sensor-press.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 1cd190c..2c0d2a4 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -78,7 +78,6 @@ static int press_read_raw(struct iio_dev *indio_dev,
 	struct press_state *press_state = iio_priv(indio_dev);
 	int report_id = -1;
 	u32 address;
-	int ret;
 	int ret_type;
 	s32 poll_value;
 
@@ -128,14 +127,12 @@ static int press_read_raw(struct iio_dev *indio_dev,
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = hid_sensor_read_samp_freq_value(
+		ret_type = hid_sensor_read_samp_freq_value(
 				&press_state->common_attributes, val, val2);
-		ret_type = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	case IIO_CHAN_INFO_HYSTERESIS:
-		ret = hid_sensor_read_raw_hyst_value(
+		ret_type = hid_sensor_read_raw_hyst_value(
 				&press_state->common_attributes, val, val2);
-		ret_type = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	default:
 		ret_type = -EINVAL;
-- 
1.7.9.5
