Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059BB42315B;
	Thu,  4 Jun 2026 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574595; cv=none; b=YlAfmVDJ7yPJLDguR55GglCLB0pbW1Fz27yTsFB70RIFCF94G4jc7s8aifWa+L158DfnDhnfx6mTKwrl6zQuyf/4p3pJ1h9oIf88EsuNorqZLlEMCox6Yg3fkAfyPBPAAFkwI8K8kg3L24CteMXfzIATlgUgXqLWIcUVTM/NxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574595; c=relaxed/simple;
	bh=o/r2e9g7zQk3LlJgStSz4W/wpwGS3HkwebK2A+571Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQJ9/2yHEdmw1gOH4wiQ1GsSQg5Zd8h3i4rXFMWeZKi4RWmesgVKdI3OFnsOAvsof8+BJuD9WYG0xyOjxV3upIe5B0Haxz1GTamBqH1BDELmdyGm8jZjIUWQrxFH+IGJ5Bpo2pKjpLJMUW5Ke6P3iwV7DnvIvd7vKdiSCGirock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=NGaOahb1; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="NGaOahb1"
Received: from email.seznam.cz
	by smtpc-mxd-85fb448c55-l247v
	(smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
	id 4cb884ccf4d7a9434e461e50;
	Thu, 04 Jun 2026 14:03:04 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780574584; bh=6hXrbMM1T2BVeFrkQ/L4qig2rPtzOvLr/FXvKnsP3zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=NGaOahb10uoJicbmkf0BAYMRhTaJi14XAZCmPXZlfInDfaKMyclAVpE9PCag7fGYv
	 wKPCySPAemjPvJxnem2giFCH1NFi7sIQLCTmTaEvOrS65HjJ2U0VyaLnHlaO50kJD2
	 IvsQlaE+5kW41ImTSjnGgRQmyLdp5fTZ8IBC/te6dlbBAbaQ4Cv4fWT/7k60wIZMoV
	 oqnHIGYELxs3zSW6oPPZhyGCFEU4yOdB4IPLlP9aA9lxxF2IUbcUSllnM7PaZrHknJ
	 xMB8noXRTnizr6k2SfvnIcWJIzpkjkVtfiqspUa2bomwbdhcnBql0idpH8Jmfwgvlm
	 rVuYfxb0vwyVg==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-k9lmt (szn-email-smtpd/2.0.73) with ESMTPA
	id 962b2e4e-0643-46d5-8e5f-dd6fb52470fe;
	Thu, 04 Jun 2026 14:03:01 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Remi Buisson <remi.buisson@tdk.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] iio: imu: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:59:28 +0200
Message-ID: <20260604120201.116925-9-vo.kratky@seznam.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604120201.116925-1-vo.kratky@seznam.cz>
References: <20260604120201.116925-1-vo.kratky@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace numeric PTR_ERR() logging with the %pe format specifier
so that error values are printed in a more readable form.

This change was identified using a Coccinelle semantic patch.

No functional change intended.

Signed-off-by: Vojtěch Krátký <vo.kratky@seznam.cz>
---
 drivers/iio/imu/fxos8700_i2c.c                  | 2 +-
 drivers/iio/imu/fxos8700_spi.c                  | 2 +-
 drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c     | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c     | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c     | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_i2c.c b/drivers/iio/imu/fxos8700_i2c.c
index 2cc4a27a4527..d60b62417325 100644
--- a/drivers/iio/imu/fxos8700_i2c.c
+++ b/drivers/iio/imu/fxos8700_i2c.c
@@ -25,7 +25,7 @@ static int fxos8700_i2c_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init_i2c(client, &fxos8700_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %pe\n", regmap);
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/imu/fxos8700_spi.c b/drivers/iio/imu/fxos8700_spi.c
index 6b0dc7a776b9..8d89ce8e92eb 100644
--- a/drivers/iio/imu/fxos8700_spi.c
+++ b/drivers/iio/imu/fxos8700_spi.c
@@ -16,7 +16,7 @@ static int fxos8700_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &fxos8700_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %ld\n", PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %pe\n", regmap);
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
index 9247eae9b3e2..e08f9605c8b3 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
@@ -45,7 +45,7 @@ static int inv_icm45600_i3c_probe(struct i3c_device *i3cdev)
 	regmap = devm_regmap_init_i3c(i3cdev, &inv_icm45600_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(&i3cdev->dev, PTR_ERR(regmap),
-					"Failed to register i3c regmap %ld\n", PTR_ERR(regmap));
+					"Failed to register i3c regmap %pe\n", regmap);
 
 	ret = regmap_read(regmap, INV_ICM45600_REG_WHOAMI, &whoami);
 	if (ret)
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index b2a7c2eaf50d..8a2b50a35f33 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -34,7 +34,7 @@ static int st_lsm6dsx_i2c_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init_i2c(client, &st_lsm6dsx_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %pe\n", regmap);
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
index cb5c5d7e1f3d..7326388cf228 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
@@ -34,7 +34,7 @@ static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
 
 	regmap = devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(dev, "Failed to register i3c regmap %ld\n", PTR_ERR(regmap));
+		dev_err(dev, "Failed to register i3c regmap %pe\n", regmap);
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 3389b15df0bc..75a7e0ab9b12 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -29,7 +29,7 @@ static int st_lsm6dsx_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &st_lsm6dsx_spi_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %ld\n", PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %pe\n", regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.54.0

