Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55478476698
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235310; cv=none; b=OrQ7EMt2oko4jyq9gWZm8fpLiyjFi4SYpdOrz1xlV3MVH0dAmmDL9iAS1eOaQHfG5Yk+X76qPNhwj8GBLwNBL7K5HCVQzAph6vqM5H8tbfP1/Ae2R5ML/j6OtSGvDw4Z63Mc1mknSc6zm1INKS1Z0x+bBolud5UlopdYBVR1Oa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235310; c=relaxed/simple;
	bh=3+TVZr2jDyfkglVmXyTEbKP6JSEdBvn2vgzqUF3ezqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfWvH18dA/qbdq1nyQUBg+vseU60ZvvAWLmYdUckd4H5KO0Acu/zpOzUecmQldLycWuDcmOS4IwsBgQbOn5t0yeJ2ezf/BBWtTKiN3+DS4APUPsABC7iQbCovjWlqG9pGPXmb8UnFJJYoIKhQkQJXUm07OB5UanbfjN0EetBfDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oquEFL3N; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oquEFL3N"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e99ef0902so129831785a.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787235307; x=1787840107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M0R988lvJA1NCj2/4LcWBPCkPVxIVW7BCz8Nv/hR7YY=;
        b=oquEFL3NNUrFS38E1uAu3gwNyDRJ2/nOMDqOoOhw0+wsWi46oq215B5VDqFPbihTW8
         if7VhiGfYEyxsD0s/TmWLhHjG/5RY0lEiiVL/zKLwT+k7vsw4a9hKyGFR10bP44ZNjVb
         j/6J4DoYSrFXHtmat4yHdvPLTRqNMyi+6GhdkRtYGBJJVPECWe+kx7ThFZx/ETjMbwFK
         qJYKDdWYfOY5wRm1bPiZpavvN58+yAFVEIbYCFpLAjmBhOUuAVSFE37HDk3L39SMzrdj
         iOYyrbqSjynP3w19dhsaaXtwYAH1bmKtAFpEFLhJDpkvCBkX9LzNFVMz6z8JYBZEBUH6
         phpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787235307; x=1787840107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M0R988lvJA1NCj2/4LcWBPCkPVxIVW7BCz8Nv/hR7YY=;
        b=fPqEvGtxz9fbgVGDclSq1ugF/n65bCDpvF3VBAbDkuNBtu6zmi9MY4T258kqo5pHPH
         Aw5/4fjZ0BTWSHUqPRlRGe4DM73wVGhjzHShBqqmZkHabPDmcqeAaPt5Z9ntZS+e0XyO
         IaKBWEr2pg2AQm7AeFWJ0pcFw52GhRJsmbnNU7OnITJVzkQJqfx/4NN/p/hvzBg/oVXb
         hWQbWAfaj+O1jiZOLxMhRjma7mn62lW6twNZ6mTw0FGsm3Ci+47CK2bMcYa3cvdq8S+W
         P0jYgqhuyX2Lr/K/6vJIlhg/F/3YEmw/jyPMoM75E91bUW4Nz89WWIm52yskk7xxfUs4
         IiXA==
X-Forwarded-Encrypted: i=1; AHgh+RpqfnEYCrE26MQHiEPtmrh/qgkHZUsjFuQ7i1D5DlXKrpPbCfYb6LldMlFOLIHl5hE+7UlnmlEWUww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyFO1krozATkqu0dbFMlTf9/GSjlKyNywDvhBd1NZBMOLVz+Gn
	Vx725jnjbvBd53NrgSsTja634RxKSIGKchB+Fm1Z76Rhi6RmdujtoInL
X-Gm-Gg: AR+sD121pf67JRBrZBMwPzLAp9fnRDau8VUHw4Yz5QQCEh9X+rhX5B3BRctaM1SXEfB
	vkl+FZ6EefUzzGHJOypihcfxb6Pr5uQ67+aUnFRyYT9wBOp/jmxWRxgdmtBmHxE9XNnR4cJf5lI
	NIkoetkY/oW/gNw+vxhdXqGuZcasttjLK4XgNNpOSBsT/C6516ErFqusVFL4mu6BlNZk44XRCDV
	n9tO+lrdxZl2BJhjktIkf53AnUIqbubNYT4TUHVt7wX+iAQNOSY0O1UUxEeAOvSb9fF6A6JlrsK
	uD04wYlHJFFwN4OBg4LzfMsDiqCDyxFEAFI9kMFewEAjoHOoe0FJJZ3Sn+x8Ny8OUCmsM/KMzAz
	72icEHWmA8gcSZ3g2UROhR0jJjxA7TJGxCV+2LJ1nk/8lT/8So4tLE35MEh0v9bLoRI2OVrhC9V
	Uxpr0/+hxLZxRcbcGBBRCoa/BF69dOzQBNWIcr8PVshTK0ydQ989g6Kg+NnlSramjEfsTklz14l
	w==
X-Received: by 2002:a05:620a:6192:b0:92e:8aed:4785 with SMTP id af79cd13be357-9371e3001f2mr1300833685a.25.1787235305862;
        Thu, 20 Aug 2026 07:15:05 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9372059de87sm372738085a.47.2026.08.20.07.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:15:05 -0700 (PDT)
From: Louis Adamian <adamianlouis@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Louis Adamian <adamianlouis@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] iio: pressure: ms5637: Parameterise second order temperature compensation
Date: Thu, 20 Aug 2026 10:12:19 -0400
Message-ID: <20260820141224.23730-5-adamianlouis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820141224.23730-1-adamianlouis@gmail.com>
References: <20260820141224.23730-1-adamianlouis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The temperature compensation formula is shared across these sensors but
with different constants. Add ms_tp_comp_consts to capture these
per-device differences. Add pressure variant specific pressure scale
variable.

No functional change intended. IIO_VAL_FRACTIONAL prints 3 more decimal
places than IIO_VAL_INT_PLUS_MICRO, giving in_pressure_input 3 more
trailing zeros.

Signed-off-by: Louis Adamian <adamianlouis@gmail.com>
---
 .../iio/common/ms_sensors/ms_sensors_i2c.c    | 61 ++++++++++++-------
 .../iio/common/ms_sensors/ms_sensors_i2c.h    | 48 +++++++++++++++
 drivers/iio/pressure/ms5637.c                 | 61 ++++++++++++++++---
 3 files changed, 140 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index f9dc7c7468c1..20f019ae51fd 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -604,6 +604,38 @@ int ms_sensors_tp_read_prom(struct ms_tp_dev *dev_data)
 }
 EXPORT_SYMBOL_NS(ms_sensors_tp_read_prom, "IIO_MEAS_SPEC_SENSORS");
 
+/* apply second order temperature compensation */
+static void ms_tp_compensate(const struct ms_tp_comp_consts *c,
+			     s32 temp, s32 dt, s64 *t2, s64 *off2, s64 *sens2)
+{
+	s64 tmp;
+
+	if (temp < 2000) {
+		tmp = temp - 2000;
+		*t2 = (c->low_t2_multiplier * ((s64)dt * (s64)dt)) >>
+		      c->low_t2_shift;
+		*off2 = (c->low_off2_multiplier * tmp * tmp) >>
+			c->low_off2_shift;
+		*sens2 = (c->low_sens2_multiplier * tmp * tmp) >>
+			 c->low_sens2_shift;
+
+		if (temp < -1500) {
+			tmp = temp + 1500;
+			*off2 += c->vlow_off2_multiplier * tmp * tmp;
+			*sens2 += c->vlow_sens2_multiplier * tmp * tmp;
+		}
+	} else {
+		*sens2 = 0;
+		if (c->has_vhigh_temp && temp > 4500)
+			*sens2 -= (((s64)temp - 4500) * ((s64)temp - 4500)) >> 3;
+
+		*t2 = (c->high_t2_multiplier * ((s64)dt * (s64)dt)) >> c->high_t2_shift;
+		*off2 = (c->high_off2_multiplier *
+			 ((s64)temp - 2000) * ((s64)temp - 2000)) >>
+			c->high_off2_shift;
+	}
+}
+
 /**
  * ms_sensors_read_temp_and_pressure() - read temp and pressure
  * @dev_data:	pointer to temperature/pressure device data
@@ -619,6 +651,7 @@ int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
 				      int *temperature,
 				      unsigned int *pressure)
 {
+	const struct ms_tp_comp_consts *c = dev_data->data->comp_consts;
 	int ret;
 	u32 t_adc, p_adc;
 	s32 dt, temp;
@@ -654,37 +687,21 @@ int ms_sensors_read_temp_and_pressure(struct ms_tp_dev *dev_data,
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
index d9898098c066..e6e64111f2e7 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.h
@@ -35,14 +35,62 @@ struct ms_tp_hw_data {
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
  * struct ms_tp_data - Temperature/Pressure sensor data
  * @name: Device name
  * @hw: Sensor hardware data
+ * @comp_consts: Temperature compensation constants
  */
 struct ms_tp_data {
 	const char *name;
 	const struct ms_tp_hw_data *hw;
+	const struct ms_tp_comp_consts *comp_consts;
 };
 
 /**
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index 6009d87f3d4c..359f3a8e79b2 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -67,10 +67,9 @@ static int ms5637_read_raw(struct iio_dev *indio_dev,
 
 			return IIO_VAL_INT;
 		case IIO_PRESSURE:	/* in kPa */
-			*val = pressure / 1000;
-			*val2 = (pressure % 1000) * 1000;
-
-			return IIO_VAL_INT_PLUS_MICRO;
+			*val = pressure;
+			*val2 = dev_data->data->comp_consts->press_scale;
+			return IIO_VAL_FRACTIONAL;
 		default:
 			return -EINVAL;
 		}
@@ -195,17 +194,63 @@ static const struct ms_tp_hw_data ms5803_hw_data  = {
 	.max_res_index = 4
 };
 
-static const struct ms_tp_data ms5637_data = { .name = "ms5637", .hw = &ms5637_hw_data };
+/*
+ * MS5637-02BA03 compensation constants
+ * Datasheet: https://www.te.com/commerce/DocumentDelivery/DDEController?Action=showdoc&DocId=Data+Sheet%7FMS5637-02BA03%7FB1%7Fpdf%7FEnglish%7FENG_DS_MS5637-02BA03_B1.pdf
+ * Pages: 7-8
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
+static const struct ms_tp_data ms5637_data = {
+	.name = "ms5637",
+	.hw = &ms5637_hw_data,
+	.comp_consts = &ms5637_02_consts,
+};
 
-static const struct ms_tp_data ms5803_data = { .name = "ms5803", .hw = &ms5803_hw_data };
+static const struct ms_tp_data ms5803_data = {
+	.name = "ms5803",
+	.hw = &ms5803_hw_data,
+	.comp_consts = &ms5637_02_consts,
+};
 
-static const struct ms_tp_data ms5805_data = { .name = "ms5805", .hw = &ms5637_hw_data };
+static const struct ms_tp_data ms5805_data = {
+	.name = "ms5805",
+	.hw = &ms5637_hw_data,
+	.comp_consts = &ms5637_02_consts,
+};
 
-static const struct ms_tp_data ms5837_data = { .name = "ms5837", .hw = &ms5637_hw_data };
+static const struct ms_tp_data ms5837_data = {
+	.name = "ms5837",
+	.hw = &ms5637_hw_data,
+	.comp_consts = &ms5637_02_consts,
+};
 
 static const struct ms_tp_data ms8607_data = {
 	.name = "ms8607-temppressure",
 	.hw = &ms5637_hw_data,
+	.comp_consts = &ms5637_02_consts,
 };
 
 static const struct i2c_device_id ms5637_id[] = {
-- 
2.55.0

