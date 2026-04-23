Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD281237713
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776910179; cv=none; b=Vs2k8+10FhlpKjs6+puTbLthBrnLsPHJt69WZ8pf5Q2F5zql+XhexrxqHh1z+1Ml0LFyS2JcbLDPBw58Kz5oZ8zNH+iJd3F9lV444hhLTKdP4GRDiMaPHutBGso9dXhe4vSXjUGj98ZF1sHs2XnzxFLz1FxLY6Q01fh8Pcw9u8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776910179; c=relaxed/simple;
	bh=UgTzOoJAF9FW0QSofAameitPLLfK9/oYtV9xhdF+ZvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KlBTJ9OYveVRZdbHX0vicu8dRk+ek93w9rTc9Rj2CoFHkAloiQHP4Jn/0g+MB6+pI1Jxt4rqA+gzy2TrV1pDWKPJKmkSN/OSVFUfB0p3tHr+CkjorqU3QrLRi8Sd2uxdbSJo0vYWmXnqlsqlNO0LSi/oG8Z90RjAvCrAdrgo7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=jVmYF5lA; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="jVmYF5lA"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2d8fa0fadfeso3281121eec.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 19:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776910175; x=1777514975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AdYBAc2wmPuaTf3wjfYoQ2ptRfKfWAcE+esoTSMfewc=;
        b=jVmYF5lA9VHecpBE9sE3Dz58KRbc72n/4Tr76xd3dbxiMM+hDx/zX6beAX5+Yesbwj
         m0T6D8+sJ6jN8ro1ng3v6WJuxPZ0aYNlkDF3mTaliDwkFjbuqftakODO1fb9HjmcgGfh
         cCEjLvptl0oLNxp42vbTyTQxuXD4ByMlYhfM7eMYaFowdONZKEw5H5avMwfd4UWgbfOl
         Er/DHw3FC6iDwcNopTXsXHEH9zEfJsNVes38H3/rujMYul58n6tqnEnjf5zIACaP4QET
         HMuTdHppG8q7SCAm6Xn0AgBelH7DiBc5+3XgAv6EOcUmoqC2W1BQdTUlu7SxPptr/1Nz
         JY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776910175; x=1777514975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdYBAc2wmPuaTf3wjfYoQ2ptRfKfWAcE+esoTSMfewc=;
        b=MMKm+F27c1d4drshrBO99euaBLR0bN7ulgw4BFZbpvXQBB7Xc2WsgX3SkXWMKgkNWv
         Fj+P8m2DCU+hFjVJb4HmetBghSw2+iAIjvrQsR+dq8sGURye5dHudgix40SJOuTAJeBH
         1tNzdHOJP1QFuvzBnYTAmKKU/l0ZuwNZ+dp+Ya84/MoRhdTaGxinWkpXdaeLwy9KM+JO
         OZ/KqHeiWdtiHdmxwPkFOmx2BW6wsypBBxDktza3E6+aLNGBlCx5ThDWcl6VV6lO40jT
         ba2MUsqEHm2mXi853utcSVw9b8gJcgvzs4YH1f1bkfaI6yVYi6smJTqRAJFJhvObA98Q
         M9Ew==
X-Forwarded-Encrypted: i=1; AFNElJ/rLmHyNlIQ6E4Kun5Nebb6NFK551h2+4+cpag5zQvZfZrGFu1ZCy/0NdvepMGUyRDXmRf63ZinhKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyObK3B9+ubczJCGG4bcrGRgH6p1aAPpda5qqIlyzOmsZMqkAmq
	Ta0mxE7wE0D6/sCRx3o0Ma5cl0qZIh6Ci3XNP5BXVkMDh1DNqbYfqISCT4se7GoCZVQ=
X-Gm-Gg: AeBDietxAwdJbFtXBiDe0/ptR4jHqZnrhpUkt0YmFnTjsvV+VJ6dtFzl1YA3bAMCI4m
	8CqcnSWMPNLjWl1MzzOutn+tat9yuqrKXR4s4IxNxuhBilaCK1KtHf110rsjSSRINl7F32kepzp
	O7hcJHYxgnJdcSmFuJQi63CWya2S1aJd8RFFqZnLB4SL2AEdelX4zYgMgOpF/IWm5vw79SuT9ak
	IVUmhnumxhW6F6t/2TLQSyim0XmrHMivkS4peZKvfGiMZ+10eu+pk8KuppmARMOGEHT/3YDdJBs
	dtjD4dLpOL53folsba2dvmtAAL8WdYbv63Q8Legm77wYtTI/+c0OuQMCg0RD5XmP5Jf7xbZwgh3
	tuKy1tE3nP7bTF3TuFYTKTtaofnEtRUpgwVWwsIRjZfeiVE4veIuVf3A2XldUcPllrkFC9HJFCy
	oGDpJZVWc+tOdrdfpeQ+61AzLZzTrgD86CemPXMX0Xo7xiu9TyI+5RQX8=
X-Received: by 2002:a05:7300:d706:b0:2c1:67e1:61a9 with SMTP id 5a478bee46e88-2e42e01500emr10972379eec.13.1776910174797;
        Wed, 22 Apr 2026 19:09:34 -0700 (PDT)
Received: from notebookdoJV.. ([45.164.49.88])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8aed43sm25529684eec.26.2026.04.22.19.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 19:09:34 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Fernandes?= <joaovictor.fernandes@usp.br>
To: jean-baptiste.maneyrol@tdk.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Otavio Capobianco <gcotavio@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: inv_icm42600: refactor sensors config
Date: Wed, 22 Apr 2026 23:09:20 -0300
Message-ID: <20260423020922.4057-1-joaovictor.fernandes@usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

gyro and accel configs were refactored to reduce code duplication

Signed-off-by: João Fernandes <joaovictor.fernandes@usp.br>
Co-developed-by: Otavio Capobianco <gcotavio@usp.br>
Signed-off-by: Otavio Capobianco <gcotavio@usp.br>
---
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 130 +++++++++---------
 1 file changed, 62 insertions(+), 68 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 76eb22488..e9fd97504 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -289,15 +289,24 @@ static int inv_icm42600_set_pwr_mgmt0(struct inv_icm42600_state *st,
 	return 0;
 }
 
-int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
-				struct inv_icm42600_sensor_conf *conf,
-				unsigned int *sleep_ms)
+static int inv_icm42600_set_sensor_conf(struct inv_icm42600_state *st,
+			     struct inv_icm42600_sensor_conf *conf,
+			     unsigned int *sleep_ms,
+			     bool is_accel)
 {
-	struct inv_icm42600_sensor_conf *oldconf = &st->conf.accel;
+	struct inv_icm42600_sensor_conf *oldconf;
+	struct inv_icm42600_sensor_conf *accel_conf;
+	struct inv_icm42600_sensor_conf *gyro_conf;
 	unsigned int val;
 	int ret;
 
-	/* Sanitize missing values with current values */
+	/* choose context for old configuration */
+	if (is_accel)
+		oldconf = &st->conf.accel;
+	else
+		oldconf = &st->conf.gyro;
+
+	/* sanitize missing values with current values */
 	if (conf->mode < 0)
 		conf->mode = oldconf->mode;
 	if (conf->fs < 0)
@@ -308,94 +317,79 @@ int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
 		conf->filter = oldconf->filter;
 
 	/* force power mode against ODR when sensor is on */
-	switch (conf->mode) {
-	case INV_ICM42600_SENSOR_MODE_LOW_POWER:
-	case INV_ICM42600_SENSOR_MODE_LOW_NOISE:
-		if (conf->odr <= INV_ICM42600_ODR_1KHZ_LN) {
-			conf->mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
-			conf->filter = INV_ICM42600_FILTER_BW_ODR_DIV_2;
-		} else if (conf->odr >= INV_ICM42600_ODR_6_25HZ_LP &&
-			   conf->odr <= INV_ICM42600_ODR_1_5625HZ_LP) {
-			conf->mode = INV_ICM42600_SENSOR_MODE_LOW_POWER;
-			conf->filter = INV_ICM42600_FILTER_AVG_16X;
+	if (is_accel) {
+		switch (conf->mode) {
+		case INV_ICM42600_SENSOR_MODE_LOW_POWER:
+		case INV_ICM42600_SENSOR_MODE_LOW_NOISE:
+			if (conf->odr <= INV_ICM42600_ODR_1KHZ_LN) {
+				conf->mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
+				conf->filter = INV_ICM42600_FILTER_BW_ODR_DIV_2;
+			} else if (conf->odr >= INV_ICM42600_ODR_6_25HZ_LP &&
+				conf->odr <= INV_ICM42600_ODR_1_5625HZ_LP) {
+				conf->mode = INV_ICM42600_SENSOR_MODE_LOW_POWER;
+				conf->filter = INV_ICM42600_FILTER_AVG_16X;
+			}
+			break;
+		default:
+			break;
 		}
-		break;
-	default:
-		break;
 	}
 
-	/* set ACCEL_CONFIG0 register (accel fullscale & odr) */
+	/* choose context */
+	if (is_accel) {
+		accel_conf = conf;
+		gyro_conf = &st->conf.gyro;
+	} else {
+		accel_conf = &st->conf.accel;
+		gyro_conf = conf;
+	}
+
+	/* set GYRO_CONFIG0 register */
 	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
-		val = INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |
-		      INV_ICM42600_ACCEL_CONFIG0_ODR(conf->odr);
-		ret = regmap_write(st->map, INV_ICM42600_REG_ACCEL_CONFIG0, val);
+		if (is_accel) {
+			val = INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) |
+			INV_ICM42600_ACCEL_CONFIG0_ODR(conf->odr);
+			ret = regmap_write(st->map, INV_ICM42600_REG_ACCEL_CONFIG0, val);
+		} else {
+			val = INV_ICM42600_GYRO_CONFIG0_FS(conf->fs) |
+		    INV_ICM42600_GYRO_CONFIG0_ODR(conf->odr);
+			ret = regmap_write(st->map, INV_ICM42600_REG_GYRO_CONFIG0, val);
+		}
 		if (ret)
 			return ret;
+
 		oldconf->fs = conf->fs;
 		oldconf->odr = conf->odr;
 	}
 
-	/* set GYRO_ACCEL_CONFIG0 register (accel filter) */
+	/* set GYRO_ACCEL_CONFIG0 register */
 	if (conf->filter != oldconf->filter) {
-		val = INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(conf->filter) |
-		      INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(st->conf.gyro.filter);
+		val = INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(accel_conf->filter) |
+				INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(gyro_conf->filter);
 		ret = regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL_CONFIG0, val);
 		if (ret)
 			return ret;
 		oldconf->filter = conf->filter;
 	}
 
-	/* set PWR_MGMT0 register (accel sensor mode) */
-	return inv_icm42600_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->mode,
+	/* set PWR_MGMT0 register */
+	return inv_icm42600_set_pwr_mgmt0(st, gyro_conf->mode, accel_conf->mode,
 					  st->conf.temp_en, sleep_ms);
 }
 
+int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
+				struct inv_icm42600_sensor_conf *conf,
+				unsigned int *sleep_ms)
+{
+	return inv_icm42600_set_sensor_conf(st, conf, sleep_ms, 1);
+}
+
 int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st,
 			       struct inv_icm42600_sensor_conf *conf,
 			       unsigned int *sleep_ms)
 {
-	struct inv_icm42600_sensor_conf *oldconf = &st->conf.gyro;
-	unsigned int val;
-	int ret;
-
-	/* sanitize missing values with current values */
-	if (conf->mode < 0)
-		conf->mode = oldconf->mode;
-	if (conf->fs < 0)
-		conf->fs = oldconf->fs;
-	if (conf->odr < 0)
-		conf->odr = oldconf->odr;
-	if (conf->filter < 0)
-		conf->filter = oldconf->filter;
-
-	/* set GYRO_CONFIG0 register (gyro fullscale & odr) */
-	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
-		val = INV_ICM42600_GYRO_CONFIG0_FS(conf->fs) |
-		      INV_ICM42600_GYRO_CONFIG0_ODR(conf->odr);
-		ret = regmap_write(st->map, INV_ICM42600_REG_GYRO_CONFIG0, val);
-		if (ret)
-			return ret;
-		oldconf->fs = conf->fs;
-		oldconf->odr = conf->odr;
-	}
-
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
+	return inv_icm42600_set_sensor_conf(st, conf, sleep_ms, 0);
 }
-
 int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
 			       unsigned int *sleep_ms)
 {
-- 
2.43.0

