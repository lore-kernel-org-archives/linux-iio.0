Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-222.synserver.de ([212.40.185.222]:1406 "EHLO
	smtp-out-222.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab3CYI40 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Mar 2013 04:56:26 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio:trigger: Introduce iio_tigger_{set,get}_drvdata
Date: Mon, 25 Mar 2013 09:58:25 +0100
Message-Id: <1364201906-30884-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Introduce iio_tigger_{set,get}_drvdata which allows to attach driver specific
data to a trigger. The functions wrap access to the triggers private_data field
and all current users are updated to use iio_tigger_{set,get}_drvdata instead of
directly accessing the private_data field. This is the first step towards
removing the private_data field from the iio_trigger struct.

The following coccinelle script has been used to update the drivers:
<smpl>
@@
struct iio_trigger *trigger;
expression priv;
@@
-trigger->private_data = priv
+iio_trigger_set_drv_data(trigger, priv)

@@
struct iio_trigger *trigger;
@@
-trigger->private_data
+iio_trigger_get_drv_data(trigger)
</smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/accel/st_accel_buffer.c                |  2 +-
 drivers/iio/adc/ad_sigma_delta.c                   |  2 +-
 drivers/iio/adc/at91_adc.c                         |  4 ++--
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  4 ++--
 drivers/iio/common/st_sensors/st_sensors_trigger.c |  2 +-
 drivers/iio/gyro/itg3200_buffer.c                  |  4 ++--
 drivers/iio/gyro/st_gyro_buffer.c                  |  2 +-
 drivers/iio/imu/adis_trigger.c                     |  4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |  4 ++--
 drivers/staging/iio/accel/lis3l02dq_ring.c         |  6 +++---
 drivers/staging/iio/adc/mxs-lradc.c                |  4 ++--
 drivers/staging/iio/meter/ade7758_trigger.c        |  6 +++---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |  8 ++++----
 drivers/staging/iio/trigger/iio-trig-gpio.c        |  6 +++---
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    | 12 +++++------
 drivers/staging/iio/trigger/iio-trig-sysfs.c       |  4 ++--
 include/linux/iio/trigger.h                        | 24 ++++++++++++++++++++++
 17 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 6bd82c7..d9b3507 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -25,7 +25,7 @@
 
 int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
 {
-	struct iio_dev *indio_dev = trig->private_data;
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 
 	return st_sensors_set_dataready_irq(indio_dev, state);
 }
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index afe6d78..f0d6335 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -470,7 +470,7 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
 		disable_irq_nosync(sigma_delta->spi->irq);
 	}
 	sigma_delta->trig->dev.parent = &sigma_delta->spi->dev;
-	sigma_delta->trig->private_data = sigma_delta;
+	iio_trigger_set_drvdata(sigma_delta->trig, sigma_delta);
 
 	ret = iio_trigger_register(sigma_delta->trig);
 	if (ret)
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 92eb6a5..6fc43c1 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -188,7 +188,7 @@ static u8 at91_adc_get_trigger_value_by_name(struct iio_dev *idev,
 
 static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 {
-	struct iio_dev *idev = trig->private_data;
+	struct iio_dev *idev = iio_trigger_get_drvdata(trig);
 	struct at91_adc_state *st = iio_priv(idev);
 	struct iio_buffer *buffer = idev->buffer;
 	struct at91_adc_reg_desc *reg = st->registers;
@@ -254,7 +254,7 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
 		return NULL;
 
 	trig->dev.parent = idev->dev.parent;
-	trig->private_data = idev;
+	iio_trigger_set_drvdata(trig, idev);
 	trig->ops = &at91_adc_trigger_ops;
 
 	ret = iio_trigger_register(trig);
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 7a525a9..87419c4 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -31,7 +31,7 @@
 static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	struct hid_sensor_common *st = trig->private_data;
+	struct hid_sensor_common *st = iio_trigger_get_drvdata(trig);
 	int state_val;
 
 	state_val = state ? 1 : 0;
@@ -76,7 +76,7 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 	}
 
 	trig->dev.parent = indio_dev->dev.parent;
-	trig->private_data = attrb;
+	iio_trigger_set_drvdata(trig, attrb);
 	trig->ops = &hid_sensor_trigger_ops;
 	ret = iio_trigger_register(trig);
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 139ed03..8fc3a97 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -40,7 +40,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 	if (err)
 		goto request_irq_error;
 
-	sdata->trig->private_data = indio_dev;
+	iio_trigger_set_drvdata(sdata->trig, indio_dev);
 	sdata->trig->ops = trigger_ops;
 	sdata->trig->dev.parent = sdata->dev;
 
diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index f667d2c..6c43af9 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -81,7 +81,7 @@ void itg3200_buffer_unconfigure(struct iio_dev *indio_dev)
 static int itg3200_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		bool state)
 {
-	struct iio_dev *indio_dev = trig->private_data;
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	int ret;
 	u8 msc;
 
@@ -129,7 +129,7 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
 
 	st->trig->dev.parent = &st->i2c->dev;
 	st->trig->ops = &itg3200_trigger_ops;
-	st->trig->private_data = indio_dev;
+	iio_trigger_set_drvdata(st->trig, indio_dev);
 	ret = iio_trigger_register(st->trig);
 	if (ret)
 		goto error_free_irq;
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index da4d122..69017c7 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -25,7 +25,7 @@
 
 int st_gyro_trig_set_state(struct iio_trigger *trig, bool state)
 {
-	struct iio_dev *indio_dev = trig->private_data;
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 
 	return st_sensors_set_dataready_irq(indio_dev, state);
 }
diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index 5a24c9c..e0017c2 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -19,7 +19,7 @@
 static int adis_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	struct adis *adis = trig->private_data;
+	struct adis *adis = iio_trigger_get_drvdata(trig);
 
 	return adis_enable_irq(adis, state);
 }
@@ -57,7 +57,7 @@ int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 
 	adis->trig->dev.parent = &adis->spi->dev;
 	adis->trig->ops = &adis_trigger_ops;
-	adis->trig->private_data = adis;
+	iio_trigger_set_drvdata(adis->trig, adis);
 	ret = iio_trigger_register(adis->trig);
 
 	indio_dev->trig = adis->trig;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index e1d0869..03b9372 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -103,7 +103,7 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 static int inv_mpu_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	return inv_mpu6050_set_enable(trig->private_data, state);
+	return inv_mpu6050_set_enable(iio_trigger_get_drvdata(trig), state);
 }
 
 static const struct iio_trigger_ops inv_mpu_trigger_ops = {
@@ -130,8 +130,8 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_free_trig;
 	st->trig->dev.parent = &st->client->dev;
-	st->trig->private_data = indio_dev;
 	st->trig->ops = &inv_mpu_trigger_ops;
+	iio_trigger_set_drvdata(st->trig, indio_dev);
 	ret = iio_trigger_register(st->trig);
 	if (ret)
 		goto error_free_irq;
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index e676403..5b8f0f6 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -228,7 +228,7 @@ error_ret:
 static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	struct iio_dev *indio_dev = trig->private_data;
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	int ret = 0;
 	u8 t;
 
@@ -252,7 +252,7 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
  */
 static int lis3l02dq_trig_try_reen(struct iio_trigger *trig)
 {
-	struct iio_dev *indio_dev = trig->private_data;
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
 	int i;
 
@@ -290,7 +290,7 @@ int lis3l02dq_probe_trigger(struct iio_dev *indio_dev)
 
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->ops = &lis3l02dq_trigger_ops;
-	st->trig->private_data = indio_dev;
+	iio_trigger_set_drvdata(st->trig, indio_dev);
 	ret = iio_trigger_register(st->trig);
 	if (ret)
 		goto error_free_trig;
diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 25a4359..eab975d 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -646,7 +646,7 @@ static irqreturn_t mxs_lradc_trigger_handler(int irq, void *p)
 
 static int mxs_lradc_configure_trigger(struct iio_trigger *trig, bool state)
 {
-	struct iio_dev *iio = trig->private_data;
+	struct iio_dev *iio = iio_trigger_get_drvdata(trig);
 	struct mxs_lradc *lradc = iio_priv(iio);
 	const uint32_t st = state ? STMP_OFFSET_REG_SET : STMP_OFFSET_REG_CLR;
 
@@ -670,7 +670,7 @@ static int mxs_lradc_trigger_init(struct iio_dev *iio)
 		return -ENOMEM;
 
 	trig->dev.parent = iio->dev.parent;
-	trig->private_data = iio;
+	iio_trigger_set_drvdata(trig, iio);
 	trig->ops = &mxs_lradc_trigger_ops;
 
 	ret = iio_trigger_register(trig);
diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index f9c6a34..7a94ddd 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -32,7 +32,7 @@ static irqreturn_t ade7758_data_rdy_trig_poll(int irq, void *private)
 static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
-	struct iio_dev *indio_dev = trig->private_data;
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 
 	dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
 	return ade7758_set_irq(&indio_dev->dev, state);
@@ -44,7 +44,7 @@ static int ade7758_data_rdy_trigger_set_state(struct iio_trigger *trig,
  **/
 static int ade7758_trig_try_reen(struct iio_trigger *trig)
 {
-	struct iio_dev *indio_dev = trig->private_data;
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct ade7758_state *st = iio_priv(indio_dev);
 
 	enable_irq(st->us->irq);
@@ -81,7 +81,7 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
 
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->ops = &ade7758_trigger_ops;
-	st->trig->private_data = indio_dev;
+	iio_trigger_set_drvdata(st->trig, indio_dev);
 	ret = iio_trigger_register(st->trig);
 
 	/* select default trigger */
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 42798da..38a158b 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -65,7 +65,7 @@ struct bfin_tmr_state {
 
 static int iio_bfin_tmr_set_state(struct iio_trigger *trig, bool state)
 {
-	struct bfin_tmr_state *st = trig->private_data;
+	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
 
 	if (get_gptimer_period(st->t->id) == 0)
 		return -EINVAL;
@@ -82,7 +82,7 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
-	struct bfin_tmr_state *st = trig->private_data;
+	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
 	unsigned long val;
 	bool enabled;
 	int ret;
@@ -125,7 +125,7 @@ static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
 				 char *buf)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
-	struct bfin_tmr_state *st = trig->private_data;
+	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
 	unsigned int period = get_gptimer_period(st->t->id);
 	unsigned long val;
 
@@ -213,9 +213,9 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
 		goto out1;
 	}
 
-	st->trig->private_data = st;
 	st->trig->ops = &iio_bfin_tmr_trigger_ops;
 	st->trig->dev.groups = iio_bfin_tmr_trigger_attr_groups;
+	iio_trigger_set_drvdata(st->trig, st);
 	ret = iio_trigger_register(st->trig);
 	if (ret)
 		goto out2;
diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
index fcc4cb0..7c593d1 100644
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
@@ -83,7 +83,7 @@ static int iio_gpio_trigger_probe(struct platform_device *pdev)
 				ret = -ENOMEM;
 				goto error_put_trigger;
 			}
-			trig->private_data = trig_info;
+			iio_trigger_set_drvdata(trig, trig_info);
 			trig_info->irq = irq;
 			trig->ops = &iio_gpio_trigger_ops;
 			ret = request_irq(irq, iio_gpio_trigger_poll,
@@ -121,7 +121,7 @@ error_free_completed_registrations:
 				 trig2,
 				 &iio_gpio_trigger_list,
 				 alloc_list) {
-		trig_info = trig->private_data;
+		trig_info = iio_trigger_get_drvdata(trig);
 		free_irq(gpio_to_irq(trig_info->irq), trig);
 		kfree(trig_info);
 		iio_trigger_unregister(trig);
@@ -140,7 +140,7 @@ static int iio_gpio_trigger_remove(struct platform_device *pdev)
 				 trig2,
 				 &iio_gpio_trigger_list,
 				 alloc_list) {
-		trig_info = trig->private_data;
+		trig_info = iio_trigger_get_drvdata(trig);
 		iio_trigger_unregister(trig);
 		free_irq(trig_info->irq, trig);
 		kfree(trig_info);
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index 9102b1b..7969597 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -30,7 +30,7 @@ struct iio_prtc_trigger_info {
 
 static int iio_trig_periodic_rtc_set_state(struct iio_trigger *trig, bool state)
 {
-	struct iio_prtc_trigger_info *trig_info = trig->private_data;
+	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
 	if (trig_info->frequency == 0)
 		return -EINVAL;
 	printk(KERN_INFO "trigger frequency is %d\n", trig_info->frequency);
@@ -42,7 +42,7 @@ static ssize_t iio_trig_periodic_read_freq(struct device *dev,
 					   char *buf)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
-	struct iio_prtc_trigger_info *trig_info = trig->private_data;
+	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
 	return sprintf(buf, "%u\n", trig_info->frequency);
 }
 
@@ -52,7 +52,7 @@ static ssize_t iio_trig_periodic_write_freq(struct device *dev,
 					    size_t len)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
-	struct iio_prtc_trigger_info *trig_info = trig->private_data;
+	struct iio_prtc_trigger_info *trig_info = iio_trigger_get_drvdata(trig);
 	unsigned long val;
 	int ret;
 
@@ -124,7 +124,7 @@ static int iio_trig_periodic_rtc_probe(struct platform_device *dev)
 			ret = -ENOMEM;
 			goto error_put_trigger_and_remove_from_list;
 		}
-		trig->private_data = trig_info;
+		iio_trigger_set_drvdata(trig, trig_info);
 		trig->ops = &iio_prtc_trigger_ops;
 		/* RTC access */
 		trig_info->rtc
@@ -158,7 +158,7 @@ error_free_completed_registrations:
 				 trig2,
 				 &iio_prtc_trigger_list,
 				 alloc_list) {
-		trig_info = trig->private_data;
+		trig_info = iio_trigger_get_drvdata(trig);
 		rtc_irq_unregister(trig_info->rtc, &trig_info->task);
 		rtc_class_close(trig_info->rtc);
 		kfree(trig_info);
@@ -176,7 +176,7 @@ static int iio_trig_periodic_rtc_remove(struct platform_device *dev)
 				 trig2,
 				 &iio_prtc_trigger_list,
 				 alloc_list) {
-		trig_info = trig->private_data;
+		trig_info = iio_trigger_get_drvdata(trig);
 		rtc_irq_unregister(trig_info->rtc, &trig_info->task);
 		rtc_class_close(trig_info->rtc);
 		kfree(trig_info);
diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c b/drivers/staging/iio/trigger/iio-trig-sysfs.c
index 3bac972..b727bde 100644
--- a/drivers/staging/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
@@ -103,7 +103,7 @@ static ssize_t iio_sysfs_trigger_poll(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
-	struct iio_sysfs_trig *sysfs_trig = trig->private_data;
+	struct iio_sysfs_trig *sysfs_trig = iio_trigger_get_drvdata(trig);
 
 	irq_work_queue(&sysfs_trig->work);
 
@@ -160,7 +160,7 @@ static int iio_sysfs_trigger_probe(int id)
 	t->trig->dev.groups = iio_sysfs_trigger_attr_groups;
 	t->trig->ops = &iio_sysfs_trigger_ops;
 	t->trig->dev.parent = &iio_sysfs_trig_dev;
-	t->trig->private_data = t;
+	iio_trigger_set_drvdata(t->trig, t);
 
 	init_irq_work(&t->work, iio_sysfs_trigger_work);
 
diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
index c66e0a9..b81948a 100644
--- a/include/linux/iio/trigger.h
+++ b/include/linux/iio/trigger.h
@@ -92,6 +92,30 @@ static inline void iio_trigger_get(struct iio_trigger *trig)
 }
 
 /**
+ * iio_device_set_drvdata() - Set trigger driver data
+ * @trig: IIO trigger structure
+ * @data: Driver specific data
+ *
+ * Allows to attach an arbitrary pointer to an IIO trigger, which can later be
+ * retrieved by iio_trigger_get_drvdata().
+ */
+static inline void iio_trigger_set_drvdata(struct iio_trigger *trig, void *data)
+{
+	trig->private_data = data;
+}
+
+/**
+ * iio_trigger_get_drvdata() - Get trigger driver data
+ * @trig: IIO trigger structure
+ *
+ * Returns the data previously set with iio_trigger_set_drvdata()
+ */
+static inline void *iio_trigger_get_drvdata(struct iio_trigger *trig)
+{
+	return trig->private_data;
+}
+
+/**
  * iio_trigger_register() - register a trigger with the IIO core
  * @trig_info:	trigger to be registered
  **/
-- 
1.8.0

