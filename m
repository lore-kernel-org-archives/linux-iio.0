Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238E379993
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670822; cv=none; b=rvMYAEsnoZYVSqDP6c5hPzW9YR0UsUt20XsZdcNu9IQAokJNLZcGUO/wgECwxOvyRVWXhdmleSLb8LIbkT+uT2BpEeW4W92JSKAqvulpsgJ6FUQUB/CNucPq8C3eUrDB1O7Wjc9TaL5kjc+t+0PyvxykotCVPSv6GqGCH3SPmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670822; c=relaxed/simple;
	bh=Yjf1EnWs9Vl5GE1/bT6WMRvyMgfjOfFq2XcfZzKr5zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knYso5fhxUSS/LZTvWE8i53y/1wcC/IuVCeDAyGoo5ewLQV9IP6wCl6Sm9cI9ECMksoSM1N94FpT4jGaqA1EKeczymP8FGoyWr/tYytv9/PoEREIE8/3NgXvU7DRTX3DC6Oc5mVANYKdPY6lJ6dSdjvCPleAh/SqJitiUMVKfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdBXxjZo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdBXxjZo"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29f30233d8aso3734595ad.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 23:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769670821; x=1770275621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4NDMLH30WLIiHS+ivAcEhRj+RaNBxv8U1Q1blf5kD4=;
        b=BdBXxjZone2CQ8bYUcxfOua9GnWrsz5BfSJm1+kXM3YaTBLtFFSD5xgdHiD7O723er
         kb0IIxKenfCCQ1hN2zQ2W2IYFntym+/yCdgg89umYw0Eu79JnfN5DUVwTjbNMNlV1NoH
         vBhSH40qyzFPtaB43wJThBO0hvznqtgOVzrkpd+NE65xOMcdh27DQWjzkGHupPxM+YFV
         VfjE0OpEMBEO6Mi1parQqnkwE9ecDQty7snODf/nJhOkyJyQRAft1L0EVajSIvj0SmqS
         qJrL4mj6ijb6qDW/6vWtAtT3PXgt+vJB4yUS7s6fXgjb09V02O9AGS72BJddcE/sbOmc
         KQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769670821; x=1770275621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I4NDMLH30WLIiHS+ivAcEhRj+RaNBxv8U1Q1blf5kD4=;
        b=OlG3DHAoyiTQMWKybWkUDg1UPgNZZi+c3+RGqoN5TzZhdT+u3JOSmKGxVym0zE2C99
         L7kEyfUZono1HAdXg+aD9oahO4ZyiewpiCywWzVruMtIcy7J87f+EWrNRKFexPhVRm8h
         Y/RbnymoYEk81framX3U12wBGwBgiMeCN65iz0RTv+t1kh6nWcKr6QYfOupFufQHIbKG
         RsNRslTA9m/uMTxo62QkloGOoJor7MnIwRD5Jn/exFJ7Mt0AKP3pPlyhdA/vXG43CARy
         xbw70KTO24WLOz4zERdYQXW1H//8hwAGg+Jao9+9wTFkUzBCA3RZ3vnda6xFDUDcka6/
         OTXg==
X-Gm-Message-State: AOJu0YzSpNIaCJtPJUuwjvk3j4Y12aFwe7tJMsPUtlZVCIzbi8GYOjLU
	K//+UyrkG6blxUSEB411bazNLXf+MALGsHTL/Fvs+jGDMc14wst45wtDY1QvHA==
X-Gm-Gg: AZuq6aIkpEFnoChMtEfeAmVMytfa+/Hy4NRrPN4seGnkWhTsjJUaSWaUSZOVnW/RfsV
	R9LGbfmwFoK9nv0bCpvmSzBilfkDNes/o4BpTJREbn7EB0t2dKEiKCSCzmwkh7Q+Ji2RosE96Xt
	FcDniJ0jf2Eb7PSKh0WJhLPGi5rThuU7bdFOA8BoaCkTjd0DByTnUkdYK5xGbdA0qyxcIj/r+Qi
	HY3DVVqIeSMEAGBjBHkV/x4fGg9ygs7Il0YcRoYrIBxVPKDTcFwpaPxXoNqtYk1sgPafSB99FS+
	n3ARLzB1Nc0iDbC3aIjYmBEimchj+F4Le2l17BsqWrt6gxn00SazlBQZZotr9ktuVcRVRUC2gSm
	ZIav9CjnpP/5qtoA4MAZsHImWpaxb7NvXJkSmWeScErvDEsAk488DT/V3GBPsY6wGX4rG5vhte9
	jJxtScNoJGODQVt+MJXzsO7aLd8ZVGhTbPU1jj/H8fpQYJzxZk
X-Received: by 2002:a17:903:1c7:b0:295:54cb:16ac with SMTP id d9443c01a7336-2a870dc1022mr79834915ad.18.1769670820583;
        Wed, 28 Jan 2026 23:13:40 -0800 (PST)
Received: from arch.localdomain (awork135098.netvigator.com. [219.76.135.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6ed92dsm44160135ad.93.2026.01.28.23.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:13:40 -0800 (PST)
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
Subject: [PATCH 4/6] iio: magnetometer: bmc150_magn: add support for bmx055 magnetometer
Date: Thu, 29 Jan 2026 15:11:00 +0800
Message-ID: <20260129071105.389493-5-jerrysteve1101@gmail.com>
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

Add the magnetometer driver for the BMX055 IMU, which is an integrated
IMU including accelerometer, gyroscope and magnetometer.

The accelerometer part can be supported by the bmc150-accel driver, while
the gyroscope part can be supported by the bmg160 driver.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/iio/magnetometer/Kconfig           | 4 ++--
 drivers/iio/magnetometer/bmc150_magn_i2c.c | 3 +++
 drivers/iio/magnetometer/bmc150_magn_spi.c | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 2b81b22c9550..efcd24ef10a3 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -85,7 +85,7 @@ config BMC150_MAGN_I2C
 	  This driver is only implementing magnetometer part, which has
 	  its own address and register map.
 
-	  This driver also supports I2C Bosch BMC156 and BMM150 chips.
+	  This driver also supports I2C Bosch BMC156, BMM150 and BMX055 chips.
 	  To compile this driver as a module, choose M here: the module will be
 	  called bmc150_magn_i2c.
 
@@ -102,7 +102,7 @@ config BMC150_MAGN_SPI
 	  This driver is only implementing magnetometer part, which has
 	  its own address and register map.
 
-	  This driver also supports SPI Bosch BMC156 and BMM150 chips.
+	  This driver also supports SPI Bosch BMC156, BMM150 and BMX055 chips.
 	  To compile this driver as a module, choose M here: the module will be
 	  called bmc150_magn_spi.
 
diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
index b110791f688a..95c1fbf38348 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -4,6 +4,7 @@
  *  - BMC150
  *  - BMC156
  *  - BMM150
+ *  - BMX055
  *
  * Copyright (c) 2016, Intel Corporation.
  */
@@ -42,6 +43,7 @@ static const struct i2c_device_id bmc150_magn_i2c_id[] = {
 	{ "bmc150_magn" },
 	{ "bmc156_magn" },
 	{ "bmm150_magn" },
+	{ "bmx055_magn" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bmc150_magn_i2c_id);
@@ -51,6 +53,7 @@ static const struct of_device_id bmc150_magn_of_match[] = {
 	{ .compatible = "bosch,bmc156_magn" },
 	{ .compatible = "bosch,bmm150_magn" }, /* deprecated compatible */
 	{ .compatible = "bosch,bmm150" },
+	{ .compatible = "bosch,bmx055_magn" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bmc150_magn_of_match);
diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
index 896b1d280731..44e82cbfa5a8 100644
--- a/drivers/iio/magnetometer/bmc150_magn_spi.c
+++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
@@ -4,6 +4,7 @@
  *  - BMC150
  *  - BMC156
  *  - BMM150
+ *  - BMX055
  *
  * Copyright (c) 2016, Intel Corporation.
  */
@@ -37,6 +38,7 @@ static const struct spi_device_id bmc150_magn_spi_id[] = {
 	{"bmc150_magn", 0},
 	{"bmc156_magn", 0},
 	{"bmm150_magn", 0},
+	{"bmx055_magn", 0},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmc150_magn_spi_id);
-- 
2.52.0

