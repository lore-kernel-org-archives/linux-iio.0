Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9138DC59
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602458; cv=none; b=rz9NoOW3Kp+6tNbYIe70hervGqgQfV/DRYBvc6SZpAWaYkTC2g+nFGHvGPFD7PxDXN9yaOsEHRdX35E1valxgK4wpLL2fcz3tVHsAS1pH4RDnwTAxIYgfSKh+9rzXOKTu7Wt87ScNuw9iNs7+RhAF3lqSHmEE4ef/KYHhoxLQbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602458; c=relaxed/simple;
	bh=Z8Q6Cje1VKDpJnaujnQksPmxZ0zKmJ2ZAE7GDaSwEZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6Gw9nvSrFevkjlLxVBFhaSpJFCdyqy+UsN7SZ/hTfnm/W9Pn+IOfNE5e9ZiiX6GCglQCCK7hWu9O5UGopbed5c8q5DSgy3KbwWMuaajnGtjK5IMoLwSu96DHj02jM/DWTaCkoXDlc9tOaqlng6y271isCoYwPB+2EG1K1Rta9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3zlh/r/; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3zlh/r/"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a1e9f55e03so6967211fa.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 13:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602455; x=1788207255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nQXWTdBiGOmg9WRHvHkejupB58j8w1lmLGZTr2gy6Vs=;
        b=S3zlh/r/sltgB85ewkIuFuOeyCGVIgROqCL0SNLvrJtUzSZhHv3dt/65psU5F70ceF
         dLUfEez3qOggbkWr+u/HAF4Cjw+38FRKIqa/DMPX7JwYJs2sDW/LVQCfzvXeAQ92iTKe
         uy+3SBqe0EzDTFLHVgbRy+63xQdT39WkzDnjFCKFv4uL8YcRh3RNUh4uqo2vmVtXataY
         1GU53X5ComV3MU1LUxMM0Plpt88w+86FlNl+MlJKjkzsim2iIrlFi8C/YSCm0ik1KBak
         qdj3XwYFH6SzgD6X/YJVgIMGoTrcydb+xztfhL9VMvYdYmSdOtlHL5bzHJ/eFw1VYhQB
         9Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602455; x=1788207255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nQXWTdBiGOmg9WRHvHkejupB58j8w1lmLGZTr2gy6Vs=;
        b=QshvwbIwM4NdMEgWj/4nNEDiKcBePAwGBLp/4B6lVLoC7t6Bt+JWYty45jOtxeRqrP
         SYXKg/ZI82YWt2s7jby0ODGDJB52MIewGuFDKokM7hecd1tmrinaIBcgZa6SKLBQUcYC
         TcmIpq28HTzaTnp4/2a0GaJD6fPmO0Om16X6VAOK1zfB7s8qC1sGchxnxobArb5f7iVR
         zrCP0IBlt6x4XLv0zbmQ9osgdUka1cw116VZTEAE35x5H00Tt+0Jw1vwT4xsrNouR6lv
         Pb+nKd1MJ/tezSG/Ppk02IhGwIwjwBxUY4B9CfbwoqkJSkICL8YreD5mXBUpv3byAP2M
         1zzg==
X-Gm-Message-State: AFuF++msFTwL2vzt7NQ17HimR65LEhj88U/X+HzFNKgyiGcl91HtxGlg
	UjY0zLfh6S75vW/UzIidiJ5CnQpZd2m/ODUz/04uFWx6XQWr2e5wEHAJ
X-Gm-Gg: AR+sD13/x5q1Qzlwt3Rd9lwqJLkSrIAGMdptgCHZujH++Rsmjejg5Q7Cqlmhfgxwcgt
	VmmSB9O9Nc84w88tcyXO/ox9HL5AxmopdCwK8mhd2Hl6qo2qKJRQeDfQ6VEXxz95EsdR7C3IrYk
	K2fenbcnVLuwRClBa5yhV2Ph4z9RcalQ+1PxTBF3KFX++n7PzGa6f5mpoBeIKp7ps5QDOdRoh/y
	ZwGbhn6fyJrFgro4x1CLhVSuhWgMtF6dRI2S7/NISnTZweYF6E6VoVjtP4ttqgdniYXYqfmnL5n
	tbv7ZeSrpqw6BZtcDHmz1/KR8Z7ZvFb25o38ILtizfj/2Oenpbot0Ne7LdpRYpM8FdkVzylSCxG
	OjblHJ3ITCRHragj7BflkvpbiQ1G8i5iIcoioYYr5VWsFrvBANG7l8ku0DtljY7tbFg++91rIG7
	EiyZOFVk11Cdi9JN4ii3xpDVpk7D9Q6CszBK3QwMRAQN68cp7fsP6rmD/2L1jLkU79wAaGNwFKX
	HIQlfZlmm31WNypJ59o48GNY3+vqBYjw1aeB3zGeNoMbb+DfU14DkHfvWlqDThm2h3aYbhbfmE=
X-Received: by 2002:a05:6512:3f25:b0:5ae:b969:417d with SMTP id 2adb3069b0e04-5b49cc05204mr327990e87.0.1787602454609;
        Mon, 24 Aug 2026 13:14:14 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48ce0cd9csm1923620e87.71.2026.08.24.13.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:14:14 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v6 3/6] iio: pressure: dps310: rework the raw read paths
Date: Mon, 24 Aug 2026 23:12:00 +0300
Message-ID: <20260824201203.396651-4-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824201203.396651-1-zoone.rupert@gmail.com>
References: <20260824201203.396651-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Raw reads take the lock themselves, so a processed pressure read takes it
twice: once for the raw read, then again when
dps310_calculate_pressure() trylocks to refresh temperature. Refresh is
skipped whenever lock is busy.

Split raw reads into variants that expect lock held, one helper per
channel taking it once for the whole sequence. Temperature refresh is
unconditional now. Buffered capture later in this series needs the same
shape.

Also use get_unaligned_be24() for 24-bit results, and mark functions that
need the lock with __must_hold() rather than a comment.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 159 +++++++++++++++++++---------------
 1 file changed, 87 insertions(+), 72 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 25d1c79876e6..269a71ea3e7a 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -19,6 +19,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/unaligned.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -286,8 +287,8 @@ static int dps310_get_temp_precision(struct dps310_data *data, int *val)
 	return 0;
 }
 
-/* Called with lock held */
 static int dps310_set_pres_precision(struct dps310_data *data, int val)
+	__must_hold(&data->lock)
 {
 	int rc;
 	u8 shift_en;
@@ -305,8 +306,8 @@ static int dps310_set_pres_precision(struct dps310_data *data, int val)
 				  DPS310_PRS_PRC_BITS, ilog2(val));
 }
 
-/* Called with lock held */
 static int dps310_set_temp_precision(struct dps310_data *data, int val)
+	__must_hold(&data->lock)
 {
 	int rc;
 	u8 shift_en;
@@ -324,8 +325,8 @@ static int dps310_set_temp_precision(struct dps310_data *data, int val)
 				  DPS310_TMP_PRC_BITS, ilog2(val));
 }
 
-/* Called with lock held */
 static int dps310_set_pres_samp_freq(struct dps310_data *data, int freq)
+	__must_hold(&data->lock)
 {
 	u8 val;
 
@@ -338,8 +339,8 @@ static int dps310_set_pres_samp_freq(struct dps310_data *data, int freq)
 				  DPS310_PRS_RATE_BITS, val);
 }
 
-/* Called with lock held */
 static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
+	__must_hold(&data->lock)
 {
 	u8 val;
 
@@ -438,6 +439,7 @@ static int dps310_ready_status(struct dps310_data *data, int ready_bit, int time
 }
 
 static int dps310_ready(struct dps310_data *data, int ready_bit, int timeout)
+	__must_hold(&data->lock)
 {
 	int rc;
 
@@ -463,82 +465,87 @@ static int dps310_ready(struct dps310_data *data, int ready_bit, int timeout)
 	return 0;
 }
 
-static int dps310_read_pres_raw(struct dps310_data *data)
+static int dps310_read_pres_raw_locked(struct dps310_data *data)
+	__must_hold(&data->lock)
 {
 	int rc;
 	int rate;
 	int timeout;
-	s32 raw;
 	u8 val[3];
 
-	if (mutex_lock_interruptible(&data->lock))
-		return -EINTR;
-
 	rc = dps310_get_pres_samp_freq(data, &rate);
 	if (rc)
-		goto done;
+		return rc;
 
 	timeout = DPS310_POLL_TIMEOUT_US(rate);
 
 	/* Poll for sensor readiness; base the timeout upon the sample rate. */
 	rc = dps310_ready(data, DPS310_PRS_RDY, timeout);
 	if (rc)
-		goto done;
+		return rc;
 
 	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
 	if (rc < 0)
-		goto done;
+		return rc;
 
-	raw = (val[0] << 16) | (val[1] << 8) | val[2];
-	data->pressure_raw = sign_extend32(raw, 23);
+	data->pressure_raw = sign_extend32(get_unaligned_be24(val), 23);
 
-done:
-	mutex_unlock(&data->lock);
-	return rc;
+	return 0;
 }
 
-/* Called with lock held */
 static int dps310_read_temp_ready(struct dps310_data *data)
+	__must_hold(&data->lock)
 {
 	int rc;
 	u8 val[3];
-	s32 raw;
 
 	rc = regmap_bulk_read(data->regmap, DPS310_TMP_BASE, val, sizeof(val));
 	if (rc < 0)
 		return rc;
 
-	raw = (val[0] << 16) | (val[1] << 8) | val[2];
-	data->temp_raw = sign_extend32(raw, 23);
+	data->temp_raw = sign_extend32(get_unaligned_be24(val), 23);
 
 	return 0;
 }
 
-static int dps310_read_temp_raw(struct dps310_data *data)
+static int dps310_read_temp_raw_locked(struct dps310_data *data)
+	__must_hold(&data->lock)
 {
 	int rc;
 	int rate;
 	int timeout;
 
-	if (mutex_lock_interruptible(&data->lock))
-		return -EINTR;
-
 	rc = dps310_get_temp_samp_freq(data, &rate);
 	if (rc)
-		goto done;
+		return rc;
 
 	timeout = DPS310_POLL_TIMEOUT_US(rate);
 
 	/* Poll for sensor readiness; base the timeout upon the sample rate. */
 	rc = dps310_ready(data, DPS310_TMP_RDY, timeout);
 	if (rc)
-		goto done;
+		return rc;
+
+	return dps310_read_temp_ready(data);
+}
+
+/*
+ * Refresh the cached temperature if a new measurement is ready, so that the
+ * pressure compensation uses a recent value. An error is not fatal here, the
+ * previous temperature is used instead.
+ */
+static void dps310_refresh_temp_locked(struct dps310_data *data)
+	__must_hold(&data->lock)
+{
+	int rc;
+	int t_ready;
 
-	rc = dps310_read_temp_ready(data);
+	rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &t_ready);
+	if (rc)
+		return;
 
-done:
-	mutex_unlock(&data->lock);
-	return rc;
+	if (t_ready & DPS310_TMP_RDY)
+		dps310_read_temp_ready(data);
 }
 
 static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
@@ -580,59 +587,47 @@ static int dps310_write_raw(struct iio_dev *iio,
 			    struct iio_chan_spec const *chan, int val,
 			    int val2, long mask)
 {
-	int rc;
 	struct dps310_data *data = iio_priv(iio);
 
-	if (mutex_lock_interruptible(&data->lock))
+	ACQUIRE(mutex_intr, lock)(&data->lock);
+	if (ACQUIRE_ERR(mutex_intr, &lock))
 		return -EINTR;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
 		case IIO_PRESSURE:
-			rc = dps310_set_pres_samp_freq(data, val);
-			break;
+			return dps310_set_pres_samp_freq(data, val);
 
 		case IIO_TEMP:
-			rc = dps310_set_temp_samp_freq(data, val);
-			break;
+			return dps310_set_temp_samp_freq(data, val);
 
 		default:
-			rc = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_PRESSURE:
-			rc = dps310_set_pres_precision(data, val);
-			break;
+			return dps310_set_pres_precision(data, val);
 
 		case IIO_TEMP:
-			rc = dps310_set_temp_precision(data, val);
-			break;
+			return dps310_set_temp_precision(data, val);
 
 		default:
-			rc = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
 
 	default:
-		rc = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&data->lock);
-	return rc;
 }
 
 static int dps310_calculate_pressure(struct dps310_data *data, int *val)
+	__must_hold(&data->lock)
 {
 	int i;
 	int rc;
-	int t_ready;
 	int kpi;
 	int kti;
 	s64 rem = 0ULL;
@@ -656,15 +651,6 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	kp = (s64)kpi;
 	kt = (s64)kti;
 
-	/* Refresh temp if it's ready, otherwise just use the latest value */
-	if (mutex_trylock(&data->lock)) {
-		rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &t_ready);
-		if (rc >= 0 && t_ready & DPS310_TMP_RDY)
-			dps310_read_temp_ready(data);
-
-		mutex_unlock(&data->lock);
-	}
-
 	p = (s64)data->pressure_raw;
 	t = (s64)data->temp_raw;
 
@@ -710,6 +696,27 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	return 0;
 }
 
+/*
+ * Sample the pressure and compensate it, taking the lock once for the whole
+ * sequence rather than once per register read.
+ */
+static int dps310_read_pressure_value(struct dps310_data *data, int *val)
+{
+	int rc;
+
+	ACQUIRE(mutex_intr, lock)(&data->lock);
+	if (ACQUIRE_ERR(mutex_intr, &lock))
+		return -EINTR;
+
+	rc = dps310_read_pres_raw_locked(data);
+	if (rc)
+		return rc;
+
+	dps310_refresh_temp_locked(data);
+
+	return dps310_calculate_pressure(data, val);
+}
+
 static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 				long mask)
 {
@@ -724,11 +731,7 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_PROCESSED:
-		rc = dps310_read_pres_raw(data);
-		if (rc)
-			return rc;
-
-		rc = dps310_calculate_pressure(data, val);
+		rc = dps310_read_pressure_value(data, val);
 		if (rc)
 			return rc;
 
@@ -747,6 +750,7 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 }
 
 static int dps310_calculate_temp(struct dps310_data *data, int *val)
+	__must_hold(&data->lock)
 {
 	s64 c0;
 	s64 t;
@@ -768,6 +772,21 @@ static int dps310_calculate_temp(struct dps310_data *data, int *val)
 	return 0;
 }
 
+static int dps310_read_temp_value(struct dps310_data *data, int *val)
+{
+	int rc;
+
+	ACQUIRE(mutex_intr, lock)(&data->lock);
+	if (ACQUIRE_ERR(mutex_intr, &lock))
+		return -EINTR;
+
+	rc = dps310_read_temp_raw_locked(data);
+	if (rc)
+		return rc;
+
+	return dps310_calculate_temp(data, val);
+}
+
 static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 			    long mask)
 {
@@ -782,11 +801,7 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_PROCESSED:
-		rc = dps310_read_temp_raw(data);
-		if (rc)
-			return rc;
-
-		rc = dps310_calculate_temp(data, val);
+		rc = dps310_read_temp_value(data, val);
 		if (rc)
 			return rc;
 
-- 
2.43.0

