Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.78.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50293E275F;
	Thu,  4 Jun 2026 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574614; cv=none; b=RPxBHOwjoRE/HNouhM7+H40+YuXicWawlX2NPngGT2T/zbjlzoIMkoullLSs9wfSkdCPcuxXtTY02KAl5m3CM/FZjnmP/Rar+VQJ60bHjr7I9TWURQnPQ5jd0fvKtKguaMYRG5XzOXiloLndt9HQ9ItVKguQ7eV1XttAPOeDIxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574614; c=relaxed/simple;
	bh=78sF0us9WTVFpDcOJ1P69gBMf7gcCX/jeU09fYQvRv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCRZUGmIsbLbQLf/Ewqk1Kiv66Wg38OI1R5mlepv4s/ym4tQVl2Q3zQoFOh9SGQ9S4fIrPj62tNQUpEQkT4bq9gSQVSzrZph1uH7jrN7AthdK5x99jw6yeh8fjQ4MMXQqc2mvJxVo0u9itGrhEdFZ2wsWjGIjxEt1a4xH/aAox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=rgmY9QkJ; arc=none smtp.client-ip=77.75.78.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="rgmY9QkJ"
Received: from email.seznam.cz
	by smtpc-mxd-f659df87d-k746b
	(smtpc-mxd-f659df87d-k746b [2a02:598:64:8a00::1000:a08])
	id 490ae69ef165cb114bf47c02;
	Thu, 04 Jun 2026 14:03:24 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780574604; bh=haUXEAXbSG/av191CxXo3s+ENgMswoc5SC4Q822w6KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=rgmY9QkJZs0hQMcmLGMeRtRNYIqEur4euTnFRiwdvbw3hOIII/VJ1A7X8sXHd3OSu
	 PSIQSFdelIFbVFxgwLVFiRG+/16V0UKIza2l7uSOuGtJkg0zvAN4rT3qP/7bc1G/Ii
	 wwnfYZ0tMSCuAEK0v6GEo3rkxOJv2DPwnAIvcQ7u0h+dp43W2mde6wnmZNKeekz7NI
	 5HfZETTa3kq2aVvyiNcmiyt18y+pRV8tyfK/d91TV0S5lykQiIrvNX//nBFynVRV8K
	 odCuZQ8fa2vFscn2LHzLvksr78FQMspP2I02AAlqbmOSjNsCwrLLkEjdd2R3IqkAq7
	 Bi2dxX+zTZA6g==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-k9lmt (szn-email-smtpd/2.0.73) with ESMTPA
	id d49efc7e-7887-4a6a-b493-a3f63c90926c;
	Thu, 04 Jun 2026 14:02:54 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] iio: chemical: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:59:23 +0200
Message-ID: <20260604120201.116925-4-vo.kratky@seznam.cz>
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

