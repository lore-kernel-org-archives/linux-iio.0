Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D96633C1AD
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772880548; cv=none; b=OM0lyo56cIZfuNE3tLUwpgrrD5pJIQak1slvhM3LtOvjsIJ1HAyRHk5sPfN3uv+veTt5DqzVkS558vrGjOcyXM+XtFw4ayshyCJPmoc8D4Mr2XQYEPmGFrvgS43psHYeuJ32ewOlx0BkKqnABZ0578j0C0s8i/bmfh18Hd+WQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772880548; c=relaxed/simple;
	bh=emadoXuR89k5VSOmxBshHtWFgpXfJdhFOciZ6tkiiaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDPmekdIRiTWnkBdudbeAuyxzKoou0ejTf1G8YtZIAhkb+bH5tS/fT6R3L1M4N5TAq+Ic9iviI+FTjK5BxiYPGfM2Zb2HmxfKBPOnS5RovjU+udGdVG54TA0hLShT/L53MYXHQ1dqzX0Sy4nzDEH4SvBq9PmPzJSg79dYh3u8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtoslBri; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtoslBri"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70f91776fcso4147266a12.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 02:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772880546; x=1773485346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjFXqCq46O9g1tLKTsXyBBTNLHuFT5sksPw6MkCiz4U=;
        b=LtoslBriWJ8maOzaqtLz3IjhaADJhBRQWInvgIYRZpQ9XFuOk6KIJbtc63UqwXWikd
         5L0PpXIVAIIBL8NSk2xdCEjEXCWqUcBJyK420s5ODrQ/GjOAX7IEY169pHomUdTKBpbU
         X1uBWKRYB1woK+PEVcvNAbkVo2yrULf49x5xnj8qeA2TNPvNxVAERJ8UnM+LbwRYz9bq
         dHOnU+SUCtAk43VEdH9IX8A1lLTYzxmmRk32mfaXwaIgNNgFQ+KuFawG93Df7n3/PNa+
         8OLpEO0YEfq1Ek0oBvuWo8Mf6vqBctMkhYqPNhkNDM6JNYab7tIHQCiftRi1LEuUOLHW
         RQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772880546; x=1773485346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZjFXqCq46O9g1tLKTsXyBBTNLHuFT5sksPw6MkCiz4U=;
        b=OUwrKW4f/gpcrf/UwlTl2XwactDS7aDpoNBL8nbRiiwwZM1inXP5rPcDFH7uHYY8ql
         4AKHiGnpRS1vZByyG14G6ltW58DK6iHE4W8E/zVR0P4Fl32binLynjDXbqSuAZ02KWe1
         U+TJyoA5+8sqn738rUdZv3JK0Z4OqS+asDPQNxxmOisSQHk2Rg1l5kcEBxB4vljKEyX8
         k8S2SrgMBC8ahPNFKlF5MF7lPq6wVty6RkYR8RsxDaDwyYE+S6EjFD5QojlTVbEGaz3q
         XI0LP8pVD+8Sb46KmOQRuDWHQNS3qall8u9CnnhZ4NwgfQLhhvCIbLx4sx9kKga7sAmt
         jSEw==
X-Forwarded-Encrypted: i=1; AJvYcCU/faHXJYv2ymD7Ut47xpvZUZ8tpyM8LffQNMyW3S/lKyA3HCyQ+4sPFcIgAxwV0km1L2pdC3IS/H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCNOrJwxnE11/ZqWtguiWZdmMoX4Q05sNxBm9xPK5+nE7FfHY
	LFPXYLiSHRykZhzm8dzLpede7EO5mlRGEVPqzLkz2okWocIRfNoCE4MB
X-Gm-Gg: ATEYQzwiXkpTWNM9VGQxsnw2v8eossY9iU6kx4YpGpIGm3I9hNw0yEsVqTPJde2W2Lt
	0XOOiYa8sJq7y43cYPI3lb/ttWvuHx0FFaYSfT+3y5xJI88NX/ivdwCptXkGCJkqIlFqr9+sc2J
	VUHUvDx7Zj7Fl+5s6/GNTDPYOrlWa9PzyVKkIU+LQzx66tnDcHu8K+ktM9UssqtTHlr10Cf46rq
	jLqgc7R9b2tLsJzF2v2cE6LFblclKJLLLtLsjyNlLkKbzQ0laszFR91Bri8Z22gmKOl8LfcSynf
	4jJZGEEfNOJYv8hCh67N59T7p5WNXltEna//FeC7Z+ZQNxkkSyWhNzWRwFvQTc3oQKJlNR9qpO3
	DQp/6kK2J2Ti24K224WGP/Hl3sXvGTVmaw6JFNjRZyAKvcToW2n2rCcYQUk7A8hm272yp/Mp/dw
	cyhskLXoFWLrRN1c72yneTjX7B
X-Received: by 2002:a17:903:2449:b0:2ae:8077:b1c1 with SMTP id d9443c01a7336-2ae82432268mr54104585ad.30.1772880546563;
        Sat, 07 Mar 2026 02:49:06 -0800 (PST)
Received: from fedora ([2401:4900:1c6a:49e5:cff6:c6fd:2f81:fb7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78d48sm49541235ad.22.2026.03.07.02.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:49:06 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com,
	i.shihao.999@gmail.com
Subject: [PATCH v2 6/6] iio: common: fix spelling mistakes in comments
Date: Sat,  7 Mar 2026 16:17:05 +0530
Message-ID: <20260307104705.49129-7-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307104705.49129-1-i.shihao.999@gmail.com>
References: <20260307104705.49129-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix incorrect spelling in comments

- exepects -> expects
- fuction -> function
- theoritical -> theoretical
- appopriate -> appropriate

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c   | 2 +-
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 82cef4a12442..af8563fde0a3 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -106,7 +106,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
		switch (st->core.type) {
		case MOTIONSENSE_TYPE_ACCEL:
			/*
-			 * EC returns data in g, iio exepects m/s^2.
+			 * EC returns data in g, iio expects m/s^2.
			 * Do not use IIO_G_TO_M_S_2 to avoid precision loss.
			 */
			*val = div_s64(val64 * 980665, 10);
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index a61428bfdce3..c115a72832b2 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -346,7 +346,7 @@ int hid_sensor_write_raw_hyst_rel_value(struct hid_sensor_common *st,
 EXPORT_SYMBOL_NS(hid_sensor_write_raw_hyst_rel_value, "IIO_HID");

 /*
- * This fuction applies the unit exponent to the scale.
+ * This function applies the unit exponent to the scale.
  * For example:
  * 9.806650000 ->exp:2-> val0[980]val1[665000000]
  * 9.000806000 ->exp:2-> val0[900]val1[80600000]
diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 97526ba87b93..4e50c03410d9 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -154,7 +154,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
		valid = inv_update_chip_period(ts, period);
	}

-	/* no previous data, compute theoritical value from interrupt */
+	/* no previous data, compute theoretical value from interrupt */
	if (ts->timestamp == 0) {
		/* elapsed time: sensor period * sensor samples number */
		interval = (int64_t)ts->period * (int64_t)sample_nb;
diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 588470863681..1960a2ce82a8 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -96,7 +96,7 @@ EXPORT_SYMBOL_NS(ms_sensors_read_prom_word, "IIO_MEAS_SPEC_SENSORS");
  *
  * Generic ADC conversion & read function for Measurement Specialties
  * devices.
- * The function will issue conversion command, sleep appopriate delay, and
+ * The function will issue conversion command, sleep appropriate delay, and
  * issue command to read ADC.
  *
  * Return: 0 on success, negative errno otherwise.
--
2.53.0
