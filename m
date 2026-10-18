Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0051096F
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792282176; cv=none; b=EgdXypDfvdUH3vgkIMYqlGipqZYVqMG3p1d13kQfCZp+cbhh6eEqFXt8yaQnRiCNBsJr5wbrLw0nyiZYYcZZsa6Xe2TnigmUn8F84VMgxRrQub6y00K6WxKJDRuF1MPwc6RGwzSC23lLvrZhGJmDh6mBOU3+d6de5CN26LGa+lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792282176; c=relaxed/simple;
	bh=6vA38k/HSG2McBVW1/kxWpDjpBI/fFHQ4pEz6Sxq1c0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/Rpalp46EmSwDy7qvWM1L3I30JTvs1OIe/osGeUqWmfuTxesxvj8TJf42I/HYAywc3qA0nQp1jVNa0Y09BL1e+Zbfxc+6U1tFAuhwxuJNezviRXkE7wjtk3mwpQfFOhT3OxYIEwW3kCxtfB5QK8cORApeiQyOi4cdibNhh0ZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCQvf1pS; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCQvf1pS"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30b6dad2382so2889039eec.0
        for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 17:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792282174; x=1792886974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o0M4NAgf3ke+VVYopgdoNuand0ccz438htrgrHijUjA=;
        b=mCQvf1pS/Z9dOATUbOIesNU0GieOU09NVIdTMu1CGS0yzvSF9L+cJo8KiQi8Yhnh8T
         4bB9ArvWINmg2xwti5YSwArRHy4zdBbJlwVgagwNR4RHmkRqPe2mK2AFEW9mInY7/GCD
         eUZJkOierxPzLBUi7p7+X7zUSJ6k2mf2iIp5YBv/y+5aoogQwNB8fWxhbJkU6KmozbrU
         /EPw1s+FZR6Co8DPJUAkzvNRAC+57A9F0r4OXQlMrdykjBj3O7vNXxa6N5F1d/Np8LC4
         kRD/RBBHibOY2/l161tuBlRsRhcsixNMdUuW2efZ5gYRaDSG7Li/B4/5/kSnuoAwG1Pf
         OVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792282174; x=1792886974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0M4NAgf3ke+VVYopgdoNuand0ccz438htrgrHijUjA=;
        b=s2zOKU/Z0yH/ih0cY/x2He8O6PqRj9UAdyMhuI5VqzEVkw+/2KBuPy9bdbCX0AIUpj
         PDa5ieqQC8cnlsuBnLEDKoKVKCHKk5NN1CWlxVF23RQKrhjhVeFkaUfTv5eWCPlQhlML
         /qz0RKFSKxrguKWT5cox/k7pzL47kXT+9UwwbSiDgJFhtgQZW8ANgeXYCZ0E8QK1SB8e
         XV6fZb3/1KajvxIqoXVGlWkc+1BmUhIkty8p0j92mLLTolRoIlm6KiQmvo5W4JA+IVjF
         YN9J6+PtaslyKKXE/ZnGOvaK2fgcYCNJtP8CRkzYz3ne+65E8i9Qb4GOVBTYmIdqvKBh
         RM5Q==
X-Forwarded-Encrypted: i=1; AKwUvBywPNbSstKEk1Ixtime4uIU/HjYy2VZCPSwYFSc730YSsX/SEdD+cc2rnN17zJIFDN4cQ0WiOYqFpI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOeYf+bfQWa96ZWvAPOGPdiZIY7XAO3Qtm2W/5nRj4n46pLXVH
	l9HgGDMvmhJS5fw2Y+IJb6L25t/Z1Vx1bkCSno94t4wSycZ7NbWR9bWn
X-Gm-Gg: AYBFou38lctGtl2zkcugIgO59bSkITOvol43qEuWYdbNKBUy5KWnQRoOCm+Tht1fdKY
	yd3DPThcHZk2vO74Ll36SoSrPjvn05kCQgX3DCt7wdV8qNVO4nzYXNTwBvqdkL5KTnpt7Anf1Lk
	wUfa7Mxx+bg2QTVbJNwzsLM1HP5faLfZnpFShYOZuyOWwXc6jmVv1jLDomY1KhbaPUXlN2bTH6+
	pkkuGDt77zOI0eCJAMRMb/yVoFhsQfqGQ5EsNNCJ0KV0Z0/2Wr4K2dNWtQRgJJxNYtnPQCOxPVX
	m20QJeMDGDVmbV1a0UfcwlnuU2NkepyEU1Rc3p7tzsn5Fc5opVmFlmYzFh/knd8+24P+IvI+Kz9
	KvuKwUmtdSPwnBqTYswYmJiURIviJN54McWEah4ZImDo7lVM5f3S0qUnaaZf17xHrrgBVSd7E3b
	pg6PVS26XpCaM1PQNXzKUml0iPAOuivKD+qs3m27zwvE1UyE9dnXoMw75aN1xPEgcMydu5fF4+G
	/C+UXG0h0WhmNYzAX3E66ysb8m1g/jjuEA9AiLt6PFHYVQoh+mDyz22TSUWHZvhHVZyOhqfZZtQ
	2zBpnyGRLBIatUfIKsn7ZuGmgX07Fg==
X-Received: by 2002:a05:7022:302:b0:157:cbf6:89c4 with SMTP id a92af1059eb24-18514350f17mr8514376c88.26.1792282173564;
        Sat, 17 Oct 2026 17:09:33 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314ef8ed8sm15976613c88.3.2026.10.17.17.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 17:09:33 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: imu: inv_mpu6050: use named initializers for temp in hw_info[]
Date: Sun, 18 Oct 2026 05:39:13 +0530
Message-ID: <20261018000924.758186-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The temp member of struct inv_mpu6050_hw is initialized positionally
in every entry of hw_info[], as { *_TEMP_OFFSET, *_TEMP_SCALE }. The
order is correct today, but positional initializers of this kind are
how the accel and gyro startup times ended up swapped.

Use designated initializers, as already done for startup_time, so each
value is assigned to the member it is named after.

No functional change.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Follow-up suggested by Jonathan on the startup time fix:
https://lore.kernel.org/all/20261011045710.357809-1-kapoorarnav43@gmail.com/

Compile-tested (W=1). The object file is byte-identical to the one
built without this patch, apart from debug info.

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 95 +++++++++++++++++-----
 1 file changed, 76 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 3bdcf92472e8..5deddd3c5e80 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -148,7 +148,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6050,
 		.config = &chip_config_6050,
 		.fifo_size = 1024,
-		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
+		.temp = {
+			.offset = INV_MPU6050_TEMP_OFFSET,
+			.scale = INV_MPU6050_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6050_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6050_GYRO_STARTUP_TIME,
@@ -160,7 +163,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 512,
-		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
+		.temp = {
+			.offset = INV_MPU6500_TEMP_OFFSET,
+			.scale = INV_MPU6500_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
@@ -172,7 +178,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 512,
-		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
+		.temp = {
+			.offset = INV_MPU6500_TEMP_OFFSET,
+			.scale = INV_MPU6500_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
@@ -184,7 +193,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 4096,
-		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
+		.temp = {
+			.offset = INV_MPU6500_TEMP_OFFSET,
+			.scale = INV_MPU6500_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
@@ -196,7 +208,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6050,
 		.config = &chip_config_6050,
 		.fifo_size = 1024,
-		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
+		.temp = {
+			.offset = INV_MPU6050_TEMP_OFFSET,
+			.scale = INV_MPU6050_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6050_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6050_GYRO_STARTUP_TIME,
@@ -208,7 +223,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6050,
 		.config = &chip_config_6050,
 		.fifo_size = 1024,
-		.temp = {INV_MPU6050_TEMP_OFFSET, INV_MPU6050_TEMP_SCALE},
+		.temp = {
+			.offset = INV_MPU6050_TEMP_OFFSET,
+			.scale = INV_MPU6050_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6050_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6050_GYRO_STARTUP_TIME,
@@ -220,7 +238,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 512,
-		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
+		.temp = {
+			.offset = INV_MPU6500_TEMP_OFFSET,
+			.scale = INV_MPU6500_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
@@ -232,7 +253,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 512,
-		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
+		.temp = {
+			.offset = INV_MPU6500_TEMP_OFFSET,
+			.scale = INV_MPU6500_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
@@ -244,7 +268,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 512,
-		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.temp = {
+			.offset = INV_ICM20608_TEMP_OFFSET,
+			.scale = INV_ICM20608_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
@@ -256,7 +283,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 512,
-		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.temp = {
+			.offset = INV_ICM20608_TEMP_OFFSET,
+			.scale = INV_ICM20608_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
@@ -268,7 +298,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 4 * 1024,
-		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.temp = {
+			.offset = INV_ICM20608_TEMP_OFFSET,
+			.scale = INV_ICM20608_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
@@ -280,7 +313,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 4 * 1024,
-		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.temp = {
+			.offset = INV_ICM20608_TEMP_OFFSET,
+			.scale = INV_ICM20608_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
@@ -292,7 +328,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_icm20602,
 		.config = &chip_config_6500,
 		.fifo_size = 1008,
-		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.temp = {
+			.offset = INV_ICM20608_TEMP_OFFSET,
+			.scale = INV_ICM20608_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_ICM20602_ACCEL_STARTUP_TIME,
 			.gyro = INV_ICM20602_GYRO_STARTUP_TIME,
@@ -304,7 +343,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_icm20602,
 		.config = &chip_config_6500,
 		.fifo_size = 1008,
-		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.temp = {
+			.offset = INV_ICM20608_TEMP_OFFSET,
+			.scale = INV_ICM20608_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_ICM20602_ACCEL_STARTUP_TIME,
 			.gyro = INV_ICM20602_GYRO_STARTUP_TIME,
@@ -316,7 +358,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 1024,
-		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.temp = {
+			.offset = INV_ICM20608_TEMP_OFFSET,
+			.scale = INV_ICM20608_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_ICM20690_ACCEL_STARTUP_TIME,
 			.gyro = INV_ICM20690_GYRO_STARTUP_TIME,
@@ -327,7 +372,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 512,
-		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.temp = {
+			.offset = INV_ICM20608_TEMP_OFFSET,
+			.scale = INV_ICM20608_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
@@ -339,7 +387,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 512,
-		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.temp = {
+			.offset = INV_ICM20608_TEMP_OFFSET,
+			.scale = INV_ICM20608_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
@@ -351,7 +402,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 4 * 1024,
-		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.temp = {
+			.offset = INV_ICM20608_TEMP_OFFSET,
+			.scale = INV_ICM20608_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
@@ -363,7 +417,10 @@ static const struct inv_mpu6050_hw hw_info[] = {
 		.reg = &reg_set_6500,
 		.config = &chip_config_6500,
 		.fifo_size = 4 * 1024,
-		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
+		.temp = {
+			.offset = INV_ICM20608_TEMP_OFFSET,
+			.scale = INV_ICM20608_TEMP_SCALE,
+		},
 		.startup_time = {
 			.accel = INV_MPU6500_ACCEL_STARTUP_TIME,
 			.gyro = INV_MPU6500_GYRO_STARTUP_TIME,
-- 
2.53.0

