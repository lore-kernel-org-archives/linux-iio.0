Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5ED3932DA
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053189; cv=none; b=QTgisGwJWAZ6ZvAP3dR1IM9dC1mnlAp4JyYLMLrui5kW4xDD5jDO8Vnvdjo3dwjjYbDGAy/lOZXTMbFYAkxv5VO5M/S2q23oOVBacN/P77wQ2eW6znSz2HGThFz/mh4XpyaG3MPuhoJeekFn3tnkIVCARDSdNx9urxdFW/5TQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053189; c=relaxed/simple;
	bh=emadoXuR89k5VSOmxBshHtWFgpXfJdhFOciZ6tkiiaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uW1nG7ZWFuoDuTYzFQmn0UNFyyS/i1OvN4WYT0XSK0QMdtCWJkM9k09Enol75PVUCNtcuL6ZqJ8JYaW+5scS91JUD8FLpjEg3bve38OZL2rOUoTSwZSXhTfMohlamBtFxKet7VV8KDKhrYMLnTXVTWDJb7SzJrMxBNJQKUvYzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQPzbftn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQPzbftn"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8296d553142so2486056b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 03:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773053184; x=1773657984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjFXqCq46O9g1tLKTsXyBBTNLHuFT5sksPw6MkCiz4U=;
        b=PQPzbftnmU7jKfynLCAhs1jEOd8hBDriV5vWmLpvjtBr9a12oaZzdx3Ghof3q/X6aS
         DV1gpVOZTCwl+wYcdbosV8JOkQljOX2MFdo9ifvEjgSk3rNPpBnLQ915zGYn9k2zIA2c
         pCP5cGYKP/EpHfwKqbOcgGvSJrJm/UFqoYRLS2cXPkysBldcChCZSfAuHlq4mebj/wzo
         f9o9yNXA23tOY4Ug5bHJShkBYvNgptykJyghZYxy0WtNTbhsAvEgxMlLiaWvm6UvC6Oy
         COAfedm6n5MFVDlFo0/sPQj/ztTeyc9YZKjIsRhxBkrCtiU+qqStvTBHSLIm5dnI42Lm
         QUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773053184; x=1773657984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZjFXqCq46O9g1tLKTsXyBBTNLHuFT5sksPw6MkCiz4U=;
        b=OZB/RbakvTxrs2GY0MnO6wiZrhoJZTfuJgDL5y5KfDZTYqhLZ6W0AZ0YFEbOm+6ive
         eUohabkfbCheQHUae/CnVce+Zmpch/ZB03z33g5DcvZ7p9ZIkmv5r9XA429VA0JI9gsf
         K4YEX0mYcdCaIKkeZNYRF22zEzUuvDp5DWVdhmTOKnELDDQE9S0I552EslvcLXxq2lKs
         lv/bOZHwG3jLUGlHEFzwWu67t5HmL+LyrKPApz/uJhWdtU8mwYik9LNOGwRQmZfyRZwI
         ZsqydRGHDBT498QqjCcdxkiYUqFK/Dx9j4Fbde8BNtSzkswVYUVvwsALDbzG57WtJP88
         3m3w==
X-Forwarded-Encrypted: i=1; AJvYcCUWoqkxOjujaHPH+V19xPhOKCP/VJ0HBeIWkpeGPNMfcOhg3bzoOazS+Osb/OtF/q6Ri43H3LQsIJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvqIvgViJmr+RZaOcUt7w0myEf0US9V08AVVraxfdzSXdR8XY9
	/TRCqR5s3xknHGr9VwUD5i+QwzAE7rC7T9ZjddPobzeUX8EA+sBDW0GJ
X-Gm-Gg: ATEYQzxxyRywX4+T99fdqWdxWJSwEAvBzWhPFvF+8sFtNfYWgRiu6UgKlFa+EbLecjQ
	2sJ3Z6LJbFyLoU/G0CHgkjx/buYFgC92lcOx47gfoyFy6A6tR2znBrAj9U9+/+6YiErCKNkY2rg
	AQQmLqSQAtOVdyyYRZyRjub/rfF6EhNwx4saYWVYzYeoTvE7wQIK95CbZAu5WaNexMn4/XwJ8IW
	0JsE3XO8K1/nLjOJo2eWNXrAe+t57Tuu5Ld/JmLQnJnYHzTLjU0evOWMp2KsbXKiGGJBVW+vvZF
	ztTJ2klsWc2aDE+c7d3CFpMUjrpGIl03cG1W0et+Qqg7oUvKyY++UAsX/Bf8ounSykXDOCMG5eI
	mTd2xex1nwuQI7BLhsukcDWOA+jDdhWexfeXghtoDCWmhJlFqS5rwFSGwACoxYE2ZwfoyYHi98O
	wrGHv+y9fvjEOH+ttHZBAsv7SV
X-Received: by 2002:a05:6a00:882:b0:827:3b1b:43e5 with SMTP id d2e1a72fcca58-829a2f8730dmr8895502b3a.47.1773053183685;
        Mon, 09 Mar 2026 03:46:23 -0700 (PDT)
Received: from fedora ([2401:4900:1f32:2ea1:a1a7:f2aa:545b:3c1e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4657445sm10276143b3a.17.2026.03.09.03.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 03:46:23 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v3 6/6] iio: common: fix spelling mistakes in comments
Date: Mon,  9 Mar 2026 16:15:13 +0530
Message-ID: <20260309104513.40359-7-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309104513.40359-1-i.shihao.999@gmail.com>
References: <20260309104513.40359-1-i.shihao.999@gmail.com>
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
