Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4C37474E
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 22:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673671; cv=none; b=JQpZhn9qRoQMJFDm/p/yE6DbPAcdbPsLYstm00pRw0R9AbE3FeSBE2o//34mJ2TpkjRTi7pFhBuUusgvG1txtDyCXZIQW5gk72VPQTXdp5gi9q6QTIaGQo01BpwXvI3ju1MgfUi+JsYY5Q3ztoGHny/g2ndczsUGpm/ilSXS7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673671; c=relaxed/simple;
	bh=KDDned/68wwTFx92VVAQh6EQv4ruMj60Zi03p957YY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iimOyZ+cNEPuP9ugknO/5+x3MJdsEa/F5+i5KXruuE7X1TwbcY4W4BN2mQXum+u/dqsmcR8oDKxIvTRI46wRFojJUzVayNXoZY8/EQlXBNXGXXaF98GWpWTNq6FZfAfVlrJ9PFBfV60kFK/qeBzNJc/KW0fnHyzUiqJUCQ4vP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPcaXeOg; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPcaXeOg"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7de4ebe10cbso1897276a34.3
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 15:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777673669; x=1778278469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXbsJusecprBo7UCoCKveUx1iEiF5W3Xj9UF66sUlt8=;
        b=MPcaXeOgnmpCymf15S8MH1K2HURV+Z0P/3y00sLrNs6ocG7itfqVaLyH2vRiQuWGtn
         YhUHJ4/I4jhlmN4Tm6dH6SHhpwofJt39M+zeCBLmooLwaPrkmQpNY1o7twQcUhVZ3e+d
         vnHAg2ey6l/UhX+zilDUZBbPmeNC8iq1bZtWw6hQgG0vgSORNReNLoJqplIV5t7FCnLc
         m99/3lTS8e71xSUrfLufQoGXk5ra/qPIQHWlVefPo8QRUi8cBihyQrMkRsQVrvlc12xl
         9q4gcptq7dnlMRhcmduEIwT0o9vZOTG9DL4FKuoPJJC38PUsJ80nwUFrQTQCxXi0PvYX
         AZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777673669; x=1778278469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CXbsJusecprBo7UCoCKveUx1iEiF5W3Xj9UF66sUlt8=;
        b=EbV+xf3rhQWGweLJxWCMIIzfeFA2hMV+59MSIXf50sd8PgVViCRhlLA6fttAcxcPCA
         22DRneD3SHgV8FTrYLtl2riKd86CRgFMTHIAYk+JkTtQnKuPvGe08pA7z0PMR0cHbgnK
         EEwrrNEGHihOBWX/Uu3HSruEdMOVLeVnt3AyDk1B1Hb3k+0W6FtoBGPlgfmpL4ewVnZp
         2labYksenECttuvIXRXP8SRqrkwM/rR46EeSld4Ou3d4VfK6QMhaQrRaYn4lipktbbmL
         Dg9/Y8oHHcD4rUeGviAkwvpr7/cOY58rxrk++hBHZAmAZNRZvLI1F7aOgAbEyBrG9qDv
         xEvQ==
X-Gm-Message-State: AOJu0YwYdH6mx0PPn2IcrKLsOrU48iFwLeSf0zGmSMlM/2ypX61EfKYP
	l7BqfQ3KUtSSh6aQKKs2+fByWpd0CH9wxYx0EaV5ekphg1/dPOfAUAlk1ikNHA==
X-Gm-Gg: AeBDies1jo0sgWtOJ4PckA9LPYTnAoBYbsGgm44TyQUU1/su9tD5gc5eMnh/R+sylQy
	BLVBZz81El81SoL4YeZHUUGn4Od9SlwoH5SxasJm4TQGbpFmSE/d4u8LY6Hg3vjIL9qi/t5w0yG
	e2p+D3HEgQ8rdK10r18fj1DhfChEJkQb+iXUDyo36pAk1TWP+aFHMzrnQAg/wMj2JeEjAVuCage
	punObZe8sZwdMcYh9+DMEKxsBRu9mtbrZYeM1Uzx7pIuIzC4APX69NJXViroXwwNbZneGOe5oQh
	+dCNUy364Cae+nCWq6OrHcPkHh5lzGfB6BZ1a7s+L3UNEVBafGH/XY1bdEkrc2wFHopRS7RM97O
	SDlVZ+FSyOCQw4QUSMhFl4SgSLybbfTSV8+s2LaZNTdB+4SC2V2NSVvQ9VL7tmgcEYkeee/qXMp
	frhErgPriAC8L+VIaGynRyuTLK4vkNztQ=
X-Received: by 2002:a05:6830:82ec:b0:7dc:de8a:b93e with SMTP id 46e09a7af769-7dee14fd16cmr849157a34.25.1777673668621;
        Fri, 01 May 2026 15:14:28 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ded51a9612sm1827337a34.26.2026.05.01.15.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:14:28 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 08/10] iio: imu: inv_icm42607: Add Wake on Movement for icm42607
Date: Fri,  1 May 2026 17:11:47 -0500
Message-ID: <20260501221152.194251-9-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501221152.194251-1-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for wake on movement for the icm42607 driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |   3 +
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 303 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 159 ++++++++-
 3 files changed, 464 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 5768e63d1dd2..a0123e062820 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -410,6 +410,9 @@ int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
 int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
 			       unsigned int *sleep_ms);
 
+int inv_icm42607_enable_wom(struct inv_icm42607_state *st);
+int inv_icm42607_disable_wom(struct inv_icm42607_state *st);
+
 int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval);
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
index d998d8c94eb9..d056c74dcbfe 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -173,6 +173,16 @@ static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
 	{ }
 };
 
+/* WoM event: rising ROC */
+static const struct iio_event_spec inv_icm42607_wom_events[] = {
+	{
+		.type = IIO_EV_TYPE_ROC,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
 	INV_ICM42607_ACCEL_CHAN(IIO_MOD_X, INV_ICM42607_ACCEL_SCAN_X,
 				inv_icm42607_accel_ext_infos),
@@ -182,6 +192,8 @@ static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
 				inv_icm42607_accel_ext_infos),
 	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
 	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42607_ACCEL_SCAN_TIMESTAMP),
+	INV_ICM42607_ACCEL_EVENT_CHAN(IIO_MOD_X_OR_Y_OR_Z, inv_icm42607_wom_events,
+				      ARRAY_SIZE(inv_icm42607_wom_events)),
 };
 
 static const struct iio_event_spec inv_icm42607_motion_events[] = {
@@ -319,6 +331,180 @@ static int inv_icm42607_accel_read_sensor(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static unsigned int inv_icm42607_accel_convert_roc_to_wom(u64 roc,
+							  int accel_hz, int accel_uhz)
+{
+	/* 1000/256mg per LSB converted in µm/s² */
+	const unsigned int convert = (9807U * (MICRO / MILLI)) / 256U;
+	u64 value;
+	u64 freq_uhz;
+
+	/* return 0 only if roc is 0 */
+	if (roc == 0)
+		return 0;
+
+	freq_uhz = (u64)accel_hz * MICRO + (u64)accel_uhz;
+	value = div64_u64(roc * MICRO, freq_uhz * (u64)convert);
+
+	/* limit value to 8 bits and prevent 0 */
+	return clamp(value, 1, 255);
+}
+
+static u64 inv_icm42607_accel_convert_wom_to_roc(unsigned int threshold,
+						 int accel_hz, int accel_uhz)
+{
+	/* 1000/256mg per LSB converted in µm/s² */
+	const unsigned int convert = (9807U * (MICRO / MILLI)) / 256U;
+	u64 value;
+	u64 freq_uhz;
+
+	value = threshold * convert;
+	freq_uhz = (u64)accel_hz * MICRO + (u64)accel_uhz;
+
+	/* compute the differential by multiplying by the frequency */
+	return div_u64(value * freq_uhz, MICRO);
+}
+
+static int inv_icm42607_accel_set_wom_threshold(struct inv_icm42607_state *st,
+						u64 value,
+						int accel_hz, int accel_uhz)
+{
+	unsigned int threshold;
+	int ret;
+
+	/* convert roc to wom threshold and convert back to handle clipping */
+	threshold = inv_icm42607_accel_convert_roc_to_wom(value, accel_hz, accel_uhz);
+	value = inv_icm42607_accel_convert_wom_to_roc(threshold, accel_hz, accel_uhz);
+
+	dev_dbg(regmap_get_device(st->map), "wom_threshold: 0x%x\n", threshold);
+
+	/* set accel WoM threshold for the 3 axes */
+	st->buffer[0] = threshold;
+	st->buffer[1] = threshold;
+	st->buffer[2] = threshold;
+	ret = regmap_bulk_write(st->map, INV_ICM42607_REG_ACCEL_WOM_X_THR, st->buffer, 3);
+	if (ret)
+		return ret;
+
+	st->apex.wom.value = value;
+
+	return 0;
+}
+
+static int _inv_icm42607_accel_enable_wom(struct iio_dev *indio_dev)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	unsigned int sleep_ms = 0;
+	int ret;
+
+	scoped_guard(mutex, &st->lock) {
+		/* turn on accel sensor */
+		conf.mode = accel_st->power_mode;
+		conf.filter = accel_st->filter;
+		ret = inv_icm42607_set_accel_conf(st, &conf, &sleep_ms);
+		if (ret)
+			return ret;
+	}
+
+	if (sleep_ms)
+		msleep(sleep_ms);
+
+	scoped_guard(mutex, &st->lock) {
+		ret = inv_icm42607_enable_wom(st);
+		if (ret)
+			return ret;
+		st->apex.on++;
+		st->apex.wom.enable = true;
+	}
+
+	return 0;
+}
+
+static int inv_icm42607_accel_enable_wom(struct iio_dev *indio_dev)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *pdev = regmap_get_device(st->map);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(pdev);
+	if (ret)
+		return ret;
+
+	ret = _inv_icm42607_accel_enable_wom(indio_dev);
+	if (ret) {
+		pm_runtime_mark_last_busy(pdev);
+		pm_runtime_put_autosuspend(pdev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int _inv_icm42607_accel_disable_wom(struct iio_dev *indio_dev)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	unsigned int sleep_ms = 0;
+	int ret;
+
+	scoped_guard(mutex, &st->lock) {
+		/*
+		 * Consider that turning off WoM is always working to avoid
+		 * blocking the chip in on mode and prevent going back to sleep.
+		 * If there is an error, the chip will anyway go back to sleep
+		 * and the feature will not work anymore.
+		 */
+		st->apex.wom.enable = false;
+		st->apex.on--;
+		ret = inv_icm42607_disable_wom(st);
+		if (ret)
+			return ret;
+		/* turn off accel sensor if not used */
+		if (!st->apex.on && !iio_buffer_enabled(indio_dev)) {
+			conf.mode = INV_ICM42607_SENSOR_MODE_OFF;
+			ret = inv_icm42607_set_accel_conf(st, &conf, &sleep_ms);
+			if (ret)
+				return ret;
+		}
+	}
+
+	if (sleep_ms)
+		msleep(sleep_ms);
+
+	return 0;
+}
+
+static int inv_icm42607_accel_disable_wom(struct iio_dev *indio_dev)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *pdev = regmap_get_device(st->map);
+	int ret;
+
+	ret = _inv_icm42607_accel_disable_wom(indio_dev);
+
+	pm_runtime_mark_last_busy(pdev);
+	pm_runtime_put_autosuspend(pdev);
+
+	return ret;
+}
+
+void inv_icm42607_accel_handle_events(struct iio_dev *indio_dev,
+				      unsigned int status2, unsigned int status3,
+				      s64 timestamp)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	u64 ev_code;
+
+	/* handle WoM event */
+	if (st->apex.wom.enable && (status2 & INV_ICM42607_INT_STATUS2_WOM_INT)) {
+		ev_code = IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
+					     IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING);
+		iio_push_event(indio_dev, ev_code, timestamp);
+	}
+}
+
 static const int inv_icm42607_accel_scale_nano[][2] = {
 	[INV_ICM42607_ACCEL_FS_16G] = { 0, 4788403 },
 	[INV_ICM42607_ACCEL_FS_8G] = { 0, 2394202 },
@@ -464,6 +650,9 @@ static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
 		return ret;
 
 	ret = inv_icm42607_set_accel_conf(st, &conf, NULL);
+	if (ret)
+		return ret;
+	ret = inv_icm42607_accel_set_wom_threshold(st, st->apex.wom.value, val, val2);
 	if (ret)
 		return ret;
 
@@ -578,6 +767,116 @@ static int inv_icm42607_accel_hwfifo_flush(struct iio_dev *indio_dev,
 	return st->fifo.nb.accel;
 }
 
+static int inv_icm42607_accel_read_event_config(struct iio_dev *indio_dev,
+						const struct iio_chan_spec *chan,
+						enum iio_event_type type,
+						enum iio_event_direction dir)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+
+	/* handle only WoM (roc rising) event */
+	if (type != IIO_EV_TYPE_ROC || dir != IIO_EV_DIR_RISING)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	return st->apex.wom.enable ? 1 : 0;
+}
+
+static int inv_icm42607_accel_write_event_config(struct iio_dev *indio_dev,
+						 const struct iio_chan_spec *chan,
+						 enum iio_event_type type,
+						 enum iio_event_direction dir,
+						 bool state)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+
+	/* handle only WoM (roc rising) event */
+	if (type != IIO_EV_TYPE_ROC || dir != IIO_EV_DIR_RISING)
+		return -EINVAL;
+
+	scoped_guard(mutex, &st->lock) {
+		if (st->apex.wom.enable == state)
+			return 0;
+	}
+
+	if (state)
+		return inv_icm42607_accel_enable_wom(indio_dev);
+
+	return inv_icm42607_accel_disable_wom(indio_dev);
+}
+
+static int inv_icm42607_accel_read_event_value(struct iio_dev *indio_dev,
+					       const struct iio_chan_spec *chan,
+					       enum iio_event_type type,
+					       enum iio_event_direction dir,
+					       enum iio_event_info info,
+					       int *val, int *val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	u32 rem;
+
+	/* handle only WoM (roc rising) event value */
+	if (type != IIO_EV_TYPE_ROC || dir != IIO_EV_DIR_RISING)
+		return -EINVAL;
+
+	guard(mutex)(&st->lock);
+
+	/* return value in micro */
+	*val = div_u64_rem(st->apex.wom.value, MICRO, &rem);
+	*val2 = rem;
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int _inv_icm42607_accel_wom_value(struct inv_icm42607_state *st,
+					 int val, int val2)
+{
+	u64 value;
+	unsigned int accel_hz, accel_uhz;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_icm42607_accel_read_odr(st, &accel_hz, &accel_uhz);
+	if (ret < 0)
+		return ret;
+
+	value = (u64)val * MICRO + (u64)val2;
+
+	return inv_icm42607_accel_set_wom_threshold(st, value,
+						    accel_hz, accel_uhz);
+}
+
+static int inv_icm42607_accel_write_event_value(struct iio_dev *indio_dev,
+						const struct iio_chan_spec *chan,
+						enum iio_event_type type,
+						enum iio_event_direction dir,
+						enum iio_event_info info,
+						int val, int val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	int ret;
+
+	/* handle only WoM (roc rising) event value */
+	if (type != IIO_EV_TYPE_ROC || dir != IIO_EV_DIR_RISING)
+		return -EINVAL;
+
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = _inv_icm42607_accel_wom_value(st, val, val2);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
 static const struct iio_info inv_icm42607_accel_info = {
 	.read_raw = inv_icm42607_accel_read_raw,
 	.write_raw = inv_icm42607_accel_write_raw,
@@ -586,6 +885,10 @@ static const struct iio_info inv_icm42607_accel_info = {
 	.update_scan_mode = inv_icm42607_accel_update_scan_mode,
 	.hwfifo_set_watermark = inv_icm42607_accel_hwfifo_set_watermark,
 	.hwfifo_flush_to_buffer = inv_icm42607_accel_hwfifo_flush,
+	.read_event_config = inv_icm42607_accel_read_event_config,
+	.write_event_config = inv_icm42607_accel_write_event_config,
+	.read_event_value = inv_icm42607_accel_read_event_value,
+	.write_event_value = inv_icm42607_accel_write_event_value,
 };
 
 struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st)
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 5c2010d8256f..480fe1741a04 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -238,6 +238,39 @@ int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
 					  sleep_ms);
 }
 
+int inv_icm42607_enable_wom(struct inv_icm42607_state *st)
+{
+	int ret;
+
+	/* enable WoM hardware */
+	ret = regmap_write(st->map, INV_ICM42607_REG_WOM_CONFIG,
+			   FIELD_PREP(INV_ICM42607_WOM_CONFIG_INT_DUR_MASK, 1) |
+			   INV_ICM42607_WOM_CONFIG_MODE |
+			   INV_ICM42607_WOM_CONFIG_EN);
+	if (ret)
+		return ret;
+
+	/* enable WoM interrupt */
+	return regmap_set_bits(st->map, INV_ICM42607_REG_INT_SOURCE1,
+			       INV_ICM42607_INT_SOURCE1_WOM_INT1_EN);
+}
+
+int inv_icm42607_disable_wom(struct inv_icm42607_state *st)
+{
+	int ret;
+
+	/* disable WoM interrupt */
+	ret = regmap_clear_bits(st->map, INV_ICM42607_REG_INT_SOURCE1,
+				INV_ICM42607_INT_SOURCE1_WOM_INT1_EN);
+	if (ret)
+		return ret;
+
+	/* disable WoM hardware */
+	return regmap_clear_bits(st->map, INV_ICM42607_REG_WOM_CONFIG,
+				 INV_ICM42607_WOM_CONFIG_EN);
+}
+
+
 int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
@@ -361,6 +394,109 @@ static int inv_icm42607_setup(struct inv_icm42607_state *st,
 	return inv_icm42607_set_conf(st, hw->conf);
 }
 
+static irqreturn_t inv_icm42607_irq_timestamp(int irq, void *_data)
+{
+	struct inv_icm42607_state *st = _data;
+
+	st->timestamp.gyro = iio_get_time_ns(st->indio_gyro);
+	st->timestamp.accel = iio_get_time_ns(st->indio_accel);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t inv_icm42607_irq_handler(int irq, void *_data)
+{
+	struct inv_icm42607_state *st = _data;
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int status;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	if (st->apex.on) {
+		unsigned int status2, status3;
+
+		/* read INT_STATUS2 and INT_STATUS3 in 1 operation */
+		ret = regmap_bulk_read(st->map, INV_ICM42607_REG_INT_STATUS2, st->buffer, 2);
+		if (ret)
+			goto out_unlock;
+		status2 = st->buffer[0];
+		status3 = st->buffer[1];
+		inv_icm42607_accel_handle_events(st->indio_accel, status2, status3,
+						 st->timestamp.accel);
+	}
+
+	ret = regmap_read(st->map, INV_ICM42607_REG_INT_STATUS, &status);
+	if (ret)
+		goto out_unlock;
+
+	if (status & INV_ICM42607_INT_STATUS_FIFO_FULL)
+		dev_warn(dev, "FIFO full data lost!\n");
+
+	if (status & INV_ICM42607_INT_STATUS_FIFO_THS) {
+		ret = inv_icm42607_buffer_fifo_read(st, 0);
+		if (ret) {
+			dev_err(dev, "FIFO read error %d\n", ret);
+			goto out_unlock;
+		}
+		ret = inv_icm42607_buffer_fifo_parse(st);
+		if (ret)
+			dev_err(dev, "FIFO parsing error %d\n", ret);
+	}
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	return IRQ_HANDLED;
+}
+
+/**
+ * inv_icm42607_irq_init() - initialize int pin and interrupt handler
+ * @st:		driver internal state
+ * @irq:	irq number
+ * @irq_type:	irq trigger type
+ * @open_drain:	true if irq is open drain, false for push-pull
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static int inv_icm42607_irq_init(struct inv_icm42607_state *st, int irq,
+				int irq_type, bool open_drain)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int val = 0;
+	int ret;
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_RISING:
+	case IRQF_TRIGGER_HIGH:
+		val = INV_ICM42607_INT_CONFIG_INT1_ACTIVE_HIGH;
+		break;
+	default:
+		val = INV_ICM42607_INT_CONFIG_INT1_ACTIVE_LOW;
+		break;
+	}
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_HIGH:
+		val |= INV_ICM42607_INT_CONFIG_INT1_LATCHED;
+		break;
+	default:
+		break;
+	}
+
+	if (!open_drain)
+		val |= INV_ICM42607_INT_CONFIG_INT1_PUSH_PULL;
+
+	ret = regmap_write(st->map, INV_ICM42607_REG_INT_CONFIG, val);
+	if (ret)
+		return ret;
+
+	irq_type |= IRQF_ONESHOT;
+	return devm_request_threaded_irq(dev, irq, inv_icm42607_irq_timestamp,
+					 inv_icm42607_irq_handler, irq_type,
+					 st->name, st);
+}
+
 static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
 {
 	int ret;
@@ -387,7 +523,7 @@ int inv_icm42607_core_probe(struct regmap *regmap, int chip,
 	struct device *dev = regmap_get_device(regmap);
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct inv_icm42607_state *st;
-	int irq;
+	int irq, irq_type;
 	bool open_drain;
 	int ret;
 
@@ -402,6 +538,9 @@ int inv_icm42607_core_probe(struct regmap *regmap, int chip,
 	if (irq < 0)
 		return dev_err_probe(dev, irq, "error missing INT1 interrupt\n");
 
+	irq_type = irq_get_trigger_type(irq);
+	if (!irq_type)
+		irq_type = IRQF_TRIGGER_FALLING;
 	open_drain = device_property_read_bool(dev, "drive-open-drain");
 
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
@@ -455,6 +594,11 @@ int inv_icm42607_core_probe(struct regmap *regmap, int chip,
 	if (IS_ERR(st->indio_accel))
 		return PTR_ERR(st->indio_accel);
 
+	/* Initialize interrupt handling */
+	ret = inv_icm42607_irq_init(st, irq, irq_type, open_drain);
+	if (ret)
+		return ret;
+
 	ret = devm_pm_runtime_set_active_enabled(dev);
 	if (ret)
 		return ret;
@@ -502,6 +646,12 @@ static int inv_icm42607_suspend(struct device *dev)
 		enable_irq_wake(st->irq);
 		disable_irq(st->irq);
 	} else {
+		/* disable APEX features and accel if wakeup disabled */
+		if (st->apex.wom.enable) {
+			ret = inv_icm42607_disable_wom(st);
+			if (ret)
+				return ret;
+		}
 		accel_conf = INV_ICM42607_SENSOR_MODE_OFF;
 	}
 
@@ -555,6 +705,13 @@ static int inv_icm42607_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* restore APEX features if disabled */
+	if (!wakeup && st->apex.wom.enable) {
+		ret = inv_icm42607_enable_wom(st);
+		if (ret)
+			return ret;
+	}
+
 	if (st->fifo.on) {
 		inv_sensors_timestamp_reset(&gyro_st->ts);
 		inv_sensors_timestamp_reset(&accel_st->ts);
-- 
2.43.0

