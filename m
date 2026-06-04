Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5027410D1A;
	Thu,  4 Jun 2026 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572143; cv=none; b=T5ppV1ub5S60SuttTSa+jah/1v5Et4Z/aLsFaC7eIAB+YQYb4KrTVBqow9VKPS6oBHbyAEDB+Ql7s9Eqd8A/IJPYCa/Kc0h4FkvDAXjOcNetdGZQU3mZEaQU0LEYqMUdPhWGxDzhygthJ/VIch9hodj9RSRLdY4k4TrXzjZ+uYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572143; c=relaxed/simple;
	bh=DDGLtFqHkWTO4WQZk+TiCW3zxIQA5pMLLYR8PK1+7Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SH+cJWCLDPI+LgRHfsQ6buDgNN7MOJvOY0ZaqV5iwK0Zu6tCRTj/+dCcfolzOAQOJHKZpTgmThZzIilbeivXUBF35XZZBXBNQ2HCXuuiBjaIuvlDSb8oCutOy4zLiq1UqTfIxIas+t7s1+RnIZmADyMvx99u/ThF4+QsSque1Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=CEfVwUwJ; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="CEfVwUwJ"
Received: from email.seznam.cz
	by smtpc-mxd-85fb448c55-l247v
	(smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
	id 4ee6f696f689db194c186c0a;
	Thu, 04 Jun 2026 13:22:03 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780572123; bh=sQK7V8zSOLRe8w2MPRVyocxXDMuzOal+vJ+FYMRQ0+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=CEfVwUwJHusW/9qcRB4N45z3usc43zfEoLrBjDx5I+dD15BNBjE57oYK7H9+gbfIe
	 kW5r3uhWFqowS78D247W3hKQcBXEBVYA6mAxo4eSP7NGinIxWVl4h+A1vUN1bMYboq
	 8ycEFa1K2qLrlORNGr90yslXVRNglQ5arJAWqt9rKSQKgVlCTIVXapMgXddVPNVBwn
	 B8/zRT9qPoAKdoRC8fp2Il+UBpOQSeGdMBun7/wKsyDwQhsLIrE4HheDi/QwA6FNP2
	 mdTS6gCa8HQk0xuZf43mIkEXfe+8xl0JKDUgzFUObnbKcgE4oyEOb2dGUPZwXLkuLx
	 Er6wl1I5q0sCQ==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-d5tsb (szn-email-smtpd/2.0.73) with ESMTPA
	id b87cc012-1511-46a6-a389-4b899679c42d;
	Thu, 04 Jun 2026 13:21:53 +0200
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
Subject: [PATCH 05/11] iio: dac: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:19:03 +0200
Message-ID: <20260604111921.106936-5-vo.kratky@seznam.cz>
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

