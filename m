Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.78.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D0D3976AD;
	Thu,  4 Jun 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572136; cv=none; b=ClaHL+x6kttEWnRFxLtpVMu7N6n3/GZrQAF0ME8wmka5HP9if+Ks8EbnTbLe9fD5ve3I2+O642luGLs7sREZWk6y5vXfMcxZ/iQfjv8Qcyltts+xJFqbb/UHmw/MVfbdi8SNmkNGUqxxTeAFC6aeuepwBNxETOT19VC9fOxH79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572136; c=relaxed/simple;
	bh=lkat711Mac6iCj9fk9zj8znttnIY9Kx+M3GQc9GJnKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBpAXpi797ecpB6P31ef5O9SlnlaPmZbCPgHD3Lz1Tk/I5bo1i6zmMP7ck3Tl7oioqDD20puEMYCwMz1lw18xsIOc/Ol9mb3axKgVeq+YmtvD1ieVWYehE1GvLmgLovhfyE9VJ6AxQF90CNtufCvej15vV7rgMF/YHPMNVsS2Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=YsqtAzq7; arc=none smtp.client-ip=77.75.78.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="YsqtAzq7"
Received: from email.seznam.cz
	by smtpc-mxd-5757bcb9c-s9zn4
	(smtpc-mxd-5757bcb9c-s9zn4 [2a02:598:128:8a00::1000:a07])
	id 47634385ff0c6e0a459dd919;
	Thu, 04 Jun 2026 13:21:55 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780572115; bh=Qql2sc+RO10kpakdFJ0JJv0VkfjAIcR/jy2vS3ydjQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=YsqtAzq7WRuQGsaq/HY4vznIpmRGLq9geOzbiTFlKfaqsOLkPaq9aFMWqXWlI3mdL
	 xvQZ88W04mDP/LdntQPl+hgIWKkjAWhrXIHKcScH0KxnzF/xnGx9p0EgQdUUqRxhf0
	 egmWiKge9AXPJIDPKRVr4q2O7QZH9wcONHGN6qZ4dltHfEuaw4nopv/4hLw42b3+g3
	 GhpVChrdGzAYV7xZMYWtbvvGxuMW8a0NZ1wfXbVtA2gAZLh9TZfZfuzOvf9rXs3qmZ
	 NT1zQn+7XCmLJ00mh2DX71m/WONZZdTwuyqbKg3AS6R6bxDJC2RugxNPf5vT92DYtV
	 v3ssu8vv2Bdwg==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-d5tsb (szn-email-smtpd/2.0.73) with ESMTPA
	id 9d4460c6-3f16-4cf2-9bb2-323c097abdff;
	Thu, 04 Jun 2026 13:21:52 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] iio: common: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:19:02 +0200
Message-ID: <20260604111921.106936-4-vo.kratky@seznam.cz>
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
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 4 ++--
 drivers/iio/common/st_sensors/st_sensors_spi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index 7156302fe997..ba35c53ee261 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -48,8 +48,8 @@ int st_sensors_i2c_configure(struct iio_dev *indio_dev,
 
 	sdata->regmap = devm_regmap_init_i2c(client, config);
 	if (IS_ERR(sdata->regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap (%ld)\n",
-			PTR_ERR(sdata->regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap (%pe)\n",
+			sdata->regmap);
 		return PTR_ERR(sdata->regmap);
 	}
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 0da27013943d..cf6bcdd57004 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -100,8 +100,8 @@ int st_sensors_spi_configure(struct iio_dev *indio_dev,
 
 	sdata->regmap = devm_regmap_init_spi(spi, config);
 	if (IS_ERR(sdata->regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap (%ld)\n",
-			PTR_ERR(sdata->regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap (%pe)\n",
+			sdata->regmap);
 		return PTR_ERR(sdata->regmap);
 	}
 
-- 
2.54.0

