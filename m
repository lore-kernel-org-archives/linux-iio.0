Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D47449EA9;
	Thu,  4 Jun 2026 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574624; cv=none; b=ih8lhZa77zhPqlCn+c8NRqsBHHmxwvJBEJBmfFENHCSoAibBazvLoz8KZoXPRzFV+7bYWWPAT+tszla1oOwHGzFVDNy4R96ROOAmO0eAlLmxZRA5vrPB+5SIz7gODUoC5dcH+vSYdQmSG/15G5FdCUw+uFnZrMoa8073dK4mL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574624; c=relaxed/simple;
	bh=FHUaeD7z2WrkyVK0u9UHCN8nHrpW88eRRrcqb7oGfxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osGanWoSIpYApcPlHncHv7BQsLODvdEooGx/GqHtHc5ylOyF0zFe6lj6oJfXMCXxh3fg8LeJg5Ti/WMsRNNlnksg/+16VGw8nvWIFaTx6s4x32lPZNfwbUCdAyJ3/zAqacJ2nX72UUhzuYCzNgv+zG9HJjWyPdZK4BjW9R5F1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=feTXYW00; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="feTXYW00"
Received: from email.seznam.cz
	by smtpc-mxd-85fb448c55-l247v
	(smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
	id 11c5d2f6a9aaff79133b486a;
	Thu, 04 Jun 2026 14:03:25 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780574605; bh=Qi1lv9P5DOxeNipYtArkdhWu6v4Aww9wj4aPrgUadZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=feTXYW00tkgQOPCEhp+YP9uJO1wwdzrab4CjyAvM8WoAUqgL+wisoFS4rpKbctyCO
	 +Eh0aFR4B2wcEJjyJcU8vCxXWTA5PZ5aPipLirXQmimcAzUelsZJ9yQG0BbBlFp6qO
	 xKyxSAXdCufO82fEquwg3IydgX5RRlXqSEpwrmuTvhmHsJ73lTrYECalGFwePiVJcf
	 avN/2Miv5nbDY2Wo5BB4uaGiC++rFH6bvwuw0piBlWPpF7y4NKVHRd8MAdUCgRum5H
	 zUMEQUkQTqbCd+H4GfE0CRfV4N2aOLluSuR4d83KdAx/O8mE4yp0ooxhxx9vgUYkpb
	 D68V3DytFZkoQ==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-k9lmt (szn-email-smtpd/2.0.73) with ESMTPA
	id 3f034d26-420b-41f7-a328-caec6d1f5ce6;
	Thu, 04 Jun 2026 14:02:51 +0200
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
Subject: [PATCH v2 01/11] iio: accel: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:59:21 +0200
Message-ID: <20260604120201.116925-2-vo.kratky@seznam.cz>
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

