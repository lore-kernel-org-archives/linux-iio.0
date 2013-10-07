Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-020.synserver.de ([212.40.185.20]:1074 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755425Ab3JGOJ4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 10:09:56 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 20/20] iio: Remove support for the legacy event config interface
Date: Mon,  7 Oct 2013 16:11:34 +0200
Message-Id: <1381155094-20166-20-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-1-git-send-email-lars@metafoo.de>
References: <1381155094-20166-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now that all drivers have been converted to the new event config interface we
can remove for the legacy event config interface. Also drop the '_new' suffix
for the event config interface callbacks, since those are the only callbacks
now.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Only included for completeness, can be applied later.
---
 drivers/iio/adc/max1363.c                  |   8 +-
 drivers/iio/dac/ad5421.c                   |   6 +-
 drivers/iio/industrialio-event.c           | 153 +++++------------------------
 drivers/iio/light/apds9300.c               |   8 +-
 drivers/iio/light/gp2ap020a00f.c           |   8 +-
 drivers/iio/light/tsl2563.c                |   8 +-
 drivers/staging/iio/accel/lis3l02dq_core.c |   8 +-
 drivers/staging/iio/accel/sca3000_core.c   |  16 +--
 drivers/staging/iio/adc/ad7291.c           |   8 +-
 drivers/staging/iio/adc/ad799x_core.c      |   6 +-
 drivers/staging/iio/cdc/ad7150.c           |   8 +-
 drivers/staging/iio/iio_simple_dummy.c     |   8 +-
 drivers/staging/iio/light/tsl2x7x_core.c   |  40 ++++----
 include/linux/iio/events.h                 |   4 -
 include/linux/iio/iio.h                    |  34 +------
 15 files changed, 93 insertions(+), 230 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index cc07b37..66c14f4 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1013,10 +1013,10 @@ static const struct iio_info max1238_info = {
 };
 
 static const struct iio_info max1363_info = {
-	.read_event_value_new = &max1363_read_thresh,
-	.write_event_value_new = &max1363_write_thresh,
-	.read_event_config_new = &max1363_read_event_config,
-	.write_event_config_new = &max1363_write_event_config,
+	.read_event_value = &max1363_read_thresh,
+	.write_event_value = &max1363_write_thresh,
+	.read_event_config = &max1363_read_event_config,
+	.write_event_config = &max1363_write_event_config,
 	.read_raw = &max1363_read_raw,
 	.update_scan_mode = &max1363_update_scan_mode,
 	.driver_module = THIS_MODULE,
diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index c44afeb..54a55ac 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -458,9 +458,9 @@ static int ad5421_read_event_value(struct iio_dev *indio_dev,
 static const struct iio_info ad5421_info = {
 	.read_raw =		ad5421_read_raw,
 	.write_raw =		ad5421_write_raw,
-	.read_event_config_new = ad5421_read_event_config,
-	.write_event_config_new = ad5421_write_event_config,
-	.read_event_value_new =	ad5421_read_event_value,
+	.read_event_config =	ad5421_read_event_config,
+	.write_event_config =	ad5421_write_event_config,
+	.read_event_value =	ad5421_read_event_value,
 	.driver_module =	THIS_MODULE,
 };
 
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 16746b9..0990469 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -225,13 +225,9 @@ static ssize_t iio_ev_state_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	if (indio_dev->info->write_event_config)
-		ret = indio_dev->info->write_event_config(indio_dev,
-			this_attr->address, val);
-	else
-		ret = indio_dev->info->write_event_config_new(indio_dev,
-			this_attr->c, iio_ev_attr_type(this_attr),
-			iio_ev_attr_dir(this_attr), val);
+	ret = indio_dev->info->write_event_config(indio_dev,
+		this_attr->c, iio_ev_attr_type(this_attr),
+		iio_ev_attr_dir(this_attr), val);
 
 	return (ret < 0) ? ret : len;
 }
@@ -244,13 +240,9 @@ static ssize_t iio_ev_state_show(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int val;
 
-	if (indio_dev->info->read_event_config)
-		val = indio_dev->info->read_event_config(indio_dev,
-			this_attr->address);
-	else
-		val = indio_dev->info->read_event_config_new(indio_dev,
-			this_attr->c, iio_ev_attr_type(this_attr),
-			iio_ev_attr_dir(this_attr));
+	val = indio_dev->info->read_event_config(indio_dev,
+		this_attr->c, iio_ev_attr_type(this_attr),
+		iio_ev_attr_dir(this_attr));
 	if (val < 0)
 		return val;
 	else
@@ -266,21 +258,13 @@ static ssize_t iio_ev_value_show(struct device *dev,
 	int val, val2;
 	int ret;
 
-	if (indio_dev->info->read_event_value) {
-		ret = indio_dev->info->read_event_value(indio_dev,
-			this_attr->address, &val);
-		if (ret < 0)
-			return ret;
-		return sprintf(buf, "%d\n", val);
-	} else {
-		ret = indio_dev->info->read_event_value_new(indio_dev,
-			this_attr->c, iio_ev_attr_type(this_attr),
-			iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
-			&val, &val2);
-		if (ret < 0)
-			return ret;
-		return iio_format_value(buf, ret, val, val2);
-	}
+	ret = indio_dev->info->read_event_value(indio_dev,
+		this_attr->c, iio_ev_attr_type(this_attr),
+		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
+		&val, &val2);
+	if (ret < 0)
+		return ret;
+	return iio_format_value(buf, ret, val, val2);
 }
 
 static ssize_t iio_ev_value_store(struct device *dev,
@@ -293,25 +277,16 @@ static ssize_t iio_ev_value_store(struct device *dev,
 	int val, val2;
 	int ret;
 
-	if (!indio_dev->info->write_event_value &&
-		!indio_dev->info->write_event_value_new)
+	if (!indio_dev->info->write_event_value)
 		return -EINVAL;
 
-	if (indio_dev->info->write_event_value) {
-		ret = kstrtoint(buf, 10, &val);
-		if (ret)
-			return ret;
-		ret = indio_dev->info->write_event_value(indio_dev,
-			this_attr->address, val);
-	} else {
-		ret = iio_str_to_fixpoint(buf, 100000, &val, &val2);
-		if (ret)
-			return ret;
-		ret = indio_dev->info->write_event_value_new(indio_dev,
-			this_attr->c, iio_ev_attr_type(this_attr),
-			iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
-			val, val2);
-	}
+	ret = iio_str_to_fixpoint(buf, 100000, &val, &val2);
+	if (ret)
+		return ret;
+	ret = indio_dev->info->write_event_value(indio_dev,
+		this_attr->c, iio_ev_attr_type(this_attr),
+		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
+		val, val2);
 	if (ret < 0)
 		return ret;
 
@@ -360,7 +335,7 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
 	return attrcount;
 }
 
-static int iio_device_add_event_sysfs_new(struct iio_dev *indio_dev,
+static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan)
 {
 	int ret = 0, i, attrcount = 0;
@@ -403,88 +378,6 @@ error_ret:
 	return ret;
 }
 
-static int iio_device_add_event_sysfs_old(struct iio_dev *indio_dev,
-				      struct iio_chan_spec const *chan)
-{
-	int ret = 0, i, attrcount = 0;
-	u64 mask = 0;
-	char *postfix;
-	if (!chan->event_mask)
-		return 0;
-
-	for_each_set_bit(i, &chan->event_mask, sizeof(chan->event_mask)*8) {
-		postfix = kasprintf(GFP_KERNEL, "%s_%s_en",
-				    iio_ev_type_text[i/IIO_EV_DIR_MAX],
-				    iio_ev_dir_text[i%IIO_EV_DIR_MAX]);
-		if (postfix == NULL) {
-			ret = -ENOMEM;
-			goto error_ret;
-		}
-		if (chan->modified)
-			mask = IIO_MOD_EVENT_CODE(chan->type, 0, chan->channel2,
-						  i/IIO_EV_DIR_MAX,
-						  i%IIO_EV_DIR_MAX);
-		else if (chan->differential)
-			mask = IIO_EVENT_CODE(chan->type,
-					      0, 0,
-					      i%IIO_EV_DIR_MAX,
-					      i/IIO_EV_DIR_MAX,
-					      0,
-					      chan->channel,
-					      chan->channel2);
-		else
-			mask = IIO_UNMOD_EVENT_CODE(chan->type,
-						    chan->channel,
-						    i/IIO_EV_DIR_MAX,
-						    i%IIO_EV_DIR_MAX);
-
-		ret = __iio_add_chan_devattr(postfix,
-					     chan,
-					     &iio_ev_state_show,
-					     iio_ev_state_store,
-					     mask,
-					     0,
-					     &indio_dev->dev,
-					     &indio_dev->event_interface->
-					     dev_attr_list);
-		kfree(postfix);
-		if (ret)
-			goto error_ret;
-		attrcount++;
-		postfix = kasprintf(GFP_KERNEL, "%s_%s_value",
-				    iio_ev_type_text[i/IIO_EV_DIR_MAX],
-				    iio_ev_dir_text[i%IIO_EV_DIR_MAX]);
-		if (postfix == NULL) {
-			ret = -ENOMEM;
-			goto error_ret;
-		}
-		ret = __iio_add_chan_devattr(postfix, chan,
-					     iio_ev_value_show,
-					     iio_ev_value_store,
-					     mask,
-					     0,
-					     &indio_dev->dev,
-					     &indio_dev->event_interface->
-					     dev_attr_list);
-		kfree(postfix);
-		if (ret)
-			goto error_ret;
-		attrcount++;
-	}
-	ret = attrcount;
-error_ret:
-	return ret;
-}
-
-static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
-				      struct iio_chan_spec const *chan)
-{
-	if (chan->event_mask)
-		return iio_device_add_event_sysfs_old(indio_dev, chan);
-	else
-		return iio_device_add_event_sysfs_new(indio_dev, chan);
-}
-
 static inline void __iio_remove_event_config_attrs(struct iio_dev *indio_dev)
 {
 	struct iio_dev_attr *p, *n;
@@ -516,8 +409,6 @@ static bool iio_check_for_dynamic_events(struct iio_dev *indio_dev)
 	int j;
 
 	for (j = 0; j < indio_dev->num_channels; j++) {
-		if (indio_dev->channels[j].event_mask != 0)
-			return true;
 		if (indio_dev->channels[j].num_event_specs != 0)
 			return true;
 	}
diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 51097bb..9ddde0c 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -344,10 +344,10 @@ static const struct iio_info apds9300_info_no_irq = {
 static const struct iio_info apds9300_info = {
 	.driver_module		= THIS_MODULE,
 	.read_raw		= apds9300_read_raw,
-	.read_event_value_new	= apds9300_read_thresh,
-	.write_event_value_new	= apds9300_write_thresh,
-	.read_event_config_new	= apds9300_read_interrupt_config,
-	.write_event_config_new	= apds9300_write_interrupt_config,
+	.read_event_value	= apds9300_read_thresh,
+	.write_event_value	= apds9300_write_thresh,
+	.read_event_config	= apds9300_read_interrupt_config,
+	.write_event_config	= apds9300_write_interrupt_config,
 };
 
 static const struct iio_event_spec apds9300_event_spec[] = {
diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 2a65bc3..b63e661 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1387,10 +1387,10 @@ static const struct iio_chan_spec gp2ap020a00f_channels[] = {
 
 static const struct iio_info gp2ap020a00f_info = {
 	.read_raw = &gp2ap020a00f_read_raw,
-	.read_event_value_new = &gp2ap020a00f_read_event_val,
-	.read_event_config_new = &gp2ap020a00f_read_event_config,
-	.write_event_value_new = &gp2ap020a00f_write_event_val,
-	.write_event_config_new = &gp2ap020a00f_write_event_config,
+	.read_event_value = &gp2ap020a00f_read_event_val,
+	.read_event_config = &gp2ap020a00f_read_event_config,
+	.write_event_value = &gp2ap020a00f_write_event_val,
+	.write_event_config = &gp2ap020a00f_write_event_config,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 5e5d9de..f5e36e1 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -702,10 +702,10 @@ static const struct iio_info tsl2563_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &tsl2563_read_raw,
 	.write_raw = &tsl2563_write_raw,
-	.read_event_value_new = &tsl2563_read_thresh,
-	.write_event_value_new = &tsl2563_write_thresh,
-	.read_event_config_new = &tsl2563_read_interrupt_config,
-	.write_event_config_new = &tsl2563_write_interrupt_config,
+	.read_event_value = &tsl2563_read_thresh,
+	.write_event_value = &tsl2563_write_thresh,
+	.read_event_config = &tsl2563_read_interrupt_config,
+	.write_event_config = &tsl2563_write_interrupt_config,
 };
 
 static int tsl2563_probe(struct i2c_client *client,
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index b2d1dfa..4568471 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -676,10 +676,10 @@ static const struct attribute_group lis3l02dq_attribute_group = {
 static const struct iio_info lis3l02dq_info = {
 	.read_raw = &lis3l02dq_read_raw,
 	.write_raw = &lis3l02dq_write_raw,
-	.read_event_value_new = &lis3l02dq_read_thresh,
-	.write_event_value_new = &lis3l02dq_write_thresh,
-	.write_event_config_new = &lis3l02dq_write_event_config,
-	.read_event_config_new = &lis3l02dq_read_event_config,
+	.read_event_value = &lis3l02dq_read_thresh,
+	.write_event_value = &lis3l02dq_write_thresh,
+	.write_event_config = &lis3l02dq_write_event_config,
+	.read_event_config = &lis3l02dq_read_event_config,
 	.driver_module = THIS_MODULE,
 	.attrs = &lis3l02dq_attribute_group,
 };
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index c49e6ef..7f6ccdf 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1126,20 +1126,20 @@ static const struct iio_info sca3000_info = {
 	.attrs = &sca3000_attribute_group,
 	.read_raw = &sca3000_read_raw,
 	.event_attrs = &sca3000_event_attribute_group,
-	.read_event_value_new = &sca3000_read_thresh,
-	.write_event_value_new = &sca3000_write_thresh,
-	.read_event_config_new = &sca3000_read_event_config,
-	.write_event_config_new = &sca3000_write_event_config,
+	.read_event_value = &sca3000_read_thresh,
+	.write_event_value = &sca3000_write_thresh,
+	.read_event_config = &sca3000_read_event_config,
+	.write_event_config = &sca3000_write_event_config,
 	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info sca3000_info_with_temp = {
 	.attrs = &sca3000_attribute_group_with_temp,
 	.read_raw = &sca3000_read_raw,
-	.read_event_value_new = &sca3000_read_thresh,
-	.write_event_value_new = &sca3000_write_thresh,
-	.read_event_config_new = &sca3000_read_event_config,
-	.write_event_config_new = &sca3000_write_event_config,
+	.read_event_value = &sca3000_read_thresh,
+	.write_event_value = &sca3000_write_thresh,
+	.read_event_config = &sca3000_read_event_config,
+	.write_event_config = &sca3000_write_event_config,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index d13f8ae..357cef2 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -452,10 +452,10 @@ static const struct iio_chan_spec ad7291_channels[] = {
 
 static const struct iio_info ad7291_info = {
 	.read_raw = &ad7291_read_raw,
-	.read_event_config_new = &ad7291_read_event_config,
-	.write_event_config_new = &ad7291_write_event_config,
-	.read_event_value_new = &ad7291_read_event_value,
-	.write_event_value_new = &ad7291_write_event_value,
+	.read_event_config = &ad7291_read_event_config,
+	.write_event_config = &ad7291_write_event_config,
+	.read_event_value = &ad7291_read_event_value,
+	.write_event_value = &ad7291_write_event_value,
 	.driver_module = THIS_MODULE,
 };
 
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 9428be8..5ea3641 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -377,9 +377,9 @@ static const struct iio_info ad7991_info = {
 static const struct iio_info ad7993_4_7_8_info = {
 	.read_raw = &ad799x_read_raw,
 	.event_attrs = &ad799x_event_attrs_group,
-	.read_event_config_new = &ad799x_read_event_config,
-	.read_event_value_new = &ad799x_read_event_value,
-	.write_event_value_new = &ad799x_write_event_value,
+	.read_event_config = &ad799x_read_event_config,
+	.read_event_value = &ad799x_read_event_value,
+	.write_event_value = &ad799x_write_event_value,
 	.driver_module = THIS_MODULE,
 	.update_scan_mode = ad7997_8_update_scan_mode,
 };
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 14a28c4..e7b3e14 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -576,10 +576,10 @@ static const struct iio_info ad7150_info = {
 	.event_attrs = &ad7150_event_attribute_group,
 	.driver_module = THIS_MODULE,
 	.read_raw = &ad7150_read_raw,
-	.read_event_config_new = &ad7150_read_event_config,
-	.write_event_config_new = &ad7150_write_event_config,
-	.read_event_value_new = &ad7150_read_event_value,
-	.write_event_value_new = &ad7150_write_event_value,
+	.read_event_config = &ad7150_read_event_config,
+	.write_event_config = &ad7150_write_event_config,
+	.read_event_value = &ad7150_read_event_value,
+	.write_event_value = &ad7150_write_event_value,
 };
 
 /*
diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index cdb8898..d3847fc 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -370,10 +370,10 @@ static const struct iio_info iio_dummy_info = {
 	.read_raw = &iio_dummy_read_raw,
 	.write_raw = &iio_dummy_write_raw,
 #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
-	.read_event_config_new = &iio_simple_dummy_read_event_config,
-	.write_event_config_new = &iio_simple_dummy_write_event_config,
-	.read_event_value_new = &iio_simple_dummy_read_event_value,
-	.write_event_value_new = &iio_simple_dummy_write_event_value,
+	.read_event_config = &iio_simple_dummy_read_event_config,
+	.write_event_config = &iio_simple_dummy_write_event_config,
+	.read_event_value = &iio_simple_dummy_read_event_value,
+	.write_event_value = &iio_simple_dummy_write_event_value,
 #endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS */
 };
 
diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 1880502..1e53808 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1672,10 +1672,10 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value_new = &tsl2x7x_read_thresh,
-		.write_event_value_new = &tsl2x7x_write_thresh,
-		.read_event_config_new = &tsl2x7x_read_interrupt_config,
-		.write_event_config_new = &tsl2x7x_write_interrupt_config,
+		.read_event_value = &tsl2x7x_read_thresh,
+		.write_event_value = &tsl2x7x_write_thresh,
+		.read_event_config = &tsl2x7x_read_interrupt_config,
+		.write_event_config = &tsl2x7x_write_interrupt_config,
 	},
 	[PRX] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[PRX],
@@ -1683,10 +1683,10 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value_new = &tsl2x7x_read_thresh,
-		.write_event_value_new = &tsl2x7x_write_thresh,
-		.read_event_config_new = &tsl2x7x_read_interrupt_config,
-		.write_event_config_new = &tsl2x7x_write_interrupt_config,
+		.read_event_value = &tsl2x7x_read_thresh,
+		.write_event_value = &tsl2x7x_write_thresh,
+		.read_event_config = &tsl2x7x_read_interrupt_config,
+		.write_event_config = &tsl2x7x_write_interrupt_config,
 	},
 	[ALSPRX] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX],
@@ -1694,10 +1694,10 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value_new = &tsl2x7x_read_thresh,
-		.write_event_value_new = &tsl2x7x_write_thresh,
-		.read_event_config_new = &tsl2x7x_read_interrupt_config,
-		.write_event_config_new = &tsl2x7x_write_interrupt_config,
+		.read_event_value = &tsl2x7x_read_thresh,
+		.write_event_value = &tsl2x7x_write_thresh,
+		.read_event_config = &tsl2x7x_read_interrupt_config,
+		.write_event_config = &tsl2x7x_write_interrupt_config,
 	},
 	[PRX2] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[PRX2],
@@ -1705,10 +1705,10 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value_new = &tsl2x7x_read_thresh,
-		.write_event_value_new = &tsl2x7x_write_thresh,
-		.read_event_config_new = &tsl2x7x_read_interrupt_config,
-		.write_event_config_new = &tsl2x7x_write_interrupt_config,
+		.read_event_value = &tsl2x7x_read_thresh,
+		.write_event_value = &tsl2x7x_write_thresh,
+		.read_event_config = &tsl2x7x_read_interrupt_config,
+		.write_event_config = &tsl2x7x_write_interrupt_config,
 	},
 	[ALSPRX2] = {
 		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX2],
@@ -1716,10 +1716,10 @@ static const struct iio_info tsl2X7X_device_info[] = {
 		.driver_module = THIS_MODULE,
 		.read_raw = &tsl2x7x_read_raw,
 		.write_raw = &tsl2x7x_write_raw,
-		.read_event_value_new = &tsl2x7x_read_thresh,
-		.write_event_value_new = &tsl2x7x_write_thresh,
-		.read_event_config_new = &tsl2x7x_read_interrupt_config,
-		.write_event_config_new = &tsl2x7x_write_interrupt_config,
+		.read_event_value = &tsl2x7x_read_thresh,
+		.write_event_value = &tsl2x7x_write_thresh,
+		.read_event_config = &tsl2x7x_read_interrupt_config,
+		.write_event_config = &tsl2x7x_write_interrupt_config,
 	},
 };
 
diff --git a/include/linux/iio/events.h b/include/linux/iio/events.h
index 5dab2c4..8bbd7bc 100644
--- a/include/linux/iio/events.h
+++ b/include/linux/iio/events.h
@@ -46,10 +46,6 @@ struct iio_event_data {
 	 ((u16)chan))
 
 
-#define IIO_EV_DIR_MAX 4
-#define IIO_EV_BIT(type, direction)			\
-	(1 << (type*IIO_EV_DIR_MAX + direction))
-
 /**
  * IIO_MOD_EVENT_CODE() - create event identifier for modified channels
  * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 256a90a..1c40a05 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -185,7 +185,6 @@ struct iio_event_spec {
  *			by all channels of the same direction.
  * @info_mask_shared_by_all: What information is to be exported that is shared
  *			by all channels.
- * @event_mask:		What events can this channel produce.
  * @event_spec:		Array of events which should be registered for this
  *			channel.
  * @num_event_specs:	Size of the event_spec array.
@@ -226,7 +225,6 @@ struct iio_chan_spec {
 	long			info_mask_shared_by_type;
 	long			info_mask_shared_by_dir;
 	long			info_mask_shared_by_all;
-	long			event_mask;
 	const struct iio_event_spec *event_spec;
 	unsigned int		num_event_specs;
 	const struct iio_chan_spec_ext_info *ext_info;
@@ -307,16 +305,8 @@ struct iio_dev;
  *			returns IIO_VAL_INT_PLUS_MICRO.
  * @read_event_config:	find out if the event is enabled.
  * @write_event_config:	set if the event is enabled.
- * @read_event_value:	read a value associated with the event. Meaning
- *			is event dependant. event_code specifies which event.
- * @write_event_value:	write the value associated with the event.
- *			Meaning is event dependent.
- * @read_event_config_new: find out if the event is enabled. New style interface.
- * @write_event_config_new: set if the event is enabled. New style interface.
- * @read_event_value_new: read a configuration value associated with the event.
- *                         New style interface.
- * @write_event_value_new: write a configuration value for the event. New style
- *			   interface.
+ * @read_event_value:	read a configuration value associated with the event.
+ * @write_event_value:	write a configuration value for the event.
  * @validate_trigger:	function to validate the trigger when the
  *			current trigger gets changed.
  * @update_scan_mode:	function to configure device and scan buffer when
@@ -345,37 +335,23 @@ struct iio_info {
 			 long mask);
 
 	int (*read_event_config)(struct iio_dev *indio_dev,
-				 u64 event_code);
-
-	int (*write_event_config)(struct iio_dev *indio_dev,
-				  u64 event_code,
-				  int state);
-
-	int (*read_event_value)(struct iio_dev *indio_dev,
-				u64 event_code,
-				int *val);
-	int (*write_event_value)(struct iio_dev *indio_dev,
-				 u64 event_code,
-				 int val);
-
-	int (*read_event_config_new)(struct iio_dev *indio_dev,
 				 const struct iio_chan_spec *chan,
 				 enum iio_event_type type,
 				 enum iio_event_direction dir);
 
-	int (*write_event_config_new)(struct iio_dev *indio_dev,
+	int (*write_event_config)(struct iio_dev *indio_dev,
 				  const struct iio_chan_spec *chan,
 				  enum iio_event_type type,
 				  enum iio_event_direction dir,
 				  int state);
 
-	int (*read_event_value_new)(struct iio_dev *indio_dev,
+	int (*read_event_value)(struct iio_dev *indio_dev,
 				const struct iio_chan_spec *chan,
 				enum iio_event_type type,
 				enum iio_event_direction dir,
 				enum iio_event_info info, int *val, int *val2);
 
-	int (*write_event_value_new)(struct iio_dev *indio_dev,
+	int (*write_event_value)(struct iio_dev *indio_dev,
 				 const struct iio_chan_spec *chan,
 				 enum iio_event_type type,
 				 enum iio_event_direction dir,
-- 
1.8.0

