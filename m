Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:39256 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750975AbaBNOzY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2014 09:55:24 -0500
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E888BF9
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2014 14:55:21 +0000 (GMT)
Received: from mail7.sgp.st.com (unknown [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA8BD1678A
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2014 14:55:21 +0000 (GMT)
From: Denis CIOCCA <denis.ciocca@st.com>
To: linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 1/4] iio:accel: call device unregister function if common_proble fails
Date: Fri, 14 Feb 2014 15:55:15 +0100
Message-Id: <1392389718-26079-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If st_accel_common_probe function fails, the device must be unregistered.
Used devm_iio_device_unregister function instead of iio_device_unregister
also in the common remove function.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel_core.c | 2 +-
 drivers/iio/accel/st_accel_i2c.c  | 6 +++++-
 drivers/iio/accel/st_accel_spi.c  | 6 +++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 38caedc..72d560f 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -512,7 +512,7 @@ void st_accel_common_remove(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
+	devm_iio_device_unregister(adata->dev, indio_dev);
 	if (adata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
 
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index d7bedbd..a31473d 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -36,9 +36,13 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 
 	err = st_accel_common_probe(indio_dev, client->dev.platform_data);
 	if (err < 0)
-		return err;
+		goto device_unregister;
 
 	return 0;
+
+device_unregister:
+	devm_iio_device_unregister(&client->dev, indio_dev);
+	return err;
 }
 
 static int st_accel_i2c_remove(struct i2c_client *client)
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 1956396..e687722 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -35,9 +35,13 @@ static int st_accel_spi_probe(struct spi_device *spi)
 
 	err = st_accel_common_probe(indio_dev, spi->dev.platform_data);
 	if (err < 0)
-		return err;
+		goto device_unregister;
 
 	return 0;
+
+device_unregister:
+	devm_iio_device_unregister(&spi->dev, indio_dev);
+	return err;
 }
 
 static int st_accel_spi_remove(struct spi_device *spi)
-- 
1.8.5.4

