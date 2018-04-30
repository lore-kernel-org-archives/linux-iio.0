Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:52780 "EHLO
        anchovy1.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeD3Jx7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Apr 2018 05:53:59 -0400
Subject: [PATCH] iio: magnetometer: mag3110: Add ability to run in continuous
 mode
References: <cc70f548-7c42-25a3-e908-b24ed8156c69@electromag.com.au>
To: linux-iio@vger.kernel.org, jic23@kernel.org
From: Richard Tresidder <rtresidd@electromag.com.au>
Message-ID: <f9675638-e5d4-481e-6061-a678f5325cec@electromag.com.au>
Date: Mon, 30 Apr 2018 17:53:54 +0800
MIME-Version: 1.0
In-Reply-To: <cc70f548-7c42-25a3-e908-b24ed8156c69@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi
Again sorry had maintainer wrong...
   This patch adds the ability to run the Mag3110 in continuous mode to
speed up the sampling rate.
Depending on the sampling rate requested the device can be put in or out
of continuous mode automatically.
Shifting out of continuous mode requires a potential 1 / ODR wait which
is also implemented
This part is largely based on the mma8542 driver implementation.

Also modified the sleep method when data is not ready to allow for
sampling > 50sps to work.
This is similar to my other recent patch regarding the mma8452 driver.

Have tested upto 80sps using hr timer and iio buffer

Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
---
diff --git a/drivers/iio/magnetometer/mag3110.c
b/drivers/iio/magnetometer/mag3110.c
index b34ace7..7cdd185 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -26,6 +26,7 @@
 #define MAG3110_OUT_Y 0x03
 #define MAG3110_OUT_Z 0x05
 #define MAG3110_WHO_AM_I 0x07
+#define MAG3110_SYSMOD 0x08
 #define MAG3110_OFF_X 0x09 /* MSB first */
 #define MAG3110_OFF_Y 0x0b
 #define MAG3110_OFF_Z 0x0d
@@ -39,6 +40,8 @@
 #define MAG3110_CTRL_DR_SHIFT 5
 #define MAG3110_CTRL_DR_DEFAULT 0
 
+#define MAG3110_SYSMOD_MODE_MASK (BIT(1) | BIT(0))
+
 #define MAG3110_CTRL_TM BIT(1) /* trigger single measurement */
 #define MAG3110_CTRL_AC BIT(0) /* continuous measurements */
 
@@ -52,26 +55,35 @@ struct mag3110_data {
     struct i2c_client *client;
     struct mutex lock;
     u8 ctrl_reg1;
+    int sleep_val;
 };
 
 static int mag3110_request(struct mag3110_data *data)
 {
     int ret, tries = 150;
 
-    /* trigger measurement */
-    ret = i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
-        data->ctrl_reg1 | MAG3110_CTRL_TM);
-    if (ret < 0)
-        return ret;
+    if ((data->ctrl_reg1 & MAG3110_CTRL_AC) == 0) {
+        /* trigger measurement */
+        ret = i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
+            data->ctrl_reg1 | MAG3110_CTRL_TM);
+        if (ret < 0)
+            return ret;
+    }
 
     while (tries-- > 0) {
         ret = i2c_smbus_read_byte_data(data->client, MAG3110_STATUS);
-        if (ret < 0)
+        if (ret < 0) {
+            dev_err(&data->client->dev, "i2c error\n");
             return ret;
+        }
         /* wait for data ready */
         if ((ret & MAG3110_STATUS_DRDY) == MAG3110_STATUS_DRDY)
             break;
-        msleep(20);
+
+        if (data->sleep_val <= 20)
+            usleep_range(data->sleep_val * 250, data->sleep_val * 500);
+        else
+            msleep(20);
     }
 
     if (tries < 0) {
@@ -100,7 +112,7 @@ static int mag3110_read(struct mag3110_data *data,
__be16 buf[3])
 }
 
 static ssize_t mag3110_show_int_plus_micros(char *buf,
-    const int (*vals)[2], int n)
+                        const int (*vals)[2], int n)
 {
     size_t len = 0;
 
@@ -115,7 +127,7 @@ static ssize_t mag3110_show_int_plus_micros(char *buf,
 }
 
 static int mag3110_get_int_plus_micros_index(const int (*vals)[2], int n,
-                    int val, int val2)
+                         int val, int val2)
 {
     while (n-- > 0)
         if (val == vals[n][0] && val2 == vals[n][1])
@@ -130,7 +142,8 @@ static int mag3110_get_int_plus_micros_index(const
int (*vals)[2], int n,
 };
 
 static ssize_t mag3110_show_samp_freq_avail(struct device *dev,
-                struct device_attribute *attr, char *buf)
+                        struct device_attribute *attr,
+                        char *buf)
 {
     return mag3110_show_int_plus_micros(buf, mag3110_samp_freq, 8);
 }
@@ -138,12 +151,118 @@ static ssize_t
mag3110_show_samp_freq_avail(struct device *dev,
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mag3110_show_samp_freq_avail);
 
 static int mag3110_get_samp_freq_index(struct mag3110_data *data,
-    int val, int val2)
+                       int val, int val2)
 {
     return mag3110_get_int_plus_micros_index(mag3110_samp_freq, 8, val,
         val2);
 }
 
+static int mag3110_calculate_sleep(struct mag3110_data *data)
+{
+    int ret, i = data->ctrl_reg1 >> MAG3110_CTRL_DR_SHIFT;
+
+    if(mag3110_samp_freq[i][0] > 0)
+        ret = 1000 / mag3110_samp_freq[i][0];
+    else
+        ret = 1000;
+
+    return ret == 0 ? 1 : ret;
+}
+
+static int mag3110_standby(struct mag3110_data *data)
+{
+    return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
+                     data->ctrl_reg1 & ~MAG3110_CTRL_AC);
+}
+
+static int mag3110_wait_standby(struct mag3110_data *data)
+{
+    int ret, tries = 30;
+
+    /* Takes up to 1/ODR to come out of active mode into stby
+         Longest expected period is 12.5seconds. We'll sleep for 500ms
between checks*/
+    while (tries-- > 0) {
+        ret = i2c_smbus_read_byte_data(data->client, MAG3110_SYSMOD);
+        if (ret < 0) {
+            dev_err(&data->client->dev, "i2c error\n");
+            return ret;
+        }
+        /* wait for standby */
+        if ((ret & MAG3110_SYSMOD_MODE_MASK) == 0)
+            break;
+      
+        msleep_interruptible(500);
+    }
+
+    if (tries < 0) {
+        dev_err(&data->client->dev, "device not entering standby mode\n");
+        return -EIO;
+    }
+
+    return 0;
+}
+
+static int mag3110_active(struct mag3110_data *data)
+{
+    return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
+                     data->ctrl_reg1);
+}
+
+/* returns >0 if active, 0 if in standby and <0 on error */
+static int mag3110_is_active(struct mag3110_data *data)
+{
+    int reg;
+
+    reg = i2c_smbus_read_byte_data(data->client, MAG3110_CTRL_REG1);
+    if (reg < 0)
+        return reg;
+
+    return reg & MAG3110_CTRL_AC;
+}
+
+static int mag3110_change_config(struct mag3110_data *data, u8 reg, u8 val)
+{
+    int ret;
+    int is_active;
+
+    mutex_lock(&data->lock);
+
+    is_active = mag3110_is_active(data);
+    if (is_active < 0) {
+        ret = is_active;
+        goto fail;
+    }
+
+    /* config can only be changed when in standby */
+    if (is_active > 0) {
+        ret = mag3110_standby(data);
+        if (ret < 0)
+            goto fail;
+    }
+
+    /* After coming out of active we must wait for the part to
transition to STBY
+       This can take up to 1 /ODR to occur */
+    ret = mag3110_wait_standby(data);
+    if (ret < 0)
+        goto fail;
+
+    ret = i2c_smbus_write_byte_data(data->client, reg, val);
+    if (ret < 0)
+        goto fail;
+
+    if (is_active > 0) {
+        ret = mag3110_active(data);
+        if (ret < 0)
+            goto fail;
+    }
+
+    ret = 0;
+fail:
+    mutex_unlock(&data->lock);
+
+    return ret;
+}
+
 static int mag3110_read_raw(struct iio_dev *indio_dev,
                 struct iio_chan_spec const *chan,
                 int *val, int *val2, long mask)
@@ -235,11 +354,13 @@ static int mag3110_write_raw(struct iio_dev
*indio_dev,
             ret = -EINVAL;
             break;
         }
-
-        data->ctrl_reg1 &= ~MAG3110_CTRL_DR_MASK;
+        data->ctrl_reg1 &= ~MAG3110_CTRL_DR_MASK & ~MAG3110_CTRL_AC;
         data->ctrl_reg1 |= rate << MAG3110_CTRL_DR_SHIFT;
-        ret = i2c_smbus_write_byte_data(data->client,
-            MAG3110_CTRL_REG1, data->ctrl_reg1);
+        data->sleep_val = mag3110_calculate_sleep(data);
+        if (data->sleep_val < 40)
+            data->ctrl_reg1 |= MAG3110_CTRL_AC;
+
+        ret = mag3110_change_config(data, MAG3110_CTRL_REG1,
data->ctrl_reg1);
         break;
     case IIO_CHAN_INFO_CALIBBIAS:
         if (val < -10000 || val > 10000) {
@@ -337,12 +458,6 @@ static irqreturn_t mag3110_trigger_handler(int irq,
void *p)
 
 static const unsigned long mag3110_scan_masks[] = {0x7, 0xf, 0};
 
-static int mag3110_standby(struct mag3110_data *data)
-{
-    return i2c_smbus_write_byte_data(data->client, MAG3110_CTRL_REG1,
-        data->ctrl_reg1 & ~MAG3110_CTRL_AC);
-}
-
 static int mag3110_probe(struct i2c_client *client,
              const struct i2c_device_id *id)
 {
@@ -374,8 +489,11 @@ static int mag3110_probe(struct i2c_client *client,
     indio_dev->available_scan_masks = mag3110_scan_masks;
 
     data->ctrl_reg1 = MAG3110_CTRL_DR_DEFAULT << MAG3110_CTRL_DR_SHIFT;
-    ret = i2c_smbus_write_byte_data(client, MAG3110_CTRL_REG1,
-        data->ctrl_reg1);
+    data->sleep_val = mag3110_calculate_sleep(data);
+    if (data->sleep_val < 40)
+        data->ctrl_reg1 |= MAG3110_CTRL_AC;
+
+    ret = mag3110_change_config(data, MAG3110_CTRL_REG1, data->ctrl_reg1);
     if (ret < 0)
         return ret;
 


--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



