Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:45819 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeD3JuP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Apr 2018 05:50:15 -0400
Subject: [PATCH] iio: accell: mma8452: Reduce sleep time when data not ready
References: <e15558d1-ef9b-edbf-7fd8-e4d0e86e6b22@electromag.com.au>
To: linux-iio@vger.kernel.org, jic23@kernel.org
From: Richard Tresidder <rtresidd@electromag.com.au>
Message-ID: <36898239-4047-b061-e6d7-7dd566a98976@electromag.com.au>
Date: Mon, 30 Apr 2018 17:50:06 +0800
MIME-Version: 1.0
In-Reply-To: <e15558d1-ef9b-edbf-7fd8-e4d0e86e6b22@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi
Sorry realised I hadn't cc'd a maintainer so trying again
First patch attempt.
Currently the driver runs into problems when trying to acquire at sample
rates higher than 50sps.
This is due to the usage of msleep when data is not ready.
This patch attempts to speed things up by utilising the usleep_range
call to allow shorter sleep times.

I've tested this using iio buffers and hr triggers up to 100sps on a
mma8451 device.
It should technically be ok up to the 800sps rate though.

I seem to have snuck a couple of whitespace alignment fixes into this also
Please let me know if I should remove separate them

Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
---
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7a2da7f..cede523 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -57,7 +57,7 @@
 #define MMA8452_FF_MT_THS            0x17
 #define  MMA8452_FF_MT_THS_MASK            0x7f
 #define MMA8452_FF_MT_COUNT            0x18
-#define MMA8452_FF_MT_CHAN_SHIFT    3
+#define MMA8452_FF_MT_CHAN_SHIFT        3
 #define MMA8452_TRANSIENT_CFG            0x1d
 #define  MMA8452_TRANSIENT_CFG_CHAN(chan)    BIT(chan + 1)
 #define  MMA8452_TRANSIENT_CFG_HPF_BYP        BIT(0)
@@ -69,7 +69,7 @@
 #define MMA8452_TRANSIENT_THS            0x1f
 #define  MMA8452_TRANSIENT_THS_MASK        GENMASK(6, 0)
 #define MMA8452_TRANSIENT_COUNT            0x20
-#define MMA8452_TRANSIENT_CHAN_SHIFT 1
+#define MMA8452_TRANSIENT_CHAN_SHIFT        1
 #define MMA8452_CTRL_REG1            0x2a
 #define  MMA8452_CTRL_ACTIVE            BIT(0)
 #define  MMA8452_CTRL_DR_MASK            GENMASK(5, 3)
@@ -106,6 +106,7 @@ struct mma8452_data {
     u8 ctrl_reg1;
     u8 data_cfg;
     const struct mma_chip_info *chip_info;
+    int sleep_val;
 };
 
  /**
@@ -193,7 +194,10 @@ static int mma8452_drdy(struct mma8452_data *data)
         if ((ret & MMA8452_STATUS_DRDY) == MMA8452_STATUS_DRDY)
             return 0;
 
-        msleep(20);
+        if (data->sleep_val <= 20)
+            usleep_range(data->sleep_val * 250, data->sleep_val * 500);
+        else
+            msleep(20);
     }
 
     dev_err(&data->client->dev, "data not ready\n");
@@ -544,10 +548,22 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
     return -EINVAL;
 }
 
+static int mma8452_calculate_sleep(struct mma8452_data *data)
+{
+    int ret, i = mma8452_get_odr_index(data);
+  
+    if (mma8452_samp_freq[i][0] > 0)
+        ret = 1000 / mma8452_samp_freq[i][0];
+    else
+        ret = 1000;
+
+    return ret == 0 ? 1 : ret;
+}
+
 static int mma8452_standby(struct mma8452_data *data)
 {
     return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG1,
-                    data->ctrl_reg1 & ~MMA8452_CTRL_ACTIVE);
+                     data->ctrl_reg1 & ~MMA8452_CTRL_ACTIVE);
 }
 
 static int mma8452_active(struct mma8452_data *data)
@@ -700,6 +716,8 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
         data->ctrl_reg1 &= ~MMA8452_CTRL_DR_MASK;
         data->ctrl_reg1 |= i << MMA8452_CTRL_DR_SHIFT;
 
+        data->sleep_val = mma8452_calculate_sleep(data);
+
         ret = mma8452_change_config(data, MMA8452_CTRL_REG1,
                         data->ctrl_reg1);
         break;
@@ -738,7 +756,7 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
         }
 
         ret = mma8452_change_config(data, MMA8452_DATA_CFG,
-                         data->data_cfg);
+                        data->data_cfg);
         break;
 
     case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
@@ -761,8 +779,9 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 }
 
 static int mma8452_get_event_regs(struct mma8452_data *data,
-        const struct iio_chan_spec *chan, enum iio_event_direction dir,
-        const struct mma8452_event_regs **ev_reg)
+                  const struct iio_chan_spec *chan,
+                  enum iio_event_direction dir,
+                  const struct mma8452_event_regs **ev_reg)
 {
     if (!chan)
         return -EINVAL;
@@ -772,9 +791,9 @@ static int mma8452_get_event_regs(struct
mma8452_data *data,
         switch (dir) {
         case IIO_EV_DIR_RISING:
             if ((data->chip_info->all_events
-                    & MMA8452_INT_TRANS) &&
-                (data->chip_info->enabled_events
-                    & MMA8452_INT_TRANS))
+                & MMA8452_INT_TRANS) &&
+                (data->chip_info->enabled_events
+                & MMA8452_INT_TRANS))
                 *ev_reg = &trans_ev_regs;
             else
                 *ev_reg = &ff_mt_ev_regs;
@@ -791,11 +810,11 @@ static int mma8452_get_event_regs(struct
mma8452_data *data,
 }
 
 static int mma8452_read_event_value(struct iio_dev *indio_dev,
-                   const struct iio_chan_spec *chan,
-                   enum iio_event_type type,
-                   enum iio_event_direction dir,
-                   enum iio_event_info info,
-                   int *val, int *val2)
+                    const struct iio_chan_spec *chan,
+                    enum iio_event_type type,
+                    enum iio_event_direction dir,
+                    enum iio_event_info info,
+                    int *val, int *val2)
 {
     struct mma8452_data *data = iio_priv(indio_dev);
     int ret, us, power_mode;
@@ -854,11 +873,11 @@ static int mma8452_read_event_value(struct iio_dev
*indio_dev,
 }
 
 static int mma8452_write_event_value(struct iio_dev *indio_dev,
-                const struct iio_chan_spec *chan,
-                enum iio_event_type type,
-                enum iio_event_direction dir,
-                enum iio_event_info info,
-                int val, int val2)
+                     const struct iio_chan_spec *chan,
+                     enum iio_event_type type,
+                     enum iio_event_direction dir,
+                     enum iio_event_info info,
+                     int val, int val2)
 {
     struct mma8452_data *data = iio_priv(indio_dev);
     int ret, reg, steps;
@@ -1528,6 +1547,7 @@ static int mma8452_probe(struct i2c_client *client,
     case FXLS8471_DEVICE_ID:
         if (ret == data->chip_info->chip_id)
             break;
+        /* FALLTHRU */
     default:
         return -ENODEV;
     }
@@ -1593,6 +1613,9 @@ static int mma8452_probe(struct i2c_client *client,
 
     data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
               (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
+              
+    data->sleep_val = mma8452_calculate_sleep(data);
+
     ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
                     data->ctrl_reg1);
     if (ret < 0)


