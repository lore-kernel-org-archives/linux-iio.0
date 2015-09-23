Return-Path: <octavian.purdila@intel.com>
From: Octavian Purdila <octavian.purdila@intel.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: srinivas.pandruvada@linux.intel.com,
	hadess@hadess.net,
	daniel.baluta@intel.com,
	irina.tirdea@intel.com,
	ao2@ao2.it,
	u.kleine-koenig@pengutronix.de,
	vlad.dogaru@intel.com,
	linus.walleij@linaro.org,
	tiberiu.a.breana@intel.com,
	javier@osg.samsung.com,
	dan.carpenter@oracle.com,
	geert@linux-m68k.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH 2/2] iio: remove gpio interrupt probing from drivers that use a single interrupt
Date: Wed, 23 Sep 2015 12:02:01 +0300
Message-Id: <1442998921-17665-3-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1442998921-17665-1-git-send-email-octavian.purdila@intel.com>
References: <1442998921-17665-1-git-send-email-octavian.purdila@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Commit 845c877009cf014b ("i2c / ACPI: Assign IRQ for devices that have
GpioInt automatically") automatically asigns the first ACPI GPIO
interrupt in client->irq, so we can remove the probing code from
drivers that use only one interrupt.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/iio/accel/bmc150-accel.c       | 30 ---------------------------
 drivers/iio/accel/kxcjk-1013.c         | 34 +------------------------------
 drivers/iio/accel/mma9553.c            | 29 --------------------------
 drivers/iio/accel/stk8312.c            | 28 -------------------------
 drivers/iio/accel/stk8ba50.c           | 28 -------------------------
 drivers/iio/imu/kmx61.c                | 28 -------------------------
 drivers/iio/light/stk3310.c            | 37 ----------------------------------
 drivers/iio/magnetometer/bmc150_magn.c | 33 ------------------------------
 drivers/iio/proximity/sx9500.c         |  9 ---------
 9 files changed, 1 insertion(+), 255 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 0104cde..6d19d46 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -38,7 +38,6 @@
 
 #define BMC150_ACCEL_DRV_NAME			"bmc150_accel"
 #define BMC150_ACCEL_IRQ_NAME			"bmc150_accel_event"
-#define BMC150_ACCEL_GPIO_NAME			"bmc150_accel_int"
 
 #define BMC150_ACCEL_REG_CHIP_ID		0x00
 
@@ -1360,32 +1359,6 @@ static irqreturn_t bmc150_accel_irq_handler(int irq, void *private)
 	return IRQ_NONE;
 }
 
-static int bmc150_accel_gpio_probe(struct i2c_client *client,
-				   struct bmc150_accel_data *data)
-{
-	struct device *dev;
-	struct gpio_desc *gpio;
-	int ret;
-
-	if (!client)
-		return -EINVAL;
-
-	dev = &client->dev;
-
-	/* data ready gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, BMC150_ACCEL_GPIO_NAME, 0, GPIOD_IN);
-	if (IS_ERR(gpio)) {
-		dev_err(dev, "Failed: gpio get index\n");
-		return PTR_ERR(gpio);
-	}
-
-	ret = gpiod_to_irq(gpio);
-
-	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
-
-	return ret;
-}
-
 static const struct {
 	int intr;
 	const char *name;
@@ -1659,9 +1632,6 @@ static int bmc150_accel_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (client->irq < 0)
-		client->irq = bmc150_accel_gpio_probe(client, data);
-
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(
 						&client->dev, client->irq,
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 3292bc0..18c1b06 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1162,35 +1162,6 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
 	return dev_name(dev);
 }
 
-static int kxcjk1013_gpio_probe(struct i2c_client *client,
-				struct kxcjk1013_data *data)
-{
-	struct device *dev;
-	struct gpio_desc *gpio;
-	int ret;
-
-	if (!client)
-		return -EINVAL;
-
-	if (data->is_smo8500_device)
-		return -ENOTSUPP;
-
-	dev = &client->dev;
-
-	/* data ready gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, "kxcjk1013_int", 0, GPIOD_IN);
-	if (IS_ERR(gpio)) {
-		dev_err(dev, "acpi gpio get index failed\n");
-		return PTR_ERR(gpio);
-	}
-
-	ret = gpiod_to_irq(gpio);
-
-	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
-
-	return ret;
-}
-
 static int kxcjk1013_probe(struct i2c_client *client,
 			   const struct i2c_device_id *id)
 {
@@ -1237,10 +1208,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &kxcjk1013_info;
 
-	if (client->irq < 0)
-		client->irq = kxcjk1013_gpio_probe(client, data);
-
-	if (client->irq > 0) {
+	if (client->irq > 0 && !data->is_smo8500_device) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						kxcjk1013_data_rdy_trig_poll,
 						kxcjk1013_event_handler,
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 771858c..9408ef3 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -26,7 +26,6 @@
 
 #define MMA9553_DRV_NAME			"mma9553"
 #define MMA9553_IRQ_NAME			"mma9553_event"
-#define MMA9553_GPIO_NAME			"mma9553_int"
 
 /* Pedometer configuration registers (R/W) */
 #define MMA9553_REG_CONF_SLEEPMIN		0x00
@@ -1073,31 +1072,6 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static int mma9553_gpio_probe(struct i2c_client *client)
-{
-	struct device *dev;
-	struct gpio_desc *gpio;
-	int ret;
-
-	if (!client)
-		return -EINVAL;
-
-	dev = &client->dev;
-
-	/* data ready GPIO interrupt pin */
-	gpio = devm_gpiod_get_index(dev, MMA9553_GPIO_NAME, 0, GPIOD_IN);
-	if (IS_ERR(gpio)) {
-		dev_err(dev, "ACPI GPIO get index failed\n");
-		return PTR_ERR(gpio);
-	}
-
-	ret = gpiod_to_irq(gpio);
-
-	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
-
-	return ret;
-}
-
 static const char *mma9553_match_acpi_device(struct device *dev)
 {
 	const struct acpi_device_id *id;
@@ -1146,9 +1120,6 @@ static int mma9553_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mma9553_info;
 
-	if (client->irq < 0)
-		client->irq = mma9553_gpio_probe(client);
-
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						mma9553_irq_handler,
diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index a578694..85fe7f7 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -50,7 +50,6 @@
 #define STK8312_ALL_CHANNEL_SIZE	3
 
 #define STK8312_DRIVER_NAME		"stk8312"
-#define STK8312_GPIO			"stk8312_gpio"
 #define STK8312_IRQ_NAME		"stk8312_event"
 
 /*
@@ -504,30 +503,6 @@ static const struct iio_buffer_setup_ops stk8312_buffer_setup_ops = {
 	.postdisable = stk8312_buffer_postdisable,
 };
 
-static int stk8312_gpio_probe(struct i2c_client *client)
-{
-	struct device *dev;
-	struct gpio_desc *gpio;
-	int ret;
-
-	if (!client)
-		return -EINVAL;
-
-	dev = &client->dev;
-
-	/* data ready gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, STK8312_GPIO, 0, GPIOD_IN);
-	if (IS_ERR(gpio)) {
-		dev_err(dev, "acpi gpio get index failed\n");
-		return PTR_ERR(gpio);
-	}
-
-	ret = gpiod_to_irq(gpio);
-	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
-
-	return ret;
-}
-
 static int stk8312_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -569,9 +544,6 @@ static int stk8312_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	if (client->irq < 0)
-		client->irq = stk8312_gpio_probe(client);
-
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						stk8312_data_rdy_trig_poll,
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index a59f5d8..5709d9e 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -45,7 +45,6 @@
 #define STK8BA50_ALL_CHANNEL_SIZE		6
 
 #define STK8BA50_DRIVER_NAME			"stk8ba50"
-#define STK8BA50_GPIO				"stk8ba50_gpio"
 #define STK8BA50_IRQ_NAME			"stk8ba50_event"
 
 #define STK8BA50_SCALE_AVAIL			"0.0384 0.0767 0.1534 0.3069"
@@ -388,30 +387,6 @@ static const struct iio_buffer_setup_ops stk8ba50_buffer_setup_ops = {
 	.postdisable = stk8ba50_buffer_postdisable,
 };
 
-static int stk8ba50_gpio_probe(struct i2c_client *client)
-{
-	struct device *dev;
-	struct gpio_desc *gpio;
-	int ret;
-
-	if (!client)
-		return -EINVAL;
-
-	dev = &client->dev;
-
-	/* data ready gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, STK8BA50_GPIO, 0, GPIOD_IN);
-	if (IS_ERR(gpio)) {
-		dev_err(dev, "acpi gpio get index failed\n");
-		return PTR_ERR(gpio);
-	}
-
-	ret = gpiod_to_irq(gpio);
-	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
-
-	return ret;
-}
-
 static int stk8ba50_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -465,9 +440,6 @@ static int stk8ba50_probe(struct i2c_client *client,
 		goto err_power_off;
 	}
 
-	if (client->irq < 0)
-		client->irq = stk8ba50_gpio_probe(client);
-
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						stk8ba50_data_rdy_trig_poll,
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 82cdf50..dbf5e99 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -27,7 +27,6 @@
 #include <linux/iio/trigger_consumer.h>
 
 #define KMX61_DRV_NAME "kmx61"
-#define KMX61_GPIO_NAME "kmx61_int"
 #define KMX61_IRQ_NAME "kmx61_event"
 
 #define KMX61_REG_WHO_AM_I	0x00
@@ -1243,30 +1242,6 @@ static const char *kmx61_match_acpi_device(struct device *dev)
 	return dev_name(dev);
 }
 
-static int kmx61_gpio_probe(struct i2c_client *client, struct kmx61_data *data)
-{
-	struct device *dev;
-	struct gpio_desc *gpio;
-	int ret;
-
-	if (!client)
-		return -EINVAL;
-
-	dev = &client->dev;
-
-	/* data ready gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, KMX61_GPIO_NAME, 0, GPIOD_IN);
-	if (IS_ERR(gpio)) {
-		dev_err(dev, "acpi gpio get index failed\n");
-		return PTR_ERR(gpio);
-	}
-
-	ret = gpiod_to_irq(gpio);
-
-	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
-	return ret;
-}
-
 static struct iio_dev *kmx61_indiodev_setup(struct kmx61_data *data,
 					    const struct iio_info *info,
 					    const struct iio_chan_spec *chan,
@@ -1360,9 +1335,6 @@ static int kmx61_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	if (client->irq < 0)
-		client->irq = kmx61_gpio_probe(client, data);
-
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						kmx61_data_rdy_trig_poll,
diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 4e56c90..42d334b 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -47,7 +47,6 @@
 #define STK3310_DRIVER_NAME			"stk3310"
 #define STK3310_REGMAP_NAME			"stk3310_regmap"
 #define STK3310_EVENT				"stk3310_event"
-#define STK3310_GPIO				"stk3310_gpio"
 
 #define STK3310_SCALE_AVAILABLE			"6.4 1.6 0.4 0.1"
 
@@ -477,34 +476,6 @@ static int stk3310_init(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int stk3310_gpio_probe(struct i2c_client *client)
-{
-	struct device *dev;
-	struct gpio_desc *gpio;
-	int ret;
-
-	if (!client)
-		return -EINVAL;
-
-	dev = &client->dev;
-
-	/* gpio interrupt pin */
-	gpio = devm_gpiod_get_index(dev, STK3310_GPIO, 0);
-	if (IS_ERR(gpio)) {
-		dev_err(dev, "acpi gpio get index failed\n");
-		return PTR_ERR(gpio);
-	}
-
-	ret = gpiod_direction_input(gpio);
-	if (ret)
-		return ret;
-
-	ret = gpiod_to_irq(gpio);
-	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
-
-	return ret;
-}
-
 static bool stk3310_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -628,14 +599,6 @@ static int stk3310_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	if (client->irq < 0) {
-		client->irq = stk3310_gpio_probe(client);
-		if (client->irq < 0) {
-			ret = client->irq;
-			goto err_standby;
-		}
-	}
-
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						stk3310_irq_handler,
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index e330205..1615b23 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -37,7 +37,6 @@
 
 #define BMC150_MAGN_DRV_NAME			"bmc150_magn"
 #define BMC150_MAGN_IRQ_NAME			"bmc150_magn_event"
-#define BMC150_MAGN_GPIO_INT			"interrupt"
 
 #define BMC150_MAGN_REG_CHIP_ID			0x40
 #define BMC150_MAGN_CHIP_ID_VAL			0x32
@@ -833,35 +832,6 @@ static const struct iio_buffer_setup_ops bmc150_magn_buffer_setup_ops = {
 	.postdisable = bmc150_magn_buffer_postdisable,
 };
 
-static int bmc150_magn_gpio_probe(struct i2c_client *client)
-{
-	struct device *dev;
-	struct gpio_desc *gpio;
-	int ret;
-
-	if (!client)
-		return -EINVAL;
-
-	dev = &client->dev;
-
-	/* data ready GPIO interrupt pin */
-	gpio = devm_gpiod_get_index(dev, BMC150_MAGN_GPIO_INT, 0);
-	if (IS_ERR(gpio)) {
-		dev_err(dev, "ACPI GPIO get index failed\n");
-		return PTR_ERR(gpio);
-	}
-
-	ret = gpiod_direction_input(gpio);
-	if (ret)
-		return ret;
-
-	ret = gpiod_to_irq(gpio);
-
-	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
-
-	return ret;
-}
-
 static const char *bmc150_magn_match_acpi_device(struct device *dev)
 {
 	const struct acpi_device_id *id;
@@ -915,9 +885,6 @@ static int bmc150_magn_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmc150_magn_info;
 
-	if (client->irq <= 0)
-		client->irq = bmc150_magn_gpio_probe(client);
-
 	if (client->irq > 0) {
 		data->dready_trig = devm_iio_trigger_alloc(&client->dev,
 							   "%s-dev%d",
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 3d756bd..66cd09a 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -868,21 +868,12 @@ static void sx9500_gpio_probe(struct i2c_client *client,
 			      struct sx9500_data *data)
 {
 	struct device *dev;
-	struct gpio_desc *gpio;
 
 	if (!client)
 		return;
 
 	dev = &client->dev;
 
-	if (client->irq <= 0) {
-		gpio = devm_gpiod_get_index(dev, SX9500_GPIO_INT, 0, GPIOD_IN);
-		if (IS_ERR(gpio))
-			dev_err(dev, "gpio get irq failed\n");
-		else
-			client->irq = gpiod_to_irq(gpio);
-	}
-
 	data->gpiod_rst = devm_gpiod_get_index(dev, SX9500_GPIO_RESET,
 					       0, GPIOD_OUT_HIGH);
 	if (IS_ERR(data->gpiod_rst)) {
-- 
1.9.1
