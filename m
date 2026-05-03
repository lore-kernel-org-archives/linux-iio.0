Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75241E5B9A
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777778244; cv=none; b=gGZgbKG771L0NS76U87v9/1O6nCbWHuafAVyMx5X5dh9iijE8rkBGcSLxsFc1cxeteVJCUUikOeJJpJAwvVpj+GOC1BlaID/in6MigCE0+VZ0elFs+hXKei8mYFbgZVkaXCgHg6cXZuiQyddtk3wEe65vej4mGTdqd91u8nF5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777778244; c=relaxed/simple;
	bh=xE/SJcucXlbRhRTif4rXuad66M8UPkAoaRKfTZ7UsQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L6fWmVR7WwsOlrv7pHGUE/j6sODRglua+IETVq5hv/FhNVH7ovmDZHq2Tamj+h36jpRlKHIIrqoy5qGo7HNb1YshvArhpSlkJJ3plB59pOV3jG7W2xKB7M7nmBAouGs5QoW29E2M9y2E59ZaxVFn/HS2KWR01pBCt1gOVxNpLj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=G3TX8W8Y; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="G3TX8W8Y"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-610aadb2d9fso978430137.0
        for <linux-iio@vger.kernel.org>; Sat, 02 May 2026 20:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777778239; x=1778383039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0DwtaxtSHhfjAI2k3a1Ffh9EszGTcoyMxIqUrnN+hP8=;
        b=G3TX8W8YGCUgiYu0UPMZo5GV4OeN7uBwr1HEtMESDNa+mhHPd+jr0WAJVQpz3QkQ8C
         ZCQ+oCi0XHIqSiCn/u7GDTYs/+ln+aZI8CebNyhs50CZ66er8wfpz8jTyZ+lhm74lz6E
         tHkPmN1aeOHcOpKtaqzqRJpK3LTaRUVU0sYuQeJp4XXFLMxqZ7xfmepAY6aaYdj0+80n
         i070ny6kS0jBudLBMrLMNWzs+KPG92o7iLT98PFtcmAeeiz16Kaky66+V7gH3a6ZaSFr
         fWgWm6cA9FlSDey6XTfask3wysItyeec70cDFQb1UOJMkdnfKHC90qFyUuVPHW9cG53K
         B3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777778239; x=1778383039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DwtaxtSHhfjAI2k3a1Ffh9EszGTcoyMxIqUrnN+hP8=;
        b=JupYlLpVdJGST0pZKMyMG9GZQmhfF5HhKqdb8f1i/CR+5fhqR12hVJFwXSPugEE44Y
         cveoGW7A540tGw2y75FpJVfmzZqYSy6SxCCm/W557RX0z5rcVLiRy05+NdWtYlBzjPkt
         p9x9Gv1ihHifYht7PQCfoP5h8o9FMF1rvRmSUe1nu0Sv168rEMZ0K5IClJmWIjS6oVGv
         NmB4KIGBeOp3HdmlU+eeV2AkmK1lzC1M41nW0Gl31E76LErVZ9KP8WRORphFs9RjBcEX
         wm83cUGE+5GN3LCXzDqNszyvSaLAPxpe3PXYKhmru6+rlffmO5rsUYy2wjpTf/f2T9El
         fJAw==
X-Forwarded-Encrypted: i=1; AFNElJ9eXGFP27J0pnWCPxfWmlrVQnJPMMDKOrag/6vTS1KiZ/6s+SUsxaOE7/EUCGCjFpbSBIT8WxDpp0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXKOBBaY+hoGVbW682cWCc1R4Ryfm/TqY9PCqt7sboBk1xF7LD
	8ilaje54doehwql03liTyiDRmCAuQwVdOmBj56bTbvbNlQZLO+41A6ZY16zpo3Ous8I=
X-Gm-Gg: AeBDietIAHpQRja3IIUVGcz3mc+QMw3UTwdXyHtsHD19RwoU2PUdhLMuL8jj612/TnW
	kVqZGu0jw2HfarUqx3qLMyU6n9nNMSamDHnRVOdPMTCv70XMR+/41OtlaTN9dHB+TDajgH87aQZ
	qdIVtLN7faFaKgrvWR9hjcNzbrTB03dsBvwPBtto49mtQ4Uc1fc+LaTG6afkFFRzwSNPwMuB7qh
	tLQDWwrzPQfIlC8ZUnq4aX4tTadTnRH6I0WEiLTbDcDeXllND1INSIcSCWF4B0BK2twPLbz36JJ
	ihKP0MmxA3RrzdSFsR6TLknEAYthPwvYpIN7PB3yit+vQuk0T6hFX14wvTZHnccsS3S2SPDWgu4
	GXnHMvF4PsoVPj90P62ldg9EhXw85sh1SgbpwxhFYdNAUqRn+iUJMxEdClMADznmPoCONmRg7UO
	7TMe7YykWSmsta+x71N8SBEZbTguJcUAkCiPXwzfI1yZpmOw==
X-Received: by 2002:a05:6102:3a0a:b0:608:759a:53bc with SMTP id ada2fe7eead31-62d81e93cc1mr1707271137.0.1777778239248;
        Sat, 02 May 2026 20:17:19 -0700 (PDT)
Received: from notebookdoJV.. ([45.164.49.175])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62bfd8b5aeesm3565008137.7.2026.05.02.20.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 20:17:18 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Fernandes?= <joaovictor.fernandes@usp.br>
To: jean-baptiste.maneyrol@tdk.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: gcotavio@usp.br,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: inv_icm42600: refactor accel/gyro configuration paths
Date: Sun,  3 May 2026 00:12:36 -0300
Message-ID: <20260503031703.33330-1-joaovictor.fernandes@usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor accel and gyro configuration paths to remove duplicated
logic and improve code structure.
Introduce a generic helper, inv_icm42600_set_sensor_conf(), to handle
common register programming and state updates.

Keep sensor-specific handling in inv_icm42600_set_accel_conf() and
inv_icm42600_set_gyro_conf() wrappers. Also extract configuration
sanitization into a dedicated helper inv_icm42600_sanitize_conf()
to further reduce repetition.

Signed-off-by: João Fernandes <joaovictor.fernandes@usp.br>
Co-developed-by: Otavio Capobianco <gcotavio@usp.br>
Signed-off-by: Otavio Capobianco <gcotavio@usp.br>
---
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 125 +++++++++---------
 1 file changed, 63 insertions(+), 62 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 76eb22488..e326e0aae 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -289,15 +289,51 @@ static int inv_icm42600_set_pwr_mgmt0(struct inv_icm42600_state *st,
 	return 0;
 }
 
-int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
-				struct inv_icm42600_sensor_conf *conf,
-				unsigned int *sleep_ms)
+static int inv_icm42600_set_sensor_conf(struct inv_icm42600_state *st,
+			      struct inv_icm42600_sensor_conf *target_conf,
+			      struct inv_icm42600_sensor_conf *accel_conf,
+			      struct inv_icm42600_sensor_conf *gyro_conf,
+			      struct inv_icm42600_sensor_conf *oldconf,
+			      unsigned int reg_config0,
+			      unsigned int target_config0_val,
+			      unsigned int *sleep_ms)
 {
-	struct inv_icm42600_sensor_conf *oldconf = &st->conf.accel;
 	unsigned int val;
 	int ret;
 
-	/* Sanitize missing values with current values */
+	/* set target sensor's CONFIG0 register */
+	if (target_conf->fs != oldconf->fs || target_conf->odr != oldconf->odr) {
+		ret = regmap_write(st->map, reg_config0, target_config0_val);
+		if (ret)
+			return ret;
+
+		oldconf->fs = target_conf->fs;
+		oldconf->odr = target_conf->odr;
+	}
+
+	/* set GYRO_ACCEL_CONFIG0 register */
+	if (target_conf->filter != oldconf->filter) {
+		val = INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(accel_conf->filter) |
+		      INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(gyro_conf->filter);
+
+		ret = regmap_write(st->map,
+				   INV_ICM42600_REG_GYRO_ACCEL_CONFIG0,
+				   val);
+		if (ret)
+			return ret;
+
+		oldconf->filter = target_conf->filter;
+	}
+
+	/* set PWR_MGMT0 register */
+	return inv_icm42600_set_pwr_mgmt0(st, gyro_conf->mode, accel_conf->mode,
+					  st->conf.temp_en, sleep_ms);
+}
+
+static void inv_icm42600_sanitize_conf(
+	struct inv_icm42600_sensor_conf *conf,
+	const struct inv_icm42600_sensor_conf *oldconf)
+{
 	if (conf->mode < 0)
 		conf->mode = oldconf->mode;
 	if (conf->fs < 0)
@@ -306,6 +342,17 @@ int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
 		conf->odr = oldconf->odr;
 	if (conf->filter < 0)
 		conf->filter = oldconf->filter;
+}
+
+int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
+				struct inv_icm42600_sensor_conf *conf,
+				unsigned int *sleep_ms)
+{
+	struct inv_icm42600_sensor_conf *oldconf = &st->conf.accel;
+	unsigned int config0_val;
+
+	/* Sanitize missing values with current values */
+	inv_icm42600_sanitize_conf(conf, oldconf);
 
 	/* force power mode against ODR when sensor is on */
 	switch (conf->mode) {
@@ -324,30 +371,12 @@ int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
 		break;
 	}
 
-	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
-	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
-		val = INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |
+	config0_val = INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |
 		      INV_ICM42600_ACCEL_CONFIG0_ODR(conf->odr);
-		ret = regmap_write(st->map, INV_ICM42600_REG_ACCEL_CONFIG0, val);
-		if (ret)
-			return ret;
-		oldconf->fs = conf->fs;
-		oldconf->odr = conf->odr;
-	}
-
-	/* set GYRO_ACCEL_CONFIG0 register (accel filter) */
-	if (conf->filter != oldconf->filter) {
-		val = INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(conf->filter) |
-		      INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(st->conf.gyro.filter);
-		ret = regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL_CONFIG0, val);
-		if (ret)
-			return ret;
-		oldconf->filter = conf->filter;
-	}
 
-	/* set PWR_MGMT0 register (accel sensor mode) */
-	return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->mode,
-					  st->conf.temp_en, sleep_ms);
+	return inv_icm42600_set_sensor_conf(st, conf, conf, &st->conf.gyro, oldconf,
+					    INV_ICM42600_REG_ACCEL_CONFIG0,
+					    config0_val, sleep_ms);
 }
 
 int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
@@ -355,45 +384,17 @@ int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
 			       unsigned int *sleep_ms)
 {
 	struct inv_icm42600_sensor_conf *oldconf = &st->conf.gyro;
-	unsigned int val;
-	int ret;
+	unsigned int config0_val;
 
-	/* sanitize missing values with current values */
-	if (conf->mode < 0)
-		conf->mode = oldconf->mode;
-	if (conf->fs < 0)
-		conf->fs = oldconf->fs;
-	if (conf->odr < 0)
-		conf->odr = oldconf->odr;
-	if (conf->filter < 0)
-		conf->filter = oldconf->filter;
+	/* Sanitize missing values with current values */
+	inv_icm42600_sanitize_conf(conf, oldconf);
 
-	/* set GYRO_CONFIG0 register (gyro fullscale & odr) */
-	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
-		val = INV_ICM42600_GYRO_CONFIG0_FS(conf->fs) |
+	config0_val = INV_ICM42600_GYRO_CONFIG0_FS(conf->fs) |
 		      INV_ICM42600_GYRO_CONFIG0_ODR(conf->odr);
-		ret = regmap_write(st->map, INV_ICM42600_REG_GYRO_CONFIG0, val);
-		if (ret)
-			return ret;
-		oldconf->fs = conf->fs;
-		oldconf->odr = conf->odr;
-	}
 
-	/* set GYRO_ACCEL_CONFIG0 register (gyro filter) */
-	if (conf->filter != oldconf->filter) {
-		val = INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(st->conf.accel.filter) |
-		      INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(conf->filter);
-		ret = regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL_CONFIG0, val);
-		if (ret)
-			return ret;
-		oldconf->filter = conf->filter;
-	}
-
-	/* set PWR_MGMT0 register (gyro sensor mode) */
-	return inv_icm42600_set_pwr_mgmt0(st, conf->mode, st->conf.accel.mode,
-					  st->conf.temp_en, sleep_ms);
-
-	return 0;
+	return inv_icm42600_set_sensor_conf(st, conf, &st->conf.accel, conf, oldconf,
+					    INV_ICM42600_REG_GYRO_CONFIG0,
+					    config0_val, sleep_ms);
 }
 
 int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
-- 
2.43.0

