Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911A42EEBB;
	Thu,  4 Jun 2026 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574598; cv=none; b=cnW++g2VJ+6kXdmGP/vhWST7TQJB0b0KGU1M/vnYHKBBoUSm8I+renn5mrOUwbR496pprTlIRFxPwzyX/DcyVrV/awfWTfLUi8qDGTRK4bZBbChxiREv+O+ti7qY5gx7aaEchxXp/rNtBdyOtJ2ixN0gkFrmPANwKWVUei5RVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574598; c=relaxed/simple;
	bh=IUQJgT4A5z6he1kxnus3Y6u4DgvB9UZ1Xv/lv9g+8IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQQztBA8ExjLQhHHeZ/BRsfAR7nRofXRAvMvj9gwtBsUS3DYyuMH0trh4Q56PqcnvVFvxhGDUtrlTzZoUdoVu+c7ZkoYMSRbwKsAKDVJGeZo3EMXjs9u5J24cFgy3z3mtbLLfkBySfNKBm5TvAGB2zTPpeTVXiMgb+FP9j83qDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=KuImsu5j; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="KuImsu5j"
Received: from email.seznam.cz
	by smtpc-mxd-85fb448c55-l247v
	(smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
	id 0fe5a62bb78a8ba40d1b3cb7;
	Thu, 04 Jun 2026 14:02:58 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780574578; bh=hTwEb3zsyzTF2UsDQB5C1zB7wKjH8+HDAyAiXN68r/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=KuImsu5j3RcIGWppNTd3Uw6Ov4m/MsNv6csIiofQa/aSu917R+J8iuKEXapdN2YIB
	 TVj3V+THzaxDxbLzxnyUvgrgugLy01ct88A3HUraaCOTp4ziCXZNR937RTFegArDN/
	 xC9B3NBdB1Iwqu/lrmCLz/fKVUhsfM1bnOBLqR4FE3LFK4r5A0vxiHFtDruopfM+0l
	 3KcMNVMZfCX2HHeanFRslbZewtRLbsGXlAS6aBxKMYfQX0ee1gLhyEbDMF4uNVgi/f
	 APgJP+zbGxKTgG1xdZfesCQvQ9zNgsnE+o44OECxM2wsZHiwFIZaZLOC7ElwQCXwwj
	 NTkTAXG0cQrVw==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-k9lmt (szn-email-smtpd/2.0.73) with ESMTPA
	id aaaf24f0-fc12-48a0-9550-7c1dcf52fd36;
	Thu, 04 Jun 2026 14:02:58 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] iio: dac: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:59:25 +0200
Message-ID: <20260604120201.116925-6-vo.kratky@seznam.cz>
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
 drivers/iio/dac/ad5770r.c | 4 ++--
 drivers/iio/dac/ltc1660.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index 6027e8d88b27..0a0ce3302a8c 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -607,8 +607,8 @@ static int ad5770r_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &ad5770r_spi_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
-			PTR_ERR(regmap));
+		dev_err(&spi->dev, "Error initializing spi regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 	st->regmap = regmap;
diff --git a/drivers/iio/dac/ltc1660.c b/drivers/iio/dac/ltc1660.c
index 6e80b49f4665..5875ad726794 100644
--- a/drivers/iio/dac/ltc1660.c
+++ b/drivers/iio/dac/ltc1660.c
@@ -167,8 +167,8 @@ static int ltc1660_probe(struct spi_device *spi)
 	priv = iio_priv(indio_dev);
 	priv->regmap = devm_regmap_init_spi(spi, &ltc1660_regmap_config);
 	if (IS_ERR(priv->regmap)) {
-		dev_err(&spi->dev, "failed to register spi regmap %ld\n",
-			PTR_ERR(priv->regmap));
+		dev_err(&spi->dev, "failed to register spi regmap %pe\n",
+			priv->regmap);
 		return PTR_ERR(priv->regmap);
 	}
 
-- 
2.54.0

