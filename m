Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1218E2E888A
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670830; cv=none; b=XRDN6ItLSmRMjn62Itg8GZEM5uShfdtCi5jGcRc8W3kTlhTzRcavtFFsJwwyi05vIMkpDeIDzNS08Orml3kOYNNF3PM45/0AOKGDaC3i7oThwLx+BPxLhJymWw/aUJee2SpDwadjvsKXjs4LE76YhdIJ6hkQCaqFvtTlmj7wulU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670830; c=relaxed/simple;
	bh=oUZ06auz2ARlCdVgRSCjyC8cnzsRmyHCorl7gHLVFkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTstQjAjoBzHLwBuykacZTNp4Qx9zSE9QtpxsOjzF+olnGGDvY7bx1O0RIr9fjUGtIUS+gw2rot2pxl6gExQTh24F2/hCZQRQziLPyayJQD16q0f9ShqOdheDxXVa4HR1uHWVC/lMXQUrhGo7fVWi/r45A/l9pvUBR1IUIyp5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5I8LPYN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5I8LPYN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a12ed4d205so3541135ad.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 23:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769670828; x=1770275628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rsj3Cj/b0cIYLaAXFjj23RrEnTo8PTMyzTwDm501dcY=;
        b=A5I8LPYNW/Q5v1xj04Onl3MCO7Q2qhFLtw7azRqtIUmsxFUwzcFeHkn97ufXKFqxxu
         4URGeDy339g+a4wbnIANsPAB8REu8wvwvgHBUpZ9v39gk5jI4Un+6vxhTlwL4N8t1W4Z
         PWA4YgCCJLjL0eLCPowIwRmVGvuB77qnO3GClPgv5Ns9ec0wgY0i+GBtwIr97ldaZ3o3
         nLSqncPYmZECBzCezZNh20ZswOBUKcRfRHnc8lccq1Vo+fa5Me2sR8Nh6OkSoNPjVVhA
         ZYqxwFiFBrqrgp2BGogzLnBUpwJDr4brMqoYT/ZMVccTddQXYJUaKysIjYH2RA+j9dXr
         47Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769670828; x=1770275628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rsj3Cj/b0cIYLaAXFjj23RrEnTo8PTMyzTwDm501dcY=;
        b=PC65ZngWVVU0NPtqAEgEdi7M85H2g8Nvg6Mv85drhpZupIGNbQ6Vl3y2XtCf9Eyxhu
         jJZF6KyuAHibhyDd49/nZISfJ4DVTNRBSw5imURNgM29JRUSGw1n4ymaugde9/UflkRj
         ypB+ieyay9OR8IKvUNEpusKz7l4Hb0kYm4ZC7jzrlJF5jpZp4s6zyOGuvhfzN3QS5rav
         /9nWJLwafMPMMaZzsCO28RmPBYUlTEGt8NNg8Jqy8a3Jvi8mZH6CbIo0vMaH0BhlFB9b
         8f8FbS59dxovsBmEAbzla0MAYM0J2/iQzRL/MLBiGXAuSEdSOJ6FspeSv7cFbimNMlgG
         +GSA==
X-Gm-Message-State: AOJu0Yxs1fApVfUzi07wVYWThUqWqD18aaBSeKd2EM+zv5ktOD/sPjG7
	8glx1Ww3S4N34d4iDAEoT5XjM/lgmMHHQ4IcSpBTIXBOktxgSb6BXjlP/D7rdrhB
X-Gm-Gg: AZuq6aLpwTmJK/cLA/4+7fPGCTQ8QnXy5Yd8WI62mrJV1rLnVWN7lkeUi65TT1O+fKV
	T3Q/8aKUl2BSbOJdH/OnOXSbFn4w9bo0EkVGRzSZ4HUThoiHybKNF3Kfr3O8mAyz1MnnhDivu3P
	bhvwPPtAZonkumZf1vvvc18DGBR4mOIXb8YVmohYGh5OPaTdRpQdbJXhyqiZ8rCowEC9RgU3AWD
	d6yjdbTmm4ufj2bcuZ3wnBMSOd3gNDZA1qr/S6pBtq1WYwCmiBEodL4utHx/uZrscVcI5qpj0L5
	G4+edSUtFUrBSsly1PzvI5BwbAwG4CzkiV5u8F4ys17vd1vRe2pOgEh4Pk++pqZmeQxbZRTAoQL
	IQPzxV/Muz7ZuwkA0PkG2gJjtBiK7hllovMDsk+Y54Fu7tokJ9cUPnMq/qAY2adpX8HBU9b5sa8
	mQDzJ5v9iKx8c5zOOncKRIWi/9ETSBOD8zik34wLlPK1bjZXiS
X-Received: by 2002:a17:903:908:b0:29d:9f5a:e0d1 with SMTP id d9443c01a7336-2a870d7b891mr72163415ad.27.1769670827973;
        Wed, 28 Jan 2026 23:13:47 -0800 (PST)
Received: from arch.localdomain (awork135098.netvigator.com. [219.76.135.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6ed92dsm44160135ad.93.2026.01.28.23.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:13:47 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH 6/6] iio: gyro: bmg160: add support for bmx055 gyroscope
Date: Thu, 29 Jan 2026 15:11:02 +0800
Message-ID: <20260129071105.389493-7-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129071105.389493-1-jerrysteve1101@gmail.com>
References: <20260129071105.389493-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the gyroscope driver for the BMX055 IMU, which is an integrated
IMU including accelerometer, gyroscope and magnetometer.

The accelerometer can be supported by the bmc150-accel driver, while
the magnetometer can be supported by the bmc150_magn driver.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/iio/gyro/Kconfig      | 4 ++--
 drivers/iio/gyro/bmg160_i2c.c | 2 ++
 drivers/iio/gyro/bmg160_spi.c | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 3e193ee0fb61..3a4caa8d238c 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -72,8 +72,8 @@ config BMG160
 	select BMG160_SPI if (SPI)
 	help
 	  Say yes here to build support for BOSCH BMG160 Tri-axis Gyro Sensor
-	  driver connected via I2C or SPI. This driver also supports BMI055
-	  and BMI088 gyroscope.
+	  driver connected via I2C or SPI. This driver also supports BMI055,
+	  BMI088 and BMX055 gyroscope.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called bmg160_i2c or bmg160_spi.
diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index 1fb8a7969c25..129d2da674ef 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -50,6 +50,7 @@ static const struct i2c_device_id bmg160_i2c_id[] = {
 	{ "bmg160" },
 	{ "bmi055_gyro" },
 	{ "bmi088_gyro" },
+	{ "bmx055_gyro" },
 	{ }
 };
 
@@ -59,6 +60,7 @@ static const struct of_device_id bmg160_of_match[] = {
 	{ .compatible = "bosch,bmg160" },
 	{ .compatible = "bosch,bmi055_gyro" },
 	{ .compatible = "bosch,bmi088_gyro" },
+	{ .compatible = "bosch,bmx055_gyro" },
 	{ }
 };
 
diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
index 6aecc5eb8347..ccf161f58f7a 100644
--- a/drivers/iio/gyro/bmg160_spi.c
+++ b/drivers/iio/gyro/bmg160_spi.c
@@ -36,6 +36,7 @@ static const struct spi_device_id bmg160_spi_id[] = {
 	{"bmg160", 0},
 	{"bmi055_gyro", 0},
 	{"bmi088_gyro", 0},
+	{"bmx055_gyro", 0},
 	{ }
 };
 
@@ -45,6 +46,7 @@ static const struct of_device_id bmg160_of_match[] = {
 	{ .compatible = "bosch,bmg160" },
 	{ .compatible = "bosch,bmi055_gyro" },
 	{ .compatible = "bosch,bmi088_gyro" },
+	{ .compatible = "bosch,bmx055_gyro" },
 	{ }
 };
 
-- 
2.52.0

