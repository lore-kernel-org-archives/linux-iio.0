Return-Path: <knaack.h@gmx.de>
Message-ID: <50032ACA.3060307@gmx.de>
Date: Sun, 15 Jul 2012 22:40:42 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: jic23@kernel.org
Subject: [PATCH 2/2] fixes for adt7410
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

This patch fixes several problems in adt7410.c.

Signed-off-by: Harmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index 917b692..619b3ef 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -49,6 +49,7 @@
 #define ADT7410_INT_POLARITY        0x8
 #define ADT7410_EVENT_MODE        0x10
 #define ADT7410_MODE_MASK        0x60
+#define ADT7410_FULL            0x0
 #define ADT7410_ONESHOT            0x20
 #define ADT7410_SPS            0x40
 #define ADT7410_PD            0x60
@@ -60,14 +61,10 @@
 #define ADT7410_T16_VALUE_SIGN            0x8000
 #define ADT7410_T16_VALUE_FLOAT_OFFSET        7
 #define ADT7410_T16_VALUE_FLOAT_MASK        0x7F
-#define ADT7410_T13_VALUE_SIGN            0x1000
-#define ADT7410_T13_VALUE_OFFSET        3
-#define ADT7410_T13_VALUE_FLOAT_OFFSET        4
-#define ADT7410_T13_VALUE_FLOAT_MASK        0xF
+#define ADT7410_T13_VALUE_MASK            0xFFF8
 #define ADT7410_T_HYST_MASK            0xF
-#define ADT7410_DEVICE_ID_MASK            0xF
-#define ADT7410_MANUFACTORY_ID_MASK        0xF0
-#define ADT7410_MANUFACTORY_ID_OFFSET        4
+#define ADT7410_DEVICE_ID_MASK            0x7
+#define ADT7410_MANUFACTORY_ID_OFFSET        3
 
 #define ADT7410_IRQS                2
 
@@ -183,6 +180,12 @@ static ssize_t adt7410_store_mode(struct device *dev,
         config |= ADT7410_ONESHOT;
     else if (strcmp(buf, "sps"))
         config |= ADT7410_SPS;
+    else if (strcmp(buf, "full"))
+        config |= ADT7410_FULL;
+    else {
+        dev_err(&chip->client->dev, "Invalid mode, valid modes are full, sps, one-shot and power-down\n");
+        return -EINVAL;
+    }
 
     ret = adt7410_i2c_write_byte(chip, ADT7410_CONFIG, config);
     if (ret)
@@ -248,14 +251,23 @@ static ssize_t adt7410_store_resolution(struct device *dev,
         return -EIO;
 
     config = chip->config & (~ADT7410_RESOLUTION);
-    if (data)
-        config |= ADT7410_RESOLUTION;
-
+    switch (data) {
+        case 13:
+            config |= 0;
+            break;
+        case 16:
+            config |= ADT7410_RESOLUTION;
+            break;
+        default:
+            dev_err(&chip->client->dev, "Invalid value, valid are 13 and 16\n");
+            return -EINVAL;
+    }
     ret = adt7410_i2c_write_byte(chip, ADT7410_CONFIG, config);
     if (ret)
         return -EIO;
 
     chip->config = config;
+   
 
     return ret;
 }
@@ -280,7 +292,7 @@ static ssize_t adt7410_show_id(struct device *dev,
 
     return sprintf(buf, "device id: 0x%x\nmanufactory id: 0x%x\n",
             id & ADT7410_DEVICE_ID_MASK,
-            (id & ADT7410_MANUFACTORY_ID_MASK) >> ADT7410_MANUFACTORY_ID_OFFSET);
+            id >> ADT7410_MANUFACTORY_ID_OFFSET);
 }
 
 static IIO_DEVICE_ATTR(id, S_IRUGO | S_IWUSR,
@@ -293,26 +305,16 @@ static ssize_t adt7410_convert_temperature(struct adt7410_chip_info *chip,
 {
     char sign = ' ';
 
-    if (chip->config & ADT7410_RESOLUTION) {
-        if (data & ADT7410_T16_VALUE_SIGN) {
-            /* convert supplement to positive value */
-            data = (u16)((ADT7410_T16_VALUE_SIGN << 1) - (u32)data);
-            sign = '-';
-        }
-        return sprintf(buf, "%c%d.%.7d\n", sign,
-                (data >> ADT7410_T16_VALUE_FLOAT_OFFSET),
-                (data & ADT7410_T16_VALUE_FLOAT_MASK) * 78125);
-    } else {
-        if (data & ADT7410_T13_VALUE_SIGN) {
-            /* convert supplement to positive value */
-            data >>= ADT7410_T13_VALUE_OFFSET;
-            data = (ADT7410_T13_VALUE_SIGN << 1) - data;
-            sign = '-';
-        }
-        return sprintf(buf, "%c%d.%.4d\n", sign,
-                (data >> ADT7410_T13_VALUE_FLOAT_OFFSET),
-                (data & ADT7410_T13_VALUE_FLOAT_MASK) * 625);
+    if (!(chip->config & ADT7410_RESOLUTION))
+        data &= ADT7410_T13_VALUE_MASK;
+    if (data & ADT7410_T16_VALUE_SIGN) {
+        /* convert supplement to positive value */
+        data = (u16)((ADT7410_T16_VALUE_SIGN << 1) - (u32)data);
+        sign = '-';
     }
+    return sprintf(buf, "%c%d.%.7d\n", sign,
+            (data >> ADT7410_T16_VALUE_FLOAT_OFFSET),
+            (data & ADT7410_T16_VALUE_FLOAT_MASK) * 78125);
 }
 
 static ssize_t adt7410_show_value(struct device *dev,
@@ -421,8 +423,14 @@ static ssize_t adt7410_set_event_mode(struct device *dev,
         return -EIO;
 
     config = chip->config &= ~ADT7410_EVENT_MODE;
-    if (strcmp(buf, "comparator") != 0)
+    if (strcmp(buf, "comparator"))
         config |= ADT7410_EVENT_MODE;
+    else if (strcmp(buf, "interrupt"))
+        config |= 0;
+    else {
+        dev_err(&chip->client->dev, "Invalid mode, valid modes are comparator and interrupt\n");
+        return -EINVAL;
+    }
 
     ret = adt7410_i2c_write_byte(chip, ADT7410_CONFIG, config);
     if (ret)
@@ -514,34 +522,29 @@ static inline ssize_t adt7410_set_t_bound(struct device *dev,
     u16 data;
     char *pos;
     int ret;
+    char *integer;
+    char fraction[] = "0000000";
 
     pos = strchr(buf, '.');
+    len = strlen(buf) - strlen(pos);
+    integer = kzalloc(len * sizeof(char), GFP_KERNEL);
+    strncpy(integer, buf, len);
 
-    ret = strict_strtol(buf, 10, &tmp1);
+    ret = strict_strtol(integer, 10, &tmp1);
 
     if (ret || tmp1 > 127 || tmp1 < -128)
         return -EINVAL;
 
     if (pos) {
-        len = strlen(pos);
-
-        if (chip->config & ADT7410_RESOLUTION) {
-            if (len > ADT7410_T16_VALUE_FLOAT_OFFSET)
-                len = ADT7410_T16_VALUE_FLOAT_OFFSET;
-            pos[len] = 0;
-            ret = strict_strtol(pos, 10, &tmp2);
-
-            if (!ret)
-                tmp2 = (tmp2 / 78125) * 78125;
-        } else {
-            if (len > ADT7410_T13_VALUE_FLOAT_OFFSET)
-                len = ADT7410_T13_VALUE_FLOAT_OFFSET;
-            pos[len] = 0;
-            ret = strict_strtol(pos, 10, &tmp2);
-
-            if (!ret)
-                tmp2 = (tmp2 / 625) * 625;
-        }
+        len = strlen(++pos);
+        if (pos[len -1] == '\n')
+            len--;
+        if (len > 7)
+            len = 7;
+        strncpy(fraction, pos, len);
+        ret = strict_strtol(fraction, 10, &tmp2);
+        if (!ret)
+            tmp2 /= 78125;
     }
 
     if (tmp1 < 0)
@@ -549,22 +552,13 @@ static inline ssize_t adt7410_set_t_bound(struct device *dev,
     else
         data = (u16)tmp1;
 
-    if (chip->config & ADT7410_RESOLUTION) {
-        data = (data << ADT7410_T16_VALUE_FLOAT_OFFSET) |
-            (tmp2 & ADT7410_T16_VALUE_FLOAT_MASK);
-
-        if (tmp1 < 0)
-            /* convert positive value to supplyment */
-            data = (u16)((ADT7410_T16_VALUE_SIGN << 1) - (u32)data);
-    } else {
-        data = (data << ADT7410_T13_VALUE_FLOAT_OFFSET) |
-            (tmp2 & ADT7410_T13_VALUE_FLOAT_MASK);
-
-        if (tmp1 < 0)
-            /* convert positive value to supplyment */
-            data = (ADT7410_T13_VALUE_SIGN << 1) - data;
-        data <<= ADT7410_T13_VALUE_OFFSET;
-    }
+    data = (data << ADT7410_T16_VALUE_FLOAT_OFFSET) |
+        (tmp2 & ADT7410_T16_VALUE_FLOAT_MASK);
+    if (tmp1 < 0)
+        /* convert positive value to supplyment */
+        data = (u16)((ADT7410_T16_VALUE_SIGN << 1) - (u32)data);
+    if (!(chip->config & ADT7410_RESOLUTION))
+        data &= ADT7410_T13_VALUE_MASK;
 
     ret = adt7410_i2c_write_word(chip, bound_reg, data);
     if (ret)
@@ -750,7 +744,7 @@ static int __devinit adt7410_probe(struct i2c_client *client,
     }
 
     /* INT bound temperature alarm event. line 1 */
-    if (adt7410_platform_data[0]) {
+    if (adt7410_platform_data) {
         ret = request_threaded_irq(adt7410_platform_data[0],
                        NULL,
                        &adt7410_event_handler,
@@ -761,13 +755,13 @@ static int __devinit adt7410_probe(struct i2c_client *client,
             goto error_unreg_ct_irq;
     }
 
-    if (client->irq && adt7410_platform_data[0]) {
+    ret = adt7410_i2c_read_byte(chip, ADT7410_CONFIG, &chip->config);
+    if (ret) {
+        ret = -EIO;
+        goto error_unreg_int_irq;
+    }
 
-        ret = adt7410_i2c_read_byte(chip, ADT7410_CONFIG, &chip->config);
-        if (ret) {
-            ret = -EIO;
-            goto error_unreg_int_irq;
-        }
+    if (client->irq && adt7410_platform_data) {
 
         /* set irq polarity low level */
         chip->config &= ~ADT7410_CT_POLARITY;
@@ -776,12 +770,12 @@ static int __devinit adt7410_probe(struct i2c_client *client,
             chip->config |= ADT7410_INT_POLARITY;
         else
             chip->config &= ~ADT7410_INT_POLARITY;
+    }
 
-        ret = adt7410_i2c_write_byte(chip, ADT7410_CONFIG, chip->config);
-        if (ret) {
-            ret = -EIO;
-            goto error_unreg_int_irq;
-        }
+    ret = adt7410_i2c_write_byte(chip, ADT7410_CONFIG, chip->config);
+    if (ret) {
+        ret = -EIO;
+        goto error_unreg_int_irq;
     }
     ret = iio_device_register(indio_dev);
     if (ret)
@@ -793,9 +787,11 @@ static int __devinit adt7410_probe(struct i2c_client *client,
     return 0;
 
 error_unreg_int_irq:
-    free_irq(adt7410_platform_data[0], indio_dev);
+    if (client->irq)
+        free_irq(adt7410_platform_data[0], indio_dev);
 error_unreg_ct_irq:
-    free_irq(client->irq, indio_dev);
+    if (adt7410_platform_data)
+        free_irq(client->irq, indio_dev);
 error_free_dev:
     iio_device_free(indio_dev);
 error_ret:
@@ -808,7 +804,7 @@ static int __devexit adt7410_remove(struct i2c_client *client)
     unsigned long *adt7410_platform_data = client->dev.platform_data;
 
     iio_device_unregister(indio_dev);
-    if (adt7410_platform_data[0])
+    if (adt7410_platform_data)
         free_irq(adt7410_platform_data[0], indio_dev);
     if (client->irq)
         free_irq(client->irq, indio_dev);
