Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F6E499F0F
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208974; cv=none; b=qlnAI5g0Dy0jtFNI9rTkpuP7UZginEs/IzqffUsvGstJmqC4sN/HipijBbrLiMNfSddXL4D/z4ixmp+rwQM5dWGaa991VYzMG0mNsclBuO/hlh0+5ewerFzXH8nELyX7znSQ0UH5/wnv8FgQAbcEAnDvixHFVz3bCmOLmqnBBsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208974; c=relaxed/simple;
	bh=C8WKxnPr7uP5n1W4IxfSgShbk4BUptHHQE/t06I9aBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Za12pWWmrTE8GQBfDzK6dlWHi94xd2Whg7RsKwAjFkYdFbwArjtKpI3jampywJcPmT4PrXe32fmKbS1o1XQFKA8mqktB/sCAJ02xjhNMSxfDThmbK9dYFnbWuYOb0sV1R6Tgy/TIlzzkdveukyY6p8A77qT62jdV+9ZfyMtlxNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=iMAapyyU; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="iMAapyyU"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so12079995e9.3
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791208970; x=1791813770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSGrLVeVFAOEps51tbyhD7UnfHCObTz/8EabMnjfI5s=;
        b=iMAapyyU3Dh9xXXeN8jl5+JJ0+bUirLD37IxehMbgd2UKkmclMLVmLuBxT1tpN+IDl
         qh67yTarjgVO/juq30wRweH90xk/KCJCv2Vfxks1EKj349liD9V9HrHBXimCrOWXr84A
         5yDeqbmwB4WdQmvCLxKIIDaYPARcv0/qkcREZLwf5OXDi1EADnA71tBaldr4i9lDWsGh
         oFnhcinIttCixwCWDKEugSd1HNcvJBhq1hQ0pqjWytSTpEc934qkRpE8ebCJGxisrPJK
         Zn7PP2jdMaVDgwRZ9iRbljAfCD7Wexa5VHhlY8iDtUYacXqb9+iB6uaNB1ZzmOHiJCal
         eFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208970; x=1791813770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sSGrLVeVFAOEps51tbyhD7UnfHCObTz/8EabMnjfI5s=;
        b=0YRAwsMTkUKJs3GF+qI7xAzn5QGGiMRgV4DWP8Y5P7g+sV37BqDs1DpOQBmIhO3Frs
         UaHBJvEuXjcjuk7g+PtuRAADbMJwqT0ZvhRIrNCfW03Q0YTEsizjNlvhprFH6l5Mu5Fx
         eGf6xBp0T07LJTwuy4Y4CrjrXKBXkG8OU3ZZ8fZSuHQNADLMdXa0XMMzOaqd46IzXHVt
         LokB4MCSYUMlvX/KWo/P23+VDgpY6rSkPvTCdoUzNNrJPi+Z3bOUyiK6NGmvaCk/IRZr
         QQO9zr+5Sz2xkESjZW68TqcW2qIdTWEEjkVEVLcl9/lEV8evDu7emXFT5Ta+MBeYbyzx
         HlpA==
X-Forwarded-Encrypted: i=1; AKwUvBz/nR9DozWafOINI8GL1e1WWg1xPEesjXh5CTKNDjFraV4VvFCdn3Xtv5gkQoiZMsvAWUh70lRMwac=@vger.kernel.org
X-Gm-Message-State: AFuF++m6pY7IN3qeFPv8aQmcuaXt1jIAEW8b4RXKjCeto+4qEkgys7Ts
	JoWX3vBrFyIjjzPDRptW3GltMKHCbJg9aoXOwZvK/q0vp1aa1LVKtTyRUN1VKNbO/5w=
X-Gm-Gg: AYBFou1F51TNSRfjSl0cN31KwvBfOHGAJz2wqSFI4EU5+Ewvq0SF5cQPfiJT/0XDfGB
	Ic7lGA5zDD183khSOuRJN0ZQsL9FgqrqjoVtsbU/QMPBcIWfhZlJ3yZXzSHwQiEFBfBFo4KVce6
	4UWHlDavxFKyjns+QLCMrRvz94N33F1P0WJ374MdOYdYOa84HpeOW/qE4gESuLXLtDMUWdLWDr3
	u3nFJiBwylHoy3dxslFAvF074k5+ONRNJqSKOiIZ3XxlBOEYOpwgzCPR5bEZ60isViuzio3cwqi
	4ucLeJrfdZskglRX89os+/U8StAEPdMDC/InnxR8kKxFrTOmr3Fivf7K8dTjU1Oekm40CESDJQh
	s6mfL4FnbpEB3wGhg+/JQzKSNUAjfQ3gdAQSweBs7vdnEvczJxfxYn/Wa7ZQNEc24UTKLClS3qw
	Rn6TbzarAJwamv7KA3wZfTZ/rGYf1CSqyw2s/nekveV1+TbAHzF4Yxq5uSQH9PRpjzE1zM/A1pZ
	t9n6lfntJxw1A==
X-Received: by 2002:a05:600c:1550:b0:49e:6778:c2bd with SMTP id 5b1f17b1804b1-4a1765776dfmr22181475e9.6.1791208968997;
        Mon, 05 Oct 2026 07:02:48 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:9c1b:24c4:d43:125f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a162e867e8sm324052715e9.15.2026.10.05.07.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:02:48 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 05 Oct 2026 15:02:02 +0100
Subject: [PATCH 06/12] iio: imu: use named initializers for acpi_device_id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-acpi-iio-v1-6-2796f713945a@thegoodpenguin.co.uk>
References: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
In-Reply-To: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Petre Rodan <petre.rodan@subdimension.ro>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, Eddie James <eajames@linux.ibm.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791208959; l=6787;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=C8WKxnPr7uP5n1W4IxfSgShbk4BUptHHQE/t06I9aBA=;
 b=+F9D/SCm67nlVT3DAymmZ2hqZCqUfkr9WWrlYQhk72bbYsKLqJFAzARJAUFJragEwCOPIPn5Y
 xt7KR7ytBstAsm1kvwEnGNXt8GKR+WAn+y5ey6Jebwj/tht8gso+8jq
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/iio/imu/bmi160/bmi160_i2c.c         | 6 +++---
 drivers/iio/imu/bmi160/bmi160_spi.c         | 4 ++--
 drivers/iio/imu/bmi270/bmi270_i2c.c         | 4 ++--
 drivers/iio/imu/bmi323/bmi323_i2c.c         | 2 +-
 drivers/iio/imu/fxos8700_i2c.c              | 2 +-
 drivers/iio/imu/fxos8700_spi.c              | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c   | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c   | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 4 ++--
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c | 2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index 3f3ee044a9cf..7a38f05a81fd 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -52,9 +52,9 @@ static const struct acpi_device_id bmi160_acpi_match[] = {
 	 * this is not expected to change anymore since at least some of
 	 * the affected devices are from 2021/2022.
 	 */
-	{"10EC5280", 0},
-	{"BMI0120", 0},
-	{"BMI0160", 0},
+	{ .id = "10EC5280" },
+	{ .id = "BMI0120" },
+	{ .id = "BMI0160" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index 107eb3374922..922909c8fa72 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -41,8 +41,8 @@ static const struct spi_device_id bmi160_spi_id[] = {
 MODULE_DEVICE_TABLE(spi, bmi160_spi_id);
 
 static const struct acpi_device_id bmi160_acpi_match[] = {
-	{"BMI0120", 0},
-	{"BMI0160", 0},
+	{ .id = "BMI0120" },
+	{ .id = "BMI0160" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index 7c035e82e6e9..1143c0061c81 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -40,9 +40,9 @@ MODULE_DEVICE_TABLE(i2c, bmi270_i2c_id);
 
 static const struct acpi_device_id bmi270_acpi_match[] = {
 	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
-	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
+	{ .id = "BMI0160", .driver_data = (kernel_ulong_t)&bmi260_chip_info },
 	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
-	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
+	{ .id = "BMI0260", .driver_data = (kernel_ulong_t)&bmi260_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bmi270_acpi_match);
diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
index e835b91ea6b4..e025c88c30b4 100644
--- a/drivers/iio/imu/bmi323/bmi323_i2c.c
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -107,7 +107,7 @@ static const struct acpi_device_id bmi323_acpi_match[] = {
 	 * driver initialization. This device reset does occur in both the
 	 * bmi323 and bmc150 init sequences.
 	 */
-	{ "BOSC0200" },
+	{ .id = "BOSC0200" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, bmi323_acpi_match);
diff --git a/drivers/iio/imu/fxos8700_i2c.c b/drivers/iio/imu/fxos8700_i2c.c
index ba47e9260928..4441ddf01338 100644
--- a/drivers/iio/imu/fxos8700_i2c.c
+++ b/drivers/iio/imu/fxos8700_i2c.c
@@ -41,7 +41,7 @@ static const struct i2c_device_id fxos8700_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, fxos8700_i2c_id);
 
 static const struct acpi_device_id fxos8700_acpi_match[] = {
-	{"FXOS8700", 0},
+	{ .id = "FXOS8700" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, fxos8700_acpi_match);
diff --git a/drivers/iio/imu/fxos8700_spi.c b/drivers/iio/imu/fxos8700_spi.c
index 56ad0c5914d9..2cd9cfcf867c 100644
--- a/drivers/iio/imu/fxos8700_spi.c
+++ b/drivers/iio/imu/fxos8700_spi.c
@@ -29,7 +29,7 @@ static const struct spi_device_id fxos8700_spi_id[] = {
 MODULE_DEVICE_TABLE(spi, fxos8700_spi_id);
 
 static const struct acpi_device_id fxos8700_acpi_match[] = {
-	{"FXOS8700", 0},
+	{ .id = "FXOS8700" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, fxos8700_acpi_match);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 9ef6ab74af8b..8f00d6f04ac1 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -274,7 +274,7 @@ static const struct of_device_id inv_of_match[] = {
 MODULE_DEVICE_TABLE(of, inv_of_match);
 
 static const struct acpi_device_id inv_acpi_match[] = {
-	{"INVN6500", INV_MPU6500},
+	{ .id = "INVN6500", .driver_data = INV_MPU6500 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 71e90ddc19dd..c6ad2e150290 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -161,7 +161,7 @@ static const struct of_device_id inv_of_match[] = {
 MODULE_DEVICE_TABLE(of, inv_of_match);
 
 static const struct acpi_device_id inv_acpi_match[] = {
-	{"INVN6000", INV_MPU6000},
+	{ .id = "INVN6000", .driver_data = INV_MPU6000 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index edec898cb11f..c4097ce2bf81 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -143,8 +143,8 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
 
 static const struct acpi_device_id st_lsm6dsx_i2c_acpi_match[] = {
-	{ "SMO8B30", ST_LSM6DS3TRC_ID, },
-	{ "SMOCF00", ST_LSM6DSO_ID, },
+	{ .id = "SMO8B30", .driver_data = ST_LSM6DS3TRC_ID },
+	{ .id = "SMOCF00", .driver_data = ST_LSM6DSO_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_lsm6dsx_i2c_acpi_match);
diff --git a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
index 6581d14e2bcf..a22ac4279503 100644
--- a/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
+++ b/drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c
@@ -39,7 +39,7 @@ static const struct i2c_device_id st_lsm9ds0_id_table[] = {
 MODULE_DEVICE_TABLE(i2c, st_lsm9ds0_id_table);
 
 static const struct acpi_device_id st_lsm9ds0_acpi_match[] = {
-	{"ACCL0001", (kernel_ulong_t)LSM303D_IMU_DEV_NAME},
+	{ .id = "ACCL0001", .driver_data = (kernel_ulong_t)LSM303D_IMU_DEV_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, st_lsm9ds0_acpi_match);

-- 
2.53.0

