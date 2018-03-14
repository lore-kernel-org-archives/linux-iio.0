Return-Path: <SRS0=6THc=GE=users.sourceforge.net=elfring@kernel.org>
To: linux-iio@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Pravin Shedge <pravin.shedge4linux@gmail.com>,
 Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/gyro/bmg160_core: Improve unlocking of a mutex in five
 functions
Message-ID: <16623de4-351d-135b-f3ff-701a465c5d92@users.sourceforge.net>
Date: Wed, 14 Mar 2018 16:15:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Mar 2018 16:06:49 +0100

* Add jump targets so that a call of the function "mutex_unlock" is stored
  only once in these function implementations.

* Replace 19 calls by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/gyro/bmg160_core.c | 103 ++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 58 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 63ca31628a93..fa367fd7bc8c 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -499,21 +499,19 @@ static int bmg160_get_temp(struct bmg160_data *data, int *val)
 
 	mutex_lock(&data->mutex);
 	ret = bmg160_set_power_state(data, true);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 
 	ret = regmap_read(data->regmap, BMG160_REG_TEMP, &raw_val);
 	if (ret < 0) {
 		dev_err(dev, "Error reading reg_temp\n");
 		bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+		goto unlock;
 	}
 
 	*val = sign_extend32(raw_val, 7);
 	ret = bmg160_set_power_state(data, false);
+unlock:
 	mutex_unlock(&data->mutex);
 	if (ret < 0)
 		return ret;
@@ -529,22 +527,20 @@ static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 
 	mutex_lock(&data->mutex);
 	ret = bmg160_set_power_state(data, true);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 
 	ret = regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(axis), &raw_val,
 			       sizeof(raw_val));
 	if (ret < 0) {
 		dev_err(dev, "Error reading axis %d\n", axis);
 		bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+		goto unlock;
 	}
 
 	*val = sign_extend32(le16_to_cpu(raw_val), 15);
 	ret = bmg160_set_power_state(data, false);
+unlock:
 	mutex_unlock(&data->mutex);
 	if (ret < 0)
 		return ret;
@@ -632,19 +628,16 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
 		 * mode to power on for other writes.
 		 */
 		ret = bmg160_set_power_state(data, true);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
+		if (ret < 0)
+			goto unlock;
+
 		ret = bmg160_set_bw(data, val);
 		if (ret < 0) {
 			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
+			goto unlock;
 		}
-		ret = bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+
+		goto set_power_state;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		if (val2)
 			return -EINVAL;
@@ -653,18 +646,15 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
 		ret = bmg160_set_power_state(data, true);
 		if (ret < 0) {
 			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
+			goto unlock;
 		}
 		ret = bmg160_set_filter(data, val);
 		if (ret < 0) {
 			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
+			goto unlock;
 		}
-		ret = bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+
+		goto set_power_state;
 	case IIO_CHAN_INFO_SCALE:
 		if (val)
 			return -EINVAL;
@@ -672,24 +662,27 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&data->mutex);
 		/* Refer to comments above for the suspend mode ops */
 		ret = bmg160_set_power_state(data, true);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
+		if (ret < 0)
+			goto unlock;
+
 		ret = bmg160_set_scale(data, val2);
 		if (ret < 0) {
 			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
+			goto unlock;
 		}
-		ret = bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+
+		goto set_power_state;
 	default:
 		return -EINVAL;
 	}
 
 	return -EINVAL;
+
+set_power_state:
+	ret = bmg160_set_power_state(data, false);
+unlock:
+	mutex_unlock(&data->mutex);
+	return ret;
 }
 
 static int bmg160_read_event(struct iio_dev *indio_dev,
@@ -763,8 +756,8 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
 
 	if (!state && data->motion_trigger_on) {
 		data->ev_enable_state = 0;
-		mutex_unlock(&data->mutex);
-		return 0;
+		ret = 0;
+		goto unlock;
 	}
 	/*
 	 * We will expect the enable and disable to do operation in
@@ -776,22 +769,19 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
 	 * is always on so sequence doesn't matter
 	 */
 	ret = bmg160_set_power_state(data, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
 
 	ret =  bmg160_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
 		bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+		goto unlock;
 	}
 
 	data->ev_enable_state = state;
+unlock:
 	mutex_unlock(&data->mutex);
-
-	return 0;
+	return ret;
 }
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("100 200 400 1000 2000");
@@ -919,8 +909,8 @@ static int bmg160_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	if (!state && data->ev_enable_state && data->motion_trigger_on) {
 		data->motion_trigger_on = false;
-		mutex_unlock(&data->mutex);
-		return 0;
+		ret = 0;
+		goto unlock;
 	}
 
 	/*
@@ -928,27 +918,24 @@ static int bmg160_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	 * enable/disable operation order
 	 */
 	ret = bmg160_set_power_state(data, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (ret < 0)
+		goto unlock;
+
 	if (data->motion_trig == trig)
 		ret =  bmg160_setup_any_motion_interrupt(data, state);
 	else
 		ret = bmg160_setup_new_data_interrupt(data, state);
 	if (ret < 0) {
 		bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+		goto unlock;
 	}
 	if (data->motion_trig == trig)
 		data->motion_trigger_on = state;
 	else
 		data->dready_trigger_on = state;
-
+unlock:
 	mutex_unlock(&data->mutex);
-
-	return 0;
+	return ret;
 }
 
 static const struct iio_trigger_ops bmg160_trigger_ops = {
-- 
2.16.2
