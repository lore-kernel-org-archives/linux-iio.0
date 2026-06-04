Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E338422E;
	Thu,  4 Jun 2026 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572139; cv=none; b=kT47a6xpCItC9vUrFexdwme+B0SIY+6+t6vidGEZkgz1kZ2Bptf+Uwqfft4P8IoqJDikn7UST7GN3qVn80QZ7oKVHvrruaArUrZv2gXJxzZxtKR3g/ckh903mJGt0TyuueCownXAVHCz8+BCPlVdGXO8E0kCooMDMZYYOMf9SRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572139; c=relaxed/simple;
	bh=m/msBevO/iQZVT89dzqHcqWLkM5e49iFGIMHNtTWeFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fa9QQbgEDaeecOAbXHPZ1w+SqdjOWHKSyS6mQezCEjktTKDz487eVO8yDUlDL9AfJYNRB5MG8+dCjD/55TLtwxiq26yzTqXewXvRu1sC+njLsDNpfwCoF5kSIXMlwzYtZiKR50W5Zhi0WaAy7BHNI4BaXKRTQz4tulxPnYpdT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=QU+cdloE; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="QU+cdloE"
Received: from email.seznam.cz
	by smtpc-mxd-85fb448c55-l247v
	(smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
	id 460751b9fe687c3644f9cb25;
	Thu, 04 Jun 2026 13:22:09 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780572129; bh=xDRt1Dcqkerhgdjm9mpPX5GDQJrDGK1nLvp9cUFugzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=QU+cdloEkQBy/gqS3/IO0CA3gCSPoZBkkodNJIlzK1ocS4BCRPKspzKES7HXu7W2i
	 LY7zPzNQR7el99gYVvDsqIxHUIpRg88j9c/Roc3ahnQ/GdTrrnWU81P/BL3aarXUTL
	 ZoYMs7TNf1GAVl1SycD/Ak4MFezi2xVkIb43NUa5Mb/9WwPjzgOkTg0q5TiHY1PVUQ
	 whfWFdR7viXcgB4wpCIiBgWG5tHztncgFIKI+XcRYn5i/7wP0Kyu2VS5vnHAHKSvk5
	 Cbu+YWU3RgBniG0iKcieFzct/pklacaxmbHgsNJBgKesQFw+lv72P+W1l43NfW57CO
	 hvB/QKfWB9EFw==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-d5tsb (szn-email-smtpd/2.0.73) with ESMTPA
	id 84957538-b7fc-4490-86a8-1a7ef89eb2bb;
	Thu, 04 Jun 2026 13:21:55 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] iio: humidity: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:19:05 +0200
Message-ID: <20260604111921.106936-7-vo.kratky@seznam.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604111921.106936-1-vo.kratky@seznam.cz>
References: <20260604111921.106936-1-vo.kratky@seznam.cz>
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
 drivers/iio/humidity/hts221_i2c.c | 4 ++--
 drivers/iio/humidity/hts221_spi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
index cbaa7d1af6c4..bf15f03cd3dd 100644
--- a/drivers/iio/humidity/hts221_i2c.c
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -31,8 +31,8 @@ static int hts221_i2c_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init_i2c(client, &hts221_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
-			PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
index e6fef2acd523..15e46ad8707d 100644
--- a/drivers/iio/humidity/hts221_spi.c
+++ b/drivers/iio/humidity/hts221_spi.c
@@ -31,8 +31,8 @@ static int hts221_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &hts221_spi_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
-			PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.54.0

