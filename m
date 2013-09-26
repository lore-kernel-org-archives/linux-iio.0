Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: [PATCH 04/18] iio:gp2ap020a00f: Switch to new event config interface
Date: Thu, 26 Sep 2013 14:58:23 +0200
Message-Id: <1380200317-19355-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1380200317-19355-1-git-send-email-lars@metafoo.de>
References: <1380200317-19355-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Switch the gp2ap020a00f driver to the new IIO event config interface as the old
one is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
---
 drivers/iio/light/gp2ap020a00f.c | 103 ++++++++++++++++++++++++++-------------
 1 file changed, 70 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index b1e4615..43f47f7 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -996,11 +996,10 @@ done:
 	return IRQ_HANDLED;
 }
 
-static u8 gp2ap020a00f_get_reg_by_event_code(u64 event_code)
+static u8 gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
+					     enum iio_event_direction event_dir)
 {
-	int event_dir = IIO_EVENT_CODE_EXTRACT_DIR(event_code);
-
-	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	switch (chan->type) {
 	case IIO_PROXIMITY:
 		if (event_dir == IIO_EV_DIR_RISING)
 			return GP2AP020A00F_PH_L_REG;
@@ -1011,13 +1010,19 @@ static u8 gp2ap020a00f_get_reg_by_event_code(u64 event_code)
 			return GP2AP020A00F_TH_L_REG;
 		else
 			return GP2AP020A00F_TL_L_REG;
+	default:
+		break;
 	}
 
 	return -EINVAL;
 }
 
 static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
-					u64 event_code, int val)
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir,
+					enum iio_event_info info,
+					int val)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	bool event_en = false;
@@ -1027,7 +1032,7 @@ static int gp2ap020a00f_write_event_val(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->lock);
 
-	thresh_reg_l = gp2ap020a00f_get_reg_by_event_code(event_code);
+	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
 	thresh_val_id = GP2AP020A00F_THRESH_VAL_ID(thresh_reg_l);
 
 	if (thresh_val_id > GP2AP020A00F_THRESH_PH) {
@@ -1072,7 +1077,11 @@ error_unlock:
 }
 
 static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
-					u64 event_code, int *val)
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir,
+				       enum iio_event_info info,
+				       int *val)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	u8 thresh_reg_l;
@@ -1080,7 +1089,7 @@ static int gp2ap020a00f_read_event_val(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->lock);
 
-	thresh_reg_l = gp2ap020a00f_get_reg_by_event_code(event_code);
+	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);
 
 	if (thresh_reg_l > GP2AP020A00F_PH_L_REG) {
 		err = -EINVAL;
@@ -1096,7 +1105,7 @@ error_unlock:
 }
 
 static int gp2ap020a00f_write_prox_event_config(struct iio_dev *indio_dev,
-					u64 event_code, int state)
+						int state)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	enum gp2ap020a00f_cmd cmd_high_ev, cmd_low_ev;
@@ -1151,7 +1160,10 @@ static int gp2ap020a00f_write_prox_event_config(struct iio_dev *indio_dev,
 }
 
 static int gp2ap020a00f_write_event_config(struct iio_dev *indio_dev,
-					u64 event_code, int state)
+					   const struct iio_chan_spec *chan,
+					   enum iio_event_type type,
+					   enum iio_event_direction dir,
+					   int state)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	enum gp2ap020a00f_cmd cmd;
@@ -1159,14 +1171,12 @@ static int gp2ap020a00f_write_event_config(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->lock);
 
-	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	switch (chan->type) {
 	case IIO_PROXIMITY:
-		err = gp2ap020a00f_write_prox_event_config(indio_dev,
-					event_code, state);
+		err = gp2ap020a00f_write_prox_event_config(indio_dev, state);
 		break;
 	case IIO_LIGHT:
-		if (IIO_EVENT_CODE_EXTRACT_DIR(event_code)
-					== IIO_EV_DIR_RISING) {
+		if (dir == IIO_EV_DIR_RISING) {
 			cmd = state ? GP2AP020A00F_CMD_ALS_HIGH_EV_EN :
 				      GP2AP020A00F_CMD_ALS_HIGH_EV_DIS;
 			err = gp2ap020a00f_exec_cmd(data, cmd);
@@ -1186,17 +1196,18 @@ static int gp2ap020a00f_write_event_config(struct iio_dev *indio_dev,
 }
 
 static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
-					u64 event_code)
+					   const struct iio_chan_spec *chan,
+					   enum iio_event_type type,
+					   enum iio_event_direction dir)
 {
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	int event_en = 0;
 
 	mutex_lock(&data->lock);
 
-	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
+	switch (chan->type) {
 	case IIO_PROXIMITY:
-		if (IIO_EVENT_CODE_EXTRACT_DIR(event_code)
-					== IIO_EV_DIR_RISING)
+		if (dir == IIO_EV_DIR_RISING)
 			event_en = test_bit(GP2AP020A00F_FLAG_PROX_RISING_EV,
 								&data->flags);
 		else
@@ -1204,14 +1215,16 @@ static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
 								&data->flags);
 		break;
 	case IIO_LIGHT:
-		if (IIO_EVENT_CODE_EXTRACT_DIR(event_code)
-					== IIO_EV_DIR_RISING)
+		if (dir == IIO_EV_DIR_RISING)
 			event_en = test_bit(GP2AP020A00F_FLAG_ALS_RISING_EV,
 								&data->flags);
 		else
 			event_en = test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EV,
 								&data->flags);
 		break;
+	default:
+		event_en = -EINVAL;
+		break;
 	}
 
 	mutex_unlock(&data->lock);
@@ -1292,6 +1305,34 @@ error_unlock:
 	return err < 0 ? err : IIO_VAL_INT;
 }
 
+static const struct iio_event_spec gp2ap020a00f_event_spec_light[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_event_spec gp2ap020a00f_event_spec_prox[] = {
+	{
+		.type = IIO_EV_TYPE_ROC,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_ROC,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_chan_spec gp2ap020a00f_channels[] = {
 	{
 		.type = IIO_LIGHT,
@@ -1307,10 +1348,8 @@ static const struct iio_chan_spec gp2ap020a00f_channels[] = {
 		},
 		.scan_index = GP2AP020A00F_SCAN_MODE_LIGHT_CLEAR,
 		.address = GP2AP020A00F_D0_L_REG,
-		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH,
-					 IIO_EV_DIR_RISING) |
-			      IIO_EV_BIT(IIO_EV_TYPE_THRESH,
-					 IIO_EV_DIR_FALLING),
+		.event_spec = gp2ap020a00f_event_spec_light,
+		.num_event_specs = ARRAY_SIZE(gp2ap020a00f_event_spec_light),
 	},
 	{
 		.type = IIO_LIGHT,
@@ -1340,20 +1379,18 @@ static const struct iio_chan_spec gp2ap020a00f_channels[] = {
 		},
 		.scan_index = GP2AP020A00F_SCAN_MODE_PROXIMITY,
 		.address = GP2AP020A00F_D2_L_REG,
-		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_ROC,
-					 IIO_EV_DIR_RISING) |
-			      IIO_EV_BIT(IIO_EV_TYPE_ROC,
-					 IIO_EV_DIR_FALLING),
+		.event_spec = gp2ap020a00f_event_spec_prox,
+		.num_event_specs = ARRAY_SIZE(gp2ap020a00f_event_spec_prox),
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(GP2AP020A00F_CHAN_TIMESTAMP),
 };
 
 static const struct iio_info gp2ap020a00f_info = {
 	.read_raw = &gp2ap020a00f_read_raw,
-	.read_event_value = &gp2ap020a00f_read_event_val,
-	.read_event_config = &gp2ap020a00f_read_event_config,
-	.write_event_value = &gp2ap020a00f_write_event_val,
-	.write_event_config = &gp2ap020a00f_write_event_config,
+	.read_event_value_new = &gp2ap020a00f_read_event_val,
+	.read_event_config_new = &gp2ap020a00f_read_event_config,
+	.write_event_value_new = &gp2ap020a00f_write_event_val,
+	.write_event_config_new = &gp2ap020a00f_write_event_config,
 	.driver_module = THIS_MODULE,
 };
 
-- 
1.8.0
