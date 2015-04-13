Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 15/17] iio: accel: mma9553: fix alignment issues
Date: Mon, 13 Apr 2015 18:41:02 +0300
Message-Id: <1428939664-12503-16-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Fix code alignment and wrap parameters.
Fix issues reported by checkpatch.pl --strict.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma9551_core.c |  8 ++---
 drivers/iio/accel/mma9551_core.h |  6 ++--
 drivers/iio/accel/mma9553.c      | 76 +++++++++++++++++++---------------------
 3 files changed, 43 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index 583660b..c34c5ce 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -297,7 +297,7 @@ EXPORT_SYMBOL(mma9551_read_status_byte);
  * Returns: 0 on success, negative value on failure.
  */
 int mma9551_read_config_word(struct i2c_client *client, u8 app_id,
-			    u16 reg, u16 *val)
+			     u16 reg, u16 *val)
 {
 	int ret;
 	__be16 v;
@@ -328,12 +328,12 @@ EXPORT_SYMBOL(mma9551_read_config_word);
  * Returns: 0 on success, negative value on failure.
  */
 int mma9551_write_config_word(struct i2c_client *client, u8 app_id,
-			     u16 reg, u16 val)
+			      u16 reg, u16 val)
 {
 	__be16 v = cpu_to_be16(val);
 
 	return mma9551_transfer(client, app_id, MMA9551_CMD_WRITE_CONFIG, reg,
-				(u8 *) &v, 2, NULL, 0);
+				(u8 *)&v, 2, NULL, 0);
 }
 EXPORT_SYMBOL(mma9551_write_config_word);
 
@@ -385,7 +385,7 @@ EXPORT_SYMBOL(mma9551_read_status_word);
  * Returns: 0 on success, negative value on failure.
  */
 int mma9551_read_config_words(struct i2c_client *client, u8 app_id,
-			     u16 reg, u8 len, u16 *buf)
+			      u16 reg, u8 len, u16 *buf)
 {
 	int ret, i;
 	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS / 2];
diff --git a/drivers/iio/accel/mma9551_core.h b/drivers/iio/accel/mma9551_core.h
index 79939e4..5e88e64 100644
--- a/drivers/iio/accel/mma9551_core.h
+++ b/drivers/iio/accel/mma9551_core.h
@@ -53,13 +53,13 @@ int mma9551_write_config_byte(struct i2c_client *client, u8 app_id,
 int mma9551_read_status_byte(struct i2c_client *client, u8 app_id,
 			     u16 reg, u8 *val);
 int mma9551_read_config_word(struct i2c_client *client, u8 app_id,
-			    u16 reg, u16 *val);
+			     u16 reg, u16 *val);
 int mma9551_write_config_word(struct i2c_client *client, u8 app_id,
-			     u16 reg, u16 val);
+			      u16 reg, u16 val);
 int mma9551_read_status_word(struct i2c_client *client, u8 app_id,
 			     u16 reg, u16 *val);
 int mma9551_read_config_words(struct i2c_client *client, u8 app_id,
-			     u16 reg, u8 len, u16 *buf);
+			      u16 reg, u8 len, u16 *buf);
 int mma9551_read_status_words(struct i2c_client *client, u8 app_id,
 			      u16 reg, u8 len, u16 *buf);
 int mma9551_write_config_words(struct i2c_client *client, u8 app_id,
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 06c8707..08f28c3 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -343,10 +343,10 @@ static int mma9553_conf_gpio(struct mma9553_data *data)
 	struct mma9553_event *ev_step_detect;
 	bool activity_enabled;
 
-	activity_enabled =
-	    mma9553_is_any_event_enabled(data, true, IIO_ACTIVITY);
-	ev_step_detect =
-	    mma9553_get_event(data, IIO_STEPS, IIO_NO_MOD, IIO_EV_DIR_NONE);
+	activity_enabled = mma9553_is_any_event_enabled(data, true,
+							IIO_ACTIVITY);
+	ev_step_detect = mma9553_get_event(data, IIO_STEPS, IIO_NO_MOD,
+					   IIO_EV_DIR_NONE);
 
 	/*
 	 * If both step detector and activity are enabled, use the MRGFL bit.
@@ -372,9 +372,8 @@ static int mma9553_conf_gpio(struct mma9553_data *data)
 			return ret;
 	}
 
-	ret = mma9551_gpio_config(data->client,
-				  MMA9553_DEFAULT_GPIO_PIN,
-				  appid, bitnum, MMA9553_DEFAULT_GPIO_POLARITY);
+	ret = mma9551_gpio_config(data->client, MMA9553_DEFAULT_GPIO_PIN, appid,
+				  bitnum, MMA9553_DEFAULT_GPIO_POLARITY);
 	if (ret < 0)
 		return ret;
 	data->gpio_bitnum = bitnum;
@@ -395,18 +394,16 @@ static int mma9553_init(struct mma9553_data *data)
 	 * a device identification command to differentiate the MMA9553L
 	 * from the MMA9550L.
 	 */
-	ret =
-	    mma9551_read_config_words(data->client, MMA9551_APPID_PEDOMETER,
-				      MMA9553_REG_CONF_SLEEPMIN,
-				      sizeof(data->conf) / sizeof(u16),
-				      (u16 *)&data->conf);
+	ret = mma9551_read_config_words(data->client, MMA9551_APPID_PEDOMETER,
+					MMA9553_REG_CONF_SLEEPMIN,
+					sizeof(data->conf) / sizeof(u16),
+					(u16 *)&data->conf);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"failed to read configuration registers\n");
 		return ret;
 	}
 
-
 	/* Reset GPIO */
 	data->gpio_bitnum = MMA9553_MAX_BITNUM;
 	ret = mma9553_conf_gpio(data);
@@ -421,19 +418,18 @@ static int mma9553_init(struct mma9553_data *data)
 	data->conf.sleepmin = MMA9553_DEFAULT_SLEEPMIN;
 	data->conf.sleepmax = MMA9553_DEFAULT_SLEEPMAX;
 	data->conf.sleepthd = MMA9553_DEFAULT_SLEEPTHD;
-	data->conf.config =
-	    mma9553_set_bits(data->conf.config, 1, MMA9553_MASK_CONF_CONFIG);
+	data->conf.config = mma9553_set_bits(data->conf.config, 1,
+					     MMA9553_MASK_CONF_CONFIG);
 	/*
 	 * Clear the activity debounce counter when the activity level changes,
 	 * so that the confidence level applies for any activity level.
 	 */
 	data->conf.config = mma9553_set_bits(data->conf.config, 1,
 					     MMA9553_MASK_CONF_ACT_DBCNTM);
-	ret =
-	    mma9551_write_config_words(data->client, MMA9551_APPID_PEDOMETER,
-				       MMA9553_REG_CONF_SLEEPMIN,
-				       sizeof(data->conf) / sizeof(u16),
-				       (u16 *)&data->conf);
+	ret = mma9551_write_config_words(data->client, MMA9551_APPID_PEDOMETER,
+					 MMA9553_REG_CONF_SLEEPMIN,
+					 sizeof(data->conf) / sizeof(u16),
+					 (u16 *)&data->conf);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"failed to write configuration registers\n");
@@ -570,7 +566,7 @@ static int mma9553_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBHEIGHT:
 		tmp = mma9553_get_bits(data->conf.height_weight,
-					MMA9553_MASK_CONF_HEIGHT);
+				       MMA9553_MASK_CONF_HEIGHT);
 		*val = tmp / 100;	/* cm to m */
 		*val2 = (tmp % 100) * 10000;
 		return IIO_VAL_INT_PLUS_MICRO;
@@ -722,7 +718,6 @@ static int mma9553_read_event_config(struct iio_dev *indio_dev,
 				     enum iio_event_type type,
 				     enum iio_event_direction dir)
 {
-
 	struct mma9553_data *data = iio_priv(indio_dev);
 	struct mma9553_event *event;
 
@@ -1029,22 +1024,22 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
 		return IRQ_HANDLED;
 	}
 
-	ev_prev_activity =
-	    mma9553_get_event(data, IIO_ACTIVITY,
-			      mma9553_activity_to_mod(data->activity),
-			      IIO_EV_DIR_FALLING);
-	ev_activity =
-	    mma9553_get_event(data, IIO_ACTIVITY,
-			      mma9553_activity_to_mod(activity),
-			      IIO_EV_DIR_RISING);
-	ev_step_detect =
-	    mma9553_get_event(data, IIO_STEPS, IIO_NO_MOD, IIO_EV_DIR_NONE);
+	ev_prev_activity = mma9553_get_event(data, IIO_ACTIVITY,
+					     mma9553_activity_to_mod(
+					     data->activity),
+					     IIO_EV_DIR_FALLING);
+	ev_activity = mma9553_get_event(data, IIO_ACTIVITY,
+					mma9553_activity_to_mod(activity),
+					IIO_EV_DIR_RISING);
+	ev_step_detect = mma9553_get_event(data, IIO_STEPS, IIO_NO_MOD,
+					   IIO_EV_DIR_NONE);
 
 	if (ev_step_detect->enabled && (stepcnt != data->stepcnt)) {
 		data->stepcnt = stepcnt;
 		iio_push_event(indio_dev,
 			       IIO_EVENT_CODE(IIO_STEPS, 0, IIO_NO_MOD,
-			       IIO_EV_DIR_NONE, IIO_EV_TYPE_CHANGE, 0, 0, 0),
+					      IIO_EV_DIR_NONE,
+					      IIO_EV_TYPE_CHANGE, 0, 0, 0),
 			       data->timestamp);
 	}
 
@@ -1054,17 +1049,19 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
 		if (ev_prev_activity && ev_prev_activity->enabled)
 			iio_push_event(indio_dev,
 				       IIO_EVENT_CODE(IIO_ACTIVITY, 0,
-				       ev_prev_activity->info->mod,
-				       IIO_EV_DIR_FALLING,
-				       IIO_EV_TYPE_THRESH, 0, 0, 0),
+						    ev_prev_activity->info->mod,
+						    IIO_EV_DIR_FALLING,
+						    IIO_EV_TYPE_THRESH, 0, 0,
+						    0),
 				       data->timestamp);
 
 		if (ev_activity && ev_activity->enabled)
 			iio_push_event(indio_dev,
 				       IIO_EVENT_CODE(IIO_ACTIVITY, 0,
-				       ev_activity->info->mod,
-				       IIO_EV_DIR_RISING,
-				       IIO_EV_TYPE_THRESH, 0, 0, 0),
+						      ev_activity->info->mod,
+						      IIO_EV_DIR_RISING,
+						      IIO_EV_TYPE_THRESH, 0, 0,
+						      0),
 				       data->timestamp);
 	}
 	mutex_unlock(&data->mutex);
@@ -1159,7 +1156,6 @@ static int mma9553_probe(struct i2c_client *client,
 				client->irq);
 			goto out_poweroff;
 		}
-
 	}
 
 	ret = iio_device_register(indio_dev);
-- 
1.9.1
