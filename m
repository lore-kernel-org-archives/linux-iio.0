Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95DF39DBDD
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624355; cv=none; b=hOni6moZ0R4AY382zF1Zd/1YAyS6cwYf/FTlEgoIeXEMv7jQmrmbSW79uYyRtr1jYNso1yJpXAXDekHd1NsixtzdLPAbow9usNdU7Z9LFuk6Ak9dPSKPSRFRsB4OqVr0eTdZd9Iad5jkvrIDoqL+4Pi9ZAQIpgExib/SbRyIsqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624355; c=relaxed/simple;
	bh=ydPrj1+ZyxxLkIt0sP5HkchY0OlR/8yl/OpF4U+QGfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGMVtKJAQ583dK0J62viZvo1CsYbO2kOq1XopavmFLv55mGr9hhUwV1iFD/kuKYg3NYIJQ7IrnGxn1xeF3T0X/HIfwAEctYAAhIo1u3Kz56BD+deJ5dqh9W2YoXHdje7yZHxqqWe8BwbolnjmNP8HV5XPJvpGniabPYxzxsjgog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4g9WstS; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4g9WstS"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-479aa2dbea2so2559102b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778624351; x=1779229151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHl10tlqMfM5nTwmh3nRFHHIlbBfIkwTOKjd6ffNEUE=;
        b=M4g9WstSct1ZNAr6bOooN6yL6kHpuAPrtPdIZhSZIqNPBESiPoOb2cjFYmkc7/3MfI
         AXQPaYxTIIs5vNRUYv1EX3b1LsJMLrrnIPllHtH8R/H1fmdb+EMlLSb8rRLsj0PqxsHK
         uPODbKQG7f3GHDyoCQt1VkgH2wKiHrGoXovGYb2FO0N+ITY3sheXf7T4F5AuAsEJVN9H
         Ds9IlC4ieBh8TN27z1iMZhLCyTQbCHl+0BxTh4DWbSDWkKR0OaU61QRJocn+OpRz3IUB
         U5aAQgKssw8j59tBGW90rqseB2hWX2U15oi0560xMRr0I5SG/c0FDmr6C8CF1ZskKnrq
         aAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624351; x=1779229151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bHl10tlqMfM5nTwmh3nRFHHIlbBfIkwTOKjd6ffNEUE=;
        b=oPSg1EtMhvRazg/4PmgCraT3c3OnRHp2VqdWOTWW5QpCuys10ihZvmy9WRX8BwGABh
         uddb/ZUy1WAyd0SfqdxXujFpk1HcH+actofMt6xUV6CF0m4avuORHoxxs5RY8D5xkFJo
         C0ZhDBggXAGAFcg1mInVUfSQ2HWRieeG2OpDBVu5LkloPwPqTOEAQ+YfOcvn9iNsdJF6
         2cB7JIqamoApVcCQE/jPkilFjiDlSm/n5d3uhogry0199iU6tStvHBEipiMnmflioEm8
         Cjnme/ko3TWaYAUMwbvBOG37MDFteuN1HfiwnMXcVCIAHNBTcMiZ5M+qqcOJ/maA4txm
         1DBw==
X-Gm-Message-State: AOJu0YzkDBjgpM3bK5UYM+uQAavhLWOBhaHZqP41zWXpbRsN7kgZukxY
	p1R9hbaIFzueiwR8fTUyQ5uwbuFrnDpcDNlAUrIjNBloVM/hUsRcpykVHMvUjgtS
X-Gm-Gg: Acq92OGjB5zX1a2OqqVfKAg1FFPCio4Kc9kwLoHJ6UfKenpFNyxHHYEocpJgz6v4AKp
	k6ufajGGJiyGxj3fPzZKSqpiClWmyAgHxBaYTMKkcEaCqaxJu4yQbXONGKsXfw++zD5Edf0Og6c
	RcbhX48YkVYqjyoCBZhVhBZdiJQ2H+tD1sXHxTRVXArgsbfUR++k9RenIwpQ3f05U8OlH6ztT2J
	bDSjeknYCx+YLYZykNbnMDvHnsnSnwLNWYze/CzQT9wm1PHH/OA7FoYYSswos1xAOgsHEdF+H83
	5IIIVYvfR+Wcv1asSiPxc9KMGP7qjOdYFAuST1aQx8Qy29ubqhB7CRBUPpiQNRM14tZooyqGExB
	ji7Ea/evNvFnth5KhMv6eM9J0QUtFZH1PME5Y3HEQnQkMuS602+TYFVmqtVV/+5ukVdpr/I+cQl
	vy5LBlJqYEUsqeVkxcvmOrGk4fFsR9nZE=
X-Received: by 2002:a54:438e:0:b0:47b:ea3c:cd92 with SMTP id 5614622812f47-482b2bb988fmr510415b6e.22.1778624351406;
        Tue, 12 May 2026 15:19:11 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986f87sm23291473b6e.13.2026.05.12.15.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:19:10 -0700 (PDT)
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
Subject: [PATCH V6 09/11] iio: imu: inv_icm42607: Add Wake on Movement to icm42607
Date: Tue, 12 May 2026 17:16:30 -0500
Message-ID: <20260512221634.256747-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512221634.256747-1-macroalpha82@gmail.com>
References: <20260512221634.256747-1-macroalpha82@gmail.com>
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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  33 ++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 304 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 263 ++++++++++++++-
 3 files changed, 590 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 095f4a495e3f..16f7929d3d0e 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -119,6 +119,14 @@ struct inv_icm42607_suspended {
 	bool temp;
 };
 
+struct inv_icm42607_apex {
+	unsigned int on;
+	struct {
+		u64 value;
+		bool enable;
+	} wom;
+};
+
 /**
  *  struct inv_icm42607_state - driver state variables
  *  @lock:		lock for serializing multiple registers access.
@@ -133,6 +141,7 @@ struct inv_icm42607_suspended {
  *  @indio_gyro:	gyroscope IIO device.
  *  @indio_accel:	accelerometer IIO device.
  *  @timestamp:         interrupt timestamps.
+ *  @apex:		APEX (Advanced Pedometer and Event detection) management
  *  @fifo:		FIFO management structure.
  *  @buffer:		data transfer buffer aligned for DMA.
  */
@@ -151,6 +160,7 @@ struct inv_icm42607_state {
 	struct {
 		s64 accel;
 	} timestamp;
+	struct inv_icm42607_apex apex;
 	struct inv_icm42607_fifo fifo;
 	__be16 buffer[3] __aligned(IIO_DMA_MINALIGN);
 };
@@ -376,6 +386,18 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607P_WHOAMI				0x60
 #define INV_ICM42607_WHOAMI				0x67
 
+/* Bank 2/3 register access */
+#define INV_ICM42607_BLK_SEL_W				0x79
+#define INV_ICM42607_MADDR_W				0x7A
+#define INV_ICM42607_M_W				0x7B
+#define INV_ICM42607_BLK_SEL_R				0x7C
+#define INV_ICM42607_MADDR_R				0x7D
+#define INV_ICM42607_M_R				0x7E
+
+#define INV_ICM42607_MREG_1				0x00
+#define INV_ICM42607_MREG_2				0x28
+#define INV_ICM42607_MREG_3				0x50
+
 /* Sleep times required by the driver */
 #define INV_ICM42607_POWER_UP_TIME_US			100000
 #define INV_ICM42607_RESET_TIME_MS			1
@@ -384,6 +406,7 @@ struct inv_icm42607_sensor_state {
 #define INV_ICM42607_GYRO_STOP_TIME_MS			150
 #define INV_ICM42607_TEMP_STARTUP_TIME_MS		14
 #define INV_ICM42607_SUSPEND_DELAY_MS			2000
+#define INV_ICM42607_MREG_DELAY_US			10
 
 typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
 
@@ -392,6 +415,9 @@ extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
+int inv_icm42607_mreg_write(struct regmap *map, unsigned int bank,
+			    u8 reg, u8 data);
+
 const struct iio_mount_matrix *
 inv_icm42607_get_mount_matrix(struct iio_dev *indio_dev,
 			      const struct iio_chan_spec *chan);
@@ -405,6 +431,9 @@ int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
 int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
 			       unsigned int *sleep_ms);
 
+int inv_icm42607_enable_wom(struct inv_icm42607_state *st);
+int inv_icm42607_disable_wom(struct inv_icm42607_state *st);
+
 int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
 
@@ -412,4 +441,8 @@ struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st);
 
 int inv_icm42607_accel_parse_fifo(struct iio_dev *indio_dev);
 
+void inv_icm42607_accel_handle_events(struct iio_dev *indio_dev,
+				      unsigned int status2, unsigned int status3,
+				      s64 timestamp);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
index 06f2126af22a..4628bda35637 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -69,6 +69,16 @@ static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
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
@@ -78,6 +88,8 @@ static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
 				inv_icm42607_accel_ext_infos),
 	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
 	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42607_ACCEL_SCAN_TIMESTAMP),
+	INV_ICM42607_ACCEL_EVENT_CHAN(IIO_MOD_X_OR_Y_OR_Z, inv_icm42607_wom_events,
+				      ARRAY_SIZE(inv_icm42607_wom_events)),
 };
 
 static const struct iio_event_spec inv_icm42607_motion_events[] = {
@@ -209,6 +221,183 @@ static int inv_icm42607_accel_read_sensor(struct iio_dev *indio_dev,
 	return 0;
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
+	int i, ret;
+
+	/* convert roc to wom threshold and convert back to handle clipping */
+	threshold = inv_icm42607_accel_convert_roc_to_wom(value, accel_hz, accel_uhz);
+	value = inv_icm42607_accel_convert_wom_to_roc(threshold, accel_hz, accel_uhz);
+
+	dev_dbg(regmap_get_device(st->map), "wom_threshold: 0x%x\n", threshold);
+
+	st->apex.wom.value = value;
+
+	/* 42607P cannot set WoM threshold. */
+	if (st->hw->whoami == INV_ICM42607P_WHOAMI)
+		return 0;
+
+	/* set accel WoM threshold for the 3 axes */
+	for (i = 0; i < 3; i++) {
+		ret = inv_icm42607_mreg_write(st->map, INV_ICM42607_MREG_2,
+					      INV_ICM42607_REG_ACCEL_WOM_X_THR,
+					      threshold);
+		if (ret)
+			return ret;
+	}
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
@@ -329,6 +518,10 @@ static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	ret = inv_icm42607_accel_set_wom_threshold(st, st->apex.wom.value, val, val2);
+	if (ret)
+		return ret;
+
 	inv_icm42607_buffer_update_fifo_period(st);
 	inv_icm42607_buffer_update_watermark(st);
 
@@ -467,6 +660,113 @@ static int inv_icm42607_accel_hwfifo_flush(struct iio_dev *indio_dev,
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
+	if (st->apex.wom.enable == state)
+		return 0;
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
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
 static const struct iio_info inv_icm42607_accel_info = {
 	.read_raw = inv_icm42607_accel_read_raw,
 	.read_avail = inv_icm42607_accel_read_avail,
@@ -475,6 +775,10 @@ static const struct iio_info inv_icm42607_accel_info = {
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
index 56ce9a51cb9c..a69cd0a61050 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -17,6 +17,57 @@
 #include "inv_icm42607.h"
 #include "inv_icm42607_buffer.h"
 
+/**
+ *  inv_icm42607_mreg_write() - Write value to user bank
+ *  @map:	device regmap
+ *  @bank:	mreg register bank
+ *  @reg:	register in the mreg bank to write to
+ *  @data:	data to write to register
+ *
+ *  Write a byte of data to bank 2 or 3 as defined in the datasheet.
+ *  Writes are performed by first writing which bank to write to the
+ *  bank write register, then writing the register address, then
+ *  writing the data.
+ *  Return 0 on success or error on error.
+ */
+int inv_icm42607_mreg_write(struct regmap *map, unsigned int bank,
+			    u8 reg, u8 data)
+{
+	const struct device *dev = regmap_get_device(map);
+	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	u8 buffer[3];
+	int ret;
+
+	/* The ICM42607P does not have additional banks for registers. */
+	if (st->hw->whoami == INV_ICM42607P_WHOAMI)
+		return -EINVAL;
+
+	/* Bank value can only be bank2 or bank3. */
+	if (bank != INV_ICM42607_MREG_2 && bank != INV_ICM42607_MREG_3)
+		return -EINVAL;
+
+	buffer[0] = bank;
+	buffer[1] = reg;
+	buffer[2] = data;
+
+	/*
+	 * Write bank, register, and value in one bulk write. Then pause
+	 * the required time according to datasheet.
+	 */
+	ret = regmap_bulk_write(map, INV_ICM42607_BLK_SEL_W, buffer, 3);
+	fsleep(INV_ICM42607_MREG_DELAY_US);
+	if (ret)
+		return ret;
+
+	/* Switch back to bank1 and pause the required amount of time. */
+	ret = regmap_write(map, INV_ICM42607_BLK_SEL_W, INV_ICM42607_MREG_1);
+	fsleep(INV_ICM42607_MREG_DELAY_US);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static bool inv_icm42607_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -28,6 +79,7 @@ static bool inv_icm42607_is_volatile_reg(struct device *dev, unsigned int reg)
 	case INV_ICM42607_REG_FIFO_LOST_PKT0 ... INV_ICM42607_REG_APEX_DATA3:
 	case INV_ICM42607_REG_INT_STATUS_DRDY:
 	case INV_ICM42607_REG_INT_STATUS ... INV_ICM42607_REG_FIFO_DATA:
+	case INV_ICM42607_BLK_SEL_W ... INV_ICM42607_M_R:
 		return true;
 	}
 
@@ -238,6 +290,38 @@ int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
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
 static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
 				 const struct inv_icm42607_conf *conf)
 {
@@ -347,6 +431,110 @@ static int inv_icm42607_setup(struct inv_icm42607_state *st,
 	return inv_icm42607_set_conf(st, st->hw->conf);
 }
 
+static irqreturn_t inv_icm42607_irq_timestamp(int irq, void *_data)
+{
+	struct inv_icm42607_state *st = _data;
+
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
+	guard(mutex)(&st->lock);
+
+	if (st->apex.on) {
+		u8 buffer[2];
+
+		/* read INT_STATUS2 and INT_STATUS3 in 1 operation */
+		ret = regmap_bulk_read(st->map, INV_ICM42607_REG_INT_STATUS2, buffer, 2);
+		if (ret) {
+			dev_err(dev, "Interrupt status read error %d\n", ret);
+			return IRQ_HANDLED;
+		}
+
+		inv_icm42607_accel_handle_events(st->indio_accel, buffer[0], buffer[1],
+						 st->timestamp.accel);
+	}
+
+	ret = regmap_read(st->map, INV_ICM42607_REG_INT_STATUS, &status);
+	if (ret) {
+		dev_err(dev, "Interrut status read error %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (status & INV_ICM42607_INT_STATUS_FIFO_FULL)
+		dev_warn(dev, "FIFO full data lost!\n");
+
+	if (status & INV_ICM42607_INT_STATUS_FIFO_THS) {
+		ret = inv_icm42607_buffer_fifo_read(st, 0);
+		if (ret) {
+			dev_err(dev, "FIFO read error %d\n", ret);
+			return IRQ_HANDLED;
+		}
+
+		ret = inv_icm42607_buffer_fifo_parse(st);
+		if (ret)
+			dev_err(dev, "FIFO parsing error %d\n", ret);
+	}
+
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
+					 st->hw->name, st);
+}
+
 static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
 {
 	int ret;
@@ -380,13 +568,18 @@ int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw
 	struct device *dev = regmap_get_device(regmap);
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct inv_icm42607_state *st;
-	int irq;
+	int irq, irq_type;
+	bool open_drain;
 	int ret;
 
 	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (irq <= 0)
 		return dev_err_probe(dev, irq, "error missing INT1 interrupt\n");
 
+	irq_type = irq_get_trigger_type(irq);
+
+	open_drain = device_property_read_bool(dev, "drive-open-drain");
+
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
@@ -441,6 +634,11 @@ int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw
 	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
+	/* Initialize interrupt handling */
+	ret = inv_icm42607_irq_init(st, irq, irq_type, open_drain);
+	if (ret)
+		return ret;
+
 	/* Initialize IIO device for Accel */
 	st->indio_accel = inv_icm42607_accel_init(st);
 	if (IS_ERR(st->indio_accel))
@@ -457,6 +655,9 @@ EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
 static int inv_icm42607_suspend(struct device *dev)
 {
 	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	struct device *accel_dev;
+	bool wakeup;
+	int accel_conf;
 	int ret;
 
 	guard(mutex)(&st->lock);
@@ -473,12 +674,36 @@ static int inv_icm42607_suspend(struct device *dev)
 			return ret;
 	}
 
-	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
-					 INV_ICM42607_SENSOR_MODE_OFF,
-					 false, NULL);
-	if (ret)
-		return ret;
-	inv_icm42607_disable_vddio_reg(st);
+	/* keep chip on and wake-up capable if APEX and wakeup on */
+	accel_dev = &st->indio_accel->dev;
+	wakeup = st->apex.on && device_may_wakeup(accel_dev);
+	if (wakeup) {
+		/* keep accel on and setup irq for wakeup */
+		accel_conf = st->conf.accel.mode;
+		enable_irq_wake(st->irq);
+		disable_irq_nosync(st->irq);
+		ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
+						 accel_conf, false, NULL);
+		if (ret) {
+			enable_irq(st->irq);
+			disable_irq_wake(st->irq);
+			return ret;
+		}
+	} else {
+		/* disable APEX features and accel if wakeup disabled */
+		if (st->apex.wom.enable) {
+			ret = inv_icm42607_disable_wom(st);
+			if (ret)
+				return ret;
+		}
+		accel_conf = INV_ICM42607_SENSOR_MODE_OFF;
+		ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
+						 INV_ICM42607_SENSOR_MODE_OFF,
+						 false, NULL);
+		if (ret)
+			return ret;
+		inv_icm42607_disable_vddio_reg(st);
+	}
 
 	return 0;
 }
@@ -491,6 +716,8 @@ static int inv_icm42607_resume(struct device *dev)
 {
 	struct inv_icm42607_state *st = dev_get_drvdata(dev);
 	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
+	struct device *accel_dev;
+	bool wakeup;
 	int ret;
 
 	guard(mutex)(&st->lock);
@@ -498,9 +725,18 @@ static int inv_icm42607_resume(struct device *dev)
 	if (pm_runtime_suspended(dev))
 		return 0;
 
-	ret = inv_icm42607_enable_vddio_reg(st);
-	if (ret)
-		return ret;
+	/* check wakeup capability */
+	accel_dev = &st->indio_accel->dev;
+	wakeup = st->apex.on && device_may_wakeup(accel_dev);
+	/* restore irq state */
+	if (wakeup) {
+		enable_irq(st->irq);
+		disable_irq_wake(st->irq);
+	} else {
+		ret = inv_icm42607_enable_vddio_reg(st);
+		if (ret)
+			return ret;
+	}
 
 	/* restore sensors state, noting gyro still not yet supported.  */
 	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
@@ -509,6 +745,13 @@ static int inv_icm42607_resume(struct device *dev)
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
 		inv_sensors_timestamp_reset(&accel_st->ts);
 		ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
-- 
2.43.0

