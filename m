Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C6421896;
	Thu,  4 Jun 2026 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572140; cv=none; b=uUp5IKB1WMQJE1KTsWKcLsnbN9eSaREM2qSbaYvvMZbTXcFKm6jb6hBfseuU8jFWKKFhbpIDF+OJkNbdEWAkUj4qS7fUnsxiV6Knxk4oGH5eosWfFGmLUcTEhvzQ3e7RtwqlXjtCkQno0wsfZQHu2Wnxz75ylU4gbEX5edgH9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572140; c=relaxed/simple;
	bh=ffuhcNpMHdglk2WjdpuyY6i2gxxQsvWhB2Ci6lMtJNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYoBlBt3xXvmqZsrTmgOa+hCs37FBq8P9FoBHa/Dj6Mp0Hl/QmdgiPdE9DjrSDYhqdbCDPFv5nw3xBM3kGkhtL4WrMYSkoYCuNO5TV8YFjfcbJxarWXoodDh7iGTMo/ro6yqhCxNTOUfAxdejiPlPDhjgKN6sZBh21lCMgJ2CNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=Pu+Oori0; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="Pu+Oori0"
Received: from email.seznam.cz
	by smtpc-mxd-85fb448c55-l247v
	(smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
	id 5d530e08e53c23875fad9494;
	Thu, 04 Jun 2026 13:22:10 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780572130; bh=1bvg8zYnyMyCjJqKJ4h8h8tAERnyEf1dZrppLbq6m04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=Pu+Oori0ifiOuVz6gArb05J4iV0jZLXdHcajBSWveNK2WFO4YDja6yWcRzz/7/0A4
	 CSzWLO4zQxY4C3XllHm9xw2xNNPgg+BeciiAqovQnouGzAxeO6AV/GYnzbwc5Sat1r
	 OwRAa6dU7Eiysv8nRAgR8nrn7Vr7w7bYYCKPG70QAeXi5mX4ArbjRT4in0SL7K+Jz9
	 n2eJHdJA44TJeV3y3zmpPQMfZNHtY9A724X4HGIqge8fpwzL30uTxFYEMU46iAj2NL
	 tqeqgr+nb/ex2+Dm3rPS0K/EKOvSo0/DcbRau1pWDzWExOgShlODZAPde5Mfcx/z7k
	 xJCArs28R3yFw==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-d5tsb (szn-email-smtpd/2.0.73) with ESMTPA
	id 927307c4-0dcc-4065-a5b3-a79d5257ff9c;
	Thu, 04 Jun 2026 13:21:50 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] iio: chemical: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:19:01 +0200
Message-ID: <20260604111921.106936-3-vo.kratky@seznam.cz>
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
 drivers/iio/chemical/bme680_i2c.c | 2 +-
 drivers/iio/chemical/bme680_spi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
index 5560ea708b36..f812a56bfd26 100644
--- a/drivers/iio/chemical/bme680_i2c.c
+++ b/drivers/iio/chemical/bme680_i2c.c
@@ -25,7 +25,7 @@ static int bme680_i2c_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init_i2c(client, &bme680_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %pe\n", regmap);
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
index aa97645ba539..d557d92007b1 100644
--- a/drivers/iio/chemical/bme680_spi.c
+++ b/drivers/iio/chemical/bme680_spi.c
@@ -123,7 +123,7 @@ static int bme680_spi_probe(struct spi_device *spi)
 	regmap = devm_regmap_init(&spi->dev, &bme680_regmap_bus,
 				  bus_context, &bme680_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %ld\n", PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %pe\n", regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.54.0

