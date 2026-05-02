Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCED1A9B24
	for <linux-iio@vger.kernel.org>; Sat,  2 May 2026 03:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777692299; cv=none; b=BhihnWvgRQsrB6vOqHtTzdUKGc0B6mrUmJv2VKpZjXcwK88SKJFVrvnhYg/QNL9otrclYr72sKyfDqUf5wGU6cDLnYbs2+j/P8uZweX6wW+cL0/Aks8hLzcRzfpnr5M3/3W6CYIooOXk94t5yJSto9rEexRAzwkC1UKMnIo2wVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777692299; c=relaxed/simple;
	bh=Snru09MHa4vdSSTFJ8++k8St5RVIbamL6q4e3ltXeII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9hVoRuZKrRg/YhFakKkOXRSLwRnLmmiDZj3OiB5XOmbN/kYwZ05DnchomAFpGFChhC2PMnLAziV3fQBbjI69y0zJhaJOQXVXSKbjcvCjDo3US2W0CB1L2CRVlgXUu7FZt2+7KIDBGFIM4deSrgg6QMD3H63iQ1aEDySKP1C7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6kxFIhX; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6kxFIhX"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dcd17e19b6so1410556a34.1
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 20:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777692296; x=1778297096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FoyrhWs5FG03vrGQrf82zp9nJimCyZ0v4w/3/GCSuyk=;
        b=O6kxFIhXahgOnY8a6tWlpetV6tbydWImYEtOGmPP+c2F3vCMfzYVjBi05pYP1QRW+j
         SMpB2EASLh1WMAPyYq7eOTDc1dTRS7BffOwP12oN6rf67rl10NII2kJQC3uVkzEcC6nB
         qxzCi6tZ2l4bVMBL8fKy9MuumoL/XdMZprpLffgQuuH/XanmKIesnTyR+5UFWU75PtIV
         3Ht5Mr7k1ecSgwIHzcwW2ULj6zvwSDJlQ/v8U8ddUjy1kBgmkRLjhWupuAuzCo34t7NS
         M5ztDzAd8fgzXvqqk1VljBF5fcOM6OFQErY1T53EIR0fUKy4bRmVmBqqXWqFJkwAXQL0
         J2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777692296; x=1778297096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoyrhWs5FG03vrGQrf82zp9nJimCyZ0v4w/3/GCSuyk=;
        b=aWJQYw1ynBC7Pr1uvoZAE/XPgONgAXrVcmmft45qGHetUjU2lUpYsCH89LL0bxGoYV
         tKMDdmOiM8tcM48keIDpeiSUo9aAfwCgkUv+QO+zniWrcpHebF95nwyPCMZVWHcYvvN+
         Rjpw8lD+6yIXLxOG91EG7ecY0Q6f4Qsymc5ZBRTF86o4DbvNt5GWQuiL5y0hm3CZUDmj
         LFaWXaolDDFFgYc85F/KTU6GTP9yAIkVSytGqls2BAEzZmm+bnZa4fNmhdeMZ+InGnvL
         M36sTZHuUTdKnw1MiN55kLEcZClM1QS0epQphZo2mtxCHetcNy2lahwt+SBtiW7UYqNr
         MI6A==
X-Forwarded-Encrypted: i=1; AFNElJ+KkFQqhL1cil61qU/1EUN8x5RU8kjJ469kes8NdWvEwP2y6OjYmaEa6DuYF2yJBJ+3Jidb7znzE1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRq0nTYYOiMKMc5JaU+tbt4UUurXybdzGhuU2zi2UNQxpd3vp+
	PSk5AFwdc+y7DBosnc0ShkCyixZFHe5oiatwtoIfAAdGZ7a33hlhIh3p
X-Gm-Gg: AeBDiet23YblL53tcFwdMWoGsbbQBObxj3AoCG7ZKl7yi7Pgo22nxFTIoIJhCajBXLG
	b+PtGGUbTvWi1J/l8EAQos8YfPijNd9YVCZ5oOtvWZVUEAj8uXBO5Gx4AXvkqEO80B3sR7tH2w/
	jIKG28biStN8C3/m9r3ZIB6TQk8565xiOO6HMxDHQmBISR1dHd+IOq2ypNztwuDVutwplOZpob7
	rK/faP2W67fwS6ydJi9iTcN3L9C5x3PQeQMkGvsKJ3zl16P51Zdc/eAn8xZvBAGcZOJ1zMtkQVF
	dLYYZklkYUhY17JctDK19rWFmPkES05uml03xsPRA1ofU8CticV4BNaQs42do+49DOg0jBY8dqn
	ll1yTfSNQr9d6xsew7JVhJa+As1Qy/K4SewPV3yPu+541SFi+mc2Ts8RSWocZQqASXo3YfbIrUQ
	MAI9Pi6em33JzevJrYK3FkvWGgRQNalQvyTQ0IaQb+x0/A7d3UBit4wEBL42NVJWVI1tHa
X-Received: by 2002:a05:6830:8292:b0:7dc:cd0b:58af with SMTP id 46e09a7af769-7dee121603bmr1263755a34.6.1777692296566;
        Fri, 01 May 2026 20:24:56 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ded51a9612sm2272396a34.26.2026.05.01.20.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 20:24:56 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: imu: kmx61: Use guard(mutex)() family over manual locking
Date: Fri,  1 May 2026 22:24:54 -0500
Message-ID: <20260502032455.76107-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include linux/cleanup.h to take advantage of new macros.

Replace manual mutex_lock() and mutex_unlock() calls across the file
with guard(mutex)() and scoped_guard() where appropriate. This will help
modernize the driver with up-to-date functions/macros.

Remove now redundant gotos and ret variables, as the new RAII macros
make them unneeded.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/imu/kmx61.c | 74 ++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 3cd91d8a89ee..2baaca129601 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -7,6 +7,7 @@
  * IIO driver for KMX61 (7-bit I2C slave address 0x0E or 0x0F).
  */
 
+#include <linux/cleanup.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/mod_devicetable.h>
@@ -794,25 +795,21 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-		mutex_lock(&data->lock);
+		guard(mutex)(&data->lock);
 
 		ret = kmx61_set_power_state(data, true, chan->address);
-		if (ret) {
-			mutex_unlock(&data->lock);
+		if (ret)
 			return ret;
-		}
 
 		ret = kmx61_read_measurement(data, base_reg, chan->scan_index);
 		if (ret < 0) {
 			kmx61_set_power_state(data, false, chan->address);
-			mutex_unlock(&data->lock);
 			return ret;
 		}
 		*val = sign_extend32(ret >> chan->scan_type.shift,
 				     chan->scan_type.realbits - 1);
 		ret = kmx61_set_power_state(data, false, chan->address);
 
-		mutex_unlock(&data->lock);
 		if (ret)
 			return ret;
 		return IIO_VAL_INT;
@@ -834,9 +831,8 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
 		if (chan->type != IIO_ACCEL && chan->type != IIO_MAGN)
 			return -EINVAL;
 
-		mutex_lock(&data->lock);
-		ret = kmx61_get_odr(data, val, val2, chan->address);
-		mutex_unlock(&data->lock);
+		scoped_guard(mutex, &data->lock)
+			ret = kmx61_get_odr(data, val, val2, chan->address);
 		if (ret)
 			return -EINVAL;
 		return IIO_VAL_INT_PLUS_MICRO;
@@ -856,19 +852,15 @@ static int kmx61_write_raw(struct iio_dev *indio_dev,
 		if (chan->type != IIO_ACCEL && chan->type != IIO_MAGN)
 			return -EINVAL;
 
-		mutex_lock(&data->lock);
-		ret = kmx61_set_odr(data, val, val2, chan->address);
-		mutex_unlock(&data->lock);
-		return ret;
+		guard(mutex)(&data->lock);
+		return kmx61_set_odr(data, val, val2, chan->address);
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ACCEL:
 			if (val != 0)
 				return -EINVAL;
-			mutex_lock(&data->lock);
-			ret = kmx61_set_scale(data, val2);
-			mutex_unlock(&data->lock);
-			return ret;
+			guard(mutex)(&data->lock);
+			return kmx61_set_scale(data, val2);
 		default:
 			return -EINVAL;
 		}
@@ -945,28 +937,25 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
 	if (state && data->ev_enable_state)
 		return 0;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	if (!state && data->motion_trig_on) {
 		data->ev_enable_state = false;
-		goto err_unlock;
+		return ret;
 	}
 
 	ret = kmx61_set_power_state(data, state, KMX61_ACC);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	ret = kmx61_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
 		kmx61_set_power_state(data, false, KMX61_ACC);
-		goto err_unlock;
+		return ret;
 	}
 
 	data->ev_enable_state = state;
 
-err_unlock:
-	mutex_unlock(&data->lock);
-
 	return ret;
 }
 
@@ -1020,11 +1009,11 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	if (!state && data->ev_enable_state && data->motion_trig_on) {
 		data->motion_trig_on = false;
-		goto err_unlock;
+		return ret;
 	}
 
 	if (data->acc_dready_trig == trig || data->motion_trig == trig)
@@ -1034,7 +1023,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	ret = kmx61_set_power_state(data, state, device);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	if (data->acc_dready_trig == trig || data->mag_dready_trig == trig)
 		ret = kmx61_setup_new_data_interrupt(data, state, device);
@@ -1042,7 +1031,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		ret = kmx61_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
 		kmx61_set_power_state(data, false, device);
-		goto err_unlock;
+		return ret;
 	}
 
 	if (data->acc_dready_trig == trig)
@@ -1051,8 +1040,6 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		data->mag_dready_trig_on = state;
 	else
 		data->motion_trig_on = state;
-err_unlock:
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -1195,19 +1182,17 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
 	else
 		base = KMX61_MAG_XOUT_L;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	iio_for_each_active_channel(indio_dev, bit) {
 		ret = kmx61_read_measurement(data, base, bit);
 		if (ret < 0) {
-			mutex_unlock(&data->lock);
-			goto err;
+			iio_trigger_notify_done(indio_dev->trig);
+			return IRQ_HANDLED;
 		}
 		buffer[i++] = ret;
 	}
-	mutex_unlock(&data->lock);
 
 	iio_push_to_buffers(indio_dev, buffer);
-err:
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -1419,22 +1404,17 @@ static void kmx61_remove(struct i2c_client *client)
 		iio_trigger_unregister(data->motion_trig);
 	}
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
-	mutex_unlock(&data->lock);
 }
 
 static int kmx61_suspend(struct device *dev)
 {
-	int ret;
 	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
 
-	mutex_lock(&data->lock);
-	ret = kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG,
+	guard(mutex)(&data->lock);
+	return kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG,
 			     false);
-	mutex_unlock(&data->lock);
-
-	return ret;
 }
 
 static int kmx61_resume(struct device *dev)
@@ -1453,13 +1433,9 @@ static int kmx61_resume(struct device *dev)
 static int kmx61_runtime_suspend(struct device *dev)
 {
 	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
-	int ret;
-
-	mutex_lock(&data->lock);
-	ret = kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
-	mutex_unlock(&data->lock);
 
-	return ret;
+	guard(mutex)(&data->lock);
+	return kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
 }
 
 static int kmx61_runtime_resume(struct device *dev)
-- 
2.53.0

