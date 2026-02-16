Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED22D9ED1;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771261854; cv=none; b=kaY2Iae/wL/csvN+3yax2yL15uFsekYv0TibkAsO07dC3KDgy/ZAn296fQo872EKLRQF/iic3KYAmxpaib2925OgpX3UCmmfoyfQSWvYIH3h7sMnD4UnEMTG6y4BC2l3SC63pN3KvT8HElWO1ONH2DnNFcib2h7TbFxWn/5269o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771261854; c=relaxed/simple;
	bh=Tuak+ENNzJNCvBEXooP42lleSO+5mhlc56gGGXWb5XQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QgQvawRwoqVRDZV4N+FTzbA7kbaCsf2+VfcIFCGBYrqLl9UoAm4uvQfp0Uu/KZmhJnnYEraQLloPmCbcHlnwOv4B7Cwe6rxI5gxHaVX8Nwyl4kd1F3PZfG63lSvxkKYPL5xxwtI2WySkXhYouLATlZmci2xJczRN2ZC2t6Qw5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk6gKg8d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk6gKg8d"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1C44C2BC86;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771261853;
	bh=Tuak+ENNzJNCvBEXooP42lleSO+5mhlc56gGGXWb5XQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uk6gKg8dmZn6u+leWulrtHcV1J1wXXtEqwjw27VmO7eHAOSAFvAXh6PKDOtHVtgld
	 fP6P4s2veE8xDZsFyoINzv8Tj/3blKoMI/eUT+CVIOiCRPu+1Gdft7dX8uMBcngj3w
	 gK5Xlm8C6SSMvSRAwzXHcgN2uJBUu6OhxYCkU8wukspQoqGXkvYmUmvT337dbhGphe
	 wXQvn6TZILWxjU8TANGQNFzks+eqnlA6taJtlGLuVllMqQjpvJtrRPKMciz6dA7qFx
	 CWy3AwpbvuTXUs95c02Ftv1YG4PUKa0gQwsgJyQOwkzIPaXVTRFp7qJxKefSHhCNJ3
	 j408hUm3pGBNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9868E81A5B;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Feb 2026 17:10:51 +0000
Subject: [PATCH v5 07/11] iio: amplifiers: ad8366: replace reset-gpio with
 reset controller
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-iio-ad8366-update-v5-7-7e6091357d02@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771261851; l=2412;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=2h/qIlXksRtIPfCMm6MG5JFQw2QvDnxOXehKZUf2GXE=;
 b=PSHg/AGJgN9vG9M3eQuvL3jFUxI9aLv0if+nBm5XzHiTzwmvwwPpbxbUczUBWOGy6iUAD5JAD
 PB5aSlFomFaDz7BX7pgjhKiBlxgd709zhp+G4XUiw3XAKFgUcjC1sEL
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Remove reset_gpio from the device state struct and use the reset_control
interface instead, using a local variable, as it is not being used
anywhere else. The reset controller init is moved out from the switch case
and optionally initialized for every device variant. Although not all
devices have a reset pin the code does not need to change if it is not
wired.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index e8c80551d524..8b3d6825423e 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 
@@ -44,7 +45,6 @@ struct ad8366_info {
 struct ad8366_state {
 	struct spi_device	*spi;
 	struct mutex            lock; /* protect sensor state */
-	struct gpio_desc	*reset_gpio;
 	unsigned char		ch[2];
 	enum ad8366_type	type;
 	const struct ad8366_info *info;
@@ -248,6 +248,7 @@ static const struct iio_chan_spec ada4961_channels[] = {
 static int ad8366_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct reset_control *rstc;
 	struct iio_dev *indio_dev;
 	struct ad8366_state *st;
 	int ret;
@@ -278,11 +279,6 @@ static int ad8366_probe(struct spi_device *spi)
 	case ID_ADL5240:
 	case ID_HMC792:
 	case ID_HMC1119:
-		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
-		if (IS_ERR(st->reset_gpio))
-			return dev_err_probe(dev, PTR_ERR(st->reset_gpio),
-					     "Failed to get reset gpio\n");
-
 		indio_dev->channels = ada4961_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
 		break;
@@ -290,6 +286,11 @@ static int ad8366_probe(struct spi_device *spi)
 		return dev_err_probe(dev, -EINVAL, "Invalid device ID\n");
 	}
 
+	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc),
+				     "Failed to get reset controller\n");
+
 	st->info = &ad8366_infos[st->type];
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad8366_info;

-- 
2.43.0


