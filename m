Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E18B331A5C;
	Tue, 10 Feb 2026 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752538; cv=none; b=CrMsnLEslJUHoI9h4X+3/g1YwtH6s8UqWcVCvf/9A0wVs/0SPnkqLCOla7NG6ilWdX2y1jGdoW4BSAucdNrJGNbAWT4Fa/ioF6SC0V2iUYJChXjLGfZe/4f04ImSvxwF02ZL061XK11LkIYVjWJNxMoYl6HzqTNaIWkE9V9O078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752538; c=relaxed/simple;
	bh=Nckr18q+Pc834VltsB532nh4FNhXlL8U3Bfapvh6vec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FaT9zfYDLP7+z6nK46XEEuVRMd5hUUKqFrQ498rbCGpDQZQIvY/rCWCb4G9bu7R+yBAAbSyMiik+XHMidg4pSPI2XFuCYu9c/SuA8hAPcDTj04XUgoyAQzTzkDh46DNZ0xpb6Y5jnqzkwcTRRCOqmOrUQO51Gb/IyQfttNAfMww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRegcP0X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRegcP0X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1BE55C4AF49;
	Tue, 10 Feb 2026 19:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770752538;
	bh=Nckr18q+Pc834VltsB532nh4FNhXlL8U3Bfapvh6vec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DRegcP0XiYscP+aCrplYWALp91kgy3MXzmwbfdumKASrueTsNqhNFywMsevGgi4cf
	 JJ2a0GolFHuWQQgBcVYlP+zqiCOkb7rqd2Fs65LO8Q3KleXsI+Z47BZ/C+PQcPPdJ0
	 IcLrv/Cm+y0AZUBEvJfGYzL0sjpaMrSH8jWZcibrNmYzUIYwQ0KHw+7/SiM8DE0eXD
	 VWlnvGhzVJhxrRD3Zj6wYmqN34ikFntxmr+jliCNHKbBWQjakwusA7/frtxVt6sKkH
	 vGiCG+jA+L9h6qbYb2ZxY+iGSV3Z6QyqCAnrJ8f4sVwfBz9ZWpqvAtUFNLOCwMb8ts
	 6zTA0ex8LkrPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD5EEB270A;
	Tue, 10 Feb 2026 19:42:18 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 10 Feb 2026 19:42:10 +0000
Subject: [PATCH v4 10/11] iio: amplifiers: ad8366: consume enable gpio
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-iio-ad8366-update-v4-10-15505f7b15b4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770752535; l=1285;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=4a2IBbnyaOJ7gewx1RlFVq18q3wqExfVEKH0FpNfWGQ=;
 b=ODvCtSxIjNnFuIBGHRSZc7k0d0/Cpiigr+61MAjQv2eUbD9QtJwKDAot2rMbFsXoP/k9CJQ3z
 FOKcHLmyF4kAFj06z/HtSpakuGw3V8AJ+Fi8DqTtkJJ5+3ono5w91RE
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Some parts may consume enable GPIO to enable serial mode
(HMC1119's and HMC792A P/S pin) or powerup the device
(e.g. ADA4961's PWUP pin).

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 79fb3119d794..b828b4be7b6e 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -204,6 +204,7 @@ static const struct iio_chan_spec ad8366_channels[] = {
 static int ad8366_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct gpio_desc *enable_gpio;
 	struct reset_control *rstc;
 	struct iio_dev *indio_dev;
 	struct ad8366_state *st;
@@ -231,6 +232,11 @@ static int ad8366_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(rstc),
 				     "Failed to get reset controller\n");
 
+	enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(enable_gpio),
+				     "Failed to get enable GPIO\n");
+
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad8366_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;

-- 
2.43.0


