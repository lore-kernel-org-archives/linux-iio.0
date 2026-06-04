Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29144218B8;
	Thu,  4 Jun 2026 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572142; cv=none; b=Fc1PDmnLw7EiTO1n9pZtBE4CTxnuTSfRBvEce5vDvDhM4Lpx7n/hJunoc6ELXIYUa3HCvL/ROhazi697Q/8NXBwGDXH7kRrkx15rvSwzyNsPz7a06d9pnilvEFXbkDheqmlJxn0gKnD6z/voyWkIXKLfUMqXRlpni57nkTYlMPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572142; c=relaxed/simple;
	bh=Yi5A4QFTz28nFMGGoB7N6Cc+T//InI5twKASkj4LItI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SBfwD+CowMZBSMXkS9CtNeoEcajUfMngsVzQa0Lr36Kh5GPhOkqZ4aoxH7ldwTAIEpk7gR2cL6fY0+JxclM6xxlHnpe13IlgVDbJvnQxrOsnwj8DGRVNe1KK6Zd7frU834y0fuVmqKG/2V594mtyDNuxHRp+rM7vY6r30B/lsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=QRbrjFMJ; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="QRbrjFMJ"
Received: from email.seznam.cz
	by smtpc-mxd-5757bcb9c-s9zn4
	(smtpc-mxd-5757bcb9c-s9zn4 [2a02:598:128:8a00::1000:a07])
	id 203d27ba98520a3522c3bd26;
	Thu, 04 Jun 2026 13:21:55 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780572115; bh=ylYI6LhKdKUoV2xaQEl0a7EutLOX+xOOnX1wBeOKaGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=QRbrjFMJ0HhNDicQm8w6yqWE2rotiVA83T/3JAze4P846rMe/OqAngyrFjcF/bEok
	 5BWfniUk3krvqAMRERMlWtmj98430BIFjmt5dFf5s2a2ek6wmzZnlkM4zTMuiWvkve
	 EGvhzPs1TIWPbgflHxYTc75kACM3krqx+unejkS7BGjeQ+2Mwu8H+UrMXITEA0jLlO
	 rRl99Hpf7hOKP5617XlfVOuCq9L3MzDdpWAmTgeMSCNK+EdcwX9gXuLmzggJh9oXHa
	 /7hFR7eBQH8bo3a1GIsxyVC5mY53+WRRJkDaFMj0rYV0jF9amKwwiDug8judRwDVs3
	 MrYqtqaCFOvUA==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-d5tsb (szn-email-smtpd/2.0.73) with ESMTPA
	id 1879c5d2-af6e-4f11-a13f-d1d65f1a7f74;
	Thu, 04 Jun 2026 13:21:46 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] iio: accel: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:18:59 +0200
Message-ID: <20260604111921.106936-1-vo.kratky@seznam.cz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Found by Coccinelle.

No functional change intended.

Signed-off-by: Vojtěch Krátký <vo.kratky@seznam.cz>
---
 drivers/iio/accel/adxl313_i2c.c | 4 ++--
 drivers/iio/accel/adxl313_spi.c | 4 ++--
 drivers/iio/accel/adxl355_i2c.c | 4 ++--
 drivers/iio/accel/adxl355_spi.c | 4 ++--
 drivers/iio/accel/kxsd9-spi.c   | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
index b67ff0b4dc54..940f5dfc4ba0 100644
--- a/drivers/iio/accel/adxl313_i2c.c
+++ b/drivers/iio/accel/adxl313_i2c.c
@@ -76,8 +76,8 @@ static int adxl313_i2c_probe(struct i2c_client *client)
 	regmap = devm_regmap_init_i2c(client,
 				      &adxl31x_i2c_regmap_config[chip_data->type]);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
-			PTR_ERR(regmap));
+		dev_err(&client->dev, "Error initializing i2c regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
index dedb0885c277..254232ffb2e2 100644
--- a/drivers/iio/accel/adxl313_spi.c
+++ b/drivers/iio/accel/adxl313_spi.c
@@ -84,8 +84,8 @@ static int adxl313_spi_probe(struct spi_device *spi)
 				      &adxl31x_spi_regmap_config[chip_data->type]);
 
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
-			PTR_ERR(regmap));
+		dev_err(&spi->dev, "Error initializing spi regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
index 1a512c7b792b..5e6aa5ba306a 100644
--- a/drivers/iio/accel/adxl355_i2c.c
+++ b/drivers/iio/accel/adxl355_i2c.c
@@ -31,8 +31,8 @@ static int adxl355_i2c_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init_i2c(client, &adxl355_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
-			PTR_ERR(regmap));
+		dev_err(&client->dev, "Error initializing i2c regmap: %pe\n",
+			regmap);
 
 		return PTR_ERR(regmap);
 	}
diff --git a/drivers/iio/accel/adxl355_spi.c b/drivers/iio/accel/adxl355_spi.c
index 869e3e57d6f7..ea22cd290c4d 100644
--- a/drivers/iio/accel/adxl355_spi.c
+++ b/drivers/iio/accel/adxl355_spi.c
@@ -34,8 +34,8 @@ static int adxl355_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &adxl355_spi_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
-			PTR_ERR(regmap));
+		dev_err(&spi->dev, "Error initializing spi regmap: %pe\n",
+			regmap);
 
 		return PTR_ERR(regmap);
 	}
diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index cbb6c6412665..afab3e1f651c 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -21,8 +21,8 @@ static int kxsd9_spi_probe(struct spi_device *spi)
 	spi->mode = SPI_MODE_0;
 	regmap = devm_regmap_init_spi(spi, &config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "%s: regmap allocation failed: %ld\n",
-			__func__, PTR_ERR(regmap));
+		dev_err(&spi->dev, "%s: regmap allocation failed: %pe\n",
+			__func__, regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.54.0

