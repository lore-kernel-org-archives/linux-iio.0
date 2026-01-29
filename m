Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6917212B0A
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670814; cv=none; b=PvyIa8P2GSM/daFolKhJ+gPymXg3mvgKb/4QH3OFm6Os/fYhII6JdiI7CO3mYPpH7i++EvJ/qv3PGABFjngn+KA3ZOyWYZSZ8z6MiWuhhB2p0EJDNN9ON18Hgejagnhk1rNGLo2ipp6FbLief2KR+9WexUZRuNUrqNegz5sI1lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670814; c=relaxed/simple;
	bh=kJASS6kCGeKvWU30kvR7qv4p4toWG+FsWczi8gNUNbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V09qYJ6BRmVH/rGHplR+FsIQ+Rvez3+fR7LNfuQSUJPhmDzNGVlJjl/QBXqqTpToda6PoleoeXtVDj7LMsw0z433dl0to2XzNgHtFDJ1peUdPgrKJgwXPun8HTIRPHuEYa6ezbAGAyGvGNjhV/aXLpAmE2cqRET6G+PvVYH8Uao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+W+dhIj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+W+dhIj"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a1022dda33so3553205ad.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 23:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769670812; x=1770275612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8APmHWc5ypzuFTbXUx1GdFASxb2Dh1Ot/Xnqt6T20aQ=;
        b=h+W+dhIj7MnqfLzDRZJqEBRkLgT0n8iiuveOS1YGre4m1eybiM4/tZMzzc/rLkjiVJ
         mSLoOqIDdusFSncjp2gwN9Vu+w4BbXy7pqXlxQxd17m8UI6q72I0H0xoqR5Vm/V2hEb9
         LH9SA0iX1hIzBfYx781eFVw25Nbcj+kEjzNEU6HmpFfXBXilAxCtTKnRNTD617E1vXEi
         oXvErv3FOaPeiqC+MkiSHAvKtMT1KkYIXe1lR5t8HHWJVug0oPnHOYlY7UuHxfSnGzr0
         sAlUbfWqfh5mhge+48fbLZY0wgKCWis+BQFsI7k7VdwZw79jmxbp6KBTG/VNSreDnuEK
         5AOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769670812; x=1770275612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8APmHWc5ypzuFTbXUx1GdFASxb2Dh1Ot/Xnqt6T20aQ=;
        b=n8hcfEhRuyS2jMST4YDQmcZU1u1rD4yBI78XYJlnTKdaEmyP7NrN/XFFbpYrwX+Pwy
         L848O347SmfTUukU0eNBI5V3r4qCGVvn9MOpn9L90LF9DIyrz952tH2WpXjqIemcviC3
         ksA1fLxHiZR0YCnLOHhdWejpx3YZtfnEONwSG43/lSluqNRCBe+piSr6Egfz9qOpTDkP
         fsR0ZknKmIkSDc2ThKYE2Bovw1PGEZrjeFHyi869Fqu6tGehKlQ/Od5Ym8TK+NsGnDhv
         XTy8xTLGyB6pPYPbsOP8G4NAph3/9h6/cT1E+toHYb2loKsPBD6hxurx67zuOwmXMPI1
         WO7A==
X-Gm-Message-State: AOJu0YxNssg4rSLVRr1Aq/lo6DlY7BKMlz469JbBDiwhDHON3hIyb5le
	ugSJXv808059jEM/tpKSK70rw7WJCN8Xy/8SOq2GX1zXtQKkG55dJYFhiUJ3C5xO
X-Gm-Gg: AZuq6aI1l8O+Vileg9diGNpJzVdqp+YntGYQ5JE8vOi+70ANAJ+ex075eWxtGecApqk
	nEy5ol40/eh0OGdqDXem7Kf/3LFwq5xraYq03c2pnGdg9LhmMFBio+iKMaoR7Ex0yailcZ8Rn0C
	c5EuC5tvtNPos/aJDf8diSW8rUjdnOC/JKIrx64EeWKwwWpIVRHHixUyzndygm0YnNyAWJhe5KP
	NOXsJWiQea/VlRpsetOEIwyTT+5Ssa5eXaTfl9/M3Asn8V4fzioXKg7oI2nosFqtPpPVOdoIUXc
	rkelJJzTukyCCX0A7O7xAYnmh0KZs/ab2kYiM38g+u5ibVnBZT4e5fveCsodfm4heC7sKCOmi8q
	hEWtMGTzimCbq0VLt/8sIo3qt46v0YEM0qS72bvYIBW8pWeOj59aIM+Nq80dRvZKJcGxRR1HdgO
	oL9WDft+7QYF3CsblD+yrEgzSsWfh2rIdFWc2kZE6OmW7cpyid
X-Received: by 2002:a17:903:1206:b0:295:99f0:6c66 with SMTP id d9443c01a7336-2a870db475dmr77819725ad.36.1769670811873;
        Wed, 28 Jan 2026 23:13:31 -0800 (PST)
Received: from arch.localdomain (awork135098.netvigator.com. [219.76.135.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6ed92dsm44160135ad.93.2026.01.28.23.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:13:31 -0800 (PST)
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
Subject: [PATCH 2/6] iio: accel: bmc150-accel: add support for bmx055 accel
Date: Thu, 29 Jan 2026 15:10:58 +0800
Message-ID: <20260129071105.389493-3-jerrysteve1101@gmail.com>
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

Add the accelerometer driver for the BMX055 IMU, which is an integrated
IMU including accelerometer, gyroscope and magnetometer.

The gyroscope part of the device can be supported by the bmg160 driver,
while the magnetometer part can be supported by the bmc150_magn driver.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/iio/accel/Kconfig             | 3 ++-
 drivers/iio/accel/bmc150-accel-core.c | 2 +-
 drivers/iio/accel/bmc150-accel-i2c.c  | 2 ++
 drivers/iio/accel/bmc150-accel-spi.c  | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 3d3f8d8673dd..757b7e6bc51e 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -281,11 +281,12 @@ config BMC150_ACCEL
 	help
 	  Say yes here to build support for the following Bosch accelerometers:
 	  BMA222, BMA222E, BMA250E, BMA253, BMA254, BMA255, BMA280, BMC150, BMC156
-	  BMI055.
+	  BMI055, BMX055.
 
 	  Note that some of these are combo modules:
 	    - BMC150/BMC156: accelerometer and magnetometer
 	    - BMI055: accelerometer and gyroscope
+	    - BMX055: accelerometer, gyroscope and magnetometer
 
 	  This driver is only implementing accelerometer part, which has
 	  its own address and register map.
diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 42ccf0316ce5..5f33273adc0d 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1132,7 +1132,7 @@ static const struct bmc150_accel_chip_info bmc150_accel_chip_info_tbl[] = {
 				 {306458, BMC150_ACCEL_DEF_RANGE_16G} },
 	},
 	{
-		.name = "BMA253/BMA254/BMA255/BMC150/BMC156/BMI055",
+		.name = "BMA253/BMA254/BMA255/BMC150/BMC156/BMI055/BMX055",
 		.chip_id = 0xFA,
 		.channels = bmc150_accel_channels,
 		.num_channels = ARRAY_SIZE(bmc150_accel_channels),
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index b4604f441553..6ba07c027b64 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -255,6 +255,7 @@ static const struct i2c_device_id bmc150_accel_id[] = {
 	{"bmc150_accel"},
 	{"bmc156_accel", BOSCH_BMC156},
 	{"bmi055_accel"},
+	{"bmx055_accel"},
 	{ }
 };
 
@@ -271,6 +272,7 @@ static const struct of_device_id bmc150_accel_of_match[] = {
 	{ .compatible = "bosch,bmc150_accel" },
 	{ .compatible = "bosch,bmc156_accel" },
 	{ .compatible = "bosch,bmi055_accel" },
+	{ .compatible = "bosch,bmx055_accel" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bmc150_accel_of_match);
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
index 26ce50b37716..90d5be54d76e 100644
--- a/drivers/iio/accel/bmc150-accel-spi.c
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -62,6 +62,7 @@ static const struct spi_device_id bmc150_accel_id[] = {
 	{"bmc150_accel"},
 	{"bmc156_accel", BOSCH_BMC156},
 	{"bmi055_accel"},
+	{"bmx055_accel"},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmc150_accel_id);
-- 
2.52.0

