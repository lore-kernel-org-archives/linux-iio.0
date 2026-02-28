Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BEB2D59E8
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299409; cv=none; b=spXCAJQ1zUz5F9x32Y8cHFWsR832g/DpwJC2eRmf/Slubscm3qo+Mej8jNK7JoHkV4fLVae8/JRc5dQLdsxSS1mL9Ol6KALyj2lUQ+zqP0cz2S1RYtDZ9B6o5Wxb7AL5ePVHCCe6d+3FsMD+Ce2G0ckxAmLCzku7C67NBjuaI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299409; c=relaxed/simple;
	bh=jHFUWbkXAXZhVkidGVCRDw3EmsPsqVg3KyXF0mhw8yM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U0TAucxViZy39z3IVf+5grAaaf1hc6ZvHnOnRRh8YgzxDU0ZfvSOFaj4LpgXIpOa3mmN40lThVBFe7D8Ym2DXUcmPwVScH24yLzse96Pusun3Fx3Lpr75yQU6NshW6u+Oth48MdUxzIHIIIKt8XB4FJ/hhTuJiQdPe/G6o+WMs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il4pC0Ag; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il4pC0Ag"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506a747448dso27795071cf.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 09:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772299405; x=1772904205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5ikge9n2FdEB/JZjGN0lysFx1hDbdUwRoNv7gD6HGg=;
        b=il4pC0AgCnPdiOJUmttbztKf9Axc37mQ2ub36YhNakvE40PQ6prKkdjZZvMICNYqYN
         JROmLQ0dyPxIqU7ciOMZR+YuNVXwKbN/UX01oSUw8JZ5OMy+Kk5hTiVei2B1iVHIGlMQ
         AjTIg7DW+2GGbQKPueLW8voNUf96SnIBSsktdW7OhZ7tkW9gm/23L1XCuBUuNfuB9kbO
         6zhe9CKCyRZxDZvayOjewIIFNVc43jPHOC5wW693FD+sv964W/zUz8jeanayAVbJdSam
         7lcanb6IefAtLheFSkfWWAmWidTbqnRMpkayDkyiRuUJ8ynZTWI2Lv69/olr9ejFYg20
         mtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772299405; x=1772904205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5ikge9n2FdEB/JZjGN0lysFx1hDbdUwRoNv7gD6HGg=;
        b=XZ9zcoWwX4dm5EJSujTZsMvZ3PYseE/GPL5VRVrUrEGLhTBtMJmcdlXKsURLhFsEKY
         /BpxiR2Zxu27DkkDu/b01ekwPW9n0WC4kufZ0qTJMN3MXBXR2SUChLlbOUd6GRMeqyBm
         EXIMjJAV8cq+qcbUeS8O96skdISFA1v/ddfeXWYbHT2W9NsDeg61/Z7Z11WBjoatMb1F
         j/Keh4rgTPdTaRwgdIyn21t1idO6LWpm5Foyd0mOHF9t5wQG3Dc1yLK+E1tkeadm2o3z
         ZbaL0BbOBIAkkjNgI3oGtxNOmJdNXtxyloYdiejBXxAw+q/X4KDJhVgPrm+S2s+1Z3H0
         K8YQ==
X-Gm-Message-State: AOJu0YyMmkHfdn2MNHaymmJMkbdh1hwF7TYq/dPrR/4X/woVYz/bsu5M
	lL7UvJCZbEFNOWdtOrVAhPi8390nQSMQER0s1R3+6ruI2ovOzppzFA35
X-Gm-Gg: ATEYQzyfTJB94bC9mD9hFPoril28mO4+2mGAtQrn2twjvhmdwqgt/mZQPLHX2bdcCuJ
	jc908eqwkCywLq/8f4+nNIw1/I7I5aB65uuPW0WT3w0BaUNs5VPc6E9QNXgeyJpqNM6SyWSMJfN
	UnqVJd909k/TeD3pk9gZQ5Qhp+DPBCOLRCU/lLWGmdblMdadYt66KLo7YhP548PkCX4NPgVgX3y
	NT/h1IyPgEH57SVYU5bB8xwzxXSdQTSRDOYl61W1irXAOqp6YZJgDYTGm30trTGF633mnEUiCb6
	YQ8tDtTBgNjj99KguJtfj7no4Iz4cMnQWCuIP3HLRsF4cR1DK5BmvwMxvHifDkVDJe1AyJlRLrS
	buBte0Ir/pW0EsMF3AF+WMeS8xrMvxLJhCgxZK0AKYAlf3Yk7RK5Ey6pDAZ2/9lhuJUJE2F4sYq
	zPlw0y+oKze0MESW443xf3FJIC3j8LY9NvuJNOD474xQ==
X-Received: by 2002:ac8:5d0e:0:b0:4ec:eecf:66e4 with SMTP id d75a77b69052e-50752714848mr89205711cf.7.1772299404998;
        Sat, 28 Feb 2026 09:23:24 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7158db9sm70394356d6.3.2026.02.28.09.23.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 09:23:24 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v8] iio: magnetometer: bmc150_magn: use automated cleanup for mutex
Date: Sat, 28 Feb 2026 12:23:20 -0500
Message-ID: <20260228172320.68144-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() and scoped_guard() to replace manual mutex lock/unlock
calls. This simplifies error handling and ensures RAII-style cleanup.

guard() is used in read_raw, write_raw, trig_reen, and
trigger_set_state. Case blocks using guard() in read_raw and write_raw
are wrapped in braces at the case label level to ensure clear scope for
the cleanup guards.

A bmc150_magn_set_power_mode_locked() helper is added to deduplicate
the lock-call-unlock pattern used by remove, runtime_suspend, suspend,
and resume.

The trigger_handler function is left unchanged as mixing guard() with
goto error paths can be fragile.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
I don't have BMC150 hardware, so I went with Andy's _locked() helper
approach rather than moving the guard into bmc150_magn_set_power_mode()
itself, which would touch the runtime PM locking Jonathan flagged as
suspicious. The deeper runtime PM cleanup can be done separately by
someone who can test it.

v8:
  - Add bmc150_magn_set_power_mode_locked() helper to deduplicate the
    lock-call-unlock pattern in remove, runtime_suspend, suspend, and
    resume (Andy Shevchenko)
v7:
  - Split into separate patches (Jonathan Cameron)
v6:
  - Remove scoped_guard() from runtime_suspend and use guard() in
    suspend/resume (Jonathan Cameron)
v5:
  - Use scoped_guard() instead of guard() in remove and
    runtime_suspend (Andy Shevchenko)

 drivers/iio/magnetometer/bmc150_magn.c | 112 ++++++++++---------------
 1 file changed, 44 insertions(+), 68 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 6a73f6e2f1f0..a4e2209f6ed4 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pm.h>
@@ -255,6 +256,13 @@ static int bmc150_magn_set_power_mode(struct bmc150_magn_data *data,
 	return -EINVAL;
 }
 
+static int bmc150_magn_set_power_mode_locked(struct bmc150_magn_data *data,
+					     enum bmc150_magn_power_modes mode)
+{
+	guard(mutex)(&data->mutex);
+	return bmc150_magn_set_power_mode(data, mode, true);
+}
+
 static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
 {
 	int ret = 0;
@@ -453,33 +461,29 @@ static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
 	s32 values[AXIS_XYZ_MAX];
 
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
 		if (iio_buffer_enabled(indio_dev))
 			return -EBUSY;
-		mutex_lock(&data->mutex);
+
+		guard(mutex)(&data->mutex);
 
 		ret = bmc150_magn_set_power_state(data, true);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
+		if (ret < 0)
 			return ret;
-		}
 
 		ret = bmc150_magn_read_xyz(data, values);
 		if (ret < 0) {
 			bmc150_magn_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
 			return ret;
 		}
 		*val = values[chan->scan_index];
 
 		ret = bmc150_magn_set_power_state(data, false);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
+		if (ret < 0)
 			return ret;
-		}
 
-		mutex_unlock(&data->mutex);
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		/*
 		 * The API/driver performs an off-chip temperature
@@ -527,48 +531,39 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_SAMP_FREQ: {
 		if (val > data->max_odr)
 			return -EINVAL;
-		mutex_lock(&data->mutex);
-		ret = bmc150_magn_set_odr(data, val);
-		mutex_unlock(&data->mutex);
-		return ret;
+		guard(mutex)(&data->mutex);
+		return bmc150_magn_set_odr(data, val);
+	}
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->channel2) {
 		case IIO_MOD_X:
-		case IIO_MOD_Y:
+		case IIO_MOD_Y: {
 			if (val < 1 || val > 511)
 				return -EINVAL;
-			mutex_lock(&data->mutex);
+			guard(mutex)(&data->mutex);
 			ret = bmc150_magn_set_max_odr(data, val, 0, 0);
-			if (ret < 0) {
-				mutex_unlock(&data->mutex);
+			if (ret < 0)
 				return ret;
-			}
-			ret = regmap_update_bits(data->regmap,
+			return regmap_update_bits(data->regmap,
 						 BMC150_MAGN_REG_REP_XY,
 						 BMC150_MAGN_REG_REP_DATAMASK,
-						 BMC150_MAGN_REPXY_TO_REGVAL
-						 (val));
-			mutex_unlock(&data->mutex);
-			return ret;
-		case IIO_MOD_Z:
+						 BMC150_MAGN_REPXY_TO_REGVAL(val));
+		}
+		case IIO_MOD_Z: {
 			if (val < 1 || val > 256)
 				return -EINVAL;
-			mutex_lock(&data->mutex);
+			guard(mutex)(&data->mutex);
 			ret = bmc150_magn_set_max_odr(data, 0, val, 0);
-			if (ret < 0) {
-				mutex_unlock(&data->mutex);
+			if (ret < 0)
 				return ret;
-			}
-			ret = regmap_update_bits(data->regmap,
+			return regmap_update_bits(data->regmap,
 						 BMC150_MAGN_REG_REP_Z,
 						 BMC150_MAGN_REG_REP_DATAMASK,
-						 BMC150_MAGN_REPZ_TO_REGVAL
-						 (val));
-			mutex_unlock(&data->mutex);
-			return ret;
+						 BMC150_MAGN_REPZ_TO_REGVAL(val));
+		}
 		default:
 			return -EINVAL;
 		}
@@ -782,9 +777,8 @@ static void bmc150_magn_trig_reen(struct iio_trigger *trig)
 	if (!data->dready_trigger_on)
 		return;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret = bmc150_magn_reset_intr(data);
-	mutex_unlock(&data->mutex);
 	if (ret)
 		dev_err(data->dev, "Failed to reset interrupt\n");
 }
@@ -794,32 +788,28 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
+
+	guard(mutex)(&data->mutex);
 
-	mutex_lock(&data->mutex);
 	if (state == data->dready_trigger_on)
-		goto err_unlock;
+		return 0;
 
 	ret = regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
 				 BMC150_MAGN_MASK_DRDY_EN,
 				 state << BMC150_MAGN_SHIFT_DRDY_EN);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	data->dready_trigger_on = state;
 
 	if (state) {
 		ret = bmc150_magn_reset_intr(data);
 		if (ret < 0)
-			goto err_unlock;
+			return ret;
 	}
-	mutex_unlock(&data->mutex);
 
 	return 0;
-
-err_unlock:
-	mutex_unlock(&data->mutex);
-	return ret;
 }
 
 static const struct iio_trigger_ops bmc150_magn_trigger_ops = {
@@ -980,9 +970,7 @@ void bmc150_magn_remove(struct device *dev)
 	if (data->dready_trig)
 		iio_trigger_unregister(data->dready_trig);
 
-	mutex_lock(&data->mutex);
-	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
-	mutex_unlock(&data->mutex);
+	bmc150_magn_set_power_mode_locked(data, BMC150_MAGN_POWER_MODE_SUSPEND);
 
 	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
 }
@@ -995,10 +983,8 @@ static int bmc150_magn_runtime_suspend(struct device *dev)
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
-					 true);
-	mutex_unlock(&data->mutex);
+	ret = bmc150_magn_set_power_mode_locked(data,
+						BMC150_MAGN_POWER_MODE_SLEEP);
 	if (ret < 0) {
 		dev_err(dev, "powering off device failed\n");
 		return ret;
@@ -1024,28 +1010,18 @@ static int bmc150_magn_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
-					 true);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return bmc150_magn_set_power_mode_locked(data,
+						 BMC150_MAGN_POWER_MODE_SLEEP);
 }
 
 static int bmc150_magn_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
-	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
-					 true);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return bmc150_magn_set_power_mode_locked(data,
+						 BMC150_MAGN_POWER_MODE_NORMAL);
 }
 #endif
 
-- 
2.44.0

