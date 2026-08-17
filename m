Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2DF463B86
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986498; cv=none; b=gE7Y73XMvNtbOSXMMgSjOY7XRcGMeWnajkoSzQ/H+d/Ep+eJXappX2OkORSNtDJTRYNyV4sSlITilj4CBOycpgqomz1MVuG1NWa6Fe423s1aK92Tr6e6uDJWGtp9KQ7JtR8e3UVaqQmugZ0yOC3ibO8yLSx+u00Pqtp8c34rJrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986498; c=relaxed/simple;
	bh=3Gvk4/djZnTobPPb33vz/llgxMNsRTXQjtyqineco/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVeY+tgfKNLAOS7MMo3GRPozlBGLgKWIezg/6k0xtjyhTA4vgT4CVbQnektdM+jSFsL7FHoRpLBe9jvmG3u5cJydGUEiyLgHQr5w7hvc/sBiERjA74OoScf5MUT1KFUkqi1uhoN7o6UjcDPDoT/maUtW3UjZDRW5k/MF8JGNwpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSzghm49; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSzghm49"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c74722e27so1901941fa.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786986494; x=1787591294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3khfOXEHHRX/gULBOcNM3D8sraxx0MJ631P1VQlh1zM=;
        b=NSzghm49fIMlZ3FmjJA2oegDwqnRm8lPPsWGkhlA7nMraM5bjubQdVhTyCJP1PGr5I
         Kk2qytL1P/PKhQLcmK5JdFjgfBVGgvU6Pu051qo1nvlDL1q17u0QXtf4lxwuRzt37ifi
         RD0ipDlYr8y/TffheuNywntEezaesPqdxIjTvzGJhhHUAVVNtOxdBL4Tpln5DiCPWIU1
         uMmeQNNhC8c/rN17gvhasUvS4YbjZf7HrOYtJs01hmFXFz8b/LYPn57DaTXWwPbezwgQ
         aL9O/0tJ2V8yOtKY7AwuqIxyJ4Uiab+NIVMx517IyYFkPOiEYjVsfeimPC06FSyCV+Jr
         YghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986494; x=1787591294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3khfOXEHHRX/gULBOcNM3D8sraxx0MJ631P1VQlh1zM=;
        b=p2laHlAXB1C8hYd0zDDIwpJ5IAAeKfuGagjyHHJx+Nx/vDs6iHLjYSIpEfW2TF7Rdv
         0Ge0z/pffRKZ8TehgJ9iQpDKvMcu3neS6BS32vi/5z/4Nz2KiMkOWoK6gICUvAjqXXLw
         QyYkh8eEziJ6FpfLE6ly4s6jLvao73jLjl4yQpt5vU3O64WN60wvw51uRS/dysBgqD10
         /fR1Xf7BmOeD7Fjx3dKQcb5C07M7lUZ0UIQWhoC/iIwXPPitr6yt8EhA6/OMK9msGWUW
         9YsZyeqhj+JMIdlFrpGlo3tkHtc/+2a/AuZElXH23j/FeLqX6FaNO3xMT9R2lYTgFgZk
         zQ2A==
X-Gm-Message-State: AOJu0YzckZzaSraoaHeaYIYEaOWIR36YkvFOSjiBCyqXQdQih4fRZXWU
	mB9Bs3Jsb+KNCRCyWJXfJKpjroMz6m1f1My1FwaNflstIOW/ky76J1Z8
X-Gm-Gg: AR+sD12VDOgFyf2xOPHu3QyO77ilshJrSNGx83qgRla7ODBT9pjOSAstLPFz7BNiPnN
	IJzz35McODo3d3GjXLEttag3Lwnd7kjfrn6mT+P7HcTs+E9cJhO7+s662rjuZHOGK4eFuxMKBRS
	7OLw9xkONotzbv6BzOgzS81dXbRTyMQYf/Ex9j0ur+6BYLmvNYuzhCdwkScU7rewL01f+vdSqsk
	i84df6RItCsvT/vlhxRCUPvSFGy8zr4JVfWcgeE4Sg382Owztb3QvVWfSSf7Ta6HfOA3icilpVD
	xiec7rx2pXT8/81ACEsynSHCc/Z0m/fRbSTy5AcCO+BxfDQ2G9NOKSUF0G726VEfq1gqBhHLqWn
	LzmSpnCbV342+OLnjhYBgYvD4H/MKfFMKXw7wYtGvtiOHS7FQ6q7vfIZEBacQEBln/XZaPeoTLf
	TSpqMc4Qf1OTtM2TYkQxAAD3Ph9Q0CFtwnBg24zcf+KcFbVdXawk8+Xi/QDj71+5jGuqLshQhaP
	n+85ZbsxtgCgRiIHo8jqQAGOvjhCBS3fuDcngYCUIi87w3DupiMrIWjH38=
X-Received: by 2002:a05:651c:43d0:20b0:38e:8357:c5ae with SMTP id 38308e7fff4ca-3a176a46b94mr671341fa.9.1786986494173;
        Mon, 17 Aug 2026 10:08:14 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b0e54casm6053841fa.15.2026.08.17.10.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:08:13 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v5 2/3] iio: pressure: dps310: add triggered buffer support
Date: Mon, 17 Aug 2026 20:07:24 +0300
Message-ID: <20260817170725.1074078-3-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817170725.1074078-1-zoone.rupert@gmail.com>
References: <20260817170725.1074078-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add triggered buffer support so pressure and temperature can be captured
into a buffer instead of only through one-shot sysfs reads. The device
measures continuously in background mode, so a capture is just a read of
the latest results and no buffer setup ops are needed.

Pressure has to be computed from the raw register value with the
compensation polynomial in section 4.9.1 of the datasheet, which also
needs a temperature reading. To keep full resolution in the buffer
without disagreeing with the unit the existing processed attribute
reports, add raw and scale attributes for pressure, raw in Pa and scale
1/1000 to convert to kPa. The channel definition carries a comment
explaining why it is done this way here and why it should not be copied
into other drivers.

Temperature is already a full resolution value in its base unit of
millidegrees Celsius, so it stays a processed channel.

Either channel can be enabled on its own. Temperature is always sampled
because the pressure compensation needs it, but only the enabled channels
are pushed to the buffer.

The raw read helpers are split into variants that expect the lock to be
held, so the trigger handler takes the lock once per scan instead of once
per value. That also lets dps310_calculate_pressure() drop its
mutex_trylock() dance, as the temperature refresh now always happens
under the caller's lock instead of only when the lock happened to be
free.

Sysfs sample reads and reconfiguration return -EBUSY while the buffer is
enabled, since they share the capture path's values and configuration.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/Kconfig  |   2 +
 drivers/iio/pressure/dps310.c | 305 ++++++++++++++++++++++++++--------
 2 files changed, 242 insertions(+), 65 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 838a8340c4c0..cef8b90b9ae7 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -112,6 +112,8 @@ config DPS310
 	tristate "Infineon DPS310 pressure and temperature sensor"
 	depends on I2C
 	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Support for the Infineon DPS310 digital barometric pressure sensor.
 	  It can be accessed over I2C bus.
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 68382960382f..0d6e65766469 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -20,8 +20,11 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define DPS310_DEV_NAME		"dps310"
 
@@ -92,19 +95,56 @@ struct dps310_data {
 	bool timeout_recovery_failed;
 };
 
+enum dps310_scan_index {
+	DPS310_SCAN_TEMP,
+	DPS310_SCAN_PRESSURE,
+};
+
 static const struct iio_chan_spec dps310_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 			BIT(IIO_CHAN_INFO_PROCESSED),
+		.scan_index = DPS310_SCAN_TEMP,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_PRESSURE,
+		/*
+		 * Pressure is only meaningful once the raw register value has
+		 * been run through the compensation polynomial in section 4.9.1
+		 * of the datasheet, which needs a temperature reading as well.
+		 * So what is reported as _raw here is already compensated, in
+		 * Pa, and _scale converts it to the kPa the ABI asks for. The
+		 * _processed attribute reports the same value and predates
+		 * buffer support, so it has to stay.
+		 *
+		 * Please do not copy this pattern into other drivers. A raw
+		 * attribute that is not the raw register value is only
+		 * tolerable here because the alternative is either losing
+		 * resolution in the buffer or breaking existing users of
+		 * _processed.
+		 */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-			BIT(IIO_CHAN_INFO_PROCESSED),
+			BIT(IIO_CHAN_INFO_PROCESSED) |
+			BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = DPS310_SCAN_PRESSURE,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 /* To be called after checking the COEF_RDY bit in MEAS_CFG */
@@ -463,7 +503,8 @@ static int dps310_ready(struct dps310_data *data, int ready_bit, int timeout)
 	return 0;
 }
 
-static int dps310_read_pres_raw(struct dps310_data *data)
+/* Called with lock held */
+static int dps310_read_pres_raw_locked(struct dps310_data *data)
 {
 	int rc;
 	int rate;
@@ -471,30 +512,25 @@ static int dps310_read_pres_raw(struct dps310_data *data)
 	s32 raw;
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
 
 	raw = (val[0] << 16) | (val[1] << 8) | val[2];
 	data->pressure_raw = sign_extend32(raw, 23);
 
-done:
-	mutex_unlock(&data->lock);
-	return rc;
+	return 0;
 }
 
 /* Called with lock held */
@@ -514,31 +550,45 @@ static int dps310_read_temp_ready(struct dps310_data *data)
 	return 0;
 }
 
-static int dps310_read_temp_raw(struct dps310_data *data)
+/* Called with lock held */
+static int dps310_read_temp_raw_locked(struct dps310_data *data)
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
 
-	rc = dps310_read_temp_ready(data);
+	return dps310_read_temp_ready(data);
+}
 
-done:
-	mutex_unlock(&data->lock);
-	return rc;
+/*
+ * Refresh the cached temperature if a new measurement is ready, so that the
+ * pressure compensation below uses a recent value. Errors are not fatal here,
+ * the previous temperature is used instead.
+ *
+ * Called with lock held.
+ */
+static void dps310_refresh_temp_locked(struct dps310_data *data)
+{
+	int rc;
+	int t_ready;
+
+	rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &t_ready);
+	if (rc)
+		return;
+
+	if (t_ready & DPS310_TMP_RDY)
+		dps310_read_temp_ready(data);
 }
 
 static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
@@ -580,59 +630,52 @@ static int dps310_write_raw(struct iio_dev *iio,
 			    struct iio_chan_spec const *chan, int val,
 			    int val2, long mask)
 {
-	int rc;
 	struct dps310_data *data = iio_priv(iio);
 
-	if (mutex_lock_interruptible(&data->lock))
+	/* Reconfiguring mid-capture would change the values being captured */
+	IIO_DEV_ACQUIRE_DIRECT_MODE(iio, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
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
 
+/* Called with lock held */
 static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 {
 	int i;
 	int rc;
-	int t_ready;
 	int kpi;
 	int kti;
 	s64 rem = 0ULL;
@@ -656,15 +699,6 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
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
 
@@ -710,6 +744,28 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	return 0;
 }
 
+/*
+ * Sample the pressure and compensate it. Shared by the raw and processed
+ * attributes, which report the same value in different units, and takes the
+ * lock once for the whole sequence.
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
@@ -723,18 +779,27 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 
 		return IIO_VAL_INT;
 
-	case IIO_CHAN_INFO_PROCESSED:
-		rc = dps310_read_pres_raw(data);
+	case IIO_CHAN_INFO_RAW:
+		rc = dps310_read_pressure_value(data, val);
 		if (rc)
 			return rc;
 
-		rc = dps310_calculate_pressure(data, val);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_PROCESSED:
+		rc = dps310_read_pressure_value(data, val);
 		if (rc)
 			return rc;
 
 		*val2 = 1000; /* Convert Pa to KPa per IIO ABI */
 		return IIO_VAL_FRACTIONAL;
 
+	case IIO_CHAN_INFO_SCALE:
+		/* The raw value is in Pa, the ABI wants kPa */
+		*val = 1;
+		*val2 = 1000;
+		return IIO_VAL_FRACTIONAL;
+
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		rc = dps310_get_pres_precision(data, val);
 		if (rc)
@@ -768,6 +833,21 @@ static int dps310_calculate_temp(struct dps310_data *data, int *val)
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
@@ -782,11 +862,7 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
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
 
@@ -804,12 +880,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 	}
 }
 
-static int dps310_read_raw(struct iio_dev *iio,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
+static int dps310_read_channel(struct dps310_data *data,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
 {
-	struct dps310_data *data = iio_priv(iio);
-
 	switch (chan->type) {
 	case IIO_PRESSURE:
 		return dps310_read_pressure(data, val, val2, mask);
@@ -822,6 +896,97 @@ static int dps310_read_raw(struct iio_dev *iio,
 	}
 }
 
+static int dps310_read_raw(struct iio_dev *iio,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct dps310_data *data = iio_priv(iio);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED: {
+		/*
+		 * Sampling here consumes the same measurement the capture path
+		 * reads, so refuse while the buffer is enabled.
+		 */
+		IIO_DEV_ACQUIRE_DIRECT_MODE(iio, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		return dps310_read_channel(data, chan, val, val2, mask);
+	}
+	default:
+		return dps310_read_channel(data, chan, val, val2, mask);
+	}
+}
+
+/* Called with lock held */
+static int dps310_fill_scan(struct iio_dev *iio, u8 *buffer)
+{
+	struct dps310_data *data = iio_priv(iio);
+	int rc;
+	int pos = 0;
+	s32 value;
+
+	/*
+	 * The pressure compensation needs a temperature reading, so temperature
+	 * is sampled even when only the pressure channel is enabled.
+	 */
+	rc = dps310_read_temp_raw_locked(data);
+	if (rc)
+		return rc;
+
+	if (test_bit(DPS310_SCAN_TEMP, iio->active_scan_mask)) {
+		rc = dps310_calculate_temp(data, &value);
+		if (rc)
+			return rc;
+
+		/* Millidegrees Celsius */
+		memcpy(&buffer[pos], &value, sizeof(value));
+		pos += sizeof(value);
+	}
+
+	if (test_bit(DPS310_SCAN_PRESSURE, iio->active_scan_mask)) {
+		rc = dps310_read_pres_raw_locked(data);
+		if (rc)
+			return rc;
+
+		rc = dps310_calculate_pressure(data, &value);
+		if (rc)
+			return rc;
+
+		/* Pascals, see the comment on the channel definition */
+		memcpy(&buffer[pos], &value, sizeof(value));
+	}
+
+	return 0;
+}
+
+static irqreturn_t dps310_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio = pf->indio_dev;
+	struct dps310_data *data = iio_priv(iio);
+	/*
+	 * Either channel can be enabled on its own, so the offset of the second
+	 * value depends on the scan mask and the layout cannot be described
+	 * with a structure. Sized for both 32-bit channels plus the timestamp.
+	 */
+	u8 buffer[16] __aligned(8) = { };
+	int rc = 0;
+
+	scoped_guard(mutex, &data->lock)
+		rc = dps310_fill_scan(iio, buffer);
+
+	if (!rc)
+		iio_push_to_buffers_with_ts(iio, buffer, sizeof(buffer),
+					    pf->timestamp);
+
+	iio_trigger_notify_done(iio->trig);
+
+	return IRQ_HANDLED;
+}
+
 static void dps310_reset(void *action_data)
 {
 	struct dps310_data *data = action_data;
@@ -877,6 +1042,16 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	/*
+	 * The device measures continuously in background mode, so a capture is
+	 * just a read of the latest results and no buffer setup ops are needed.
+	 */
+	rc = devm_iio_triggered_buffer_setup(&client->dev, iio,
+					     iio_pollfunc_store_time,
+					     dps310_trigger_handler, NULL);
+	if (rc)
+		return rc;
+
 	rc = devm_iio_device_register(&client->dev, iio);
 	if (rc)
 		return rc;
-- 
2.43.0

