Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.78.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D703E275F;
	Thu,  4 Jun 2026 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574594; cv=none; b=WGno68U8xURVXc9RcaOAnYVDUc/V99IldAaSpRxj/zSjDDryI82MlOEiXDcyi3PIY8V2l6WtYIMkpaaVDGMexEbwFdpLdTQRPoEqH2XuEAj5Fq+CiaFSxL+0vL9Wj0Xnrt/n0JiI5Sv3tA2N0ucdOSnMWKlwF48OcKbJngKP6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574594; c=relaxed/simple;
	bh=s2ZDS+8EfkgbI6/+bzq+jFVlyNUQnAEZFQgp/QnCHD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7WwpLlgln/HNbQVEjRo1+SdM9cxxiWpaXgYF69w3miB47NzCrhVrPiI8yiS1noT+zBOFus2SgbbBnBnayWrVxswN/LHH3UdTy6x/unuIxH30aqz3zdEY3sHgxJsERKw+YUXkpzL0lVX8VBV2ds7eixVqGJdvD7zIE+W2a5APWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=J8jn7WRu; arc=none smtp.client-ip=77.75.78.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="J8jn7WRu"
Received: from email.seznam.cz
	by smtpc-mxd-f659df87d-k746b
	(smtpc-mxd-f659df87d-k746b [2a02:598:64:8a00::1000:a08])
	id 4ea9f8f9f6c6d5764c576265;
	Thu, 04 Jun 2026 14:03:04 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780574584; bh=Riqt+J1YWk3ZnzTfF7J+RkWhl8pwhoTJDe95Q8Nt/hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=J8jn7WRuhzo7oUEaHOXm+CIATFH5Tfoa/kYIKaB9gLhd+Uq/aovzHhR0K+Uin6tXg
	 s8/mzBWWyCGBDCn7s3gnF/N748IG2U/8inhnhrOL+a9XHco+h9XSNdzeHgDNWN6vFB
	 iUa2IDdo+5IOWyzYoO35jwcaBXy2tZvHxdbQzMra8nX9Yq/HugcZXIvE1/g2FvaRhx
	 YOQ3CJQwH8Yya9LKMn9Sp6Xrf0Db1Z7qQcuwW5a6QukZNZDAHEkc8LwYdFs/PjygEo
	 Bo4VCvw370onJAI0n+ohKir2h0LWs7Q+E3hFIsSCjsvarHPb+jRjjNnuqsqqjXWo/j
	 8kck6ltNf1Khg==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-k9lmt (szn-email-smtpd/2.0.73) with ESMTPA
	id e0cb273e-e281-47df-94ef-8a6fd1364ff5;
	Thu, 04 Jun 2026 14:02:56 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/11] iio: common: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:59:24 +0200
Message-ID: <20260604120201.116925-5-vo.kratky@seznam.cz>
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

