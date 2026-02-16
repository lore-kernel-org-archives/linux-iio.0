Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1082D8793;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771261854; cv=none; b=dN+DGvUCnPZQ0EzYW5BGPEFRJ931B7zoDj7PvYZ/MFs47KTNxtT7Z1wCc2dk7dRo/fufMT7pDKTaxkPRj//3h1v3ZwPo+MVAXDweKQHo8/n77H8AXp+ls83h7Qx88xA2pbMSJRqLZxsC5eLCBixkGI7sKmTN7t4KnocEKQpWXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771261854; c=relaxed/simple;
	bh=VJIxV51qTWBKnBlL0cp3FKxxTxkOycr50HPLDnoxl8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzI2l4QG7PHEEYZzKFgrLXsGQl4bE4Zo3YLK0jaeiw2sMXnvoXlx3siY14YSeuNK3MiT2sPylMy0Mlga0xnRoK9rF/i9Ae8O1atuWMx35FVspQShvuyJQLdicDXsKEFOS5U4UdIKF2J4Qbgy5sJmojILOAoogpKH2W0UbZKETsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxb1dk0E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxb1dk0E"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC7A3C19424;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771261853;
	bh=VJIxV51qTWBKnBlL0cp3FKxxTxkOycr50HPLDnoxl8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hxb1dk0ElITDRI6MH3ApbaShbMeLaIQe1wa8Qo/j0EgKFOrvkr4oVYEsDhFL3+2eq
	 1T4heWs5PRLiRDzop7WhvVa/Sjq1UUliHUs8oKbjPOesLxX1moH1M2LadLanWx60k3
	 1xIiC1ZfbyjcNXsPSiE4CfXIxc5MfBGj0fMIpp7WCx5MtLlcJcsO8m5gE3jrWYLUiS
	 HUkY5Yx+75E13JhZlRZnbzTrWeGeD58Rn/sd9fBdyxmoLVjKTNDeHmq/H6jVDw3w98
	 sAHG4OS9p+f4GcM56ymK0vW0cZFgNDktnMpY1rb7Sn5CNST53SGKPOdi1u64yWjCvj
	 XaR07RWIn+xOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5533E81A56;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Feb 2026 17:10:50 +0000
Subject: [PATCH v5 06/11] iio: amplifiers: ad8366: refactor device resource
 management
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-iio-ad8366-update-v5-6-7e6091357d02@analog.com>
References: <20260216-iio-ad8366-update-v5-0-7e6091357d02@analog.com>
In-Reply-To: <20260216-iio-ad8366-update-v5-0-7e6091357d02@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771261851; l=3284;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=hd/kdztzjkqokqD0/DlRs6C35T+S3wfeCNHmHeep5rY=;
 b=RBa1W3xX34QtistcDCpL93oZyXPHUmlWaKtpOOvr4beJPTQgDmq99AKSThqdHpR+mSULjFArk
 aaCQXfRxsw0D3aNPByXMd50i/rNygHKWDFbIqlR3h586+4DhZjaLKxY
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
index 6466f3eb6bbc..e8c80551d524 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -43,7 +43,6 @@ struct ad8366_info {
 
 struct ad8366_state {
 	struct spi_device	*spi;
-	struct regulator	*reg;
 	struct mutex            lock; /* protect sensor state */
 	struct gpio_desc	*reset_gpio;
 	unsigned char		ch[2];
@@ -263,14 +262,10 @@ static int ad8366_probe(struct spi_device *spi)
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
 
@@ -284,17 +279,15 @@ static int ad8366_probe(struct spi_device *spi)
 	case ID_HMC792:
 	case ID_HMC1119:
 		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
-		if (IS_ERR(st->reset_gpio)) {
-			ret = PTR_ERR(st->reset_gpio);
-			goto error_disable_reg;
-		}
+		if (IS_ERR(st->reset_gpio))
+			return dev_err_probe(dev, PTR_ERR(st->reset_gpio),
+					     "Failed to get reset gpio\n");
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
@@ -304,31 +297,9 @@ static int ad8366_probe(struct spi_device *spi)
 
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
@@ -346,7 +317,6 @@ static struct spi_driver ad8366_driver = {
 		.name	= KBUILD_MODNAME,
 	},
 	.probe		= ad8366_probe,
-	.remove		= ad8366_remove,
 	.id_table	= ad8366_id,
 };
 

-- 
2.43.0


