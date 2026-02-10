Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB16D32ED3A;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752538; cv=none; b=lCOSSPQjQamPGROMvGPmoH9iajW7xbFUsu6/cE3N4xfSg0LDGKLUC1yPUTvT1oG3T6bf+SaRCt7WB3hgRLcn0SWDUmHTqcZ3r4xaqm4CsK5dLFE3O76NFmC49F5/+ut2rjYvAbIzuDDPFzM+RqxRDUEcxZ48xnhGKGLLnzkk4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752538; c=relaxed/simple;
	bh=9bhEdZyE426udr5V3ZdReH9PNJlu7ZAy82PbMg/t5Hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGmJjpVDxNo/IEyZLHt489WdMuHNrFWNNaVdILa71AVkVJVMQqUBdr++dY5a8ivdhNFwpoFX1WmMLlmV3Ge3FGMiZuK1EAa4GDsUmo98Sv9Af2M7y5dm4RF+Pfjf2u1CM5mUCgOk3AAGjmgJ/LUNxONWcUWJLlgwLNC4FD9lkzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEozOCg0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEozOCg0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7113C2BC9E;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770752537;
	bh=9bhEdZyE426udr5V3ZdReH9PNJlu7ZAy82PbMg/t5Hs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OEozOCg0owq3RF+KB9xK+HP79Jw6a0aBEnw/GEPuWSFGZXvPiYE49iHSdMsnLiVOD
	 VziJXKLiUB3WkKsMLDH4ChKeF6QdZYYPvwxqdvmNvEFF10PJYNpbo3js8XpypdZx72
	 0T+GLoqYLrEOwVdg2aQt+MKbCdy4DrhdwYdoCjq0vhhKGgIoyoS7U+RUxVrF77OWXK
	 VHKmdSW0X+WZj8KvHvHApSrcXuAFBUMBsjOILTNSlnZNm6IjeVjZqlH+BA4fu1Y104
	 If35YVcCSrk3zBm7mSYcUG04Jrgp1E7tlhEbvjwjaedwS56eP9KFEpUwMc7GjxtRPw
	 n1UtcVw/bwSIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC647EB2709;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 10 Feb 2026 19:42:07 +0000
Subject: [PATCH v4 07/11] iio: amplifiers: ad8366: refactor device resource
 management
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-iio-ad8366-update-v4-7-15505f7b15b4@analog.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
In-Reply-To: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770752535; l=3237;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Iqe9a/13m6an1CCQungGiUSkPN31FhHQ76ZeG/vcghA=;
 b=T8Sd1yRyxrjB/wAll/W9WhydtNy4I7AZzvIVKlITL4Qq2bviYp2zeL9Zw6zqN6ryAX22Mf7Dy
 Ux6ZF5F/I74BbPr7jwtL/jRk36YoZ4k70W8gqKW5/BOKenNnkfcWtqv
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
index 67817dedd75d..343f370eae65 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -37,7 +37,6 @@ struct ad8366_info {
 
 struct ad8366_state {
 	struct spi_device	*spi;
-	struct regulator	*reg;
 	struct mutex            lock; /* protect sensor state */
 	unsigned char		ch[2];
 	enum ad8366_type	type;
@@ -257,14 +256,10 @@ static int ad8366_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	st->reg = devm_regulator_get(&spi->dev, "vcc");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-	}
+	ret = devm_regulator_get_enable(dev, "vcc");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulator\n");
 
-	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 	st->type = spi_get_device_id(spi)->driver_data;
 
@@ -278,17 +273,15 @@ static int ad8366_probe(struct spi_device *spi)
 	case ID_HMC792:
 	case ID_HMC1119:
 		rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
-		if (IS_ERR(rstc)) {
-			ret = PTR_ERR(rstc);
-			goto error_disable_reg;
-		}
+		if (IS_ERR(rstc))
+			return dev_err_probe(dev, PTR_ERR(rstc),
+					     "Failed to get reset controller\n");
+
 		indio_dev->channels = ada4961_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
 		break;
 	default:
-		dev_err(&spi->dev, "Invalid device ID\n");
-		ret = -EINVAL;
-		goto error_disable_reg;
+		return dev_err_probe(dev, -EINVAL, "Invalid device ID\n");
 	}
 
 	st->info = &ad8366_infos[st->type];
@@ -298,31 +291,9 @@ static int ad8366_probe(struct spi_device *spi)
 
 	ret = ad8366_write(indio_dev, 0, 0);
 	if (ret < 0)
-		goto error_disable_reg;
+		return dev_err_probe(dev, ret, "failed to write initial gain\n");
 
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
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id ad8366_id[] = {
@@ -340,7 +311,6 @@ static struct spi_driver ad8366_driver = {
 		.name	= KBUILD_MODNAME,
 	},
 	.probe		= ad8366_probe,
-	.remove		= ad8366_remove,
 	.id_table	= ad8366_id,
 };
 

-- 
2.43.0


