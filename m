Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172038399A;
	Thu,  4 Jun 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572136; cv=none; b=muk0f83pT4ktCU+VEaJ5XHRBTXsYiGWezMsqmvt8D9RAHMcA6SZ7woloSSwbiy3dpe0ukNzwpBGD/Y1NYA9XJZDFZOah6fp0n1uwy/1Lm090gRBKEv8tbEaBscEQVl3FBLGD3leC5L/dyFJowydXKmePoCrXVyOEliE5z4gqa2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572136; c=relaxed/simple;
	bh=AJUZgEZP456VlyGWdfff41a/Nn4pRxr8oNfOxk9M7H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mozVOM40aowZWIEEJGiDk5b4i4Vosc7KPfNfExOCkZlqHeuQMP+AJ9hfptOu0rkzT06+JiIsdWTmlOnx6BaaCvrW9dVgte1RigVhISKsNnR8jEUj5kzn/7T5NFINwu+snZ0PL7ENKsGhTDVYHsJD/BILX2evpEQOJOL6DXSLiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=fXSCvtIV; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="fXSCvtIV"
Received: from email.seznam.cz
	by smtpc-mxd-85fb448c55-l247v
	(smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
	id 17a227bbafcd0a34155cbd27;
	Thu, 04 Jun 2026 13:22:03 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780572123; bh=awpDKfJhKBGcUjjUv+N0K+3dn3LQsDMzBANkov73OY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=fXSCvtIVjWeiauiC1/UbalZ+ZP/+T6/CmR0Dy/llnP7yjFytbbSbUXu7WObRGxB8Y
	 JvmbasEHbRMiUzP6OiNPzI2txMWnJcIymxOptJhXEKVlSCAs0agu/2dQsd3XfBLBRv
	 ULnqMhDr57QLxMne4C3So+6NkE9igSBoGj+SZ6g/wEA30q44a7S5/R04EvVPTFSvW0
	 ZRLVKsnYu/DdafPtPdnyMCdrQLIWpKJZ2RcU8zx5P0G/HtNwlg2l0HHGHepbLw+3Ds
	 DJ7z/x0zy6MSGmJ6PujwocM59FESvRvPMmsECG/LIe+C6csKEo0jjL0nib7ub3A+Bt
	 atXQ/jLDO+Eog==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-d5tsb (szn-email-smtpd/2.0.73) with ESMTPA
	id 4f06d159-aef0-4e1c-b458-8ca739527c71;
	Thu, 04 Jun 2026 13:21:59 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] iio: light: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:19:07 +0200
Message-ID: <20260604111921.106936-9-vo.kratky@seznam.cz>
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
 drivers/iio/light/gp2ap002.c      | 2 +-
 drivers/iio/light/st_uvis25_i2c.c | 4 ++--
 drivers/iio/light/st_uvis25_spi.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index a0d8a58f2704..5eb414e07a08 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -462,7 +462,7 @@ static int gp2ap002_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init(dev, &gp2ap002_regmap_bus, dev, &config);
 	if (IS_ERR(regmap)) {
-		dev_err(dev, "Failed to register i2c regmap %ld\n", PTR_ERR(regmap));
+		dev_err(dev, "Failed to register i2c regmap %pe\n", regmap);
 		return PTR_ERR(regmap);
 	}
 	gp2ap002->map = regmap;
diff --git a/drivers/iio/light/st_uvis25_i2c.c b/drivers/iio/light/st_uvis25_i2c.c
index 5d9bb4d9be63..00092ec68639 100644
--- a/drivers/iio/light/st_uvis25_i2c.c
+++ b/drivers/iio/light/st_uvis25_i2c.c
@@ -31,8 +31,8 @@ static int st_uvis25_i2c_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init_i2c(client, &st_uvis25_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
-			PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/light/st_uvis25_spi.c b/drivers/iio/light/st_uvis25_spi.c
index a5aad74ce73e..6019208670f1 100644
--- a/drivers/iio/light/st_uvis25_spi.c
+++ b/drivers/iio/light/st_uvis25_spi.c
@@ -32,8 +32,8 @@ static int st_uvis25_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &st_uvis25_spi_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
-			PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %pe\n", 
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.54.0

