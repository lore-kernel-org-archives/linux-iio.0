Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A827BF79;
	Sun, 26 Jul 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785079426; cv=none; b=Ze8IeBZZvSSEHFxjFQjcgzoKrMYqLUW7FkAMoFc/LsmTlrwSSZPoHnHZ6/N1NAo4CZ91FA2hGcjINm+vwCgmCugZwcYs4KCZVyjnDskqzx0zSduo+umQJ/x82gqgEZu5PFDHrh3A6HWGTRkx4NK+r8yRAnq+HoxTbeK9hvEHPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785079426; c=relaxed/simple;
	bh=KNDkYcsJP3oPIBIY5BZ9MEcEmeZuUoXE96o75ub6aVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MeEZ95w1vOO1YKelxnvdmhUkNjDdzqsnxoWrtFufZoEQnvQBEgSRAtJB3E9FIDOZuh8hL9Enx6gEWsASymJoT9sofoGZT2asTcLUaOSw6yQCQK5AybgygRWH30jrHouPKdrQYzoHFaYb3hQktJsqgftJtTNk6eCxhi0Rj2aXnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=Ph5exH6g; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="Ph5exH6g"
Received: from email.seznam.cz
	by smtpc-mxd-7457b5647d-hg8d7
	(smtpc-mxd-7457b5647d-hg8d7 [2a02:598:96:8a00::1200:712])
	id 63f95e7cdb9673f36107c4e0;
	Sun, 26 Jul 2026 17:23:40 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1785079420; bh=YBjS/UyXFvEwqU8l9ZCUWuzHEEETAl8/yMgYurhfG9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=Ph5exH6gaBHzIlJsTeVD5Pnjf92qHuYPU7L/1x8Kd4qNDBstxbrRSmpL8DafZr45h
	 VYYBgLBmy3rxMaOam5qMgkej+6yi7TUea26UqbjryuLMUqTuyGIaz9BWWG331O1q+U
	 g+XAR063ZLzL3RfOUR4m6a/+jNs2+HCnC19noFSOKXDQwY0Yd3zcPObCdiVrFwmA1i
	 UAnHNYYqX5C+YBTOrkNjXRSxZ54eXqBSHBizmrzh4E8rJFiFiqaZ6JHID47soUiIVj
	 tXNbnx54/7aUXmTYlgOZ84KvbcuMKybTwr3idOVZ+p+mhk7iAue5b7tsc2K7DvDcRY
	 Ud4oFNq+U+b1g==
Received: from archlinux.localdomain ([88.146.244.229])
	by smtpd-relay-7f78fc978-g5qpw (szn-email-smtpd/2.0.78) with ESMTPA
	id 74bf1343-bfa9-4cd2-92f7-ce57cdaf3424;
	Sun, 26 Jul 2026 17:21:18 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: 
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Siratul Islam <email@sirat.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: chemical: bme680: Use dev_err_probe()
Date: Sun, 26 Jul 2026 17:21:07 +0200
Message-ID: <20260726152111.171339-1-vo.kratky@seznam.cz>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Used dev_err_probe() instead of dev_err() to simplify error handling.

Signed-off-by: Vojtěch Krátký <vo.kratky@seznam.cz>
---
 drivers/iio/chemical/bme680_i2c.c | 7 +++----
 drivers/iio/chemical/bme680_spi.c | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index 4cc0e491621a..c34d67bcb2a3 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -24,10 +24,9 @@ static int bme680_i2c_probe(struct i2c_client *client)
 	const char *name = NULL;
 
 	regmap = devm_regmap_init_i2c(client, &bme680_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "Failed to register i2c regmap\n");
 
 	if (id)
 		name = id->name;
diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index 785200a6fd65..e6f9b6b7f8e2 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -121,10 +121,9 @@ static int bme680_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init(&spi->dev, &bme680_regmap_bus,
 				  bus_context, &bme680_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %ld\n", PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "Failed to register spi regmap\n");
 
 	return bme680_core_probe(&spi->dev, regmap, id->name);
 }
-- 
2.55.0

