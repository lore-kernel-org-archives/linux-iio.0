Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C42D7DC6
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781057117; cv=none; b=d4IvyRdQMH70UMLpy9CLn6Ksw8ReB8xxPhktaek8oGO/wggVTrz1DmghTMe3ntN0nu3M4Vo1Se/Dl3n98K5/QWRugTNtVfoOPbYaXlzvWR+wImY5mh09Kjn+DpBJZVSiD0sxL+9WeovAbRdL42sKPOFnqLXtdYHbZDw5ATh4oPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781057117; c=relaxed/simple;
	bh=1dEN0pdoBi/KoXM0cpZ/zrNU505YVV+kFjxTHvCi9j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMcBFv6bOINkjwfkOmY4i9tSlPbWi76d0DsV8e+JWpPAKA4o7RLTO+/aL2qPTRTkramXYtPJ94c+3kYa9486WtTAMmXCPoKVNEz1L4WeSBYF4C7DiUBRZOr72/Nbl1f+nDu4FVIV1TA9W+Br18eSOqX6iCOhIwOPDM4EB75xfhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peRXUp+m; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peRXUp+m"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9159da9bba5so449057885a.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 19:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781057113; x=1781661913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FweqRCjQCw3lz+AS07ddD9dpKIg1dBTDl8QMGyemSig=;
        b=peRXUp+mq6vEBeGXbKCZDFOBWjM/51FP0LSgG/cASWLgJHCuGEwjqy2R2Hv34NT4mO
         YGQb3UQS+xbeWsl2eVQW6mfeQnRqOVU0oMh+c8bOv4qa3KuNYBgos8v7qhlS1eXuPR/U
         CcQ9OTZGoDPqJjM1l6mD9XqLNBjsDdHNAhKLjeGUKSV2/Ttz30nAzKo7jGXQpl0YJu8a
         XVO2O1WPr8au3+D+37joLK8grwqDj3qtbBYdaNP9pnW+7gS3bfTSbq3booWhInRhccL5
         c6XDJCl8eRXWwLTSz/6VK+mg6LaFKXSa27BCWM9N6v+UCEMGL8N/u9Qls15YHedtvt2p
         8axg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781057113; x=1781661913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FweqRCjQCw3lz+AS07ddD9dpKIg1dBTDl8QMGyemSig=;
        b=jzjSz4Mh+zaCF5Z4HqkvdEak2xOvrJHNcrm2UCaGxDg/YQ6fGyUCT/BoLJJTgZYgV0
         6XmYyv0UCfVRdzpvncVAhuPh4++00EoVPXkk1NMuUycAGQulOG4FYoxO4VlxXJedTDqD
         kC35ueaGuIyvz97Sn3IyIh8bF32mE3/OOcH8K5+ZnBp/yRCQOeh6K5sPlN+D3cgjcWdL
         vivt7OeNV/dZei8lofpo4nDLt+Giuf8FJqU76xWgYvp21UxTNf2fQ6y1+otsokylB/zW
         nGJvDooAqdoVcto85fd/3mCcYQlMGxa0jym/6M3x19C/Hzjoyh9AJrx8jn3vk6NNpK+o
         jpoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8CJJTGlKBnhqk+CL/ycl9FSPL8/JmwuapzbZZbeAKDh5frS4RarqnCuTBWFmHEQ1v9yAyozHq9X3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOWgvSCDwGJAfqX9Jxfdkge4bL/WUbZEvtaXxx13L5HZpmgWK
	tyyxg9ICU/aklevCWGm9yApC5izAmUp7fqUK3t33Wsp1RE2jLxwKdBoh
X-Gm-Gg: Acq92OG+mIZBC6UlX+k1Wvcp1wxr9C+soJTRmggJqk8BUZWMeH/qx8TuvnZoKeCrlDE
	h+NGHyjUKGgjuuMSDU9yhOru0U+RSlJVTT2e/vWPNiwsZCpVvo/ZuUc9XdPVG0DA/ASGTUvcNGD
	L63XLRTBZ7pdmZar1X4qdr7UvZu2m2aG5iVt8JgpBViCDNV7cEx+ie93DzcUGZ7eQX/RxNyRhjs
	4AIZCOXuK1t6RYtmRbgHqoob5eDfFRIPnrv3KnoYd+NZWIcG/ZrXZBg+LRDQOMduwDrxHVVU5WK
	Dn7ZUE67MzyDZuXOxnoAdeFG7psxgj6qeLGsakEK/X9mAWKfaw0XYqbCB2hgXLPpTT0ywE17hqj
	jugC9vOdPQn5Md9Tq3AKplgttem+CojN+msjDmwdnVlPUGvn62FtyJR6d/0anMsEOXs2JWidUSA
	7H2awMiUvBbWjGWVDEDDRx+KTQxOALOImJu5wrY0jBLhoS6HQ=
X-Received: by 2002:a05:620a:8396:b0:915:9015:3413 with SMTP id af79cd13be357-915a9de9ff4mr3861846085a.57.1781057113279;
        Tue, 09 Jun 2026 19:05:13 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a40d566sm2267004985a.47.2026.06.09.19.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 19:05:12 -0700 (PDT)
From: Louis Adamian <adamianlouis@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Louis Adamian <adamianlouis@gmail.com>
Subject: [PATCH v2 2/2] iio: pressure: ms5637: Add variant specific temperature compensation
Date: Tue,  9 Jun 2026 22:04:58 -0400
Message-ID: <20260610020458.104818-3-adamianlouis@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610020458.104818-1-adamianlouis@gmail.com>
References: <20260610020458.104818-1-adamianlouis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add correct temperature compensation for ms5637-30BA, MS5803-01BA,02BA,
05BA, 14BA, 30BA, MS5837-30BA. The temperature compensation formula is
shared across these sensors but with different constants. Add
ms_tp_comp_consts to capture these per-device differences. Add pressure
variant specific pressure scale variable.

Signed-off-by: Louis Adamian <adamianlouis@gmail.com>
---
 .../iio/common/ms_sensors/ms_sensors_i2c.c    |  62 ++-
 .../iio/common/ms_sensors/ms_sensors_i2c.h    |  48 +++
 drivers/iio/pressure/ms5637.c                 | 388 +++++++++++++++++-
 3 files changed, 465 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 1960a2ce82a8..d5e217d7ba0b 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -604,6 +604,39 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
 }
 EXPORT_SYMBOL_NS(ms_sensors_tp_read_prom, "IIO_MEAS_SPEC_SENSORS");
 
+/* apply second order temperature compensation */
+static void ms_tp_compensate(const struct ms_tp_comp_consts *c,
+			     s32 temp, s32 dt, s64 *t2, s64 *off2, s64 *sens2)
+{
+	if (temp < 2000) {
+		s64 tmp = (s64)temp - 2000;
+
+		*t2 = (c->low_t2_multiplier * ((s64)dt * (s64)dt)) >>
+		      c->low_t2_shift;
+		*off2 = (c->low_off2_multiplier * tmp * tmp) >>
+			c->low_off2_shift;
+		*sens2 = (c->low_sens2_multiplier * tmp * tmp) >>
+			 c->low_sens2_shift;
+
+		if (temp < -1500) {
+			s64 tmp_vlow = (s64)temp + 1500;
+			*off2 += c->vlow_off2_multiplier * tmp_vlow * tmp_vlow;
+			*sens2 +=
+				c->vlow_sens2_multiplier * tmp_vlow * tmp_vlow;
+		}
+	} else {
+		*sens2 = 0;
+		if (c->has_vhigh_temp && temp > 4500)
+			*sens2 -= (((s64)temp - 4500) * ((s64)temp - 4500)) >> 3;
+
+		*t2 = (c->high_t2_multiplier * ((s64)dt * (s64)dt)) >>
+		      c->high_t2_shift;
+		*off2 = (c->high_off2_multiplier *
+			 ((s64)temp - 2000) * ((s64)temp - 2000)) >>
+			c->high_off2_shift;
+	}
+}
+
 /**
  * ms_sensors_read_temp_and_pressure() - read temp and pressure
  * @dev_data:	pointer to temperature/pressure device data
@@ -624,6 +657,7 @@ int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
 	s32 dt, temp;
 	s64 off, sens, t2, off2, sens2;
 	u16 *prom = dev_data->prom, delay;
+	const struct ms_tp_comp_consts *c = dev_data->comp_consts;
 
 	mutex_lock(&dev_data->lock);
 	delay = ms_sensors_tp_conversion_time[dev_data->res_index];
@@ -654,37 +688,21 @@ int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
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
+	ms_tp_compensate(c, temp, dt, &t2, &off2, &sens2);
 
 	/* OFF = OFF_T1 + TCO * dT */
-	off = (((s64)prom[2]) << 17) + ((((s64)prom[4]) * (s64)dt) >> 6);
+	off = (((s64)prom[2]) << c->off_t1_shift) +
+	      ((((s64)prom[4]) * (s64)dt) >> c->off_shift);
 	off -= off2;
 
 	/* Sensitivity at actual temperature = SENS_T1 + TCS * dT */
-	sens = (((s64)prom[1]) << 16) + (((s64)prom[3] * dt) >> 7);
+	sens = (((s64)prom[1]) << c->sens_t1_shift) +
+	       (((s64)prom[3] * dt) >> c->sens_shift);
 	sens -= sens2;
 
 	/* Temperature compensated pressure = D1 * SENS - OFF */
 	*temperature = (temp - t2) * 10;
-	*pressure = (u32)(((((s64)p_adc * sens) >> 21) - off) >> 15);
+	*pressure = (u32)(((((s64)p_adc * sens) >> c->press_sens_shift) - off) >> c->press_shift);
 
 	return 0;
 }
diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
index f15b973f27c6..0d3b68e03c8f 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
@@ -35,6 +35,52 @@ struct ms_tp_hw_data {
 	u8 max_res_index;
 };
 
+/**
+ * struct ms_tp_comp_consts - Temperature compensation constants
+ * @press_scale: pressure scale
+ * @high_t2_multiplier: multiplier for t2 in high temperature state
+ * @high_t2_shift: bit shift for t2 in high temperature state
+ * @high_off2_multiplier: multiplier for off2 in high temperature state
+ * @high_off2_shift: bit shift for off2 in high temperature state
+ * @low_t2_multiplier: multiplier for t2 in low temperature state
+ * @low_t2_shift: bit shift for t2 in low temperature state
+ * @low_off2_multiplier: multiplier for off2 in low temperature state
+ * @low_off2_shift: bit shift for off2 in low temperature state
+ * @low_sens2_multiplier: multiplier for sens2 in low temperature state
+ * @low_sens2_shift: bit shift for sens2 in low temperature state
+ * @vlow_off2_multiplier: multiplier for value added to off2 in very low temperature state
+ * @vlow_sens2_multiplier: multiplier for value added to sens2 in very low temperature state
+ * @has_vhigh_temp: has very high temperature compensation logic
+ * @off_t1_shift: temperature offset t1 bit shift
+ * @off_shift: temperature offset shift
+ * @sens_t1_shift: temperature sensitivity t1 shift
+ * @sens_shift: temperature sensitivity shift
+ * @press_sens_shift: pressure sensitivity shift
+ * @press_shift: pressure shift
+ */
+struct ms_tp_comp_consts {
+	u32 press_scale;
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
+};
+
 /**
  * struct ms_tp_dev - Temperature/Pressure sensor device structure
  * @client:	i2c client
@@ -42,6 +88,7 @@ struct ms_tp_hw_data {
  * @prom:	array of PROM coefficients used for conversion. Added element
  *              for CRC computation
  * @res_index:	index to selected sensor resolution
+ * @comp_consts: temperature compensation constants
  */
 struct ms_tp_dev {
 	struct i2c_client *client;
@@ -49,6 +96,7 @@ struct ms_tp_dev {
 	const struct ms_tp_hw_data *hw;
 	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB];
 	u8 res_index;
+	const struct ms_tp_comp_consts *comp_consts;
 };
 
 int ms_sensors_reset(void *cli, u8 cmd, unsigned int delay);
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 03945a4fc718..36bda9694b4c 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -33,6 +33,7 @@
 struct ms_tp_data {
 	const char *name;
 	const struct ms_tp_hw_data *hw;
+	const struct ms_tp_comp_consts *comp_consts;
 };
 
 static const int ms5637_samp_freq[6] = { 960, 480, 240, 120, 60, 30 };
@@ -73,8 +74,10 @@ static int ms5637_read_raw(struct iio_dev *indio_dev,
 
 			return IIO_VAL_INT;
 		case IIO_PRESSURE:	/* in kPa */
-			*val = pressure / 1000;
-			*val2 = (pressure % 1000) * 1000;
+			*val = pressure / dev_data->comp_consts->press_scale;
+			*val2 = (pressure %
+				 (s64)dev_data->comp_consts->press_scale) *
+				(1000000 / dev_data->comp_consts->press_scale);
 
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
@@ -171,6 +174,7 @@ static int ms5637_probe(struct i2c_client *client)
 	dev_data->res_index = data->hw->max_res_index;
 	dev_data->hw = data->hw;
 	mutex_init(&dev_data->lock);
+	dev_data->comp_consts = data->comp_consts;
 
 	indio_dev->info = &ms5637_info;
 	indio_dev->name = data->name;
@@ -201,33 +205,395 @@ static const struct ms_tp_hw_data ms5803_hw_data  = {
 	.max_res_index = 4
 };
 
-static const struct ms_tp_data ms5637_data = { .name = "ms5637", .hw = &ms5637_hw_data };
+/*
+ * MS5637-02BA03 compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=showdoc&DocId=Data+Sheet%7FMS5637-02BA03%7FB1%7Fpdf%7FEnglish%7FENG_DS_MS5637-02BA03_B1.pdf
+ * Pages: 8-9
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5637_02_consts = {
+	.press_scale = 1000,
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
+};
+
+static const struct ms_tp_data ms5637_02_data = {
+	.name = "ms5637-02ba",
+	.hw = &ms5637_hw_data,
+	.comp_consts = &ms5637_02_consts,
+};
+
+/*
+ * MS5637-30BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=showdoc&DocId=Data+Sheet%7FMS5637-30BA%7FA3%7Fpdf%7FEnglish%7FENG_DS_MS5637-30BA_A3.pdf
+ * Pages: 8-9
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5637_30_consts = {
+	.press_scale = 100,
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
+};
 
-static const struct ms_tp_data ms5803_data = { .name = "ms5803", .hw = &ms5803_hw_data };
+static const struct ms_tp_data ms5637_30_data = {
+	.name = "ms5637-30ba",
+	.hw = &ms5637_hw_data,
+	.comp_consts = &ms5637_30_consts,
+};
 
-static const struct ms_tp_data ms5805_data = { .name = "ms5805", .hw = &ms5637_hw_data };
+/*
+ * MS5803-01BA compensation Constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5803-01BA&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf
+ * Pages: 13-14
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5803_01_consts = {
+	.press_scale = 1000,
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
+};
 
-static const struct ms_tp_data ms5837_data = { .name = "ms5837", .hw = &ms5637_hw_data };
+static const struct ms_tp_data ms5803_01_data = {
+	.name = "ms5803-01ba",
+	.hw = &ms5803_hw_data,
+	.comp_consts = &ms5803_01_consts,
+};
+
+/*
+ * MS5803-02BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5803-02BA&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf
+ * Pages: 13-14
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5803_02_consts = {
+	.press_scale = 1000,
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
+};
+
+static const struct ms_tp_data ms5803_02_data = {
+	.name = "ms5803-02ba",
+	.hw = &ms5803_hw_data,
+	.comp_consts = &ms5803_02_consts,
+};
+
+/*
+ * MS5803-05BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5803-05BA&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=MS580305BA01-00
+ * Pages: 13-14
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5803_05_consts = {
+	.press_scale = 1000,
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
+};
+
+static const struct ms_tp_data ms5803_05_data = {
+	.name = "ms5803-05ba",
+	.hw = &ms5803_hw_data,
+	.comp_consts = &ms5803_05_consts,
+};
+
+/*
+ * MS5803-14BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5803-14BA&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=MS580314BA01-50
+ * Pages: 13-14
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5803_14_consts = {
+	.press_scale = 100,
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
+};
+
+static const struct ms_tp_data ms5803_14_data = {
+	.name = "ms5803-14ba",
+	.hw = &ms5803_hw_data,
+	.comp_consts = &ms5803_14_consts,
+};
+
+/*
+ * MS5803-30BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5803-30BA&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=MS580330BA01-00
+ * Pages: 13-14
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5803_30_consts = {
+	.press_scale = 100,
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
+};
+
+static const struct ms_tp_data ms5803_30_data = {
+	.name = "ms5803-30ba",
+	.hw = &ms5803_hw_data,
+	.comp_consts = &ms5803_30_consts,
+};
+
+/*
+ * MS5805-02BA01 compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5805-02BA01&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=MS580502BA01-50
+ * Pages: 8-9
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5805_consts = {
+	.press_scale = 1000,
+	.high_t2_multiplier = 0,
+	.high_t2_shift = 0,
+	.high_off2_multiplier = 0,
+	.high_off2_shift = 0,
+	.low_t2_multiplier = 11,
+	.low_t2_shift = 35,
+	.low_off2_multiplier = 31,
+	.low_off2_shift = 3,
+	.low_sens2_multiplier = 63,
+	.low_sens2_shift = 5,
+	.vlow_off2_multiplier = 0,
+	.vlow_sens2_multiplier = 0,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 17,
+	.off_shift = 6,
+	.sens_t1_shift = 16,
+	.sens_shift = 7,
+	.press_sens_shift = 21,
+	.press_shift = 15,
+};
+
+static const struct ms_tp_data ms5805_data = {
+	.name = "ms5805",
+	.hw = &ms5637_hw_data,
+	.comp_consts = &ms5805_consts,
+};
+
+/*
+ * MS5837-02BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5837-02BA01&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=20000979-00
+ * Pages: 7-8
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5837_02_consts = {
+	.press_scale = 1000,
+	.high_t2_multiplier = 0,
+	.high_t2_shift = 0,
+	.high_off2_multiplier = 0,
+	.high_off2_shift = 0,
+	.low_t2_multiplier = 11,
+	.low_t2_shift = 35,
+	.low_off2_multiplier = 31,
+	.low_off2_shift = 3,
+	.low_sens2_multiplier = 63,
+	.low_sens2_shift = 5,
+	.vlow_off2_multiplier = 0,
+	.vlow_sens2_multiplier = 0,
+	.has_vhigh_temp = false,
+	.off_t1_shift = 17,
+	.off_shift = 6,
+	.sens_t1_shift = 16,
+	.sens_shift = 7,
+	.press_sens_shift = 21,
+	.press_shift = 15,
+};
+
+static const struct ms_tp_data ms5837_02_data = {
+	.name = "ms5837-02ba",
+	.hw = &ms5637_hw_data,
+	.comp_consts = &ms5837_02_consts,
+};
 
 static const struct ms_tp_data ms8607_data = {
 	.name = "ms8607-temppressure",
 	.hw = &ms5637_hw_data,
+	.comp_consts = &ms5637_02_consts,
+};
+
+/*
+ * MS5837-30BA compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=srchrtrv&DocNm=MS5837-30BA&DocType=Data%20Sheet&DocLang=English&DocFormat=pdf&PartCntxt=MS583730BA01-50
+ * Pages: 11-12
+ * Sections: Pressure and Temperature Calculation, Second Order Temperature Compensation
+ */
+static const struct ms_tp_comp_consts ms5837_30_consts = {
+	.press_scale = 100,
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
+};
+
+static const struct ms_tp_data ms5837_30_data = {
+	.name = "ms5837-30ba",
+	.hw = &ms5637_hw_data,
+	.comp_consts = &ms5837_30_consts,
 };
 
 static const struct i2c_device_id ms5637_id[] = {
-	{ .name = "ms5637", .driver_data = (kernel_ulong_t)&ms5637_data },
+	{ .name = "ms5637", .driver_data = (kernel_ulong_t)&ms5637_02_data },
+	{ .name = "ms5637-02ba", .driver_data = (kernel_ulong_t)&ms5637_02_data },
+	{ .name = "ms5637-30ba", .driver_data = (kernel_ulong_t)&ms5637_30_data },
+	{ .name = "ms5803", .driver_data = (kernel_ulong_t)&ms5803_02_data },
+	{ .name = "ms5803-01ba", .driver_data = (kernel_ulong_t)&ms5803_01_data },
+	{ .name = "ms5803-02ba", .driver_data = (kernel_ulong_t)&ms5803_02_data },
+	{ .name = "ms5803-05ba", .driver_data = (kernel_ulong_t)&ms5803_05_data },
+	{ .name = "ms5803-14ba", .driver_data = (kernel_ulong_t)&ms5803_14_data },
+	{ .name = "ms5803-30ba", .driver_data = (kernel_ulong_t)&ms5803_30_data },
 	{ .name = "ms5805", .driver_data = (kernel_ulong_t)&ms5805_data },
-	{ .name = "ms5837", .driver_data = (kernel_ulong_t)&ms5837_data },
+	{ .name = "ms5837", .driver_data = (kernel_ulong_t)&ms5837_02_data },
+	{ .name = "ms5837-02ba", .driver_data = (kernel_ulong_t)&ms5837_02_data },
+	{ .name = "ms5837-30ba", .driver_data = (kernel_ulong_t)&ms5837_30_data },
 	{ .name = "ms8607-temppressure", .driver_data = (kernel_ulong_t)&ms8607_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ms5637_id);
 
 static const struct of_device_id ms5637_of_match[] = {
-	{ .compatible = "meas,ms5637", .data = &ms5637_data },
-	{ .compatible = "meas,ms5803", .data = &ms5803_data },
+	{ .compatible = "meas,ms5637", .data = &ms5637_02_data },
+	{ .compatible = "meas,ms5637-02ba", .data = &ms5637_02_data },
+	{ .compatible = "meas,ms5637-30ba", .data = &ms5637_30_data },
+	{ .compatible = "meas,ms5803", .data = &ms5803_02_data },
+	{ .compatible = "meas,ms5803-01ba", .data = &ms5803_01_data },
+	{ .compatible = "meas,ms5803-02ba", .data = &ms5803_02_data },
+	{ .compatible = "meas,ms5803-05ba", .data = &ms5803_05_data },
+	{ .compatible = "meas,ms5803-14ba", .data = &ms5803_14_data },
+	{ .compatible = "meas,ms5803-30ba", .data = &ms5803_30_data },
 	{ .compatible = "meas,ms5805", .data = &ms5805_data },
-	{ .compatible = "meas,ms5837", .data = &ms5837_data },
+	{ .compatible = "meas,ms5837", .data = &ms5837_02_data },
+	{ .compatible = "meas,ms5837-02ba", .data = &ms5837_02_data },
+	{ .compatible = "meas,ms5837-30ba", .data = &ms5837_30_data },
 	{ .compatible = "meas,ms8607-temppressure", .data = &ms8607_data },
 	{ }
 };
-- 
2.54.0

