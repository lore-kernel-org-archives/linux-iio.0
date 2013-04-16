Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:40447 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935534Ab3DPOiJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Apr 2013 10:38:09 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MLC00JH9RBGLDV0@mailout2.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 16 Apr 2013 23:38:08 +0900 (KST)
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org, achew@nvidia.com
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 2/2] iio: ak8975: Implement data ready interrupt handling
Date: Tue, 16 Apr 2013 16:37:20 +0200
Message-id: <1366123040-17917-3-git-send-email-j.anaszewski@samsung.com>
In-reply-to: <1366123040-17917-1-git-send-email-j.anaszewski@samsung.com>
References: <1366123040-17917-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Implement "data ready" interrupt handling in addition to the
two existing read modes - DRDY GPIO polling and ST1 register
DRDY bit polling.

Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Andrew Chew <achew@nvidia.com>
---
 drivers/iio/magnetometer/ak8975.c |   91 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index eb17eca..d379c4c 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -24,10 +24,11 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
-
+#include <linux/bitops.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 
@@ -83,6 +84,7 @@
  */
 #define AK8975_MAX_CONVERSION_TIMEOUT	500
 #define AK8975_CONVERSION_DONE_POLL_TIME 10
+#define AK8975_DATA_READY_TIMEOUT	((100*HZ)/1000)
 
 /*
  * Per-instance context data for the device.
@@ -95,6 +97,9 @@ struct ak8975_data {
 	long			raw_to_gauss[3];
 	u8			reg_cache[AK8975_MAX_REGS];
 	int			eoc_gpio;
+	int			eoc_irq;
+	wait_queue_head_t	data_ready_queue;
+	unsigned long		flags;
 };
 
 static const int ak8975_index_to_reg[] = {
@@ -124,6 +129,51 @@ static int ak8975_write_data(struct i2c_client *client,
 }
 
 /*
+ * Handle data ready irq
+ */
+static irqreturn_t ak8975_irq_handler(int irq, void *data)
+{
+	struct ak8975_data *ak8975 = data;
+
+	set_bit(0, &ak8975->flags);
+	wake_up(&ak8975->data_ready_queue);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Install data ready interrupt handler
+ */
+static int ak8975_setup_irq(struct ak8975_data *data)
+{
+	struct i2c_client *client = data->client;
+	int rc;
+	int irq;
+
+	if (client->irq)
+		irq = client->irq;
+	else
+		irq = gpio_to_irq(data->eoc_gpio);
+
+	rc = request_irq(irq, ak8975_irq_handler,
+			 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			 dev_name(&client->dev), data);
+	if (rc < 0) {
+		dev_err(&client->dev,
+			"irq %d request failed, (gpio %d): %d\n",
+			irq, data->eoc_gpio, rc);
+		return rc;
+	}
+
+	init_waitqueue_head(&data->data_ready_queue);
+	clear_bit(0, &data->flags);
+	data->eoc_irq = irq;
+
+	return rc;
+}
+
+
+/*
  * Perform some start-of-day setup, including reading the asa calibration
  * values and caching them.
  */
@@ -171,6 +221,16 @@ static int ak8975_setup(struct i2c_client *client)
 				AK8975_REG_CNTL_MODE_POWER_DOWN,
 				AK8975_REG_CNTL_MODE_MASK,
 				AK8975_REG_CNTL_MODE_SHIFT);
+
+	if (data->eoc_gpio > 0 || client->irq) {
+		ret = ak8975_setup_irq(data);
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Error setting data ready interrupt\n");
+			return ret;
+		}
+	}
+
 	if (ret < 0) {
 		dev_err(&client->dev, "Error in setting power-down mode\n");
 		return ret;
@@ -267,9 +327,23 @@ static int wait_conversion_complete_polled(struct ak8975_data *data)
 		dev_err(&client->dev, "Conversion timeout happened\n");
 		return -EINVAL;
 	}
+
 	return read_status;
 }
 
+/* Returns 0 if the end of conversion interrupt occured or -ETIME otherwise */
+static int wait_conversion_complete_interrupt(struct ak8975_data *data)
+{
+	int ret;
+
+	ret = wait_event_timeout(data->data_ready_queue,
+				 test_bit(0, &data->flags),
+				 AK8975_DATA_READY_TIMEOUT);
+	clear_bit(0, &data->flags);
+
+	return ret > 0 ? 0 : -ETIME;
+}
+
 /*
  * Emits the raw flux value for the x, y, or z axis.
  */
@@ -295,13 +369,16 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	}
 
 	/* Wait for the conversion to complete. */
-	if (gpio_is_valid(data->eoc_gpio))
+	if (data->eoc_irq)
+		ret = wait_conversion_complete_interrupt(data);
+	else if (gpio_is_valid(data->eoc_gpio))
 		ret = wait_conversion_complete_gpio(data);
 	else
 		ret = wait_conversion_complete_polled(data);
 	if (ret < 0)
 		goto exit;
 
+	/* This will be executed only for non-interrupt based waiting case */
 	if (ret & AK8975_REG_ST1_DRDY_MASK) {
 		ret = i2c_smbus_read_byte_data(client, AK8975_REG_ST2);
 		if (ret < 0) {
@@ -412,6 +489,11 @@ static int ak8975_probe(struct i2c_client *client,
 	}
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
+
+	data->client = client;
+	data->eoc_gpio = eoc_gpio;
+	data->eoc_irq = 0;
+
 	/* Perform some basic start-of-day setup of the device. */
 	err = ak8975_setup(client);
 	if (err < 0) {
@@ -436,6 +518,8 @@ static int ak8975_probe(struct i2c_client *client,
 
 exit_free_iio:
 	iio_device_free(indio_dev);
+	if (data->eoc_irq)
+		free_irq(data->eoc_irq, NULL);
 exit_gpio:
 	if (gpio_is_valid(eoc_gpio))
 		gpio_free(eoc_gpio);
@@ -450,6 +534,9 @@ static int ak8975_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
+	if (data->eoc_irq)
+		free_irq(data->eoc_irq, NULL);
+
 	if (gpio_is_valid(data->eoc_gpio))
 		gpio_free(data->eoc_gpio);
 
-- 
1.7.5.4

