Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6E30146C
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777942511; cv=none; b=b+zt1DX/+8/hVuaZ6yIK4KdtH/nNmmjRVM0/amhHquY8EHzCGgmqUeOpSvBQLjakYgL971AeSMmO/q/Dx6Id4vP6yJ4RwIIUWLqyQuxyS3JRAVZkCImR9STdDeylpzR3EpahAyRql0GOZpYZdyx+VRTtFuraf54fuR7Oqjs4RrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777942511; c=relaxed/simple;
	bh=HcCAi4XZWr4VI9YnxqL/9prvlesZPWwyc2UQVr0F5B4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYkLKkrTtimsq7en7WFBWR80ihGC+nObLE2cOYkEBdfUK/VNjJORSkYOqfjNobw2+9CE/qjy7Ks+C0NfUj5syZiWZxSpMdTHQD40bcUtZhfMOlS9mkLQIcs0p+UR5lV9hGZQcQcGj84sJWmKu4fIf+GKUYAlPapsPY5HtEZj5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzyduO9E; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzyduO9E"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-696ad0c2c2fso872537eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 17:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777942508; x=1778547308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+BIg5IZCVor1FBDgkb7U/DMcxDxLFNQWGvO8VPvc5U=;
        b=BzyduO9E4t0cdOZ3KY9qVjc9Klv0T0KMpaAuMkZ7tRIU63kyecBwyflyHep9qCv0Ag
         mWz7v63AiH0ALxdbfLlR4maI61ZaEBYgWwiALiZG2JqjvCVIBbnx20qDlNy4dLkcG/XD
         9P5mJmyZiZaAh575gm8UyEwYl8MKkU/vrErQpmRzQFjvTezOJx2sRVAGQRTXtOaJTmlR
         rroho8PHBvELTpWTl6ZujTYK52diLCi/mBJJzOLqF0y8yopG/Yi2Y3vaA8cLIvjsTbB6
         dEvrM/jDulAZdVkAD9c6R2iWRXCTSSvATEja+DpyhY8qpbSmFJ8Nb4E9W3tn73mQLcSz
         /XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777942508; x=1778547308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+BIg5IZCVor1FBDgkb7U/DMcxDxLFNQWGvO8VPvc5U=;
        b=Ql1pLLWCcMU6IF+L4d/ji8ey7qcdjRkvzgBwQ7wuyGtDOcu3MwMM+R8zcjrDQJ8BQQ
         Dxy5bbN9R7SDNJHY719oTvdc2Qt9Neg90GVrieCxJM+miXPqvROiW1mub/0ae8sl2GqN
         fp0/f3YFBY/mAcP6Q+qAh+aTFCbxYb1Q5zGdgG9SSOOf/5dQHIxJCRoOFQfLsR79L5ty
         yExtswmBVHqpvC82Ktb5+NFMZ3wiAEXD9A7EXS4A5RFHfYhGJWHZpT06YiKTmLW2cslG
         qiZgqi0ee4NkzS3n6tYBlaMPS1jDty2S6TYUJEWl3yThUa8TKnH+UfI/tXLyrJxLCnir
         r/7w==
X-Forwarded-Encrypted: i=1; AFNElJ+2zUAtBa42b+XF2QZ6QhdhBV7h/jkBufdgEXcT3aDOjbuSAxmWWh6zlPPdSZSUainqkYXib3+uAXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzllVBb57KpIeZuWHehqe/SzAJOPmXctL117to9xsJBcu1PJupL
	OsC6U4Cj4JeHn36E/ZEOj0Tv1GfINTpC2yzqT8CyqHffZMk7qOSGcqhO
X-Gm-Gg: AeBDieu+u1StU2jcXSxZvH0351fBaLYQOos0Gep6NAi1zbdpR5GgFJygIz7qEbzEnDu
	3WFFk2cV8oc5kSHFAHNVQG1nNkfS53rvx0yoAbLQ7WlT/qjIjPNaj01zMy2DJP2ydLHEboKA2TA
	igFgScutTiGA7uS+n0NOl46HGZk0M3nRhZIjNwceRpVn7JRfcVCSvCCivcl7NdOXqzNzh8WLdyk
	8+7KbLDgIBrddhKnRy6FOfpYf/CZHelwoeRIoH5c6BwbbjXkPxz8Oh7sfEhD3pn6xJU46cgDMuH
	0f6uO7hH2+Z/BNjF7UqCF7OKp+CUEDxdp7J0e+tkWO8tV1Pg7surGzXA7MdUiYiuG9ju5jGCg8/
	k0fXT75vK36om8xMOoiI5RdCx6okHRH9+qrwdlapORspsufUJxJkgcc1pK09zPYt5vX7edgo/n+
	75JpoJ4dlLOL/xjkXH3CjfoQah0URSIjQhT+h49rTpGDsBynpOKP09VRpNH6eUXvS54guH
X-Received: by 2002:a05:6820:f034:b0:696:2cb1:9ffb with SMTP id 006d021491bc7-69697e17b24mr6591039eaf.55.1777942507787;
        Mon, 04 May 2026 17:55:07 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454942dc1sm11263209fac.5.2026.05.04.17.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 17:55:07 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: imu: kmx61: Use guard(mutex)() family over manual locking
Date: Mon,  4 May 2026 19:55:05 -0500
Message-ID: <20260505005506.160891-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
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
 v2:
 - Remove redundant blank line per Andy.
 - Put kmx61_set_mode() function call in kmx61_runtime_suspend() on one
   line per Andy.

 drivers/iio/imu/kmx61.c | 76 ++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 3cd91d8a89ee..6d2e98607d35 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -7,6 +7,7 @@
  * IIO driver for KMX61 (7-bit I2C slave address 0x0E or 0x0F).
  */
 
+#include <linux/cleanup.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/mod_devicetable.h>
@@ -794,25 +795,20 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
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
-
-		mutex_unlock(&data->lock);
 		if (ret)
 			return ret;
 		return IIO_VAL_INT;
@@ -834,9 +830,8 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
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
@@ -856,19 +851,15 @@ static int kmx61_write_raw(struct iio_dev *indio_dev,
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
@@ -945,28 +936,25 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
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
 
@@ -1020,11 +1008,11 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
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
@@ -1034,7 +1022,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	ret = kmx61_set_power_state(data, state, device);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	if (data->acc_dready_trig == trig || data->mag_dready_trig == trig)
 		ret = kmx61_setup_new_data_interrupt(data, state, device);
@@ -1042,7 +1030,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		ret = kmx61_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
 		kmx61_set_power_state(data, false, device);
-		goto err_unlock;
+		return ret;
 	}
 
 	if (data->acc_dready_trig == trig)
@@ -1051,8 +1039,6 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		data->mag_dready_trig_on = state;
 	else
 		data->motion_trig_on = state;
-err_unlock:
-	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -1195,19 +1181,17 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
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
@@ -1419,22 +1403,16 @@ static void kmx61_remove(struct i2c_client *client)
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
-			     false);
-	mutex_unlock(&data->lock);
-
-	return ret;
+	guard(mutex)(&data->lock);
+	return kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, false);
 }
 
 static int kmx61_resume(struct device *dev)
@@ -1453,13 +1431,9 @@ static int kmx61_resume(struct device *dev)
 static int kmx61_runtime_suspend(struct device *dev)
 {
 	struct kmx61_data *data = i2c_get_clientdata(to_i2c_client(dev));
-	int ret;
 
-	mutex_lock(&data->lock);
-	ret = kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
-	mutex_unlock(&data->lock);
-
-	return ret;
+	guard(mutex)(&data->lock);
+	return kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG, true);
 }
 
 static int kmx61_runtime_resume(struct device *dev)

base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
-- 
2.54.0

