Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:57301 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751972AbaBNPQw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Feb 2014 10:16:52 -0500
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C2844B1
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2014 15:16:48 +0000 (GMT)
Received: from mail7.sgp.st.com (unknown [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B26C816969
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2014 15:16:48 +0000 (GMT)
From: Denis CIOCCA <denis.ciocca@st.com>
To: linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 1/4] iio:accel: call devm_iio_device_free function if common_proble fails
Date: Fri, 14 Feb 2014 16:16:40 +0100
Message-Id: <1392391005-2719-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1392391005-2719-1-git-send-email-denis.ciocca@st.com>
References: <1392391005-2719-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If st_accel_common_probe function fails, the device must be freed.
Added devm_iio_device_free also on common_remove function.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel_core.c | 1 +
 drivers/iio/accel/st_accel_i2c.c  | 6 +++++-
 drivers/iio/accel/st_accel_spi.c  | 6 +++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 38caedc..5ba3049 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -517,6 +517,7 @@ void st_accel_common_remove(struct iio_dev *indio_dev)
 		st_sensors_deallocate_trigger(indio_dev);
 
 	st_accel_deallocate_ring(indio_dev);
+	devm_iio_device_free(adata->dev, indio_dev);
 }
 EXPORT_SYMBOL(st_accel_common_remove);
 
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index d7bedbd..391b035 100644
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
+	devm_iio_device_free(&client->dev, indio_dev);
+	return err;
 }
 
 static int st_accel_i2c_remove(struct i2c_client *client)
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 1956396..52ebbdb 100644
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
+	devm_iio_device_free(&spi->dev, indio_dev);
+	return err;
 }
 
 static int st_accel_spi_remove(struct spi_device *spi)
-- 
1.8.5.4

