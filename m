Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46516 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbbBSPWU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 Feb 2015 10:22:20 -0500
Received: by iecvy18 with SMTP id vy18so422692iec.13
        for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2015 07:22:19 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 19 Feb 2015 16:22:19 +0100
Message-ID: <CAEmm_TbT_uZZD3Q3dQb14t3DyLkQtCjjg42SQeYb6bWg1wGpZw@mail.gmail.com>
Subject: [PATCH] iio: max517: Add support for MAX520 and MAX521 chips.
From: =?UTF-8?Q?Antonio_Fiol_Bonn=C3=ADn?= <antonio@fiol.es>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

MAX520 and MAX521 are protocol-compatible with the already supported
chips, just have more channels.

Signed-off-by: Antonio Fiol <antonio@fiol.es>
---
 drivers/iio/dac/Kconfig        | 11 ++++++++---
 drivers/iio/dac/max517.c       | 45 +++++++++++++++++++++++++++++++-------=
----
 include/linux/iio/dac/max517.h |  2 +-
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 2236ea2..2374cce 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -143,11 +143,16 @@ config AD7303
       ad7303.

 config MAX517
-    tristate "Maxim MAX517/518/519 DAC driver"
+    tristate "Maxim MAX517/518/519/520/521 DAC driver"
     depends on I2C
     help
-      If you say yes here you get support for the Maxim chips MAX517,
-      MAX518 and MAX519 (I2C 8-Bit DACs with rail-to-rail outputs).
+      If you say yes here you get support for the following Maxim chips
+      (I2C 8-Bit DACs with rail-to-rail outputs):
+      MAX517 - Single channel, single reference
+      MAX518 - dual channel, ref=3DVdd
+      MAX519 - dual channel, dual reference
+      MAX520 - quad channel, quad reference
+      MAX521 - octal channel, independent ref for ch0-3, shared ref for ch=
4-7

       This driver can also be built as a module.  If so, the module
       will be called max517.
diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 9a82a72..993977d 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -39,11 +39,13 @@ enum max517_device_ids {
     ID_MAX517,
     ID_MAX518,
     ID_MAX519,
+    ID_MAX520,
+    ID_MAX521,
 };

 struct max517_data {
     struct i2c_client    *client;
-    unsigned short        vref_mv[2];
+    unsigned short        vref_mv[8];
 };

 /*
@@ -149,7 +151,13 @@ static const struct iio_info max517_info =3D {

 static const struct iio_chan_spec max517_channels[] =3D {
     MAX517_CHANNEL(0),
-    MAX517_CHANNEL(1)
+    MAX517_CHANNEL(1),
+    MAX517_CHANNEL(2),
+    MAX517_CHANNEL(3),
+    MAX517_CHANNEL(4),
+    MAX517_CHANNEL(5),
+    MAX517_CHANNEL(6),
+    MAX517_CHANNEL(7)
 };

 static int max517_probe(struct i2c_client *client,
@@ -158,6 +166,7 @@ static int max517_probe(struct i2c_client *client,
     struct max517_data *data;
     struct iio_dev *indio_dev;
     struct max517_platform_data *platform_data =3D client->dev.platform_da=
ta;
+    int chan;

     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
     if (!indio_dev)
@@ -169,11 +178,21 @@ static int max517_probe(struct i2c_client *client,
     /* establish that the iio_dev is a child of the i2c device */
     indio_dev->dev.parent =3D &client->dev;

-    /* reduced channel set for MAX517 */
-    if (id->driver_data =3D=3D ID_MAX517)
-        indio_dev->num_channels =3D 1;
-    else
+    switch (id->driver_data) {
+    case ID_MAX521:
+        indio_dev->num_channels =3D 8;
+        break;
+    case ID_MAX520:
+        indio_dev->num_channels =3D 4;
+        break;
+    case ID_MAX519:
+    case ID_MAX518:
         indio_dev->num_channels =3D 2;
+        break;
+    default:  /* single channel for MAX517 */
+        indio_dev->num_channels =3D 1;
+        break;
+    }
     indio_dev->channels =3D max517_channels;
     indio_dev->modes =3D INDIO_DIRECT_MODE;
     indio_dev->info =3D &max517_info;
@@ -182,11 +201,11 @@ static int max517_probe(struct i2c_client *client,
      * Reference voltage on MAX518 and default is 5V, else take vref_mv
      * from platform_data
      */
-    if (id->driver_data =3D=3D ID_MAX518 || !platform_data) {
-        data->vref_mv[0] =3D data->vref_mv[1] =3D 5000; /* mV */
-    } else {
-        data->vref_mv[0] =3D platform_data->vref_mv[0];
-        data->vref_mv[1] =3D platform_data->vref_mv[1];
+    for (chan =3D 0; chan < indio_dev->num_channels; chan++) {
+        if (id->driver_data =3D=3D ID_MAX518 || !platform_data)
+            data->vref_mv[chan] =3D 5000; /* mV */
+        else
+            data->vref_mv[chan] =3D platform_data->vref_mv[chan];
     }

     return iio_device_register(indio_dev);
@@ -202,6 +221,8 @@ static const struct i2c_device_id max517_id[] =3D {
     { "max517", ID_MAX517 },
     { "max518", ID_MAX518 },
     { "max519", ID_MAX519 },
+    { "max520", ID_MAX520 },
+    { "max521", ID_MAX521 },
     { }
 };
 MODULE_DEVICE_TABLE(i2c, max517_id);
@@ -218,5 +239,5 @@ static struct i2c_driver max517_driver =3D {
 module_i2c_driver(max517_driver);

 MODULE_AUTHOR("Roland Stigge <stigge@antcom.de>");
-MODULE_DESCRIPTION("MAX517/MAX518/MAX519 8-bit DAC");
+MODULE_DESCRIPTION("MAX517/MAX518/MAX519/MAX521/MAX521 8-bit DAC");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/dac/max517.h b/include/linux/iio/dac/max517.=
h
index f6d1d25..7668716 100644
--- a/include/linux/iio/dac/max517.h
+++ b/include/linux/iio/dac/max517.h
@@ -9,7 +9,7 @@
 #define IIO_DAC_MAX517_H_

 struct max517_platform_data {
-    u16                vref_mv[2];
+    u16                vref_mv[8];
 };

 #endif /* IIO_DAC_MAX517_H_ */
--=20
1.9.1
