Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:41222 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934923AbaGPSdG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Jul 2014 14:33:06 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 06/13] iio:bma180: Use bool instead of int for state
Date: Wed, 16 Jul 2014 20:32:49 +0200
Message-Id: <1405535576-26482-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
References: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 284598d..aa7566f 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -62,11 +62,8 @@
 #define BMA180_LOW_NOISE	0x00
 #define BMA180_LOW_POWER	0x03
 
-#define BMA180_LOW_NOISE_STR	"low_noise"
-#define BMA180_LOW_POWER_STR	"low_power"
-
 /* Defaults values */
-#define BMA180_DEF_PMODE	0
+#define BMA180_DEF_PMODE	false
 #define BMA180_DEF_BW		20
 #define BMA180_DEF_SCALE	2452
 
@@ -80,10 +77,10 @@ struct bma180_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
 	struct mutex mutex;
-	int sleep_state;
+	bool sleep_state;
 	int scale;
 	int bw;
-	int pmode;
+	bool pmode;
 	char *buff;
 };
 
@@ -133,7 +130,7 @@ static int bma180_reset_intr(struct bma180_data *data)
 	return ret;
 }
 
-static int bma180_set_new_data_intr_state(struct bma180_data *data, int state)
+static int bma180_set_new_data_intr_state(struct bma180_data *data, bool state)
 {
 	u8 reg_val = state ? BMA180_NEW_DATA_INT : 0x00;
 	int ret = i2c_smbus_write_byte_data(data->client, BMA180_CTRL_REG3,
@@ -153,7 +150,7 @@ err:
 	return ret;
 }
 
-static int bma180_set_sleep_state(struct bma180_data *data, int state)
+static int bma180_set_sleep_state(struct bma180_data *data, bool state)
 {
 	int ret = bma180_set_bits(data, BMA180_CTRL_REG0, BMA180_SLEEP, state);
 
@@ -167,7 +164,7 @@ static int bma180_set_sleep_state(struct bma180_data *data, int state)
 	return 0;
 }
 
-static int bma180_set_ee_writing_state(struct bma180_data *data, int state)
+static int bma180_set_ee_writing_state(struct bma180_data *data, bool state)
 {
 	int ret = bma180_set_bits(data, BMA180_CTRL_REG0, BMA180_EE_W, state);
 
@@ -225,7 +222,7 @@ static int bma180_set_scale(struct bma180_data *data, int val)
 	return -EINVAL;
 }
 
-static int bma180_set_pmode(struct bma180_data *data, int mode)
+static int bma180_set_pmode(struct bma180_data *data, bool mode)
 {
 	u8 reg_val = mode ? BMA180_LOW_POWER : BMA180_LOW_NOISE;
 	int ret = bma180_set_bits(data, BMA180_TCO_Z, BMA180_MODE_CONFIG,
@@ -275,10 +272,10 @@ static int bma180_chip_init(struct bma180_data *data)
 	ret = bma180_set_bits(data, BMA180_CTRL_REG0, BMA180_DIS_WAKE_UP, 1);
 	if (ret)
 		goto err;
-	ret = bma180_set_ee_writing_state(data, 1);
+	ret = bma180_set_ee_writing_state(data, true);
 	if (ret)
 		goto err;
-	ret = bma180_set_new_data_intr_state(data, 0);
+	ret = bma180_set_new_data_intr_state(data, false);
 	if (ret)
 		goto err;
 	ret = bma180_set_bits(data, BMA180_OFFSET_LSB1, BMA180_SMP_SKIP, 1);
@@ -303,11 +300,11 @@ err:
 
 static void bma180_chip_disable(struct bma180_data *data)
 {
-	if (bma180_set_new_data_intr_state(data, 0))
+	if (bma180_set_new_data_intr_state(data, false))
 		goto err;
-	if (bma180_set_ee_writing_state(data, 0))
+	if (bma180_set_ee_writing_state(data, false))
 		goto err;
-	if (bma180_set_sleep_state(data, 1))
+	if (bma180_set_sleep_state(data, true))
 		goto err;
 
 	return;
@@ -410,10 +407,7 @@ static const struct iio_info bma180_info = {
 	.driver_module		= THIS_MODULE,
 };
 
-static const char * const bma180_power_modes[] = {
-	BMA180_LOW_NOISE_STR,
-	BMA180_LOW_POWER_STR,
-};
+static const char * const bma180_power_modes[] = { "low_noise", "low_power" };
 
 static int bma180_get_power_mode(struct iio_dev *indio_dev,
 		const struct iio_chan_spec *chan)
@@ -633,7 +627,7 @@ static int bma180_suspend(struct device *dev)
 	int ret;
 
 	mutex_lock(&data->mutex);
-	ret = bma180_set_sleep_state(data, 1);
+	ret = bma180_set_sleep_state(data, true);
 	mutex_unlock(&data->mutex);
 
 	return ret;
@@ -646,7 +640,7 @@ static int bma180_resume(struct device *dev)
 	int ret;
 
 	mutex_lock(&data->mutex);
-	ret = bma180_set_sleep_state(data, 0);
+	ret = bma180_set_sleep_state(data, false);
 	mutex_unlock(&data->mutex);
 
 	return ret;
-- 
1.9.1

