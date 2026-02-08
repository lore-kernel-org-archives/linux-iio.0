Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD045202979
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770513438; cv=none; b=RDRbUi08gcpnijas0velHvNR3Q8kVFud8NSltLPn9axi3r3EOQx9KuxrPAD8MYAFtIFT6pYcrQla3R2tByuv882Oc4pOHlwrKdLm0VBSjE9NMpDFz0cs/9kmw5CxgrcwtWNgLm+RHqiVaMgE+A0iKEHfwknLAGkBbLy1yGI/VQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770513438; c=relaxed/simple;
	bh=Sq4yboqJjhW/YcdDUsIXJhq+eoRSDISvfllebuk/UZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npIwrhUGrfr/h4sKWqtdUv53eoHJbxmDSuKNXp206ha/GRwlqU0lztirdasTysaDKx3PkiR5BAwRN//Fei0gCMBn7g7E93MdObSyoqDNT2MJJNyi/lAfvoUr+DnGfnhD2yL+FN/kIlB644VZ8HkbhLneggrCAlqVdOtErnsa1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftCRZ47P; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftCRZ47P"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c713a6a6f8so400214685a.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Feb 2026 17:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770513437; x=1771118237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJKnbhwPq4ROqJlUr/cylPdAkSeoEAJ5YNwTn8Q47Q0=;
        b=ftCRZ47P/a1n9MeUAhcTqB5mdJILdV7C6Enoespy6IeSgIzSumTU2pY1/cvqbS43op
         AIkV/fuDi1aMFLodk8B7nz2r9PE730+k272kM3J882s0N4I6WhXLCqfE5w1yxkamGBqR
         p4wl+DsXgZnPnGIfFBqT11H2HoAyHNP346OQy/XLGOiuRaroQ1zHlnXUpamW5du1ANLC
         aI57/cTWbKpVCrHQ+vPGXQ6pdY+EURM2Fdbn3Vs1/BuR51/JSWmSHc/45ltRcYnavRjp
         YoM07JpWrthKky/ycicSAsU5uM5ppw6UWGV33PaiIVm9TT4YiPHttNu1QJfJBGmlri/n
         UuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770513437; x=1771118237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hJKnbhwPq4ROqJlUr/cylPdAkSeoEAJ5YNwTn8Q47Q0=;
        b=ihh4Faex/Rcf3FSprFXIyGgPYzrgcs5sjkkkkv4jctjxxidFNzoXvJfl/fINBXV3JB
         paFcQiGpVMetmeVBsw+Uh1xpVM3tUcbz4TyxPcmBabRbc1yES9Rbhl0DQ699NvWtvetO
         bgIi12HK90WkT3pZwfcYYe0VhEGv7wt4GOBv82/l0KSWFkEGPN00Iwpsm8sL0HMZx+E+
         IBK4fH/4pjmcKAi4CNjeoZ9EL0sQLyjkoG4jnJpP3cmS7J/3/kB+OsEoYV1X+TUbKS2v
         Cugcn24nqRFEiTRiquDUjgaf3markUyH340+D35Ocw6tQdvbFBX+Ka/7EM+bbmSkVYI7
         3p2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTDBaKPYMFiMftcpC1IkXMKAm/SCCeYZpBHJg/ww8RxljSK5InViJj3dXNQIXi/+fB9oy/iBXQDGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OCLT62moNgFfw8hQOtfAuOgU+hpoq26jduR9JK0nkYeAmmWo
	b4uOmuYfKx9BE6lBm2q83duZRQ+gE68UT5TRAHbZkbxPBENtwNCWQSiV
X-Gm-Gg: AZuq6aJUYiBbbTnLsKq+M4XY99X3N9fhWVuP25mmvn7Ga3jKe4N7hGXp2SPYrFHGAZN
	xHJz3ICI2TT9hmFvIJ3eLuqAJenQT6x35Yhewxe4xULgs2QmdmwU4Twjuy+Vs3mbQPnWLjrnZ7Q
	KFZwYW+E7mloifqkxhwzOvhRVXCJP0iISYrn08HCCVhURD/jlc0/u59c6/Laa7bZdC4vb0u8rfv
	PVogU7nOhFyb9PURHvpMWdVkNlb4rZHz5hOhKpwzGGaHQ2EauTfK9+6R2Abj5qB1VqbLTOLltPI
	jsbos30fUxNbxfXRVurjn5fBkpeEOXMfxlhMDwJsuZP9EzWnB1ASw77ZbeTMfVKTiud52rVw+bn
	VUirph3yCnhAH6Asi9n3KEQWGnGmW/c0PJLZk5KIh+lyyLCK7Kb8IL1G7Pw8wjYkFxcivALqB9P
	ZhYNESCwljIby9QcckjE54+MtgqyF43w==
X-Received: by 2002:a05:620a:444f:b0:8c7:3ff0:d489 with SMTP id af79cd13be357-8cae06d85f5mr913830985a.1.1770513436601;
        Sat, 07 Feb 2026 17:17:16 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf4a97997sm481364385a.0.2026.02.07.17.17.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Feb 2026 17:17:16 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v5 1/2] iio: magnetometer: bmc150_magn: use automated cleanup for mutex
Date: Sat,  7 Feb 2026 20:16:58 -0500
Message-ID: <20260208011659.53722-2-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260208011659.53722-1-neelb2403@gmail.com>
References: <20260208011659.53722-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() and scoped_guard() to replace manual mutex lock/unlock
calls. This simplifies error handling and ensures RAII-style cleanup.

Additionally, replace msleep(5) with fsleep(5000) to allow the kernel
to select the most appropriate delay mechanism based on duration.

guard() is used in read_raw, write_raw, trig_reen, trigger_set_state,
and resume. Case blocks in read_raw and write_raw are wrapped in braces
to ensure clear scope for the cleanup guards.

scoped_guard() is used in remove, runtime_suspend, and suspend where a
short mutex-protected scope is needed for a single function call.

The trigger_handler function is left unchanged as mixing guard() with
goto error paths can be fragile.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 132 ++++++++++---------------
 1 file changed, 54 insertions(+), 78 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 6a73f6e2f1f0..117bf70d6899 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
@@ -456,29 +457,24 @@ static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		if (iio_buffer_enabled(indio_dev))
 			return -EBUSY;
-		mutex_lock(&data->mutex);
+		{
+			guard(mutex)(&data->mutex);
 
-		ret = bmc150_magn_set_power_state(data, true);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
+			ret = bmc150_magn_set_power_state(data, true);
+			if (ret < 0)
+				return ret;
 
-		ret = bmc150_magn_read_xyz(data, values);
-		if (ret < 0) {
-			bmc150_magn_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
-		*val = values[chan->scan_index];
+			ret = bmc150_magn_read_xyz(data, values);
+			if (ret < 0) {
+				bmc150_magn_set_power_state(data, false);
+				return ret;
+			}
+			*val = values[chan->scan_index];
 
-		ret = bmc150_magn_set_power_state(data, false);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			return ret;
+			ret = bmc150_magn_set_power_state(data, false);
+			if (ret < 0)
+				return ret;
 		}
-
-		mutex_unlock(&data->mutex);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/*
@@ -530,45 +526,37 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val > data->max_odr)
 			return -EINVAL;
-		mutex_lock(&data->mutex);
-		ret = bmc150_magn_set_odr(data, val);
-		mutex_unlock(&data->mutex);
-		return ret;
+		guard(mutex)(&data->mutex);
+		return bmc150_magn_set_odr(data, val);
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->channel2) {
 		case IIO_MOD_X:
 		case IIO_MOD_Y:
 			if (val < 1 || val > 511)
 				return -EINVAL;
-			mutex_lock(&data->mutex);
-			ret = bmc150_magn_set_max_odr(data, val, 0, 0);
-			if (ret < 0) {
-				mutex_unlock(&data->mutex);
-				return ret;
+			{
+				guard(mutex)(&data->mutex);
+				ret = bmc150_magn_set_max_odr(data, val, 0, 0);
+				if (ret < 0)
+					return ret;
+				return regmap_update_bits(data->regmap,
+							 BMC150_MAGN_REG_REP_XY,
+							 BMC150_MAGN_REG_REP_DATAMASK,
+							 BMC150_MAGN_REPXY_TO_REGVAL(val));
 			}
-			ret = regmap_update_bits(data->regmap,
-						 BMC150_MAGN_REG_REP_XY,
-						 BMC150_MAGN_REG_REP_DATAMASK,
-						 BMC150_MAGN_REPXY_TO_REGVAL
-						 (val));
-			mutex_unlock(&data->mutex);
-			return ret;
 		case IIO_MOD_Z:
 			if (val < 1 || val > 256)
 				return -EINVAL;
-			mutex_lock(&data->mutex);
-			ret = bmc150_magn_set_max_odr(data, 0, val, 0);
-			if (ret < 0) {
-				mutex_unlock(&data->mutex);
-				return ret;
+			{
+				guard(mutex)(&data->mutex);
+				ret = bmc150_magn_set_max_odr(data, 0, val, 0);
+				if (ret < 0)
+					return ret;
+				return regmap_update_bits(data->regmap,
+							 BMC150_MAGN_REG_REP_Z,
+							 BMC150_MAGN_REG_REP_DATAMASK,
+							 BMC150_MAGN_REPZ_TO_REGVAL(val));
 			}
-			ret = regmap_update_bits(data->regmap,
-						 BMC150_MAGN_REG_REP_Z,
-						 BMC150_MAGN_REG_REP_DATAMASK,
-						 BMC150_MAGN_REPZ_TO_REGVAL
-						 (val));
-			mutex_unlock(&data->mutex);
-			return ret;
 		default:
 			return -EINVAL;
 		}
@@ -695,7 +683,7 @@ static int bmc150_magn_init(struct bmc150_magn_data *data)
 	 * 3ms power-on time according to datasheet, let's better
 	 * be safe than sorry and set this delay to 5ms.
 	 */
-	msleep(5);
+	fsleep(5000);
 
 	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND,
 					 false);
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
@@ -1026,10 +1007,9 @@ static int bmc150_magn_suspend(struct device *dev)
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
-					 true);
-	mutex_unlock(&data->mutex);
+	scoped_guard(mutex, &data->mutex)
+		ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
+						 true);
 
 	return ret;
 }
@@ -1038,14 +1018,10 @@ static int bmc150_magn_resume(struct device *dev)
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

