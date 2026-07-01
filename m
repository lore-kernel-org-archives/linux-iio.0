Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055C368D72
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923231; cv=none; b=OT8UzAtSyUmzhJ3q57MbGezQd5xF1KDoNNaxf9tpy886GEq7EwzlArCpt4iEbFv704SY0FdRZGwciJTX5ge6Y+3HVwu3ScyoqVrg898fMw39vRid0sJnfW9Q0tW/le6y+LbkzavXNMMtggY/nScPYnFE9aBRbDo/uFLTcqf83ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923231; c=relaxed/simple;
	bh=dOm4yf3XkDtGD5jTdq2Mx7WHpriaGkXslb0ZoLOb8gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ux2GK+RUfGcXEi7FJUBus29OsBlxsHXrGJGqN3dimDbMj7tTzGZwNMMTgrP2WIMAmwOr7emHX//Dz95WJpmFiP/JgDE0lrZk2XXZZaMIzy4aWiwAtLEO86/Xk7mqHg8fwt0yWyirzcapLRUI0DkkMiFrGaDFBkc8siDEKK0de/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzWHJTHm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzWHJTHm"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c996117854so2695015ad.3
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923229; x=1783528029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wP0ijcdd0B9FlzQjnGlPogLhcsgKg9w9ShfjwPmhrpE=;
        b=HzWHJTHmrr7cgJ4nocy4a5WYvD3ubWn/3NzlkDbIQFYwyyws0arwACxZHTNqaSARxJ
         Cap0MOWNXd4KKjieYQlWYOUnA0Mujb8ykwGdRT7sM0wKpdrUxKzPlBC0JqGTN0z+peoJ
         WBJol7kZlycppoDV707qagA+hS3lwAgZPOn9oPEUYuGSyKRF3pUN4LmDkKAIqpx3DdLl
         DVifHNzoi7abewgKlCjf6Ne+SDSFL1/YY40tyC6ImioRdWYCGAgj5uRNy+1spUzC4012
         b8WjhzZbT6FhZA+S4tLhyYTuL/iCIrdXR1ZhXBFrKJ1MKWichiHvETWHo+bk/UURN/nQ
         4ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923229; x=1783528029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wP0ijcdd0B9FlzQjnGlPogLhcsgKg9w9ShfjwPmhrpE=;
        b=n5JtKni8jhVF1SLqqlDGp6CC8wflxWvcKoZ8nyFS02G1A+J1EPZU11Yezc4eymyqq/
         EFmoof394Btf+JFKJ1rc8PL77+KRQPfXvn51JI+Eytq00gIys8HJt3sBkbhnBMV3qpMl
         M2S649Pzy+B8f2v7XGvHMHVx9fmo5QS1euyl2iSL1i7RAME2fKFwoMmZ4VQSckuw4hgJ
         RoA9gSb2m2iNoF/BxwsaTtc2egdQ7KTO25Ml2y4PN7Y1sAih/PquyM51fmM+SqRZROUC
         HB+a+5B1egrpcCaN970HdvmAhDOf+ZBJAlA0pWBjkPVlqNeO3AJDZE9wCkrmrUMGZyfq
         CT8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rocz+pHxG41tvzEbW7vw4Pu5ccl+YnGU6ih4SyLGdSRtr2SWV1mYbZmCcfTs2Dz07siDP4Gz7oJxII=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTYRnYCoTEnWWFgLCFzfiyjlLiqRg53nvwJbxJ8Koa2QKVUW8S
	Scph4RTmYQNlPHPQbQWctBCkwLGmZWD8QHWXgrupo9RJ+xyBcezgfc8W
X-Gm-Gg: AfdE7clxMW0h+r3UIHTYlU4BBXRPWY7R5Ez8mBOanOGVq8EKPBTL7WKHJyC2NnGd5tE
	Xkxt1Xk5CO1eGgyzruEEdmprkzKsFdfONNDiX8cT4P8iKprxX0kYUKSbVDPipuSCzX4foaqZgjY
	wzpTs4SF9xgUy8U9kKJatyyYq7+L5CLLfY14yKRuGrUgc3s10SHQwTleOyzht/vOE3bBvflPqlk
	GC6KNmZ+1eN+zWcNDha8wJ1W0kmb5oF4b8gEhcBgBKeWekNU0d8y4vcUWOirdUA5FCDvWoDHwhU
	wmRUXhO2YUmhjz4gP/3RQ1NeAX0nzqWMcXhQc2X81vezimFdfJdj+mj/3Boy30JVpDNAwuqBVQU
	8CSdWOd0/wkprfTD3Vks4NK1FzOVTqxl18I2lXl8yxx1JHNO3dzlcH57GEJkQmYNpHcF/i38Dlh
	clvyN2qaZ5IXeslAV+23CDocp+8Ogr0s1QJx8SA5BS1UeGJTRCScmIA6smcUF1TZOfvCM+OiotJ
	ZXQ+IUtJ+sY2qFZ2CG3n3+PCq+58FJ2Gt6Qwek+YS47Kr8F/f2qnfNOXAJa5GqTxWYCuxq4tmLe
	GkLCtJryOgN+9mWbt9yt185fC/DEoLace9tRRf3htjO/vsTfUcnAJpuRgStXg7ywiM8+oCc=
X-Received: by 2002:a17:90b:2f8e:b0:37f:fc3a:382d with SMTP id 98e67ed59e1d1-380aa25bc1amr1362290a91.6.1782923229359;
        Wed, 01 Jul 2026 09:27:09 -0700 (PDT)
Received: from midnightair.tail6abcb.ts.net ([2401:4900:1c94:62e8:bc10:77d0:2fda:415d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2cd21bcsm44657916eec.0.2026.07.01.09.27.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 09:27:08 -0700 (PDT)
From: Anas Khan <anxkhn28@gmail.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Remi Buisson <remi.buisson@tdk.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anas Khan <anxkhn28@gmail.com>
Subject: [PATCH v2] iio: imu: fix typos in comments
Date: Wed,  1 Jul 2026 21:56:59 +0530
Message-ID: <20260701162659.43310-1-anxkhn28@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701151811.22130-1-anxkhn28@gmail.com>
References: <20260701151811.22130-1-anxkhn28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several comment misspellings across drivers/iio/imu/, found with
codespell and manual review. The corrected words are coefficient,
temperature, sensitivity, access, chosen, and buses.

Signed-off-by: Anas Khan <anxkhn28@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
v2: expand from the single adis16480 temperature fix (v1) to cover all
    comment typos in drivers/iio/imu/, as requested by Andy Shevchenko.
    The Reviewed-by is carried over as the changes remain trivial typo
    fixes.
 drivers/iio/imu/adis16480.c                        | 4 ++--
 drivers/iio/imu/bmi160/bmi160_core.c               | 2 +-
 drivers/iio/imu/fxos8700_core.c                    | 2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 2 +-
 drivers/iio/imu/inv_icm45600/inv_icm45600.h        | 2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c         | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 543d5c4bfb11..c7163540cd02 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -111,7 +111,7 @@
 
 #define ADIS16480_REG_SERIAL_NUM		ADIS16480_REG(0x04, 0x20)
 
-/* Each filter coefficent bank spans two pages */
+/* Each filter coefficient bank spans two pages */
 #define ADIS16480_FIR_COEF(page) (x < 60 ? ADIS16480_REG(page, (x) + 8) : \
 		ADIS16480_REG((page) + 1, (x) - 60 + 8))
 #define ADIS16480_FIR_COEF_A(x)			ADIS16480_FIR_COEF(0x05, (x))
@@ -1468,7 +1468,7 @@ static irqreturn_t adis16480_trigger_handler(int irq, void *p)
 			 * We need to perform the padding to have the buffer
 			 * elements naturally aligned in case there are any
 			 * 32-bit storage size channels enabled which are added
-			 * in the buffer after the temprature data. In case
+			 * in the buffer after the temperature data. In case
 			 * there is no data being added after the temperature
 			 * data, the padding is harmless.
 			 */
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 4abb83b75e2e..2c0d21eb853a 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2016, Intel Corporation.
  * Copyright (c) 2019, Martin Kelly.
  *
- * IIO core driver for BMI160, with support for I2C/SPI busses
+ * IIO core driver for BMI160, with support for I2C/SPI buses
  *
  * TODO: magnetometer, hardware FIFO
  */
diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
index 281ebfd9c15a..9d2eb6fbab4a 100644
--- a/drivers/iio/imu/fxos8700_core.c
+++ b/drivers/iio/imu/fxos8700_core.c
@@ -2,7 +2,7 @@
 /*
  * FXOS8700 - NXP IMU (accelerometer plus magnetometer)
  *
- * IIO core driver for FXOS8700, with support for I2C/SPI busses
+ * IIO core driver for FXOS8700, with support for I2C/SPI buses
  *
  * TODO: Buffer, trigger, and IRQ support
  */
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 68a395758031..91b7f1ecba55 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -186,7 +186,7 @@ static unsigned int inv_icm42600_wm_truncate(unsigned int watermark,
  * smallest latency but this is not as simple as choosing the smallest watermark
  * value. Latency depends on watermark and ODR. It requires several steps:
  * 1) compute gyro and accel latencies and choose the smallest value.
- * 2) adapt the choosen latency so that it is a multiple of both gyro and accel
+ * 2) adapt the chosen latency so that it is a multiple of both gyro and accel
  *    ones. Otherwise it is possible that you don't meet a requirement. (for
  *    example with gyro @100Hz wm 4 and accel @100Hz with wm 6, choosing the
  *    value of 4 will not meet accel latency requirement because 6 is not a
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
index 1c796d4b2a40..95fa934a42b4 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600.h
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
@@ -190,7 +190,7 @@ struct inv_icm45600_sensor_state {
 #define INV_ICM45600_REG_IREG_ADDR			0x7C
 #define INV_ICM45600_REG_IREG_DATA			0x7E
 
-/* Direct acces registers */
+/* Direct access registers */
 #define INV_ICM45600_REG_MISC2				0x007F
 #define INV_ICM45600_MISC2_SOFT_RESET			BIT(1)
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
index 47394594d17a..6b858fdfd1c6 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
@@ -106,9 +106,9 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
 		return ret;
 
 	/*
-	 * Sensor sentivity
+	 * Sensor sensitivity
 	 * 1 uT = 0.01 G and value is in micron (1e6)
-	 * sensitvity = x uT * 0.01 * 1e6
+	 * sensitivity = x uT * 0.01 * 1e6
 	 */
 	switch (st->chip_type) {
 	case INV_MPU9150:
-- 
2.54.0

