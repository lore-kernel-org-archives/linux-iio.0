Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:51180 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932857Ab1JNNrA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2011 09:47:00 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/2] staging:iio: fix removal path to allow correct freeing.
Date: Fri, 14 Oct 2011 14:46:58 +0100
Message-Id: <1318600019-11809-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1318600019-11809-1-git-send-email-jic23@cam.ac.uk>
References: <1318600019-11809-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix a dumb lack of consideration of the effect of combining
the iio_device_unregister and iio_free_device calls into
one.  There is no valid place to free some of the sysfs
array elements.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_core.c      |    3 +-
 drivers/staging/iio/accel/adis16203_core.c      |    3 +-
 drivers/staging/iio/accel/adis16204_core.c      |    3 +-
 drivers/staging/iio/accel/adis16209_core.c      |    3 +-
 drivers/staging/iio/accel/adis16220_core.c      |   13 +++++------
 drivers/staging/iio/accel/adis16240_core.c      |    3 +-
 drivers/staging/iio/accel/kxsd9.c               |    1 +
 drivers/staging/iio/accel/lis3l02dq_core.c      |    7 +++--
 drivers/staging/iio/accel/sca3000_core.c        |   13 +++++------
 drivers/staging/iio/adc/ad7150.c                |    3 +-
 drivers/staging/iio/adc/ad7152.c                |    1 +
 drivers/staging/iio/adc/ad7192.c                |   26 ++++++++--------------
 drivers/staging/iio/adc/ad7280a.c               |   19 ++++++++--------
 drivers/staging/iio/adc/ad7291.c                |    4 ++-
 drivers/staging/iio/adc/ad7298_core.c           |    4 +-
 drivers/staging/iio/adc/ad7476_core.c           |    3 +-
 drivers/staging/iio/adc/ad7606_core.c           |    3 +-
 drivers/staging/iio/adc/ad7746.c                |    1 +
 drivers/staging/iio/adc/ad7780.c                |    3 +-
 drivers/staging/iio/adc/ad7793.c                |    3 +-
 drivers/staging/iio/adc/ad7816.c                |    3 +-
 drivers/staging/iio/adc/ad7887_core.c           |    3 +-
 drivers/staging/iio/adc/ad799x_core.c           |    3 +-
 drivers/staging/iio/adc/adt7310.c               |    3 +-
 drivers/staging/iio/adc/adt7410.c               |    3 +-
 drivers/staging/iio/adc/adt75.c                 |    3 +-
 drivers/staging/iio/adc/max1363_core.c          |    3 +-
 drivers/staging/iio/addac/adt7316.c             |    3 +-
 drivers/staging/iio/dac/ad5446.c                |    9 ++++---
 drivers/staging/iio/dac/ad5504.c                |    4 +-
 drivers/staging/iio/dac/ad5624r_spi.c           |    3 +-
 drivers/staging/iio/dac/ad5686.c                |    4 +-
 drivers/staging/iio/dac/ad5791.c                |    5 +--
 drivers/staging/iio/dds/ad5930.c                |    1 +
 drivers/staging/iio/dds/ad9832.c                |    9 ++++---
 drivers/staging/iio/dds/ad9834.c                |    8 +++---
 drivers/staging/iio/dds/ad9850.c                |    1 +
 drivers/staging/iio/dds/ad9852.c                |    1 +
 drivers/staging/iio/dds/ad9910.c                |    1 +
 drivers/staging/iio/dds/ad9951.c                |    1 +
 drivers/staging/iio/gyro/adis16060_core.c       |    1 +
 drivers/staging/iio/gyro/adis16080_core.c       |    1 +
 drivers/staging/iio/gyro/adis16130_core.c       |    1 +
 drivers/staging/iio/gyro/adis16260_core.c       |    4 ++-
 drivers/staging/iio/gyro/adxrs450_core.c        |   11 +++------
 drivers/staging/iio/impedance-analyzer/ad5933.c |    3 +-
 drivers/staging/iio/imu/adis16400_core.c        |    3 +-
 drivers/staging/iio/industrialio-core.c         |    3 --
 drivers/staging/iio/light/isl29018.c            |    1 +
 drivers/staging/iio/light/tsl2563.c             |    5 +++-
 drivers/staging/iio/light/tsl2583.c             |    1 +
 drivers/staging/iio/magnetometer/ak8975.c       |    7 +++--
 drivers/staging/iio/magnetometer/hmc5843.c      |    4 ++-
 drivers/staging/iio/meter/ade7753.c             |    5 ++-
 drivers/staging/iio/meter/ade7754.c             |    3 +-
 drivers/staging/iio/meter/ade7758_core.c        |    5 ++-
 drivers/staging/iio/meter/ade7759.c             |    3 +-
 drivers/staging/iio/meter/ade7854.c             |    1 +
 drivers/staging/iio/resolver/ad2s1200.c         |    1 +
 drivers/staging/iio/resolver/ad2s1210.c         |    4 +-
 drivers/staging/iio/resolver/ad2s90.c           |    1 +
 61 files changed, 148 insertions(+), 110 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index d7ec505..1c5dad5 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -532,10 +532,11 @@ static int adis16201_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
+	iio_device_unregister(indio_dev);
 	adis16201_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16201_unconfigure_ring(indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 2ffcf4e..8a33374 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -487,10 +487,11 @@ static int adis16203_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
+	iio_device_unregister(indio_dev);
 	adis16203_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16203_unconfigure_ring(indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 2ca617d..cc6eb26 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -561,10 +561,11 @@ static int adis16204_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
+	iio_device_unregister(indio_dev);
 	adis16204_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16204_unconfigure_ring(indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index d03ac01..0a8571b 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -536,10 +536,11 @@ static int adis16209_remove(struct spi_device *spi)
 
 	flush_scheduled_work();
 
+	iio_device_unregister(indio_dev);
 	adis16209_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16209_unconfigure_ring(indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 15f5f30..6d4503d 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -624,7 +624,7 @@ static const struct iio_info adis16220_info = {
 
 static int __devinit adis16220_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct adis16220_state *st;
 	struct iio_dev *indio_dev;
 
@@ -652,11 +652,10 @@ static int __devinit adis16220_probe(struct spi_device *spi)
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
-	regdone = 1;
 
 	ret = sysfs_create_bin_file(&indio_dev->dev.kobj, &accel_bin);
 	if (ret)
-		goto error_free_dev;
+		goto error_unregister_dev;
 
 	ret = sysfs_create_bin_file(&indio_dev->dev.kobj, &adc1_bin);
 	if (ret)
@@ -678,11 +677,10 @@ error_rm_adc1_bin:
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
 error_rm_accel_bin:
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
+error_unregister_dev:
+	iio_device_unregister(indio_dev);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
@@ -697,6 +695,7 @@ static int adis16220_remove(struct spi_device *spi)
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
 	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index ee1e873..b8be292 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -589,10 +589,11 @@ static int adis16240_remove(struct spi_device *spi)
 
 	flush_scheduled_work();
 
+	iio_device_unregister(indio_dev);
 	adis16240_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16240_unconfigure_ring(indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index eeee808..5238503 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -262,6 +262,7 @@ error_ret:
 static int __devexit kxsd9_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
+	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 737dd97..559545a 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -736,7 +736,7 @@ error_uninitialize_buffer:
 error_unreg_buffer_funcs:
 	lis3l02dq_unconfigure_buffer(indio_dev);
 error_free_dev:
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
@@ -774,6 +774,8 @@ static int lis3l02dq_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
+
 	ret = lis3l02dq_disable_all_events(indio_dev);
 	if (ret)
 		goto err_ret;
@@ -789,8 +791,7 @@ static int lis3l02dq_remove(struct spi_device *spi)
 	iio_buffer_unregister(indio_dev);
 	lis3l02dq_unconfigure_buffer(indio_dev);
 
-	iio_device_unregister(indio_dev);
-
+	iio_free_device(indio_dev);
 err_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index f2cdb1f..62cdef4 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1123,7 +1123,7 @@ static const struct iio_info sca3000_info_with_temp = {
 
 static int __devinit sca3000_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct sca3000_state *st;
 	struct iio_dev *indio_dev;
 
@@ -1155,7 +1155,7 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
 		goto error_free_dev;
-	regdone = 1;
+
 	ret = iio_buffer_register(indio_dev,
 				  sca3000_channels,
 				  ARRAY_SIZE(sca3000_channels));
@@ -1189,11 +1189,9 @@ error_free_irq:
 error_unregister_ring:
 	iio_buffer_unregister(indio_dev);
 error_unregister_dev:
+	iio_device_unregister(indio_dev);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 
 error_ret:
 	return ret;
@@ -1228,9 +1226,10 @@ static int sca3000_remove(struct spi_device *spi)
 		return ret;
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
 		free_irq(spi->irq, indio_dev);
+	iio_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	sca3000_unconfigure_ring(indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index 7d05096..e185f0e 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -628,13 +628,14 @@ static int __devexit ad7150_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
+	iio_device_unregister(indio_dev);
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 
 	if (client->dev.platform_data)
 		free_irq(*(unsigned int *)client->dev.platform_data, indio_dev);
 
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index f980a09..662584d 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -519,6 +519,7 @@ static int __devexit ad7152_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 29258f4..31c376b 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -1032,7 +1032,7 @@ static int __devinit ad7192_probe(struct spi_device *spi)
 	struct ad7192_platform_data *pdata = spi->dev.platform_data;
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
-	int ret, i , voltage_uv = 0, regdone = 0;
+	int ret, i , voltage_uv = 0;
 
 	if (!pdata) {
 		dev_err(&spi->dev, "no platform data?\n");
@@ -1090,14 +1090,9 @@ static int __devinit ad7192_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_ring;
-	regdone = 1;
-
 	ret = ad7192_probe_trigger(indio_dev);
 	if (ret)
-		goto error_unreg_ring;
+		goto error_ring_cleanup;
 
 	ret = iio_buffer_register(indio_dev,
 				  indio_dev->channels,
@@ -1107,15 +1102,18 @@ static int __devinit ad7192_probe(struct spi_device *spi)
 
 	ret = ad7192_setup(st);
 	if (ret)
-		goto error_uninitialize_ring;
+		goto error_unreg_ring;
 
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto error_unreg_ring;
 	return 0;
 
-error_uninitialize_ring:
+error_unreg_ring:
 	iio_buffer_unregister(indio_dev);
 error_remove_trigger:
 	ad7192_remove_trigger(indio_dev);
-error_unreg_ring:
+error_ring_cleanup:
 	ad7192_ring_cleanup(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(st->reg))
@@ -1124,10 +1122,7 @@ error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
 
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 
 	return ret;
 }
@@ -1137,6 +1132,7 @@ static int ad7192_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7192_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	ad7192_remove_trigger(indio_dev);
 	ad7192_ring_cleanup(indio_dev);
@@ -1146,8 +1142,6 @@ static int ad7192_remove(struct spi_device *spi)
 		regulator_put(st->reg);
 	}
 
-	iio_device_unregister(indio_dev);
-
 	return 0;
 }
 
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 386834a..372d059 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -831,7 +831,7 @@ static int __devinit ad7280_probe(struct spi_device *spi)
 {
 	const struct ad7280_platform_data *pdata = spi->dev.platform_data;
 	struct ad7280_state *st;
-	int ret, regdone = 0;
+	int ret;
 	const unsigned short tACQ_ns[4] = {465, 1010, 1460, 1890};
 	const unsigned short nAVG[4] = {1, 2, 4, 8};
 	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
@@ -903,21 +903,20 @@ static int __devinit ad7280_probe(struct spi_device *spi)
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_attr;
-	regdone = 1;
 
 	if (spi->irq > 0) {
 		ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
 				   AD7280A_ALERT, 1,
 				   AD7280A_ALERT_RELAY_SIG_CHAIN_DOWN);
 		if (ret)
-			goto error_free_attr;
+			goto error_unregister;
 
 		ret = ad7280_write(st, AD7280A_DEVADDR(st->slave_num),
 				   AD7280A_ALERT, 0,
 				   AD7280A_ALERT_GEN_STATIC_HIGH |
 				   (pdata->chain_last_alert_ignore & 0xF));
 		if (ret)
-			goto error_free_attr;
+			goto error_unregister;
 
 		ret = request_threaded_irq(spi->irq,
 					   NULL,
@@ -927,10 +926,12 @@ static int __devinit ad7280_probe(struct spi_device *spi)
 					   indio_dev->name,
 					   indio_dev);
 		if (ret)
-			goto error_free_attr;
+			goto error_unregister;
 	}
 
 	return 0;
+error_unregister:
+	iio_device_unregister(indio_dev);
 
 error_free_attr:
 	kfree(st->iio_attr);
@@ -939,10 +940,7 @@ error_free_channels:
 	kfree(st->channels);
 
 error_free_device:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 
 	return ret;
 }
@@ -954,13 +952,14 @@ static int __devexit ad7280_remove(struct spi_device *spi)
 
 	if (spi->irq > 0)
 		free_irq(spi->irq, indio_dev);
+	iio_device_unregister(indio_dev);
 
 	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
 			AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
 
 	kfree(st->channels);
 	kfree(st->iio_attr);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index acdce8c..10e79e8 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -670,6 +670,8 @@ static int __devexit ad7291_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ad7291_chip_info *chip = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
+
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 
@@ -678,7 +680,7 @@ static int __devexit ad7291_remove(struct i2c_client *client)
 		regulator_put(chip->reg);
 	}
 
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index b772727..c1de73a 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -249,14 +249,14 @@ static int __devexit ad7298_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7298_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	ad7298_ring_cleanup(indio_dev);
-	iio_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 1953dbf..fd79fac 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -211,13 +211,14 @@ static int ad7476_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7476_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	ad7476_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 3c0fb72..54423ab 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -545,6 +545,7 @@ int ad7606_remove(struct iio_dev *indio_dev, int irq)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	ad7606_ring_cleanup(indio_dev);
 
@@ -555,7 +556,7 @@ int ad7606_remove(struct iio_dev *indio_dev, int irq)
 	}
 
 	ad7606_free_gpios(st);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7746.c b/drivers/staging/iio/adc/ad7746.c
index 3fe0c17..2867943 100644
--- a/drivers/staging/iio/adc/ad7746.c
+++ b/drivers/staging/iio/adc/ad7746.c
@@ -766,6 +766,7 @@ static int __devexit ad7746_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index a8103c0..7a579a1 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -255,13 +255,14 @@ static int ad7780_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7780_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	free_irq(spi->irq, st);
 	gpio_free(st->pdata->gpio_pdrst);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 0a536c5..a831b92 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -1013,6 +1013,7 @@ static int ad7793_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7793_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	ad7793_remove_trigger(indio_dev);
 	ad7793_ring_cleanup(indio_dev);
@@ -1022,7 +1023,7 @@ static int ad7793_remove(struct spi_device *spi)
 		regulator_put(st->reg);
 	}
 
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 1440619..bdb9049 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -435,13 +435,14 @@ static int __devexit ad7816_remove(struct spi_device *spi_dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(&spi_dev->dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	dev_set_drvdata(&spi_dev->dev, NULL);
 	if (spi_dev->irq)
 		free_irq(spi_dev->irq, indio_dev);
 	gpio_free(chip->busy_pin);
 	gpio_free(chip->convert_pin);
 	gpio_free(chip->rdwr_pin);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 9456c03..609dcd5 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -230,13 +230,14 @@ static int ad7887_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7887_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	ad7887_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 2d60539..ee6cd79 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -892,6 +892,7 @@ static __devexit int ad799x_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ad799x_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	if (client->irq > 0)
 		free_irq(client->irq, indio_dev);
 
@@ -901,7 +902,7 @@ static __devexit int ad799x_remove(struct i2c_client *client)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index cbbd349..c9e0be3 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -856,12 +856,13 @@ static int __devexit adt7310_remove(struct spi_device *spi_dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(&spi_dev->dev);
 	unsigned long *adt7310_platform_data = spi_dev->dev.platform_data;
 
+	iio_device_unregister(indio_dev);
 	dev_set_drvdata(&spi_dev->dev, NULL);
 	if (adt7310_platform_data[0])
 		free_irq(adt7310_platform_data[0], indio_dev);
 	if (spi_dev->irq)
 		free_irq(spi_dev->irq, indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index cc913bc..a289e42 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -819,11 +819,12 @@ static int __devexit adt7410_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	unsigned long *adt7410_platform_data = client->dev.platform_data;
 
+	iio_device_unregister(indio_dev);
 	if (adt7410_platform_data[0])
 		free_irq(adt7410_platform_data[0], indio_dev);
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/adt75.c b/drivers/staging/iio/adc/adt75.c
index 08215e9..a677cfc 100644
--- a/drivers/staging/iio/adc/adt75.c
+++ b/drivers/staging/iio/adc/adt75.c
@@ -613,9 +613,10 @@ static int __devexit adt75_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
+	iio_device_unregister(indio_dev);
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index e962f84..12db93e 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -1347,6 +1347,7 @@ static int max1363_remove(struct i2c_client *client)
 	struct max1363_state *st = iio_priv(indio_dev);
 	struct regulator *reg = st->reg;
 
+	iio_device_unregister(indio_dev);
 	if (client->irq)
 		free_irq(st->client->irq, indio_dev);
 	iio_buffer_unregister(indio_dev);
@@ -1356,7 +1357,7 @@ static int max1363_remove(struct i2c_client *client)
 		regulator_disable(reg);
 		regulator_put(reg);
 	}
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index d37726e..8df2470 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2219,9 +2219,10 @@ int __devexit adt7316_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adt7316_chip_info *chip = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	if (chip->bus.irq)
 		free_irq(chip->bus.irq, indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index dc98867a..e1c204d 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -424,13 +424,14 @@ static int ad5446_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5446_state *st = iio_priv(indio_dev);
-	struct regulator *reg = st->reg;
 
 	iio_device_unregister(indio_dev);
-	if (!IS_ERR(reg)) {
-		regulator_disable(reg);
-		regulator_put(reg);
+	if (!IS_ERR(st->reg)) {
+		regulator_disable(st->reg);
+		regulator_put(st->reg);
 	}
+	iio_free_device(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index a430874..a0be132 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -350,6 +350,7 @@ static int __devexit ad5504_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5504_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
 
@@ -357,8 +358,7 @@ static int __devexit ad5504_remove(struct spi_device *spi)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 8e7fafb..01e8e48 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -289,11 +289,12 @@ static int __devexit ad5624r_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5624r_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index adf898f..e7545a3 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -421,12 +421,12 @@ static int __devexit ad5686_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index 6c34700..abb5952 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -371,6 +371,7 @@ static int __devexit ad5791_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5791_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg_vdd)) {
 		regulator_disable(st->reg_vdd);
 		regulator_put(st->reg_vdd);
@@ -380,9 +381,7 @@ static int __devexit ad5791_remove(struct spi_device *spi)
 		regulator_disable(st->reg_vss);
 		regulator_put(st->reg_vss);
 	}
-	iio_device_unregister(indio_dev);
-
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dds/ad5930.c b/drivers/staging/iio/dds/ad5930.c
index 4847ea2..f5e368b 100644
--- a/drivers/staging/iio/dds/ad5930.c
+++ b/drivers/staging/iio/dds/ad5930.c
@@ -130,6 +130,7 @@ error_ret:
 static int __devexit ad5930_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
+	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index aefcab1..0db0b3a 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -328,13 +328,14 @@ static int __devexit ad9832_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad9832_state *st = iio_priv(indio_dev);
-	struct regulator *reg = st->reg;
 
 	iio_device_unregister(indio_dev);
-	if (!IS_ERR(reg)) {
-		regulator_disable(reg);
-		regulator_put(reg);
+	if (!IS_ERR(st->reg)) {
+		regulator_disable(st->reg);
+		regulator_put(st->reg);
 	}
+	iio_free_device(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index fe46119..c468f69 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -417,13 +417,13 @@ static int __devexit ad9834_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad9834_state *st = iio_priv(indio_dev);
-	struct regulator *reg = st->reg;
 
 	iio_device_unregister(indio_dev);
-	if (!IS_ERR(reg)) {
-		regulator_disable(reg);
-		regulator_put(reg);
+	if (!IS_ERR(st->reg)) {
+		regulator_disable(st->reg);
+		regulator_put(st->reg);
 	}
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dds/ad9850.c b/drivers/staging/iio/dds/ad9850.c
index 7f2dd47..a14771b 100644
--- a/drivers/staging/iio/dds/ad9850.c
+++ b/drivers/staging/iio/dds/ad9850.c
@@ -116,6 +116,7 @@ error_ret:
 static int __devexit ad9850_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
+	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dds/ad9852.c b/drivers/staging/iio/dds/ad9852.c
index 7f65b92..cfceaa6 100644
--- a/drivers/staging/iio/dds/ad9852.c
+++ b/drivers/staging/iio/dds/ad9852.c
@@ -267,6 +267,7 @@ error_ret:
 static int __devexit ad9852_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
+	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dds/ad9910.c b/drivers/staging/iio/dds/ad9910.c
index b72df8c..da83d2b 100644
--- a/drivers/staging/iio/dds/ad9910.c
+++ b/drivers/staging/iio/dds/ad9910.c
@@ -400,6 +400,7 @@ error_ret:
 static int __devexit ad9910_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
+	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dds/ad9951.c b/drivers/staging/iio/dds/ad9951.c
index 3d478e7..20c1825 100644
--- a/drivers/staging/iio/dds/ad9951.c
+++ b/drivers/staging/iio/dds/ad9951.c
@@ -211,6 +211,7 @@ error_ret:
 static int __devexit ad9951_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
+	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index abb6f05..38cf3f4 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -183,6 +183,7 @@ error_ret:
 static int adis16060_r_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
+	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 07b013a..5b5a60d6 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -177,6 +177,7 @@ error_ret:
 static int adis16080_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
+	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 87670c0..749240d 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -155,6 +155,7 @@ error_ret:
 static int adis16130_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
+	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index dc440d15..d37fae7 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -673,6 +673,8 @@ static int adis16260_remove(struct spi_device *spi)
 	int ret;
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
+	iio_device_unregister(indio_dev);
+
 	ret = adis16260_stop_device(indio_dev);
 	if (ret)
 		goto err_ret;
@@ -682,7 +684,7 @@ static int adis16260_remove(struct spi_device *spi)
 	adis16260_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16260_unconfigure_ring(indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 1fda3db..37837c7 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -325,7 +325,7 @@ static const struct iio_info adxrs450_info = {
 
 static int __devinit adxrs450_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct adxrs450_state *st;
 	struct iio_dev *indio_dev;
 
@@ -351,20 +351,16 @@ static int __devinit adxrs450_probe(struct spi_device *spi)
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
-	regdone = 1;
 
 	/* Get the device into a sane initial state */
 	ret = adxrs450_initial_setup(indio_dev);
 	if (ret)
 		goto error_initial;
 	return 0;
-
 error_initial:
+	iio_device_unregister(indio_dev);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 
 error_ret:
 	return ret;
@@ -373,6 +369,7 @@ error_ret:
 static int adxrs450_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
+	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index e7ef3b2..1086e0b 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -768,13 +768,14 @@ static __devexit int ad5933_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ad5933_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	iio_sw_rb_free(indio_dev->buffer);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 365f99a..d082a37 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1088,6 +1088,7 @@ static int adis16400_remove(struct spi_device *spi)
 	int ret;
 	struct iio_dev *indio_dev =  spi_get_drvdata(spi);
 
+	iio_device_unregister(indio_dev);
 	ret = adis16400_stop_device(indio_dev);
 	if (ret)
 		goto err_ret;
@@ -1095,7 +1096,7 @@ static int adis16400_remove(struct spi_device *spi)
 	adis16400_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16400_unconfigure_ring(indio_dev);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index f52fa3a..326e967 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -971,7 +971,6 @@ static int iio_device_register_eventset(struct iio_dev *indio_dev)
 			    l)
 		indio_dev->event_interface->group.attrs[attrn++] =
 			&p->dev_attr.attr;
-
 	indio_dev->groups[indio_dev->groupcounter++] =
 		&indio_dev->event_interface->group;
 
@@ -1002,8 +1001,6 @@ static void iio_dev_release(struct device *device)
 		iio_device_unregister_trigger_consumer(indio_dev);
 	iio_device_unregister_eventset(indio_dev);
 	iio_device_unregister_sysfs(indio_dev);
-	ida_simple_remove(&iio_ida, indio_dev->id);
-	kfree(indio_dev);
 }
 
 static struct device_type iio_dev_type = {
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 6958aa5..9dc9e63 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -581,6 +581,7 @@ static int __devexit isl29018_remove(struct i2c_client *client)
 
 	dev_dbg(&client->dev, "%s()\n", __func__);
 	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index a5e08b3..7e984bc 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -789,6 +789,8 @@ static int tsl2563_remove(struct i2c_client *client)
 {
 	struct tsl2563_chip *chip = i2c_get_clientdata(client);
 	struct iio_dev *indio_dev = iio_priv_to_dev(chip);
+
+	iio_device_unregister(indio_dev);
 	if (!chip->int_enabled)
 		cancel_delayed_work(&chip->poweroff_work);
 	/* Ensure that interrupts are disabled - then flush any bottom halves */
@@ -799,7 +801,8 @@ static int tsl2563_remove(struct i2c_client *client)
 	tsl2563_set_power(chip, 0);
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
-	iio_device_unregister(indio_dev);
+
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index c7daa2f..80f77cf 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -909,6 +909,7 @@ static int taos_resume(struct i2c_client *client)
 static int __devexit taos_remove(struct i2c_client *client)
 {
 	iio_device_unregister(i2c_get_clientdata(client));
+	iio_free_device(i2c_get_clientdata(client));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index ab0e26c..8b01712 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -546,12 +546,13 @@ static int ak8975_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ak8975_data *data = iio_priv(indio_dev);
-	int eoc_gpio = data->eoc_gpio;
 
 	iio_device_unregister(indio_dev);
 
-	if (gpio_is_valid(eoc_gpio))
-		gpio_free(eoc_gpio);
+	if (gpio_is_valid(data->eoc_gpio))
+		gpio_free(data->eoc_gpio);
+
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 04c7ab0..fc9ee97 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -579,9 +579,11 @@ exit:
 static int hmc5843_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
 	 /*  sleep mode to save power */
 	hmc5843_configure(client, MODE_SLEEP);
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 3d62bfd..10c3c54 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -559,12 +559,13 @@ static int ade7753_remove(struct spi_device *spi)
 	int ret;
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
+	iio_device_unregister(indio_dev);
+
 	ret = ade7753_stop_device(&(indio_dev->dev));
 	if (ret)
 		goto err_ret;
 
-	iio_device_unregister(indio_dev);
-
+	iio_free_device(indio_dev);
 err_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index cdb62a4..39a069a 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -581,11 +581,12 @@ static int ade7754_remove(struct spi_device *spi)
 	int ret;
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
+	iio_device_unregister(indio_dev);
 	ret = ade7754_stop_device(&(indio_dev->dev));
 	if (ret)
 		goto err_ret;
 
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 3f31368..7d66343 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -823,6 +823,7 @@ static int ade7758_remove(struct spi_device *spi)
 	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
 
+	iio_device_unregister(indio_dev);
 	ret = ade7758_stop_device(&indio_dev->dev);
 	if (ret)
 		goto err_ret;
@@ -832,9 +833,9 @@ static int ade7758_remove(struct spi_device *spi)
 	ade7758_unconfigure_ring(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
-	iio_device_unregister(indio_dev);
 
-	return 0;
+	iio_free_device(indio_dev);
+
 err_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 69b1f8b..2e3fac5 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -503,11 +503,12 @@ static int ade7759_remove(struct spi_device *spi)
 	int ret;
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
+	iio_device_unregister(indio_dev);
 	ret = ade7759_stop_device(&(indio_dev->dev));
 	if (ret)
 		goto err_ret;
 
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index bc1f83e..ca88676 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -591,6 +591,7 @@ EXPORT_SYMBOL(ade7854_probe);
 int ade7854_remove(struct iio_dev *indio_dev)
 {
 	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 26268bf..d7ad46a 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -150,6 +150,7 @@ error_ret:
 static int __devexit ad2s1200_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
+	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
 }
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 8a6fcb6..6401a62 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -737,10 +737,10 @@ error_ret:
 static int __devexit ad2s1210_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad2s1210_state *st = iio_priv(indio_dev);
 
-	ad2s1210_free_gpios(st);
 	iio_device_unregister(indio_dev);
+	ad2s1210_free_gpios(iio_priv(indio_dev));
+	iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 8b3d34d..a9200d9 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -100,6 +100,7 @@ error_ret:
 static int __devexit ad2s90_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
+	iio_free_device(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.7

