Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41024 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966549AbbDWQ2V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 23 Apr 2015 12:28:21 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: octavian.purdila@intel.com, jic23@kernel.org
Cc: daniel.baluta@intel.com, srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org
Subject: [RFC PATCH] iio: accel: kxcjk1013: Use polling when IRQ is not available
Date: Thu, 23 Apr 2015 19:30:15 +0300
Message-Id: <1429806615-25167-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This sets up a delayed work with polling period depending on
device's sampling rate and it's a faster alternative to user
sysfs attributes polling.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
This is just an RFC to see if we are on the same page in the problem
of using an IIO triggered buffer even if we don't have an interrupt
source.

In my opinion the cleanest and less error prone solution is to use
an external hrtimer based trigger as implemented in this patchseries:

* https://lkml.org/lkml/2015/4/20/319

We tested this and it fits our needs, it also has the advantage that
we don't have to modify the drivers.

Jonathan, proposed that each driver should internally poll for the status
of the device and read data when available.

* https://lkml.org/lkml/2015/4/15/575

This is exactly the functionality introduced by this patch. Sure we can factor
out some of these functions in the IIO core, but as it is right now this patch
is intrusive and I'm not sure it covers all corner cases.

One thing that I want to bring into discussion is that polling the status of
data ready it is somehow useless. Polling at a rate near to sampling frequency
data will always be ready. Testes showed that 98% of time the poll handler
found the DRDY bit set, thus making the I2C transaction useless. Also, by using
this approach we cannot offer poll intervals smaller than 1ms.

What do you think? :)

 drivers/iio/accel/kxcjk-1013.c | 145 ++++++++++++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index df6f5d7..08b3abe 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -76,6 +76,9 @@
 
 #define KXCJK1013_SLEEP_DELAY_MS	2000
 
+#define KXCJK1013_REG_INT_SRC1_BIT_WUFS	BIT(0)
+#define KXCJK1013_REG_INT_SRC1_BIT_DRDY	BIT(4)
+
 #define KXCJK1013_REG_INT_SRC2_BIT_ZP	BIT(0)
 #define KXCJK1013_REG_INT_SRC2_BIT_ZN	BIT(1)
 #define KXCJK1013_REG_INT_SRC2_BIT_YP	BIT(2)
@@ -109,6 +112,11 @@ struct kxcjk1013_data {
 	int64_t timestamp;
 	enum kx_chipset chipset;
 	bool is_smo8500_device;
+
+	/* used for polling dataready when no IRQ is available */
+	struct delayed_work work;
+	unsigned int poll_interval;
+	bool use_poll;
 };
 
 enum kxcjk1013_axis {
@@ -215,6 +223,8 @@ static const struct {
 				 {800, 0, 0x06},
 				 {1600, 0, 0x06} };
 
+static int kxcjk1013_setup_pollinterval(struct kxcjk1013_data *data);
+
 static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 			      enum kxcjk1013_mode mode)
 {
@@ -333,6 +343,10 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 
 	data->odr_bits = ret;
 
+	ret = kxcjk1013_setup_pollinterval(data);
+	if (ret < 0)
+		return ret;
+
 	/* Set up INT polarity */
 	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_CTRL1);
 	if (ret < 0) {
@@ -376,6 +390,15 @@ static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
 }
 #endif
 
+void kxcjk1013_setup_delayed_work(struct kxcjk1013_data *data, bool on)
+{
+	if (on)
+		schedule_delayed_work(&data->work,
+				      msecs_to_jiffies(data->poll_interval));
+	else
+		cancel_delayed_work(&data->work);
+}
+
 static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 {
 #ifdef CONFIG_PM
@@ -395,6 +418,8 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 		return ret;
 	}
 #endif
+	if (data->use_poll)
+		kxcjk1013_setup_delayed_work(data, on);
 
 	return 0;
 }
@@ -603,6 +628,10 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 
 	data->odr_bits = odr_bits;
 
+	ret = kxcjk1013_setup_pollinterval(data);
+	if (ret < 0)
+		return ret;
+
 	odr_bits = kxcjk1013_convert_wake_odr_to_bit(val, val2);
 	if (odr_bits < 0)
 		return odr_bits;
@@ -638,6 +667,26 @@ static int kxcjk1013_get_odr(struct kxcjk1013_data *data, int *val, int *val2)
 	return -EINVAL;
 }
 
+/*
+ * get an approximation of poll interval based on sampling frequency
+ */
+static int kxcjk1013_setup_pollinterval(struct kxcjk1013_data *data)
+{
+	int val, val2;
+	int ret;
+
+	ret = kxcjk1013_get_odr(data, &val, &val2);
+	if (ret < 0)
+		return ret;
+	if (val2)
+		val++;
+
+	data->poll_interval = MSEC_PER_SEC / val;
+	pr_info("Poll interval is %d\n", data->poll_interval);
+
+	return 0;
+}
+
 static int kxcjk1013_get_acc_reg(struct kxcjk1013_data *data, int axis)
 {
 	u8 reg = KXCJK1013_REG_XOUT_L + axis * 2;
@@ -1147,6 +1196,34 @@ static irqreturn_t kxcjk1013_data_rdy_trig_poll(int irq, void *private)
 		return IRQ_HANDLED;
 }
 
+static void kxcjk1013_poll_handler(struct work_struct *work)
+{
+	struct kxcjk1013_data *data;
+	struct iio_dev *indio_dev;
+	struct delayed_work *delay = to_delayed_work(work);
+	int ret;
+
+	data = container_of(delay, struct kxcjk1013_data, work);
+	indio_dev = iio_priv_to_dev(data);
+
+	data->timestamp = iio_get_time_ns();
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_SRC1);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
+		return;
+	}
+
+	if (data->dready_trigger_on && (ret & KXCJK1013_REG_INT_SRC1_BIT_DRDY))
+		irq_wake_thread(indio_dev->pollfunc->irq, indio_dev);
+
+	if (data->motion_trigger_on && (ret & KXCJK1013_REG_INT_SRC1_BIT_WUFS))
+		irq_wake_thread(indio_dev->pollfunc->irq, indio_dev);
+
+
+	schedule_delayed_work(&data->work,
+			      msecs_to_jiffies(data->poll_interval));
+}
+
 static const char *kxcjk1013_match_acpi_device(struct device *dev,
 					       enum kx_chipset *chipset,
 					       bool *is_smo8500_device)
@@ -1249,42 +1326,46 @@ static int kxcjk1013_probe(struct i2c_client *client,
 						indio_dev);
 		if (ret)
 			goto err_poweroff;
+	} else {
+		INIT_DELAYED_WORK(&data->work, kxcjk1013_poll_handler);
+		data->use_poll = true;
+	}
 
-		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
-							   "%s-dev%d",
-							   indio_dev->name,
-							   indio_dev->id);
-		if (!data->dready_trig) {
-			ret = -ENOMEM;
-			goto err_poweroff;
-		}
+	data->dready_trig = devm_iio_trigger_alloc(&client->dev,
+						   "%s-dev%d",
+						   indio_dev->name,
+						   indio_dev->id);
+	if (!data->dready_trig) {
+		ret = -ENOMEM;
+		goto err_poweroff;
+	}
 
-		data->motion_trig = devm_iio_trigger_alloc(&client->dev,
-							  "%s-any-motion-dev%d",
-							  indio_dev->name,
-							  indio_dev->id);
-		if (!data->motion_trig) {
-			ret = -ENOMEM;
-			goto err_poweroff;
-		}
+	data->motion_trig = devm_iio_trigger_alloc(&client->dev,
+						  "%s-any-motion-dev%d",
+						  indio_dev->name,
+						  indio_dev->id);
+	if (!data->motion_trig) {
 
-		data->dready_trig->dev.parent = &client->dev;
-		data->dready_trig->ops = &kxcjk1013_trigger_ops;
-		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
-		indio_dev->trig = data->dready_trig;
-		iio_trigger_get(indio_dev->trig);
-		ret = iio_trigger_register(data->dready_trig);
-		if (ret)
-			goto err_poweroff;
+		ret = -ENOMEM;
+		goto err_poweroff;
+	}
 
-		data->motion_trig->dev.parent = &client->dev;
-		data->motion_trig->ops = &kxcjk1013_trigger_ops;
-		iio_trigger_set_drvdata(data->motion_trig, indio_dev);
-		ret = iio_trigger_register(data->motion_trig);
-		if (ret) {
-			data->motion_trig = NULL;
-			goto err_trigger_unregister;
-		}
+	data->dready_trig->dev.parent = &client->dev;
+	data->dready_trig->ops = &kxcjk1013_trigger_ops;
+	iio_trigger_set_drvdata(data->dready_trig, indio_dev);
+	indio_dev->trig = data->dready_trig;
+	iio_trigger_get(indio_dev->trig);
+	ret = iio_trigger_register(data->dready_trig);
+	if (ret)
+		goto err_poweroff;
+
+	data->motion_trig->dev.parent = &client->dev;
+	data->motion_trig->ops = &kxcjk1013_trigger_ops;
+	iio_trigger_set_drvdata(data->motion_trig, indio_dev);
+	ret = iio_trigger_register(data->motion_trig);
+	if (ret) {
+		data->motion_trig = NULL;
+		goto err_trigger_unregister;
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev,
-- 
1.9.1

