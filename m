Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:53647 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab3IPQC7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 12:02:59 -0400
Received: by mail-ea0-f175.google.com with SMTP id m14so2133655eaj.34
        for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2013 09:02:58 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 20/20] iio: magn-core: st: Clean up error handling in probe()
Date: Mon, 16 Sep 2013 17:02:26 +0100
Message-Id: <1379347346-823-21-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
References: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Reduce the amount of those unnecessary goto calls, as in most cases
we can simply return immediately. We also only call for the IRQ number
once and use that value throughout.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/magnetometer/st_magn_core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index e8d2849..729c71a 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -348,8 +348,9 @@ static const struct iio_info magn_info = {
 int st_magn_common_probe(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata)
 {
-	int err;
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
+	int irq = mdata->get_irq_data_ready(indio_dev);
+	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &magn_info;
@@ -357,7 +358,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev,
 	err = st_sensors_check_device_support(indio_dev,
 				ARRAY_SIZE(st_magn_sensors), st_magn_sensors);
 	if (err < 0)
-		goto st_magn_common_probe_error;
+		return err;
 
 	mdata->num_data_channels = ST_MAGN_NUMBER_DATA_CHANNELS;
 	mdata->multiread_bit = mdata->sensor->multi_read_bit;
@@ -370,12 +371,12 @@ int st_magn_common_probe(struct iio_dev *indio_dev,
 
 	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
-		goto st_magn_common_probe_error;
+		return err;
 
-	if (mdata->get_irq_data_ready(indio_dev) > 0) {
+	if (irq > 0) {
 		err = st_magn_allocate_ring(indio_dev);
 		if (err < 0)
-			goto st_magn_common_probe_error;
+			return err;
 		err = st_sensors_allocate_trigger(indio_dev, NULL);
 		if (err < 0)
 			goto st_magn_probe_trigger_error;
@@ -385,15 +386,15 @@ int st_magn_common_probe(struct iio_dev *indio_dev,
 	if (err)
 		goto st_magn_device_register_error;
 
-	return err;
+	return 0;
 
 st_magn_device_register_error:
-	if (mdata->get_irq_data_ready(indio_dev) > 0)
+	if (irq > 0)
 		st_sensors_deallocate_trigger(indio_dev);
 st_magn_probe_trigger_error:
-	if (mdata->get_irq_data_ready(indio_dev) > 0)
+	if (irq > 0)
 		st_magn_deallocate_ring(indio_dev);
-st_magn_common_probe_error:
+
 	return err;
 }
 EXPORT_SYMBOL(st_magn_common_probe);
-- 
1.8.1.2

