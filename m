Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F43382E4;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117859; cv=none; b=XXf3Xo7a6WKSCcHY0B0WLqRz4Uq8VeYtnVnUdTmxZmExGj87cbUtw2uydBxeo+nJM+6REgwPIiafkn9ubD+v8DQXPrMrcRa5S7UmiYjX+yl3+eIN/jgKbNXqqaqhV5trGnFD4H+Ws1o/pT1J2NfhjlzEbtzN3g9ofaCz8mQUPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117859; c=relaxed/simple;
	bh=OkrRjjRXZ14XH3hepKiVh+rGbuFi8EYTlqqCt8mD1+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJWRSGCyK+TBIlVPovzKNP1Qzfe/4S2eSBt03Ojr2ZNYc45Oi3J4Rgq8uZBkiCZHlC0aUXBL6DftKAp/XfJK2wVt6WZ8SCg0gjIPyos29vWtX453qhhr7sBynDK4wnTJ0I++MhrT8H8Sbl6800mT5Rz7NvIfNuS/TO7Zwcq86Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBCZZ/T3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBCZZ/T3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96FA5C116D0;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770117859;
	bh=OkrRjjRXZ14XH3hepKiVh+rGbuFi8EYTlqqCt8mD1+g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eBCZZ/T3rcTrsZynR9AVzcHtCPaoKEgamUZ/vjbsxc1ll+DLJrwAGUJjf7QCdfkaU
	 n2wzPPA79FFsn6WDOcgQK78yPJKcSUFtXIAgQV1D8RqzlKtw/RGrYW3rrWkRipLuR8
	 aGymbdDNLCKw64+Dl4xkEAaO6Rq+o3+gkF2bhzwMSlKbqW+4XTJtpytcLT2B5vkPpM
	 OMOE6VwYFrmf9CkDcQsU9gyJE/g4cJ7asKRrfGNg/Y6rNWKVTvcjJLBXgP9v1PpXeI
	 FOX4t93q3WoaZA2dTgAziUr3smearDveK24w9LJvi+Ae0DNIshk0hbejqG5fM+bz0z
	 BTJN0FhUx3azw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E02AE6E813;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Feb 2026 11:24:11 +0000
Subject: [PATCH v3 5/9] iio: amplifiers: ad8366: refactor device resource
 management
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-iio-ad8366-update-v3-5-5d5636b5181a@analog.com>
References: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
In-Reply-To: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770117857; l=3293;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=f+kMNCcEGZUSXT8GVTgbBGh2m45pMNgPC1EpKanwlWg=;
 b=QNUN9HjLyrpZeTAjssfmUhl9ReViIORKF/ARDaupDTw072/+Xik5ksSJHsb8b7p9IJckuEGnj
 /tSnt4l+Qc/AyG5Nf7bysVSf4xJ//MsC7qqaVwxzbu4h6IIkI7/1yBX
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Adhere modern device resource management with the following:
- Voltage regulator managed and enabled internally;
- IIO device registration handled with devm_iio_device_register();
- removal of goto's from the probe function;
- ad8366_remove() removed as it is not needed anymore;

With the drop of goto's dev_err_probe() is used to report probe errors.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 50 +++++++++--------------------------------
 1 file changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index d6e18eb71bc8..2da10c748362 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -40,7 +40,6 @@ struct ad8366_info {
 
 struct ad8366_state {
 	struct spi_device	*spi;
-	struct regulator	*reg;
 	struct mutex            lock; /* protect sensor state */
 	unsigned char		ch[2];
 	enum ad8366_type	type;
@@ -259,14 +258,10 @@ static int ad8366_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	st->reg = devm_regulator_get(&spi->dev, "vcc");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-	}
+	ret = devm_regulator_get_enable(&spi->dev, "vcc");
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Failed to get regulator\n");
 
-	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 	st->type = spi_get_device_id(spi)->driver_data;
 
@@ -280,17 +275,15 @@ static int ad8366_probe(struct spi_device *spi)
 	case ID_HMC792:
 	case ID_HMC1119:
 		reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
-		if (IS_ERR(reset_gpio)) {
-			ret = PTR_ERR(reset_gpio);
-			goto error_disable_reg;
-		}
+		if (IS_ERR(reset_gpio))
+			return dev_err_probe(&spi->dev, PTR_ERR(reset_gpio),
+					     "Failed to get reset GPIO\n");
+
 		indio_dev->channels = ada4961_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
 		break;
 	default:
-		dev_err(&spi->dev, "Invalid device ID\n");
-		ret = -EINVAL;
-		goto error_disable_reg;
+		return dev_err_probe(&spi->dev, -EINVAL, "Invalid device ID\n");
 	}
 
 	st->info = &ad8366_infos[st->type];
@@ -300,31 +293,9 @@ static int ad8366_probe(struct spi_device *spi)
 
 	ret = ad8366_write(indio_dev, 0, 0);
 	if (ret < 0)
-		goto error_disable_reg;
+		return dev_err_probe(&spi->dev, ret, "failed to write initial gain\n");
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	return 0;
-
-error_disable_reg:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
-
-	return ret;
-}
-
-static void ad8366_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad8366_state *st = iio_priv(indio_dev);
-	struct regulator *reg = st->reg;
-
-	iio_device_unregister(indio_dev);
-
-	if (!IS_ERR(reg))
-		regulator_disable(reg);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad8366_id[] = {
@@ -342,7 +313,6 @@ static struct spi_driver ad8366_driver = {
 		.name	= KBUILD_MODNAME,
 	},
 	.probe		= ad8366_probe,
-	.remove		= ad8366_remove,
 	.id_table	= ad8366_id,
 };
 

-- 
2.43.0


