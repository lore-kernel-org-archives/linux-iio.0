Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.78.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FED429825;
	Thu,  4 Jun 2026 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574596; cv=none; b=asacONElDNzMhCpQsZs1AtB9xx3p3AOSWMrfQ/t5vaKEhoSPJMMybTBGbqCujsrqsnUnzYUsUP/uI/WWO0MfF+aPCvS3nXXPqVuOVbPWGLucZalGHUIUZac51C0hwBlOjPk6uADragP0mFSXa3UZr8XkG3fyWSvrT+cuST8f69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574596; c=relaxed/simple;
	bh=C8CaCZmXAivwAyB8AND6bTmdsD9OkI2V/7E6CsRsnNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFePFccdWjRqHcJ6s/1lAXfsaD9woZTNtjkBRYUmeeGX+1OZdS0ugepOnWh1kXGPWEQSoZMR5Q210LFz/NHovmc3xGue3JQq/Hv1s+5mc5B/DE/FxmCJ0rzPWjmIM1WvXZYwpI6NiQZBSLJ+haazxVdtX/TRcm1haMS5wbU50ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=UqmNE845; arc=none smtp.client-ip=77.75.78.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="UqmNE845"
Received: from email.seznam.cz
	by smtpc-mxd-f659df87d-k746b
	(smtpc-mxd-f659df87d-k746b [2a02:598:64:8a00::1000:a08])
	id 45b475f4fddb587b474aef68;
	Thu, 04 Jun 2026 14:03:05 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780574585; bh=0woT+pwQeggFJWWps/CRjMmRSsxci7gZtS0C/flmATY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=UqmNE845Ec9+q11H4QkxzoyOrBdcgoRK7SQjGoXsddyVRrrXI5mNDVWha1AgVsTYN
	 Dm+JkDAA2YxHxokZEEBuY7hAMORbRMgwJlR8BKChl2u9o3H0ooA7lufbH16vMnUbPA
	 HUjaBu/dTKI3+ODQ1J5UfnA/eSQfLd1GlxzgAg/4gkibz3GUfjusCWslLMDMMgjuth
	 L2zTrlMOWVRGjygITkRTWbAdUZ25IXnHG0EPFmJ5k2dTmoe9M05+Kk8NAXWSwDY54D
	 yBxcL94Nri/XvcMVqIc6rrkVAr+TJVGgkTMPrDo0DKvPUvJ4zkqmWrvbleCGETs9BN
	 9dZnQdGFzvYwQ==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-k9lmt (szn-email-smtpd/2.0.73) with ESMTPA
	id 18d8f7b5-1fa3-4d02-aaf5-d3c1cec35d39;
	Thu, 04 Jun 2026 14:02:58 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] iio: gyro: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:59:26 +0200
Message-ID: <20260604120201.116925-7-vo.kratky@seznam.cz>
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

