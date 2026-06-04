Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.78.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9F39D6C9;
	Thu,  4 Jun 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572135; cv=none; b=ElvIaTMIVMgolHKqVEKeD1g66xb6bfx/jO58nH5yc2r+J2/KHGTHu3eS6pMhyRL9vMa+TlpWhasypgQ3RRUBzCdG8cNq8e2Y+SS7+jwQg3qs9tJ7+PwQxP95M+QSI6Sy5wH89Hj3pURzH7jPqdDedmi56ULOy90LgejohIfnY78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572135; c=relaxed/simple;
	bh=ADxOjD17nkpTMnTjSid/+7UemvsqRRZEdKgELBJsnlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMsZB5fv0X3L8h+Cf+eqsae4GZ8qYFEeglV1gB8Y6c29P+1ifAUlgR/p2mV05kWgbh02F5Ki29A8DrlQxVGvQClY5rf+BWP+T5Vle01nlImQJOUEs5VfVLsp6gb4nKIdPFzsDL7T5GYcj3KaOvnD+A4UnbCpjhQXgqbSMwQCZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=acAhcNHj; arc=none smtp.client-ip=77.75.78.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="acAhcNHj"
Received: from email.seznam.cz
	by smtpc-mxd-5757bcb9c-s9zn4
	(smtpc-mxd-5757bcb9c-s9zn4 [2a02:598:128:8a00::1000:a07])
	id 18922e00a0fd038f1a6cb49c;
	Thu, 04 Jun 2026 13:21:57 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780572117; bh=H/r6mXWdnLeWBu87fBzmKOfV8Gwd0feTevuA5DB+m5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=acAhcNHjZmFsFRPLzn/L8MgeoziDfNVTRWvuPOkK5GVnW0tqMLfRikcUY2QCRpvfg
	 VQUahfBI/T7SnevAHl+LoM4CHDaWlHsQwFV7yieKwZUkjaPiuOSNxgoA8ObrMk3BQ0
	 e3ffSAbaMU40hsvhhOqDV6NPe0JQXLJBD1qij6ddcVA41btZ7YW25tGr6v1Im0D3Ol
	 UpKGWs+P1nrz6ShRpNsLiCZ4j1N68po2kRAie6vHWNk5WS/OQ4QMUoavPAbBJK2Vv4
	 HcS2vbXBnVdrZl2aBDfYJnovadwLXm1AJ+HShXYC9Y4K7UwyK+BE/xLlH+YG0uDRrz
	 Z60e6rhwNFuVQ==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-d5tsb (szn-email-smtpd/2.0.73) with ESMTPA
	id 9d013914-b31a-4b73-94d6-326e402f815c;
	Thu, 04 Jun 2026 13:21:54 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] iio: gyro: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:19:04 +0200
Message-ID: <20260604111921.106936-6-vo.kratky@seznam.cz>
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
 drivers/iio/gyro/fxas21002c_i2c.c | 4 ++--
 drivers/iio/gyro/fxas21002c_spi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/gyro/fxas21002c_i2c.c b/drivers/iio/gyro/fxas21002c_i2c.c
index 43c6b3079487..9ea9637c39d8 100644
--- a/drivers/iio/gyro/fxas21002c_i2c.c
+++ b/drivers/iio/gyro/fxas21002c_i2c.c
@@ -25,8 +25,8 @@ static int fxas21002c_i2c_probe(struct i2c_client *i2c)
 
 	regmap = devm_regmap_init_i2c(i2c, &fxas21002c_regmap_i2c_conf);
 	if (IS_ERR(regmap)) {
-		dev_err(&i2c->dev, "Failed to register i2c regmap: %ld\n",
-			PTR_ERR(regmap));
+		dev_err(&i2c->dev, "Failed to register i2c regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/gyro/fxas21002c_spi.c b/drivers/iio/gyro/fxas21002c_spi.c
index d62efe50b697..67ecf441c244 100644
--- a/drivers/iio/gyro/fxas21002c_spi.c
+++ b/drivers/iio/gyro/fxas21002c_spi.c
@@ -26,8 +26,8 @@ static int fxas21002c_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &fxas21002c_regmap_spi_conf);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap: %ld\n",
-			PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.54.0

