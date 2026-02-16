Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF487286D53
	for <linux-iio@vger.kernel.org>; Mon, 16 Feb 2026 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771206903; cv=none; b=Gh2zakkMs/cCJF5GoozYzym9L07dsE7Bu2wZkhaCHPmwDnV5SmqagaftZw7S3HwjEuuZkbOtzBQLTArVnd677ybkYw/ASJEWGAIcRNXeF2J2y/RbIl4V15vCaHhH8cV8cFG86UiY9Y33r1piT8ZBeL5fOdmGqqQgn5y8QvPmnmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771206903; c=relaxed/simple;
	bh=KsWPbtp7dclOQsts4hkX/EvpcaH3CkHz85VewowG1As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kP0Bpg6yAunlIGgAMX+M0R1dU+NV1bQmNQIchrtH4NOnmMrYJBZViN7rHktvqP/E4mYdcbFT/7glMlMkzOVDfMZiZOfJkPQyiy7D0sCpJMEly13u/QN2MNEFBiFLWlvKZ/aWiy5k4Hhf+hK3H/8nTnqC05MHI3ngblHFbTZCckI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlDJUXuV; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlDJUXuV"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-895071c5527so38781166d6.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 17:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771206901; x=1771811701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpXlIWLRWovA3pP6LHlXyJYMgADVO8vHpsAgvc24yB8=;
        b=GlDJUXuVnlnDaOhFAOhUN6E88wIKc500wV4IG5zjdCUDhIbCcmCz5VW4e1xWyzJYAj
         NHiyyoXgPQ3TRmjdSmYnjrbeMcDq9nEsLLx4mP3zrW/qtDy4BvuRvHVzIVnTXowT94a5
         FGIE1L1wfYGKjYAyVXz3O9woFD9zkW8nmwTemQqW3T0vK98bLtj4YS/55wmMNCQJBzv8
         BtDbf/v0atQwNw4Z+rvbpeEMa2AxtGoC9RuppLi2OkQmK6Hqlz7/k6k8Lt9IKNOhgLH0
         kB91kbvL35mvn20D8cecf0d86nOmGaZGtTgJhKspkZOR6xAnUYcCugb4fiHKEIY4UPJ8
         szcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771206901; x=1771811701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpXlIWLRWovA3pP6LHlXyJYMgADVO8vHpsAgvc24yB8=;
        b=RrZ8apTCvCktULl08m834Es9yt01f2cU0DXkxgs/xQt+pjMcT+u0cdTRr6508mvGiN
         JEqxTwOQPCF6eTLOpJmG60+zIppojCPHepqnl7pXAFyLd8I2Qs1TQ0Dt65AGB2pigGOz
         B3/e3oFmIJe0asJhqpOejRGPPdnmIKf8ZufTYH7Xns7v912f9jD6zzcNssPFvb1EQHLP
         95ACp7TwqZgImVsIhNUYP00oERF4KNXM4peFHTPAyLGZgmYYjiSG/MhIWG2gKhF2vyN2
         i4tzzcXnsN1KGnuMDN8Eda/7yJPZQbOavMIuxtnubZ+JO9DSjJ51Ei77POkBfj2qzeXP
         723g==
X-Forwarded-Encrypted: i=1; AJvYcCWGpDXBTm7lHy8Aexqo7dQgRJS+ZK+0ksnViaj/krje4BDMTIRXdjXKbyPSJcQBG+rt9ZMVOTULFik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsh7Cyjnadi+VcER2PwiELQpw/kGSxGRqu+pXVELWSLePssQ4o
	/aB7q4Zm3rMSoHyvYBXw5z+zucDIxOt+eTRBYB5Gnjbnyzan4w8Nc60G
X-Gm-Gg: AZuq6aJIP5OKCcpD7zS4WmBHLRixlEWUbTmPbbam3lfCuK2r2vUDLLeKSkIat5xqgid
	MTYClMEz7Q9LUkmgRLxPLbRYA29EzRYTUzpgOpUm3TaYqaI0csC3TlsyNGlkO3YerTN5CvCHZIw
	AIqT0POlubR0GVmiWAu/SBL/KLfXk4XN3uIdJ45/FKXLUIELPm5UldjMlc4sVy7qwJBTAACLDlY
	oYQ8O78i50ch/2T9Z6tH+cfRQe0x/fhxTzrCQmC6zLYp7a8kezCZ+m/onO+mgRh/J4z9N70tNWL
	2942o2GoJ3C/sw9bLdCBPfszbod1hqPSPCw7PAmOvHMZLQQPijTJdznC630l396RgaswoccLvIE
	57j/LZ3dazKFjFsZyYlONX+CAV6wS4S/WA3ryKVmjprYmjpRtqb/8jMW9ddwYxFgH9PNcR9+plp
	HjIgvlUV+j4G6rgngr4ex0OYtdicNZLNoBlYBoTBXdVA==
X-Received: by 2002:ad4:5d6b:0:b0:895:4cc2:8bfe with SMTP id 6a1803df08f44-8974049b5ffmr95098266d6.48.1771206900921;
        Sun, 15 Feb 2026 17:55:00 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506849fbb9dsm126926161cf.15.2026.02.15.17.55.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Feb 2026 17:55:00 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v7 1/3] iio: magnetometer: bmc150_magn: use automated cleanup for mutex
Date: Sun, 15 Feb 2026 20:54:52 -0500
Message-ID: <20260216015454.61836-2-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260216015454.61836-1-neelb2403@gmail.com>
References: <20260216015454.61836-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() and scoped_guard() to replace manual mutex lock/unlock
calls. This simplifies error handling and ensures RAII-style cleanup.

guard() is used in read_raw, write_raw, trig_reen, trigger_set_state,
suspend, and resume. Case blocks using guard() in read_raw and
write_raw are wrapped in braces at the case label level to ensure
clear scope for the cleanup guards.

scoped_guard() is used in remove and runtime_suspend where a short
mutex-protected scope is needed for a single function call.

The trigger_handler function is left unchanged as mixing guard() with
goto error paths can be fragile.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 109 ++++++++++---------------
 1 file changed, 41 insertions(+), 68 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 6a73f6e2f1f0..ff6196c86e6b 100644
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
@@ -453,33 +454,29 @@ static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
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
@@ -527,48 +524,39 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
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
@@ -782,9 +770,8 @@ static void bmc150_magn_trig_reen(struct iio_trigger *trig)
 	if (!data->dready_trigger_on)
 		return;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret = bmc150_magn_reset_intr(data);
-	mutex_unlock(&data->mutex);
 	if (ret)
 		dev_err(data->dev, "Failed to reset interrupt\n");
 }
@@ -794,32 +781,28 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
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
@@ -980,9 +963,8 @@ void bmc150_magn_remove(struct device *dev)
 	if (data->dready_trig)
 		iio_trigger_unregister(data->dready_trig);
 
-	mutex_lock(&data->mutex);
-	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
-	mutex_unlock(&data->mutex);
+	scoped_guard(mutex, &data->mutex)
+		bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
 
 	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
 }
@@ -995,10 +977,9 @@ static int bmc150_magn_runtime_suspend(struct device *dev)
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
-					 true);
-	mutex_unlock(&data->mutex);
+	scoped_guard(mutex, &data->mutex)
+		ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
+						 true);
 	if (ret < 0) {
 		dev_err(dev, "powering off device failed\n");
 		return ret;
@@ -1024,28 +1005,20 @@ static int bmc150_magn_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&data->mutex);
-	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
-					 true);
-	mutex_unlock(&data->mutex);
 
-	return ret;
+	guard(mutex)(&data->mutex);
+	return bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
+					  true);
 }
 
 static int bmc150_magn_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&data->mutex);
-	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
-					 true);
-	mutex_unlock(&data->mutex);
 
-	return ret;
+	guard(mutex)(&data->mutex);
+	return bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
+					  true);
 }
 #endif
 
-- 
2.44.0

