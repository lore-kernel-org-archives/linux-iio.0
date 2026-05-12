Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1BE3DB962
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606770; cv=none; b=GDlhAuW382Nro+mGPxCdKH6Uhy3MU9Ir/pIdK91+rGJ2h2OzX3O1gf4/smpq44ttabaKvluKsDU2kGy8nlT/WwRe4utmcdrDGJJujBHYXh0Ho43FgBB0I35eZFyNfCVULNcx+ULPhjtF3Q3iuAGmyCb1ppeflV9JH/Tq3t+Pz2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606770; c=relaxed/simple;
	bh=Vaefe+ZNtTgIWAADYrl7bCpltaGo3lx26Grg4v4u+g8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhHAZqXf0j8tJSllXzIqmmdu31VcQdHZyZAh+3x80GJPTbORM02/Cy1NvGCC+rWfGXyNpS982IXevccaYktcyuEMMuLCxRBUU/BlPwEk470cXJLbEGe1DJDqv50nS7W01VYHb4wirMfMtfDJM141MW+I9JT86YLu23FiP6ErVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Y/s+dVn1; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Y/s+dVn1"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-133466cf955so3349610c88.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1778606767; x=1779211567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CtTm6S0kgOt4sm7/qte+PbTLM/COEmHiXc6XohYcm+4=;
        b=Y/s+dVn1AkBRuGJ/syFQfaT/pos964G9jzb/V27ztsQHMyeJkkxSXhScFS7ykc0707
         haUmq6cAvInOunbjG9rWqdI9PE4bdIEcP/x/U5fC7U2gYJFkrZScsF2zrc4AKQ9GAtM4
         whnhpw2C2eduerhi+venAt5r1t1vMFya7+lNu+ChKbvTMZEhE0y8mfeGw283ookumHlD
         q3Ell5fg5pq4O1011+RVkvitCgCf+EA3ayah7mEx0xxbmGjYSY2DExNxb1/lQBA9MkhR
         jJgKfs+fme2G8DNd4RJuKO29uFmMqo8tmLIddGJ8gh8Blo2nq4LuyZBqlfzO7nZCCNY+
         BUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778606767; x=1779211567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtTm6S0kgOt4sm7/qte+PbTLM/COEmHiXc6XohYcm+4=;
        b=VOv4mr77asPm9auk55uP4/fYv+BhumfN6GB4XZqdJp+63RSaSd4pgaMFWpcm3kH0+Y
         sT2jPqoYeY2CU4JtZNJRFw4rcwV3L5OZqcyoEnIazSEXFRTJLGi2C+RWXf4pxv/Elm0h
         KMNASfvK4leu/QR5COk6XpNnd6Fe9Ho1VE4o8ujq/d+eSBvb4bSiV5ZJVrs5MkHDsc7D
         8kGAQsBUH1QgmQnycxv/l/HPnQBFffrhuh1UjiMmKnEe0vkU2gzMvb0ynO6wFL44Qkm3
         kiWcs6/DUk0xM2XDSy+Als+P0bl5xok/tn5gu7251KWBY/JjV9c19MH1/mtWkPodQhmb
         GbjQ==
X-Forwarded-Encrypted: i=1; AFNElJ87Z2gQejzHccr6cE7/LAVqHNhlbrvzAVT4j43JaLjVR3Pf5+l9Z4/8c3RnymWdWAtP80q3QBxyMCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXsmSz9Dj/au+A9FzvXUkRWmd+1UMem6zKeWLyrzygskm78Eyr
	9ZL8+LXrxCJTNr4tyuPhqX/g2uroTl5//nNBIqg0f0YC3F53FkeqMY1qFFJ8YeSNo+Q=
X-Gm-Gg: Acq92OFjTHHI3DX5voTN7mP8JHbs0ORtuP4MYeI+7ITOuZbRDbI09ETGQ3RgQVT9tHo
	Ye39fVe4FSz5lhYc8WwVEbLLlSyIkme1sPLfwrairjK8UIQZeWBH9GNyiZWuc11l5gUxKqQijez
	guw+JDDxBVNDYcTaoSDHZ84qbucZqTXS8UA5gtVDIFyzWpidYb4TxVOYwK8fZLmC2I1gjd++j0W
	l/yPhSAWgSAWa3wcq0dQoDdhFWiG1fCGCS+qXrjUpUQ+B8lHaG8tqmncYrIH7+L1gsN4QSOpmfp
	N/qsCrM24MffIFlydLUY+bh4Khd/swIOges4Cx3Z4SWAk3kUs44YKlZkEhI/r6HocrJ2DqYo9zK
	JKi2iBQYpyOrAZDdvNhF3zhBPUT1Fd4zLV2FlnxUnW66LVw0S+Ctwdmk9A9/lCg7BtKqu+FpvwO
	DXQ+oIALxs70KZFAVd
X-Received: by 2002:a05:7022:6b81:b0:11b:b179:6e17 with SMTP id a92af1059eb24-132a82e912fmr8503226c88.34.1778606766624;
        Tue, 12 May 2026 10:26:06 -0700 (PDT)
Received: from aline.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327865955fsm24931145c88.11.2026.05.12.10.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:26:06 -0700 (PDT)
From: Aline Ayumi Nakazawa <aline.nakazawa@ime.usp.br>
X-Google-Original-From: Aline Ayumi Nakazawa
To: jean-baptiste.maneyrol@tdk.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: aline.nakazawa@ime.usp.br,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: inv_mpu6050: use guard(mutex) and scoped_guard
Date: Tue, 12 May 2026 14:25:14 -0300
Message-ID: <20260512172538.101383-1-aline.nakazawa@ime.usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aline Nakazawa <aline.nakazawa@ime.usp.br>

Replace manual mutex_lock/unlock calls with guard() and scoped_guard()
macros.

Signed-off-by: Aline Nakazawa <aline.nakazawa@ime.usp.br>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 199 ++++++++++-----------
 1 file changed, 92 insertions(+), 107 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 5796896d54cd..154d9086b6e9 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -20,6 +20,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/cleanup.h>
 
 #include <linux/iio/common/inv_sensors_timestamp.h>
 #include <linux/iio/iio.h>
@@ -756,27 +757,27 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
-		mutex_lock(&st->lock);
-		ret = inv_mpu6050_read_channel_data(indio_dev, chan, val);
-		mutex_unlock(&st->lock);
+		scoped_guard(mutex, &st->lock) {
+			ret = inv_mpu6050_read_channel_data(indio_dev, chan, val);
+		}
 		iio_device_release_direct(indio_dev);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
-		case IIO_ANGL_VEL:
-			mutex_lock(&st->lock);
+		case IIO_ANGL_VEL: {
+			guard(mutex)(&st->lock);
 			*val  = 0;
 			*val2 = gyro_scale_6050[st->chip_config.fsr];
-			mutex_unlock(&st->lock);
 
 			return IIO_VAL_INT_PLUS_NANO;
-		case IIO_ACCEL:
-			mutex_lock(&st->lock);
+		}
+		case IIO_ACCEL: {
+			guard(mutex)(&st->lock);
 			*val = 0;
 			*val2 = accel_scale[st->chip_config.accl_fs];
-			mutex_unlock(&st->lock);
 
 			return IIO_VAL_INT_PLUS_MICRO;
+		}
 		case IIO_TEMP:
 			*val = st->hw->temp.scale / 1000000;
 			*val2 = st->hw->temp.scale % 1000000;
@@ -797,18 +798,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
-			mutex_lock(&st->lock);
-			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
+			guard(mutex)(&st->lock);
+			return inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
 						chan->channel2, val);
-			mutex_unlock(&st->lock);
-			return ret;
 		case IIO_ACCEL:
-			mutex_lock(&st->lock);
-			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
+			guard(mutex)(&st->lock);
+			return inv_mpu6050_sensor_show(st, st->reg->accl_offset,
 						chan->channel2, val);
-			mutex_unlock(&st->lock);
-			return ret;
-
 		default:
 			return -EINVAL;
 		}
@@ -896,50 +892,49 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
 
-	mutex_lock(&st->lock);
-	result = pm_runtime_resume_and_get(pdev);
-	if (result)
-		goto error_write_raw_unlock;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		switch (chan->type) {
-		case IIO_ANGL_VEL:
-			result = inv_mpu6050_write_gyro_scale(st, val, val2);
-			break;
-		case IIO_ACCEL:
-			result = inv_mpu6050_write_accel_scale(st, val, val2);
-			break;
-		default:
-			result = -EINVAL;
+	scoped_guard(mutex, &st->lock) {
+		result = pm_runtime_resume_and_get(pdev);
+		if (result)
 			break;
-		}
-		break;
-	case IIO_CHAN_INFO_CALIBBIAS:
-		switch (chan->type) {
-		case IIO_ANGL_VEL:
-			result = inv_mpu6050_sensor_set(st,
-							st->reg->gyro_offset,
-							chan->channel2, val);
+
+		switch (mask) {
+		case IIO_CHAN_INFO_SCALE:
+			switch (chan->type) {
+			case IIO_ANGL_VEL:
+				result = inv_mpu6050_write_gyro_scale(st, val, val2);
+				break;
+			case IIO_ACCEL:
+				result = inv_mpu6050_write_accel_scale(st, val, val2);
+				break;
+			default:
+				result = -EINVAL;
+				break;
+			}
 			break;
-		case IIO_ACCEL:
-			result = inv_mpu6050_sensor_set(st,
-							st->reg->accl_offset,
-							chan->channel2, val);
+		case IIO_CHAN_INFO_CALIBBIAS:
+			switch (chan->type) {
+			case IIO_ANGL_VEL:
+				result = inv_mpu6050_sensor_set(st,
+								st->reg->gyro_offset,
+								chan->channel2, val);
+				break;
+			case IIO_ACCEL:
+				result = inv_mpu6050_sensor_set(st,
+								st->reg->accl_offset,
+								chan->channel2, val);
+				break;
+			default:
+				result = -EINVAL;
+				break;
+			}
 			break;
 		default:
 			result = -EINVAL;
 			break;
 		}
-		break;
-	default:
-		result = -EINVAL;
-		break;
-	}
 
-	pm_runtime_put_autosuspend(pdev);
-error_write_raw_unlock:
-	mutex_unlock(&st->lock);
+		pm_runtime_put_autosuspend(pdev);
+	}
 	iio_device_release_direct(indio_dev);
 
 	return result;
@@ -1315,49 +1310,46 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	fifo_rate = INV_MPU6050_DIVIDER_TO_FIFO_RATE(d);
 	fifo_period = NSEC_PER_SEC / fifo_rate;
 
-	mutex_lock(&st->lock);
-	if (d == st->chip_config.divider) {
-		result = 0;
-		goto fifo_rate_fail_unlock;
-	}
-
-	fifo_on = st->chip_config.accl_fifo_enable ||
-		  st->chip_config.gyro_fifo_enable ||
-		  st->chip_config.magn_fifo_enable;
-	result = inv_sensors_timestamp_update_odr(&st->timestamp, fifo_period, fifo_on);
-	if (result)
-		goto fifo_rate_fail_unlock;
+	scoped_guard(mutex, &st->lock) {
+		if (d == st->chip_config.divider)
+			return count;
 
-	result = pm_runtime_resume_and_get(pdev);
-	if (result)
-		goto fifo_rate_fail_unlock;
+		fifo_on = st->chip_config.accl_fifo_enable ||
+			st->chip_config.gyro_fifo_enable ||
+			st->chip_config.magn_fifo_enable;
+		result = inv_sensors_timestamp_update_odr(&st->timestamp, fifo_period, fifo_on);
+		if (result)
+			return result;
 
-	result = regmap_write(st->map, st->reg->sample_rate_div, d);
-	if (result)
-		goto fifo_rate_fail_power_off;
-	st->chip_config.divider = d;
+		result = pm_runtime_resume_and_get(pdev);
+		if (result)
+			return result;
 
-	result = inv_mpu6050_set_lpf(st, fifo_rate);
-	if (result)
-		goto fifo_rate_fail_power_off;
+		result = regmap_write(st->map, st->reg->sample_rate_div, d);
+		if (!result) {
+			st->chip_config.divider = d;
 
-	/* update rate for magn, noop if not present in chip */
-	result = inv_mpu_magn_set_rate(st, fifo_rate);
-	if (result)
-		goto fifo_rate_fail_power_off;
+			result = inv_mpu6050_set_lpf(st, fifo_rate);
+			if (!result) {
+				/* update rate for magn, noop if not present in chip */
+				result = inv_mpu_magn_set_rate(st, fifo_rate);
+			}
 
-	/* update wom threshold since roc is dependent on sampling frequency */
-	result = inv_mpu6050_set_wom_threshold(st, st->chip_config.roc_threshold,
-					       INV_MPU6050_FREQ_DIVIDER(st));
-	if (result)
-		goto fifo_rate_fail_power_off;
+			if (!result) {
+				/*
+				 * update wom threshold since roc is dependent on
+				 * sampling frequency
+				 */
+				result = inv_mpu6050_set_wom_threshold(st,
+						st->chip_config.roc_threshold,
+						INV_MPU6050_FREQ_DIVIDER(st));
+			}
+		}
 
-fifo_rate_fail_power_off:
-	pm_runtime_put_autosuspend(pdev);
-fifo_rate_fail_unlock:
-	mutex_unlock(&st->lock);
-	if (result)
-		return result;
+		pm_runtime_put_autosuspend(pdev);
+		if (result)
+			return result;
+	}
 
 	return count;
 }
@@ -1372,9 +1364,9 @@ inv_fifo_rate_show(struct device *dev, struct device_attribute *attr,
 	struct inv_mpu6050_state *st = iio_priv(dev_to_iio_dev(dev));
 	unsigned fifo_rate;
 
-	mutex_lock(&st->lock);
-	fifo_rate = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
-	mutex_unlock(&st->lock);
+	scoped_guard(mutex, &st->lock) {
+		fifo_rate = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
+	}
 
 	return sysfs_emit(buf, "%u\n", fifo_rate);
 }
@@ -1718,16 +1710,12 @@ static int inv_mpu6050_reg_access(struct iio_dev *indio_dev,
 				  unsigned int *readval)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	if (readval)
-		ret = regmap_read(st->map, reg, readval);
-	else
-		ret = regmap_write(st->map, reg, writeval);
-	mutex_unlock(&st->lock);
+		return regmap_read(st->map, reg, readval);
 
-	return ret;
+	return regmap_write(st->map, reg, writeval);
 }
 
 static const struct iio_info mpu_info = {
@@ -2227,23 +2215,20 @@ static int inv_mpu_runtime_suspend(struct device *dev)
 	unsigned int sensors;
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	sensors = INV_MPU6050_SENSOR_ACCL | INV_MPU6050_SENSOR_GYRO |
 			INV_MPU6050_SENSOR_TEMP | INV_MPU6050_SENSOR_MAGN |
 			INV_MPU6050_SENSOR_WOM;
 	ret = inv_mpu6050_switch_engine(st, false, sensors);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	ret = inv_mpu6050_set_power_itg(st, false);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	inv_mpu_core_disable_regulator_vddio(st);
-
-out_unlock:
-	mutex_unlock(&st->lock);
 	return ret;
 }
 
-- 
2.51.0

