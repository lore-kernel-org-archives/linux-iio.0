Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-020.synserver.de ([212.40.185.20]:1046 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754969Ab3JGOJs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 10:09:48 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 10/20] staging:iio:sca3000: Switch to new config interface
Date: Mon,  7 Oct 2013 16:11:24 +0200
Message-Id: <1381155094-20166-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-1-git-send-email-lars@metafoo.de>
References: <1381155094-20166-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Switch the sca3000 driver to the new IIO event config interface as the old one
is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/sca3000_core.c | 58 ++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 6a9ca20..c49e6ef 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -419,8 +419,11 @@ static IIO_DEVICE_ATTR(measurement_mode, S_IRUGO | S_IWUSR,
 
 static IIO_DEVICE_ATTR(revision, S_IRUGO, sca3000_show_rev, NULL, 0);
 
-#define SCA3000_EVENT_MASK					\
-	(IIO_EV_BIT(IIO_EV_TYPE_MAG, IIO_EV_DIR_RISING))
+static const struct iio_event_spec sca3000_event = {
+	.type = IIO_EV_TYPE_MAG,
+	.dir = IIO_EV_DIR_RISING,
+	.mask_separate = BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_ENABLE),
+};
 
 #define SCA3000_CHAN(index, mod)				\
 	{							\
@@ -437,7 +440,8 @@ static IIO_DEVICE_ATTR(revision, S_IRUGO, sca3000_show_rev, NULL, 0);
 			.storagebits = 16,			\
 			.shift = 5,				\
 		},						\
-		.event_mask = SCA3000_EVENT_MASK,		\
+		.event_spec = &sca3000_event,			\
+		.num_event_specs = 1,				\
 	 }
 
 static const struct iio_chan_spec sca3000_channels[] = {
@@ -703,12 +707,15 @@ static IIO_CONST_ATTR_TEMP_OFFSET("-214.6");
  * sca3000_read_thresh() - query of a threshold
  **/
 static int sca3000_read_thresh(struct iio_dev *indio_dev,
-			       u64 e,
-			       int *val)
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int *val, int *val2)
 {
 	int ret, i;
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int num = IIO_EVENT_CODE_EXTRACT_MODIFIER(e);
+	int num = chan->channel2;
 	mutex_lock(&st->lock);
 	ret = sca3000_read_ctrl_reg(st, sca3000_addresses[num][1]);
 	mutex_unlock(&st->lock);
@@ -724,18 +731,21 @@ static int sca3000_read_thresh(struct iio_dev *indio_dev,
 				 ARRAY_SIZE(st->info->mot_det_mult_xz))
 			*val += st->info->mot_det_mult_xz[i];
 
-	return 0;
+	return IIO_VAL_INT;
 }
 
 /**
  * sca3000_write_thresh() control of threshold
  **/
 static int sca3000_write_thresh(struct iio_dev *indio_dev,
-				u64 e,
-				int val)
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int num = IIO_EVENT_CODE_EXTRACT_MODIFIER(e);
+	int num = chan->channel2;
 	int ret;
 	int i;
 	u8 nonlinear = 0;
@@ -866,12 +876,14 @@ done:
  * sca3000_read_event_config() what events are enabled
  **/
 static int sca3000_read_event_config(struct iio_dev *indio_dev,
-				     u64 e)
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 	u8 protect_mask = 0x03;
-	int num = IIO_EVENT_CODE_EXTRACT_MODIFIER(e);
+	int num = chan->channel2;
 
 	/* read current value of mode register */
 	mutex_lock(&st->lock);
@@ -969,13 +981,15 @@ error_ret:
  * this mode is disabled.  Currently normal mode is assumed.
  **/
 static int sca3000_write_event_config(struct iio_dev *indio_dev,
-				      u64 e,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
 				      int state)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret, ctrlval;
 	u8 protect_mask = 0x03;
-	int num = IIO_EVENT_CODE_EXTRACT_MODIFIER(e);
+	int num = chan->channel2;
 
 	mutex_lock(&st->lock);
 	/* First read the motion detector config to find out if
@@ -1112,20 +1126,20 @@ static const struct iio_info sca3000_info = {
 	.attrs = &sca3000_attribute_group,
 	.read_raw = &sca3000_read_raw,
 	.event_attrs = &sca3000_event_attribute_group,
-	.read_event_value = &sca3000_read_thresh,
-	.write_event_value = &sca3000_write_thresh,
-	.read_event_config = &sca3000_read_event_config,
-	.write_event_config = &sca3000_write_event_config,
+	.read_event_value_new = &sca3000_read_thresh,
+	.write_event_value_new = &sca3000_write_thresh,
+	.read_event_config_new = &sca3000_read_event_config,
+	.write_event_config_new = &sca3000_write_event_config,
 	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info sca3000_info_with_temp = {
 	.attrs = &sca3000_attribute_group_with_temp,
 	.read_raw = &sca3000_read_raw,
-	.read_event_value = &sca3000_read_thresh,
-	.write_event_value = &sca3000_write_thresh,
-	.read_event_config = &sca3000_read_event_config,
-	.write_event_config = &sca3000_write_event_config,
+	.read_event_value_new = &sca3000_read_thresh,
+	.write_event_value_new = &sca3000_write_thresh,
+	.read_event_config_new = &sca3000_read_event_config,
+	.write_event_config_new = &sca3000_write_event_config,
 	.driver_module = THIS_MODULE,
 };
 
-- 
1.8.0

