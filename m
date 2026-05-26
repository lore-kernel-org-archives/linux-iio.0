Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7D3C09F2
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821850; cv=none; b=QzuyHy/Gs/5HMYwYpCd4VGDhnqoHVHTRij7d3gUvjYLHCexXPk+hwaMj7ValVyXpRZCzsJUXZtsF3FqbVjCgRXqpOSXhX9mS9fXpaXRvOZgMdIqPvVtfVUVCUA+jygTKEGWpBzNiUwrNkltxWQSQZ6ijVCmb7R5Wfh7EzpB2VlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821850; c=relaxed/simple;
	bh=UBqMvMBAQMWFx5qPdilgU4mpRpzThRo0CewAXVRFWdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdmR8Z6RGzVrqhqSJgRXO1aFFvJ0mfGJWp0cXXhbozw0vBGdErq2Pfqf+nn/8xKV42a0IDx3N4a/oJSa5xcNLGcBULWBFzrOtggisxCrLBnYLNLNtujVx3m0SpE6Wo8izooUl5bWQa1kW0Jibw7an1nxNd7r/3iIH5+EKONe5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8X+T747; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8X+T747"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8c92737a8d3so70533746d6.1
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 11:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779821847; x=1780426647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GggC8A1NQHtEOhI6v7zwNutT7eq7AOCZAnOhZqWciho=;
        b=T8X+T7471ngWdrpVHWpYs+fCiEC9fSqXkRC6Za2nSNtQhrEWFdkpUvAuXrTk+xzua3
         oao5W4vvF3tfIGDlIJwm08S0vS0JVzn/xkzgffLjoHqwxlB2r39prnLbLIzsXy0gjj3z
         cbHdZ0JfaQDhYI+2r4wcFAHqPMqUyQPKG39dnXi8DiLqOLsw/qMXHg5WIzxot1Ei2vHL
         YfzBfVs8ND1H2mvBbPfTl0//ZSuDq0uMPwH8kCsH6/Z1FAwZ72SjhkTf6SlMJ1TFEjpL
         YTGzeJn/ucm6O4nINzbrGTcyVYK6QUQMte/uKZR4c6UFWhLiasEP/ti7Tnz/3FhLqZi8
         9zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821847; x=1780426647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GggC8A1NQHtEOhI6v7zwNutT7eq7AOCZAnOhZqWciho=;
        b=qp/AsoUYh4T52s4zrQaz+dD9Zric1o3nz2/emqnrBkgTS5D8s8C3ynV61oHWFdEGX/
         bA6Q3rFCrrqxI35D0BgdSYNWxBj7ZC3jDe7/WGn6jqxJTbMS4UeE8DTHyjHXWXcZl1zP
         drhlb0ZSI9H//A3y/BiaO/E3yo1cD492C7Z9S554zjzRYYhX9vIV7HvA8L+QKv5F+MF8
         wT5G1dcCFZsfTC18OnrTNB/kJIWtzxbDa/tZ62B3xrJOSFn/MuJmXggtwHitybHwuaZV
         x8CW5HINNo+ywqf/ld1UX0x6ejEqJllBVK5PJEh3FrUFBuroBI1zNmlwUuP3LzYODlXP
         vaUA==
X-Gm-Message-State: AOJu0Yy86Kbjwv9ux/FK5YhEgDJD0cGEWKb+IoUcAFbmwO/vIBHZV+dx
	Oftp62mVtnjBxtg08dCm2QFdxty8oociPez3jv9ZbAQgk0DB2my+8sqbZ2UYz9Lri+8=
X-Gm-Gg: Acq92OEqmct+0ccIL5i/sBspu2I7VGALKJkovkTmxDdtJtdYHVi5KKCugBeS+YYjv4f
	Wy/qeWGivbUGsSVgp8YBjLoWIT02llbQL5i0gmwrXZa/TWYypzLhY6f9KDcybLtz9nmwaf/qZwl
	KCTiDdWAyBejKJAQ2hjAB7/fKQiqsZYdJXbnXNNlQ1GHk0Gw3KcXci/74sFEX5jgdadeg6AaE3d
	eie6AuXrHh7jL3KIlS/Rj6oDgEnJCeNRdrnjc1qpa1TYfQe2RhGofiLt1UEbWwiagRMMGN5ZB/E
	NxrNO6fukcmGI/nMCTnmdJdaaJ2Q1VnHXpImmy2+imjlJz0ocIf2gXgFe6p057nsT3SbwHk+J+u
	J4jGYszC3lVBh+FOVVuXg5YiMh/mLtDhZyd9UOL9V3VTPj3w02NVvbusrcycnrCvvxxq/RxPnVb
	K5jzIFALyvtKgXT4v1ZftbSN4EwLvVJAqL
X-Received: by 2002:a05:6214:5b8a:b0:8cc:6a81:9ee1 with SMTP id 6a1803df08f44-8cc7b602f3amr296220966d6.49.1779821847382;
        Tue, 26 May 2026 11:57:27 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcf797sm150619496d6.4.2026.05.26.11.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:57:25 -0700 (PDT)
From: Louis Adamian <adamianlouis@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	Louis Adamian <adamianlouis@gmail.com>
Subject: [RFC PATCH 2/2] iio: pressure: ms5637: Add variant specific temperature compensation
Date: Tue, 26 May 2026 14:40:31 -0400
Message-ID: <20260526185612.35048-4-adamianlouis@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526185612.35048-2-adamianlouis@gmail.com>
References: <20260526185612.35048-2-adamianlouis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add correct temperature compensation for ms5637-30BA, MS5803-01BA,02BA,
05BA,14BA,30BA, MS5837-30BA. The temperature compensation formula is
shared across these sensors but with different constants. Add
ms_tp_comp_consts to capture these per-device differences. Add pressure
variant specific pressure scale variable.

Signed-off-by: Louis Adamian <adamianlouis@gmail.com>
---
 .../iio/common/ms_sensors/ms_sensors_i2c.c    |  81 +++---
 .../iio/common/ms_sensors/ms_sensors_i2c.h    |  47 +++
 drivers/iio/pressure/ms5637.c                 | 273 ++++++++++++++++--
 3 files changed, 351 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 1960a2ce82a8..0798e7c9e0e8 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -604,6 +604,39 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
 }
 EXPORT_SYMBOL_NS(ms_sensors_tp_read_prom, "IIO_MEAS_SPEC_SENSORS");
 
+/* apply second order temperature compensation */
+static void ms_tp_compensate(const struct ms_tp_comp_consts *comp_consts,
+			     s32 temp, s32 dt, s64 *t2, s64 *off2, s64 *sens2)
+{
+	if (temp < 2000) {
+		s64 tmp = (s64)temp - 2000;
+		*t2 = (comp_consts->low_t2_multiplier * ((s64)dt * (s64)dt)) >>
+		      comp_consts->low_t2_shift;
+		*off2 = (comp_consts->low_off2_multiplier * tmp * tmp) >>
+			comp_consts->low_off2_shift;
+		*sens2 = (comp_consts->low_sens2_multiplier * tmp * tmp) >>
+			 comp_consts->low_sens2_shift;
+
+		if (temp < -1500) {
+			s64 tmp = (s64)temp + 1500;
+			*off2 += comp_consts->vlow_off2_multiplier * tmp * tmp;
+			*sens2 +=
+				comp_consts->vlow_sens2_multiplier * tmp * tmp;
+		}
+	} else {
+		if (comp_consts->has_vhigh_temp && temp > 4500) {
+			*sens2 -= (((s64)temp - 4500) * ((s64)temp - 4500)) >>
+				  3;
+		}
+		*t2 = (comp_consts->high_t2_multiplier * ((s64)dt * (s64)dt)) >>
+		      comp_consts->high_t2_shift;
+		*off2 = (comp_consts->high_off2_multiplier *
+			 ((s64)temp - 2000) * ((s64)temp - 2000)) >>
+			comp_consts->high_off2_shift;
+		*sens2 = 0;
+	}
+}
+
 /**
  * ms_sensors_read_temp_and_pressure() - read temp and pressure
  * @dev_data:	pointer to temperature/pressure device data
@@ -629,22 +662,18 @@ int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
 	delay = ms_sensors_tp_conversion_time[dev_data->res_index];
 
 	ret = ms_sensors_convert_and_read(
-					dev_data->client,
-					MS_SENSORS_TP_T_CONVERSION_START +
-						dev_data->res_index * 2,
-					MS_SENSORS_TP_ADC_READ,
-					delay, &t_adc);
+		dev_data->client,
+		MS_SENSORS_TP_T_CONVERSION_START + dev_data->res_index * 2,
+		MS_SENSORS_TP_ADC_READ, delay, &t_adc);
 	if (ret) {
 		mutex_unlock(&dev_data->lock);
 		return ret;
 	}
 
 	ret = ms_sensors_convert_and_read(
-					dev_data->client,
-					MS_SENSORS_TP_P_CONVERSION_START +
-						dev_data->res_index * 2,
-					MS_SENSORS_TP_ADC_READ,
-					delay, &p_adc);
+		dev_data->client,
+		MS_SENSORS_TP_P_CONVERSION_START + dev_data->res_index * 2,
+		MS_SENSORS_TP_ADC_READ, delay, &p_adc);
 	mutex_unlock(&dev_data->lock);
 	if (ret)
 		return ret;
@@ -654,38 +683,24 @@ int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
 	/* Actual temperature = 2000 + dT * TEMPSENS */
 	temp = 2000 + (((s64)dt * prom[6]) >> 23);
 
-	/* Second order temperature compensation */
-	if (temp < 2000) {
-		s64 tmp = (s64)temp - 2000;
-
-		t2 = (3 * ((s64)dt * (s64)dt)) >> 33;
-		off2 = (61 * tmp * tmp) >> 4;
-		sens2 = (29 * tmp * tmp) >> 4;
-
-		if (temp < -1500) {
-			s64 tmp = (s64)temp + 1500;
-
-			off2 += 17 * tmp * tmp;
-			sens2 += 9 * tmp * tmp;
-		}
-	} else {
-		t2 = (5 * ((s64)dt * (s64)dt)) >> 38;
-		off2 = 0;
-		sens2 = 0;
-	}
+	ms_tp_compensate(dev_data->comp_consts, temp, dt, &t2, &off2, &sens2);
 
 	/* OFF = OFF_T1 + TCO * dT */
-	off = (((s64)prom[2]) << 17) + ((((s64)prom[4]) * (s64)dt) >> 6);
+	off = (((s64)prom[2]) << dev_data->comp_consts->off_t1_shift) +
+	      ((((s64)prom[4]) * (s64)dt) >> dev_data->comp_consts->off_shift);
 	off -= off2;
 
 	/* Sensitivity at actual temperature = SENS_T1 + TCS * dT */
-	sens = (((s64)prom[1]) << 16) + (((s64)prom[3] * dt) >> 7);
+	sens = (((s64)prom[1]) << dev_data->comp_consts->sens_t1_shift) +
+	       (((s64)prom[3] * dt) >> dev_data->comp_consts->sens_shift);
 	sens -= sens2;
 
 	/* Temperature compensated pressure = D1 * SENS - OFF */
 	*temperature = (temp - t2) * 10;
-	*pressure = (u32)(((((s64)p_adc * sens) >> 21) - off) >> 15);
-
+	*pressure = (u32)(((((s64)p_adc * sens) >>
+			    dev_data->comp_consts->press_sens_shift) -
+			   off) >>
+			  dev_data->comp_consts->press_shift);
 	return 0;
 }
 EXPORT_SYMBOL_NS(ms_sensors_read_temp_and_pressure, "IIO_MEAS_SPEC_SENSORS");
diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
index f15b973f27c6..41f5dde45e56 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
@@ -35,6 +35,51 @@ struct ms_tp_hw_data {
 	u8 max_res_index;
 };
 
+/**
+ * struct ms_tp_comp_consts - Temperature compensation constants
+ * @high_t2_multiplier:    multiplier for t2 in high temperature state
+ * @high_t2_shift:    bit shift for t2 in high temperature state
+ * @high_off2_multiplier:    multiplier for off2 in high temperature state
+ * @high_off2_shift:    bit shift for off2 in high temperature state
+ * @low_t2_multiplier:    multiplier for t2 in low temperature state
+ * @low_t2_shift:    bit shift for t2 in low temperature state
+ * @low_off2_multiplier:    multiplier for off2 in low temperature state
+ * @low_off2_shift:    bit shift for off2 in low temperature state
+ * @low_sens2_multiplier:    multiplier for sens2 in low temperature state
+ * @low_sens2_shift:    bit shift for sens2 in low temperature state
+ * @vlow_off2_multiplier:    multiplier for value added to t2 in very low temperature state
+ * @vlow_sens2_multiplier:    multiplier for value added to sens2 in very low temperature state
+ * @has_vhigh_temp:    has very high temperature compensation logic
+ * @off_t1_shift:    temperature offset t1 bit shift
+ * @off_shift:    temperature offset shift
+ * @sens_t1_shift:    temperature sensitivity t1 shift
+ * @sens_shift:    temperature sensitivity shift
+ * @press_sens_shift:     pressure sensitivity shift
+ * @press_shift:     pressure shift
+ */
+struct ms_tp_comp_consts {
+	u8 high_t2_multiplier;
+	u8 high_t2_shift;
+	u8 high_off2_multiplier;
+	u8 high_off2_shift;
+	u8 low_t2_multiplier;
+	u8 low_t2_shift;
+	u8 low_off2_multiplier;
+	u8 low_off2_shift;
+	u8 low_sens2_multiplier;
+	u8 low_sens2_shift;
+	u8 vlow_off2_multiplier;
+	u8 vlow_sens2_multiplier;
+	bool has_vhigh_temp;
+	u8 off_t1_shift;
+	u8 off_shift;
+	u8 sens_t1_shift;
+	u8 sens_shift;
+	u8 press_sens_shift;
+	u8 press_shift;
+	u32 press_scale;
+};
+
 /**
  * struct ms_tp_dev - Temperature/Pressure sensor device structure
  * @client:	i2c client
@@ -42,6 +87,7 @@ struct ms_tp_hw_data {
  * @prom:	array of PROM coefficients used for conversion. Added element
  *              for CRC computation
  * @res_index:	index to selected sensor resolution
+ * @comp_consts: temperature compensation constants
  */
 struct ms_tp_dev {
 	struct i2c_client *client;
@@ -49,6 +95,7 @@ struct ms_tp_dev {
 	const struct ms_tp_hw_data *hw;
 	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB];
 	u8 res_index;
+	const struct ms_tp_comp_consts *comp_consts;
 };
 
 int ms_sensors_reset(void *cli, u8 cmd, unsigned int delay);
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 59705a666979..b9a0be9b53cb 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -33,11 +33,13 @@
 struct ms_tp_data {
 	const char *name;
 	const struct ms_tp_hw_data *hw;
+	const struct ms_tp_comp_consts *comp_consts;
 };
 
 static const int ms5637_samp_freq[6] = { 960, 480, 240, 120, 60, 30 };
 
-static ssize_t ms5637_show_samp_freq(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t ms5637_show_samp_freq(struct device *dev,
+				     struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ms_tp_dev *dev_data = iio_priv(indio_dev);
@@ -73,8 +75,10 @@ static int ms5637_read_raw(struct iio_dev *indio_dev,
 
 			return IIO_VAL_INT;
 		case IIO_PRESSURE:	/* in kPa */
-			*val = pressure / 1000;
-			*val2 = (pressure % 1000) * 1000;
+			*val = pressure / dev_data->comp_consts->press_scale;
+			*val2 = (pressure %
+				 dev_data->comp_consts->press_scale) *
+				dev_data->comp_consts->press_scale;
 
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
@@ -171,7 +175,7 @@ static int ms5637_probe(struct i2c_client *client)
 	dev_data->res_index = data->hw->max_res_index;
 	dev_data->hw = data->hw;
 	mutex_init(&dev_data->lock);
-
+	dev_data->comp_consts = data->comp_consts;
 	indio_dev->info = &ms5637_info;
 	indio_dev->name = data->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -191,43 +195,278 @@ static int ms5637_probe(struct i2c_client *client)
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-static const struct ms_tp_hw_data ms5637_hw_data  = {
-	.prom_len = 7,
-	.max_res_index = 5
+static const struct ms_tp_hw_data ms5637_hw_data = { .prom_len = 7,
+						     .max_res_index = 5 };
+
+static const struct ms_tp_hw_data ms5803_hw_data = { .prom_len = 8,
+						     .max_res_index = 4 };
+
+static const struct ms_tp_comp_consts ms5637_consts = {
+	.high_t2_multiplier = 5,
+	.high_t2_shift = 38,
+	.high_off2_multiplier = 0,
+	.high_off2_shift = 0,
+	.low_t2_multiplier = 3,
+	.low_t2_shift = 33,
+	.low_off2_multiplier = 61,
+	.low_off2_shift = 4,
+	.low_sens2_multiplier = 29,
+	.low_sens2_shift = 4,
+	.vlow_off2_multiplier = 17,
+	.vlow_sens2_multiplier = 9,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 17,
+	.off_shift = 6,
+	.sens_t1_shift = 16,
+	.sens_shift = 7,
+	.press_sens_shift = 21,
+	.press_shift = 15,
+	.press_scale = 1000
+};
+
+static const struct ms_tp_data ms5637_data = { .name = "ms5637",
+					       .hw = &ms5637_hw_data,
+					       .comp_consts = &ms5637_consts };
+
+static const struct ms_tp_comp_consts ms5637_30_consts = {
+	.high_t2_multiplier = 2,
+	.high_t2_shift = 37,
+	.high_off2_multiplier = 1,
+	.high_off2_shift = 4,
+	.low_t2_multiplier = 3,
+	.low_t2_shift = 33,
+	.low_off2_multiplier = 3,
+	.low_off2_shift = 1,
+	.low_sens2_multiplier = 5,
+	.low_sens2_shift = 3,
+	.vlow_off2_multiplier = 7,
+	.vlow_sens2_multiplier = 4,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 16,
+	.off_shift = 7,
+	.sens_t1_shift = 15,
+	.sens_shift = 8,
+	.press_sens_shift = 21,
+	.press_shift = 13,
+	.press_scale = 100
 };
 
-static const struct ms_tp_hw_data ms5803_hw_data  = {
-	.prom_len = 8,
-	.max_res_index = 4
+static const struct ms_tp_data ms5637_30_data = { .name = "ms5637-30ba",
+						  .hw = &ms5637_hw_data,
+						  .comp_consts =
+							  &ms5637_30_consts };
+
+static const struct ms_tp_data ms5803_data = { .name = "ms5803",
+					       .hw = &ms5803_hw_data,
+					       .comp_consts = &ms5637_consts };
+
+static const struct ms_tp_data ms5805_data = { .name = "ms5805",
+					       .hw = &ms5637_hw_data,
+					       .comp_consts = &ms5637_consts };
+
+static const struct ms_tp_data ms5837_data = { .name = "ms5837",
+					       .hw = &ms5637_hw_data,
+					       .comp_consts = &ms5637_consts };
+
+static const struct ms_tp_data ms8607_data = { .name = "ms8607-temppressure",
+					       .hw = &ms5637_hw_data,
+					       .comp_consts = &ms5637_consts };
+
+static const struct ms_tp_comp_consts ms5803_01_consts = {
+	.high_t2_multiplier = 0,
+	.high_t2_shift = 0,
+	.high_off2_multiplier = 0,
+	.high_off2_shift = 0,
+	.low_t2_multiplier = 1,
+	.low_t2_shift = 31,
+	.low_off2_multiplier = 3,
+	.low_off2_shift = 0,
+	.low_sens2_multiplier = 7,
+	.low_sens2_shift = 3,
+	.vlow_off2_multiplier = 0,
+	.vlow_sens2_multiplier = 2,
+	.has_vhigh_temp = true,
+	.off_t1_shift = 16,
+	.off_shift = 7,
+	.sens_t1_shift = 15,
+	.sens_shift = 8,
+	.press_sens_shift = 21,
+	.press_shift = 15,
+	.press_scale = 1000
 };
 
-static const struct ms_tp_data ms5637_data = { .name = "ms5637", .hw = &ms5637_hw_data };
+static const struct ms_tp_data ms5803_01_data = { .name = "ms5803-01ba",
+						  .hw = &ms5803_hw_data,
+						  .comp_consts =
+							  &ms5803_01_consts };
+
+static const struct ms_tp_comp_consts ms5803_02_consts = {
+	.high_t2_multiplier = 0,
+	.high_t2_shift = 0,
+	.high_off2_multiplier = 0,
+	.high_off2_shift = 0,
+	.low_t2_multiplier = 1,
+	.low_t2_shift = 31,
+	.low_off2_multiplier = 61,
+	.low_off2_shift = 4,
+	.low_sens2_multiplier = 2,
+	.low_sens2_shift = 0,
+	.vlow_off2_multiplier = 20,
+	.vlow_sens2_multiplier = 12,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 17,
+	.off_shift = 6,
+	.sens_t1_shift = 16,
+	.sens_shift = 7,
+	.press_sens_shift = 21,
+	.press_shift = 15,
+	.press_scale = 1000
+};
 
-static const struct ms_tp_data ms5803_data = { .name = "ms5803", .hw = &ms5803_hw_data };
+static const struct ms_tp_data ms5803_02_data = { .name = "ms5803-02ba",
+						  .hw = &ms5803_hw_data,
+						  .comp_consts =
+							  &ms5803_02_consts };
+
+static const struct ms_tp_comp_consts ms5803_05_consts = {
+	.high_t2_multiplier = 0,
+	.high_t2_shift = 0,
+	.high_off2_multiplier = 0,
+	.high_off2_shift = 0,
+	.low_t2_multiplier = 3,
+	.low_t2_shift = 33,
+	.low_off2_multiplier = 3,
+	.low_off2_shift = 3,
+	.low_sens2_multiplier = 7,
+	.low_sens2_shift = 3,
+	.vlow_off2_multiplier = 0,
+	.vlow_sens2_multiplier = 3,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 18,
+	.off_shift = 5,
+	.sens_t1_shift = 17,
+	.sens_shift = 7,
+	.press_sens_shift = 21,
+	.press_shift = 15,
+	.press_scale = 1000
+};
 
-static const struct ms_tp_data ms5805_data = { .name = "ms5805", .hw = &ms5637_hw_data };
+static const struct ms_tp_data ms5803_05_data = { .name = "ms5803-05ba",
+						  .hw = &ms5803_hw_data,
+						  .comp_consts =
+							  &ms5803_05_consts };
+
+static const struct ms_tp_comp_consts ms5803_14_consts = {
+	.high_t2_multiplier = 7,
+	.high_t2_shift = 37,
+	.high_off2_multiplier = 1,
+	.high_off2_shift = 4,
+	.low_t2_multiplier = 3,
+	.low_t2_shift = 33,
+	.low_off2_multiplier = 3,
+	.low_off2_shift = 1,
+	.low_sens2_multiplier = 5,
+	.low_sens2_shift = 3,
+	.vlow_off2_multiplier = 7,
+	.vlow_sens2_multiplier = 4,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 16,
+	.off_shift = 7,
+	.sens_t1_shift = 15,
+	.sens_shift = 8,
+	.press_sens_shift = 21,
+	.press_shift = 15,
+	.press_scale = 100
+};
 
-static const struct ms_tp_data ms5837_data = { .name = "ms5837", .hw = &ms5637_hw_data };
+static const struct ms_tp_data ms5803_14_data = { .name = "ms5803-14ba",
+						  .hw = &ms5803_hw_data,
+						  .comp_consts =
+							  &ms5803_14_consts };
+
+static const struct ms_tp_comp_consts ms5803_30_consts = {
+	.high_t2_multiplier = 7,
+	.high_t2_shift = 37,
+	.high_off2_multiplier = 1,
+	.high_off2_shift = 4,
+	.low_t2_multiplier = 3,
+	.low_t2_shift = 33,
+	.low_off2_multiplier = 3,
+	.low_off2_shift = 1,
+	.low_sens2_multiplier = 5,
+	.low_sens2_shift = 3,
+	.vlow_off2_multiplier = 7,
+	.vlow_sens2_multiplier = 4,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 16,
+	.off_shift = 7,
+	.sens_t1_shift = 15,
+	.sens_shift = 8,
+	.press_sens_shift = 21,
+	.press_shift = 13,
+	.press_scale = 100
+};
 
-static const struct ms_tp_data ms8607_data = {
-	.name = "ms8607-temppressure",
-	.hw = &ms5637_hw_data,
+static const struct ms_tp_data ms5803_30_data = { .name = "ms5803-30ba",
+						  .hw = &ms5803_hw_data,
+						  .comp_consts =
+							  &ms5803_30_consts };
+
+static const struct ms_tp_comp_consts ms5837_30_consts = {
+	.high_t2_multiplier = 7,
+	.high_t2_shift = 37,
+	.high_off2_multiplier = 1,
+	.high_off2_shift = 4,
+	.low_t2_multiplier = 3,
+	.low_t2_shift = 33,
+	.low_off2_multiplier = 3,
+	.low_off2_shift = 1,
+	.low_sens2_multiplier = 5,
+	.low_sens2_shift = 3,
+	.vlow_off2_multiplier = 7,
+	.vlow_sens2_multiplier = 4,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 16,
+	.off_shift = 7,
+	.sens_t1_shift = 15,
+	.sens_shift = 8,
+	.press_sens_shift = 21,
+	.press_shift = 13,
+	.press_scale = 100
 };
 
+static const struct ms_tp_data ms5837_30_data = { .name = "ms5837-30ba",
+						  .hw = &ms5803_hw_data,
+						  .comp_consts =
+							  &ms5837_30_consts };
+
 static const struct i2c_device_id ms5637_id[] = {
 	{"ms5637", (kernel_ulong_t)&ms5637_data },
 	{"ms5805", (kernel_ulong_t)&ms5805_data },
 	{"ms5837", (kernel_ulong_t)&ms5837_data },
 	{"ms8607-temppressure", (kernel_ulong_t)&ms8607_data },
+	{"ms5803", (kernel_ulong_t)&ms5803_01_data },
+	{"ms5803-01ba", (kernel_ulong_t)&ms5803_01_data },
+	{"ms5803-02ba", (kernel_ulong_t)&ms5803_02_data },
+	{"ms5803-05ba", (kernel_ulong_t)&ms5803_05_data },
+	{"ms5803-14ba", (kernel_ulong_t)&ms5803_14_data },
+	{"ms5803-30ba", (kernel_ulong_t)&ms5803_30_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ms5637_id);
 
 static const struct of_device_id ms5637_of_match[] = {
 	{ .compatible = "meas,ms5637", .data = &ms5637_data },
+	{ .compatible = "meas,ms5637-30ba", .data = &ms5637_30_data },
 	{ .compatible = "meas,ms5803", .data = &ms5803_data },
+	{ .compatible = "meas,ms5803-01ba", .data = &ms5803_01_data },
+	{ .compatible = "meas,ms5803-02ba", .data = &ms5803_02_data },
+	{ .compatible = "meas,ms5803-05ba", .data = &ms5803_05_data },
+	{ .compatible = "meas,ms5803-14ba", .data = &ms5803_14_data },
+	{ .compatible = "meas,ms5803-30ba", .data = &ms5803_30_data },
 	{ .compatible = "meas,ms5805", .data = &ms5805_data },
 	{ .compatible = "meas,ms5837", .data = &ms5837_data },
+	{ .compatible = "meas,ms5837-30ba", .data = &ms5837_30_data },
 	{ .compatible = "meas,ms8607-temppressure", .data = &ms8607_data },
 	{ }
 };
-- 
2.54.0

