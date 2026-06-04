Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.78.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4D843E48D;
	Thu,  4 Jun 2026 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574605; cv=none; b=KlCuw5srZfsjO5ShxL/T6O3GMba+WD9BWwAfJTiK4IXfa9ilIs4FI2hwzuPCY89Es43HhJIsjcAmkyVMPEWcSg7iOiJsw8pGYYtVRmDMGrUDvC/gsn34aUfbrzS6AbDEkVZbh3qdPwsMhViQdJbUGnoPZ1MbZkaGFzDQufJLm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574605; c=relaxed/simple;
	bh=UHe9XPlmDjtBioNXuxZu5e4gjeQR6uKjM8VgdIVulUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGFqtrHe+MkUnnM2kPa8bNBIH97qFXVceFvTScKfOhwGcw5ofUoP8uNsMogekGyiZnG6zZL9HfK7kCAqbFrh6Zbz0i8xh1FyR+BTrKKHFMDJkOZjSeb3PYmG87IMGM/RGCQE8smlgRtIYC6PHtoM4Ye0vM09PlIqzcGFcXLDe7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=lsak4CMF; arc=none smtp.client-ip=77.75.78.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="lsak4CMF"
Received: from email.seznam.cz
	by smtpc-mxd-f659df87d-k746b
	(smtpc-mxd-f659df87d-k746b [2a02:598:64:8a00::1000:a08])
	id 48bcbe9af0d393154a422406;
	Thu, 04 Jun 2026 14:03:15 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780574595; bh=TlPl1hL0mw2a6RJLV1U3TWM3B9TVz8r4vzeCi6blXKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=lsak4CMFFF//NPCr/8KfFPH90ESEuYv+2f2zGZqrN1vDG6Yta59ZPRRxqBYtOc0Lp
	 u+fbG466qcCxWyIRI3nVt87xjywGbgB5bTuM85mLtSr/9b+5nlPd50TsNT7FbzZxYq
	 Njl6iZQebzrrbPeyLxWQaqQtqa/Irr2de3r/+v4KpNgiynrOt6Ka/vgcZNHrC3CWOG
	 WLiOReYN1Y7Xo2Uk4WyhTIKnOm2H27U1kYRmKH/+EQLOb2CpfOpMfiPsc86ZvY+5Ee
	 ADwqDEUjJErfnJtuLJfhKHfvd90g7e5eq6V4rznsMgpRCDxmVtfsowUqtwh+9WO3qn
	 W9B9PL9TdXc9w==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-k9lmt (szn-email-smtpd/2.0.73) with ESMTPA
	id b6907123-a9c9-4cec-83f4-4deaadeb6a63;
	Thu, 04 Jun 2026 14:03:03 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] iio: light: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:59:29 +0200
Message-ID: <20260604120201.116925-10-vo.kratky@seznam.cz>
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

