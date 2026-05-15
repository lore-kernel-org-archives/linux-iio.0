Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B233016E0
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850251; cv=none; b=f81XNOVPJYiMPobEypQ8xSaR0xZj5R5m1fu7FGKNK42bG81SkUamfsWENgZGT5fW2TeHeVTj6NatXahSpbEmCe0gMpdF9o+XwKR7EyxbC2z9ek4X5W6i0ni7Summ2jO0v1vnVaolr+5+8sFTmT9NzAUqNoTCGfqXdfNP0msf4Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850251; c=relaxed/simple;
	bh=XqhvFkwJ9wOIhIZ4LnjwcTa/mdlmJb30Ouy2A76ttSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfKuCjjpxaf/omKKcCoY/EjZ2t+ybih1rGCIyA/WcU7RTxVQ56M1/CpLbVKI0R/FDnUn1bu4iMfgS0x7tAAI3uhSXJlrp+zHtF27HF/TQX7VKH9k03KaL0vJ6DjL/Slb5qzc2Cv3vTxvV8YJ9T0lUJDLYElUiE2lzGkuWfAMObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tEH3Yo/0; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEH3Yo/0"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-439f000476eso1470070fac.0
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 06:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778850247; x=1779455047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3sRvlMFxJopUWxvRPucM1fPeBOxWlVQn7zlqRJK8HM=;
        b=tEH3Yo/08D6l2WjHpzLQnwCYyFuyLIeUw+53P1yVQsemYpOguzLr4FXtghOcOkUyIX
         QEqc1pYZGs9hx2mn/hrNmZlLUa+zzxjQJT0r/y7U06gB2Zcj1SsjAqHSjFcwO/D1NKfE
         Er0yPikf5DLHiIGdc53Hp4OQvWgSgriZNOpWtlS/j2i+wbeliVMJrVM/2gzdLaNNKE+A
         IhUqsroNP6tc+enN9Hs2lpwptlOnZfZEwA7o1RXMflNOcxGjU7RTE9VdB26BLyNHt9YR
         gDVsNxd7IVO3dm/PJuam2PmZ0HNe/BFPNWigKyNJVwe9s59gQeQDUW8TmPExosbsT3EK
         Y9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850247; x=1779455047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V3sRvlMFxJopUWxvRPucM1fPeBOxWlVQn7zlqRJK8HM=;
        b=ng25H4/JXUbkonGqaRFPi5rk48FJcLPvBB1EcNEARaKGdAPkrNL2K6qzGCKVAGEl/M
         6sCtYPcdTII0S8iIBFr/rryxTk68IH6oR6bktT31XX3kEalFnxCdP1RfbKbHwGKb4/5k
         z/Xh6KhkPCtftWIJmfwtL9Nnuj/GRP7glzp7DBkRlH7bn5OWdp1lIuDIO5K81wGoGKed
         a6uzh6C87ULG5/9C1mlFuxfv53CZuQ44RmowGEXbOaOOoDXhy4mflGyJcpUuBcelDw3r
         /2Yz2xf20QrJ3xrzYXBveSv1N7v0P+lIaaMnUPkm7r1T2r7JkTki86TJ1ITSvB4NnEDp
         hmvw==
X-Gm-Message-State: AOJu0Yx4aa/5jhecO/VHHaVGRddPo4zRizaiv9kcfJuhv8tked69LUPB
	xUS4+TMON454pP6RblVsUMO2ERYqvyLpb7yuQH4TWblhVeoCKpatn+yKItqs4tc5
X-Gm-Gg: Acq92OFRW3D+EPMdTXphDoNpSoRm42uR6YBGVs6BI2V7qRcZy9vUN0gu9M0NBVK8cWU
	13CZDVr0TU/meRWIrTJr1Ai0498vXRSorV/Srgqxcmc1/bXBNqasdE7lAW7CIrmdymx9rJRHU/U
	KXEZvZJ2F2EU0JrdqUJyORoyfl2XkL3BPpyAeds5ZlRxJ9cZQ6XzfCSmFDKSHD+ed0Ex+w94oKC
	71rfiE9S/1rFQ9OU+FdK9G/2beWC0bu9PQ8LZ+o8Ro3uT6RXCLReyA2JiU0drV1+FgyTpftDNIF
	geABG/5QGoDVH3uToJLQ8agHLXpQ5ruTVYsk4czndh6n8x45wlBD3unClC2qQ28+ynDL9nLPbBe
	WnWC1T0YOmDv28smGnw+bB5dAWyAOtleY2uuqupHFp0kbqSYkII6kxt0U4Kcv5yOGQyXOGmAx61
	K/ZfnxqY8K3nEfene3y3jmR8ut2hpAVuzHRUYklK4nrA==
X-Received: by 2002:a05:6871:b0d:b0:439:a524:a29b with SMTP id 586e51a60fabf-43a2dcc9486mr2330253fac.7.1778850169537;
        Fri, 15 May 2026 06:02:49 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:8c2e:6a8e:445a:9169])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc53f2acsm4155822fac.14.2026.05.15.06.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:02:49 -0700 (PDT)
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
Subject: [PATCH V7 09/11] iio: imu: inv_icm42607: Add Wake on Movement to icm42607
Date: Fri, 15 May 2026 08:00:14 -0500
Message-ID: <20260515130018.237378-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515130018.237378-1-macroalpha82@gmail.com>
References: <20260515130018.237378-1-macroalpha82@gmail.com>
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
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 267 ++++++++++++++-
 3 files changed, 594 insertions(+), 10 deletions(-)

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
index b354a84fd2ed..504245b0282b 100644
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
@@ -209,6 +221,181 @@ static int inv_icm42607_accel_read_sensor(struct iio_dev *indio_dev,
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
+	value = div64_u64(roc, (freq_uhz * (u64)convert) / MICRO);
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
+					      INV_ICM42607_REG_ACCEL_WOM_X_THR + i,
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
+		inv_icm42607_disable_wom(st);
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
@@ -329,6 +516,10 @@ static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	ret = inv_icm42607_accel_set_wom_threshold(st, st->apex.wom.value, val, val2);
+	if (ret)
+		return ret;
+
 	inv_icm42607_buffer_update_fifo_period(st);
 	inv_icm42607_buffer_update_watermark(st);
 
@@ -475,6 +666,115 @@ static int inv_icm42607_accel_hwfifo_flush(struct iio_dev *indio_dev,
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
+	int accel_hz, accel_uhz;
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
@@ -483,6 +783,10 @@ static const struct iio_info inv_icm42607_accel_info = {
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
index 1e685451f785..8ab8b5f739f2 100644
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
@@ -360,6 +444,114 @@ static int inv_icm42607_setup(struct inv_icm42607_state *st,
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
+	mutex_lock(&st->lock);
+
+	if (st->apex.on) {
+		u8 buffer[2];
+
+		/* read INT_STATUS2 and INT_STATUS3 in 1 operation */
+		ret = regmap_bulk_read(st->map, INV_ICM42607_REG_INT_STATUS2, buffer, 2);
+		if (ret) {
+			dev_err(dev, "Interrupt status read error %d\n", ret);
+			goto out_unlock;
+		}
+
+		inv_icm42607_accel_handle_events(st->indio_accel, buffer[0], buffer[1],
+						 st->timestamp.accel);
+	}
+
+	ret = regmap_read(st->map, INV_ICM42607_REG_INT_STATUS, &status);
+	if (ret) {
+		dev_err(dev, "Interrut status read error %d\n", ret);
+		goto out_unlock;
+	}
+
+	if (status & INV_ICM42607_INT_STATUS_FIFO_FULL)
+		dev_warn(dev, "FIFO full data lost!\n");
+
+	if (status & INV_ICM42607_INT_STATUS_FIFO_THS) {
+		mutex_unlock(&st->lock);
+		ret = inv_icm42607_buffer_fifo_read(st, 0);
+		if (ret) {
+			dev_err(dev, "FIFO read error %d\n", ret);
+			goto out_unlock;
+		}
+
+		mutex_lock(&st->lock);
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
+					 st->hw->name, st);
+}
+
 static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
 {
 	int ret;
@@ -393,13 +585,18 @@ int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw
 	struct device *dev = regmap_get_device(regmap);
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct inv_icm42607_state *st;
-	int irq;
+	int irq, irq_type;
+	bool open_drain;
 	int ret;
 
 	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (!(irq > 0))
 		return dev_err_probe(dev, -EINVAL, "Unable to get INT1 interrupt\n");
 
+	irq_type = irq_get_trigger_type(irq);
+
+	open_drain = device_property_read_bool(dev, "drive-open-drain");
+
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
@@ -459,6 +656,11 @@ int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw
 	if (IS_ERR(st->indio_accel))
 		return PTR_ERR(st->indio_accel);
 
+	/* Initialize interrupt handling */
+	ret = inv_icm42607_irq_init(st, irq, irq_type, open_drain);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
@@ -466,6 +668,9 @@ EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
 static int inv_icm42607_suspend(struct device *dev)
 {
 	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	struct device *accel_dev;
+	bool wakeup;
+	int accel_conf;
 	int ret;
 
 	guard(mutex)(&st->lock);
@@ -482,12 +687,36 @@ static int inv_icm42607_suspend(struct device *dev)
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
@@ -496,6 +725,8 @@ static int inv_icm42607_resume(struct device *dev)
 {
 	struct inv_icm42607_state *st = dev_get_drvdata(dev);
 	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
+	struct device *accel_dev;
+	bool wakeup;
 	int ret;
 
 	guard(mutex)(&st->lock);
@@ -503,9 +734,18 @@ static int inv_icm42607_resume(struct device *dev)
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
@@ -514,6 +754,13 @@ static int inv_icm42607_resume(struct device *dev)
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

