Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44259 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751923AbbGUKPO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2015 06:15:14 -0400
From: Giuseppe Barba <giuseppe.barba@st.com>
To: <linux-iio@vger.kernel.org>
CC: <denis.ciocca@st.com>, <jic23@kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>
Subject: [PATCH] iio: st: rework code style removing goto statements
Date: Tue, 21 Jul 2015 12:14:12 +0200
Message-ID: <1437473652-29150-1-git-send-email-giuseppe.barba@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The scope of this patch is to remove some goto statements and its label
present into st sensors driver.

Signed-off-by: Giuseppe Barba <giuseppe.barba@st.com>
---
 drivers/iio/accel/st_accel_buffer.c               |  7 +--
 drivers/iio/accel/st_accel_core.c                 |  3 +-
 drivers/iio/common/st_sensors/st_sensors_buffer.c | 29 ++++-----
 drivers/iio/common/st_sensors/st_sensors_core.c   | 75 ++++++++++-------------
 drivers/iio/common/st_sensors/st_sensors_i2c.c    |  5 +-
 drivers/iio/common/st_sensors/st_sensors_spi.c    | 10 ++-
 drivers/iio/gyro/st_gyro_buffer.c                 |  7 +--
 drivers/iio/gyro/st_gyro_core.c                   |  5 +-
 drivers/iio/magnetometer/st_magn_buffer.c         | 20 ++----
 drivers/iio/magnetometer/st_magn_core.c           |  5 +-
 drivers/iio/magnetometer/st_magn_i2c.c            |  6 +-
 drivers/iio/magnetometer/st_magn_spi.c            |  6 +-
 drivers/iio/pressure/st_pressure_buffer.c         | 20 ++----
 drivers/iio/pressure/st_pressure_core.c           | 13 ++--
 drivers/iio/pressure/st_pressure_spi.c            |  6 +-
 15 files changed, 77 insertions(+), 140 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index a1e642e..21b5ac4 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -41,10 +41,8 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 
 	adata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (adata->buffer_data == NULL) {
-		err = -ENOMEM;
-		goto allocate_memory_error;
-	}
+	if (adata->buffer_data == NULL)
+		return -ENOMEM;
 
 	err = st_sensors_set_axis_enable(indio_dev,
 					(u8)indio_dev->active_scan_mask[0]);
@@ -59,7 +57,6 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
 
 st_accel_buffer_postenable_error:
 	kfree(adata->buffer_data);
-allocate_memory_error:
 	return err;
 }
 
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index ff30f88..beea981 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -559,7 +559,7 @@ static int st_accel_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		err = st_sensors_read_info_raw(indio_dev, ch, val);
 		if (err < 0)
-			goto read_error;
+			break;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
@@ -573,7 +573,6 @@ static int st_accel_read_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-read_error:
 	return err;
 }
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index e18bc67..4d1f75c 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -32,10 +32,8 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 			indio_dev->channels[0].scan_type.storagebits >> 3;
 
 	addr = kmalloc(num_data_channels, GFP_KERNEL);
-	if (!addr) {
-		len = -ENOMEM;
-		goto st_sensors_get_buffer_element_error;
-	}
+	if (!addr)
+		return -ENOMEM;
 
 	for (i = 0; i < num_data_channels; i++) {
 		if (test_bit(i, indio_dev->active_scan_mask)) {
@@ -59,7 +57,7 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 					   GFP_KERNEL);
 			if (!rx_array) {
 				len = -ENOMEM;
-				goto st_sensors_free_memory;
+				break;
 			}
 
 			len = sdata->tf->read_multiple_byte(&sdata->tb,
@@ -68,7 +66,7 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 				rx_array, sdata->multiread_bit);
 			if (len < 0) {
 				kfree(rx_array);
-				goto st_sensors_free_memory;
+				break;
 			}
 
 			for (i = 0; i < n * byte_for_channel; i++) {
@@ -88,16 +86,13 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 		break;
 	default:
 		len = -EINVAL;
-		goto st_sensors_free_memory;
+		break;
 	}
-	if (len != byte_for_channel * n) {
+	if ((len > 0) && (len != byte_for_channel * n))
 		len = -EIO;
-		goto st_sensors_free_memory;
-	}
 
-st_sensors_free_memory:
 	kfree(addr);
-st_sensors_get_buffer_element_error:
+
 	return len;
 }
 EXPORT_SYMBOL(st_sensors_get_buffer_element);
@@ -110,13 +105,11 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	len = st_sensors_get_buffer_element(indio_dev, sdata->buffer_data);
-	if (len < 0)
-		goto st_sensors_get_buffer_element_error;
-
-	iio_push_to_buffers_with_timestamp(indio_dev, sdata->buffer_data,
-		pf->timestamp);
+	if (len > 0)
+		iio_push_to_buffers_with_timestamp(indio_dev,
+							sdata->buffer_data,
+							pf->timestamp);
 
-st_sensors_get_buffer_element_error:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 2e7fdb5..c84b4f2 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -35,34 +35,32 @@ static int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
 
 	err = sdata->tf->read_byte(&sdata->tb, sdata->dev, reg_addr, &new_data);
 	if (err < 0)
-		goto st_sensors_write_data_with_mask_error;
+		return err;
 
 	new_data = ((new_data & (~mask)) | ((data << __ffs(mask)) & mask));
-	err = sdata->tf->write_byte(&sdata->tb, sdata->dev, reg_addr, new_data);
 
-st_sensors_write_data_with_mask_error:
-	return err;
+	return sdata->tf->write_byte(&sdata->tb, sdata->dev, reg_addr,
+								new_data);
 }
 
 static int st_sensors_match_odr(struct st_sensor_settings *sensor_settings,
 			unsigned int odr, struct st_sensor_odr_avl *odr_out)
 {
-	int i, ret = -EINVAL;
+	int i;
 
 	for (i = 0; i < ST_SENSORS_ODR_LIST_MAX; i++) {
 		if (sensor_settings->odr.odr_avl[i].hz == 0)
-			goto st_sensors_match_odr_error;
+			break;
 
 		if (sensor_settings->odr.odr_avl[i].hz == odr) {
 			odr_out->hz = sensor_settings->odr.odr_avl[i].hz;
 			odr_out->value = sensor_settings->odr.odr_avl[i].value;
-			ret = 0;
-			break;
+
+			return 0;
 		}
 	}
 
-st_sensors_match_odr_error:
-	return ret;
+	return -EINVAL;
 }
 
 int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr)
@@ -73,7 +71,7 @@ int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr)
 
 	err = st_sensors_match_odr(sdata->sensor_settings, odr, &odr_out);
 	if (err < 0)
-		goto st_sensors_match_odr_error;
+		return err;
 
 	if ((sdata->sensor_settings->odr.addr ==
 					sdata->sensor_settings->pw.addr) &&
@@ -96,7 +94,6 @@ int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr)
 	if (err >= 0)
 		sdata->odr = odr_out.hz;
 
-st_sensors_match_odr_error:
 	return err;
 }
 EXPORT_SYMBOL(st_sensors_set_odr);
@@ -104,21 +101,19 @@ EXPORT_SYMBOL(st_sensors_set_odr);
 static int st_sensors_match_fs(struct st_sensor_settings *sensor_settings,
 					unsigned int fs, int *index_fs_avl)
 {
-	int i, ret = -EINVAL;
+	int i;
 
 	for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
 		if (sensor_settings->fs.fs_avl[i].num == 0)
-			goto st_sensors_match_odr_error;
+			break;
 
 		if (sensor_settings->fs.fs_avl[i].num == fs) {
 			*index_fs_avl = i;
-			ret = 0;
-			break;
+			return 0;
 		}
 	}
 
-st_sensors_match_odr_error:
-	return ret;
+	return -EINVAL;
 }
 
 static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
@@ -130,22 +125,23 @@ static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
 		return 0;
 
 	err = st_sensors_match_fs(sdata->sensor_settings, fs, &i);
-	if (err < 0)
-		goto st_accel_set_fullscale_error;
+	if (err < 0) {
+		dev_err(&indio_dev->dev, "requested fullscale is not supported.\n");
+		return err;
+	}
 
 	err = st_sensors_write_data_with_mask(indio_dev,
 				sdata->sensor_settings->fs.addr,
 				sdata->sensor_settings->fs.mask,
 				sdata->sensor_settings->fs.fs_avl[i].value);
-	if (err < 0)
-		goto st_accel_set_fullscale_error;
+	if (err < 0) {
+		dev_err(&indio_dev->dev, "failed to set new fullscale.\n");
+		return err;
+	}
 
 	sdata->current_fullscale = (struct st_sensor_fullscale_avl *)
 					&sdata->sensor_settings->fs.fs_avl[i];
-	return err;
 
-st_accel_set_fullscale_error:
-	dev_err(&indio_dev->dev, "failed to set new fullscale.\n");
 	return err;
 }
 
@@ -166,7 +162,7 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable)
 			err = st_sensors_match_odr(sdata->sensor_settings,
 							sdata->odr, &odr_out);
 			if (err < 0)
-				goto set_enable_error;
+				return err;
 			tmp_value = odr_out.value;
 			found = true;
 		}
@@ -174,7 +170,7 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable)
 				sdata->sensor_settings->pw.addr,
 				sdata->sensor_settings->pw.mask, tmp_value);
 		if (err < 0)
-			goto set_enable_error;
+			return err;
 
 		sdata->enabled = true;
 
@@ -186,12 +182,11 @@ int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable)
 				sdata->sensor_settings->pw.mask,
 				sdata->sensor_settings->pw.value_off);
 		if (err < 0)
-			goto set_enable_error;
+			return err;
 
 		sdata->enabled = false;
 	}
 
-set_enable_error:
 	return err;
 }
 EXPORT_SYMBOL(st_sensors_set_enable);
@@ -375,7 +370,7 @@ int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
 				sdata->sensor_settings->drdy_irq.ig1.en_mask,
 				(int)enable);
 		if (err < 0)
-			goto st_accel_set_dataready_irq_error;
+			return err;
 	}
 
 	if (sdata->drdy_int_pin == 1)
@@ -384,12 +379,9 @@ int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
 		drdy_mask = sdata->sensor_settings->drdy_irq.mask_int2;
 
 	/* Enable/Disable the interrupt generator for data ready. */
-	err = st_sensors_write_data_with_mask(indio_dev,
+	return st_sensors_write_data_with_mask(indio_dev,
 					sdata->sensor_settings->drdy_irq.addr,
 					drdy_mask, (int)enable);
-
-st_accel_set_dataready_irq_error:
-	return err;
 }
 EXPORT_SYMBOL(st_sensors_set_dataready_irq);
 
@@ -406,13 +398,10 @@ int st_sensors_set_fullscale_by_gain(struct iio_dev *indio_dev, int scale)
 		}
 	}
 	if (err < 0)
-		goto st_sensors_match_scale_error;
+		return err;
 
-	err = st_sensors_set_fullscale(indio_dev,
+	return st_sensors_set_fullscale(indio_dev,
 				sdata->sensor_settings->fs.fs_avl[i].num);
-
-st_sensors_match_scale_error:
-	return err;
 }
 EXPORT_SYMBOL(st_sensors_set_fullscale_by_gain);
 
@@ -456,22 +445,22 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
 		err = -EBUSY;
-		goto out;
+		goto st_sensors_mutex_unlock;
 	} else {
 		err = st_sensors_set_enable(indio_dev, true);
 		if (err < 0)
-			goto out;
+			goto st_sensors_mutex_unlock;
 
 		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
 		err = st_sensors_read_axis_data(indio_dev, ch, val);
 		if (err < 0)
-			goto out;
+			goto st_sensors_mutex_unlock;
 
 		*val = *val >> ch->scan_type.shift;
 
 		err = st_sensors_set_enable(indio_dev, false);
 	}
-out:
+st_sensors_mutex_unlock:
 	mutex_unlock(&indio_dev->mlock);
 
 	return err;
diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index 98cfee29..793d7a8 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -33,12 +33,11 @@ static int st_sensors_i2c_read_byte(struct st_sensor_transfer_buffer *tb,
 
 	err = i2c_smbus_read_byte_data(to_i2c_client(dev), reg_addr);
 	if (err < 0)
-		goto st_accel_i2c_read_byte_error;
+		return err;
 
 	*res_byte = err & 0xff;
 
-st_accel_i2c_read_byte_error:
-	return err < 0 ? err : 0;
+	return 0;
 }
 
 static int st_sensors_i2c_read_multiple_byte(
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 5b37737..d7a14e0 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -51,16 +51,14 @@ static int st_sensors_spi_read(struct st_sensor_transfer_buffer *tb,
 		tb->tx_buf[0] = reg_addr | ST_SENSORS_SPI_READ;
 
 	err = spi_sync_transfer(to_spi_device(dev), xfers, ARRAY_SIZE(xfers));
-	if (err)
-		goto acc_spi_read_error;
+	if (err) {
+		mutex_unlock(&tb->buf_lock);
+		return err;
+	}
 
 	memcpy(data, tb->rx_buf, len);
 	mutex_unlock(&tb->buf_lock);
 	return len;
-
-acc_spi_read_error:
-	mutex_unlock(&tb->buf_lock);
-	return err;
 }
 
 static int st_sensors_spi_read_byte(struct st_sensor_transfer_buffer *tb,
diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
index d67b17b..9da07ed 100644
--- a/drivers/iio/gyro/st_gyro_buffer.c
+++ b/drivers/iio/gyro/st_gyro_buffer.c
@@ -41,10 +41,8 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
 
 	gdata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (gdata->buffer_data == NULL) {
-		err = -ENOMEM;
-		goto allocate_memory_error;
-	}
+	if (gdata->buffer_data == NULL)
+		return -ENOMEM;
 
 	err = st_sensors_set_axis_enable(indio_dev,
 					(u8)indio_dev->active_scan_mask[0]);
@@ -59,7 +57,6 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
 
 st_gyro_buffer_postenable_error:
 	kfree(gdata->buffer_data);
-allocate_memory_error:
 	return err;
 }
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 4b993a5..668e099 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -324,7 +324,7 @@ static int st_gyro_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		err = st_sensors_read_info_raw(indio_dev, ch, val);
 		if (err < 0)
-			goto read_error;
+			break;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
@@ -338,7 +338,6 @@ static int st_gyro_read_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-read_error:
 	return err;
 }
 
@@ -357,7 +356,7 @@ static int st_gyro_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&indio_dev->mlock);
 		err = st_sensors_set_odr(indio_dev, val);
 		mutex_unlock(&indio_dev->mlock);
-		return err;
+		break;
 	default:
 		err = -EINVAL;
 	}
diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index ecd3bd0..ea4006f 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -41,21 +41,14 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 
 	mdata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (mdata->buffer_data == NULL) {
-		err = -ENOMEM;
-		goto allocate_memory_error;
-	}
+	if (mdata->buffer_data == NULL)
+		return -ENOMEM;
 
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_magn_buffer_postenable_error;
+		kfree(mdata->buffer_data);
 
 	return err;
-
-st_magn_buffer_postenable_error:
-	kfree(mdata->buffer_data);
-allocate_memory_error:
-	return err;
 }
 
 static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
@@ -64,12 +57,9 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 
 	err = iio_triggered_buffer_predisable(indio_dev);
-	if (err < 0)
-		goto st_magn_buffer_predisable_error;
-
-	err = st_sensors_set_enable(indio_dev, false);
+	if (err >= 0)
+		err = st_sensors_set_enable(indio_dev, false);
 
-st_magn_buffer_predisable_error:
 	kfree(mdata->buffer_data);
 	return err;
 }
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index f8dc4b8..abf75c5 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -497,7 +497,7 @@ static int st_magn_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		err = st_sensors_read_info_raw(indio_dev, ch, val);
 		if (err < 0)
-			goto read_error;
+			break;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
@@ -515,7 +515,6 @@ static int st_magn_read_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-read_error:
 	return err;
 }
 
@@ -534,7 +533,7 @@ static int st_magn_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&indio_dev->mlock);
 		err = st_sensors_set_odr(indio_dev, val);
 		mutex_unlock(&indio_dev->mlock);
-		return err;
+		break;
 	default:
 		err = -EINVAL;
 	}
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 8aa37af..787e5bb 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -60,14 +60,10 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 
 	mdata = iio_priv(indio_dev);
 	st_sensors_of_i2c_probe(client, st_magn_of_match);
-
 	st_sensors_i2c_configure(indio_dev, client, mdata);
-
 	err = st_magn_common_probe(indio_dev);
-	if (err < 0)
-		return err;
 
-	return 0;
+	return (err < 0) ? err : 0;
 }
 
 static int st_magn_i2c_remove(struct i2c_client *client)
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 0abca2c..1d78dae 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -29,14 +29,10 @@ static int st_magn_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	mdata = iio_priv(indio_dev);
-
 	st_sensors_spi_configure(indio_dev, spi, mdata);
-
 	err = st_magn_common_probe(indio_dev);
-	if (err < 0)
-		return err;
 
-	return 0;
+	return (err < 0) ? err : 0;
 }
 
 static int st_magn_spi_remove(struct spi_device *spi)
diff --git a/drivers/iio/pressure/st_pressure_buffer.c b/drivers/iio/pressure/st_pressure_buffer.c
index 2ff53f2..d8a83e7 100644
--- a/drivers/iio/pressure/st_pressure_buffer.c
+++ b/drivers/iio/pressure/st_pressure_buffer.c
@@ -41,21 +41,14 @@ static int st_press_buffer_postenable(struct iio_dev *indio_dev)
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
 
 	press_data->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (press_data->buffer_data == NULL) {
-		err = -ENOMEM;
-		goto allocate_memory_error;
-	}
+	if (press_data->buffer_data == NULL)
+		return -ENOMEM;
 
 	err = iio_triggered_buffer_postenable(indio_dev);
 	if (err < 0)
-		goto st_press_buffer_postenable_error;
+		kfree(press_data->buffer_data);
 
 	return err;
-
-st_press_buffer_postenable_error:
-	kfree(press_data->buffer_data);
-allocate_memory_error:
-	return err;
 }
 
 static int st_press_buffer_predisable(struct iio_dev *indio_dev)
@@ -64,12 +57,9 @@ static int st_press_buffer_predisable(struct iio_dev *indio_dev)
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
 
 	err = iio_triggered_buffer_predisable(indio_dev);
-	if (err < 0)
-		goto st_press_buffer_predisable_error;
-
-	err = st_sensors_set_enable(indio_dev, false);
+	if (err >= 0)
+		err = st_sensors_set_enable(indio_dev, false);
 
-st_press_buffer_predisable_error:
 	kfree(press_data->buffer_data);
 	return err;
 }
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index eb41d2b..b26b1a8 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -325,10 +325,12 @@ static int st_press_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&indio_dev->mlock);
 		err = st_sensors_set_odr(indio_dev, val);
 		mutex_unlock(&indio_dev->mlock);
-		return err;
+		break;
 	default:
 		return -EINVAL;
 	}
+
+	return err;
 }
 
 static int st_press_read_raw(struct iio_dev *indio_dev,
@@ -342,7 +344,7 @@ static int st_press_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		err = st_sensors_read_info_raw(indio_dev, ch, val);
 		if (err < 0)
-			goto read_error;
+			break;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
@@ -356,8 +358,7 @@ static int st_press_read_raw(struct iio_dev *indio_dev,
 			*val2 = press_data->current_fullscale->gain2;
 			break;
 		default:
-			err = -EINVAL;
-			goto read_error;
+			return -EINVAL;
 		}
 
 		return IIO_VAL_INT_PLUS_NANO;
@@ -368,8 +369,7 @@ static int st_press_read_raw(struct iio_dev *indio_dev,
 			*val2 = 10;
 			break;
 		default:
-			err = -EINVAL;
-			goto read_error;
+			return -EINVAL;
 		}
 
 		return IIO_VAL_FRACTIONAL;
@@ -380,7 +380,6 @@ static int st_press_read_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
-read_error:
 	return err;
 }
 
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 1ffa6d4..21aac46 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -29,14 +29,10 @@ static int st_press_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	press_data = iio_priv(indio_dev);
-
 	st_sensors_spi_configure(indio_dev, spi, press_data);
-
 	err = st_press_common_probe(indio_dev);
-	if (err < 0)
-		return err;
 
-	return 0;
+	return (err < 0) ? err : 0;
 }
 
 static int st_press_spi_remove(struct spi_device *spi)
-- 
1.9.1

