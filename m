Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2BB31076A;
	Mon, 16 Feb 2026 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771261854; cv=none; b=fTPJ91zhqfSJJ87bpOOjE/6TlcxBvKhGckIo1M45zkrnumbMLfBQpo96zhexT+eV/1pOroVHQ4Nfd/PJ//3mseYm1gJdtt+LRCrKLLQVVhsjSYhcGCJZjQxy1/hxr1JLpXCpEX4hMXvH3HtwDLs4dGqSLv0h7a5exVMAVEskgNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771261854; c=relaxed/simple;
	bh=rGdi/WfzUKG1XZXMbKOthTj36Ehl3dWzjXO/zqT5+Jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jmmtp6kghRXbKNxotLvi1SlNccQv/iLhib28/eQ1hjs3xZ2OWbBAEnAHGP+hJb8az9MIhPvJ5nhH0oBZpdqLVWwrpGymn3rI7zrbPKPoyo9RQmqzAmNLpNkfYO9XHpB+4brwqPbJFeUF/7JimeC8bFpJ9uVdcQld4DhEbNqtyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sflnjk2v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sflnjk2v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 273F6C2BCB5;
	Mon, 16 Feb 2026 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771261854;
	bh=rGdi/WfzUKG1XZXMbKOthTj36Ehl3dWzjXO/zqT5+Jo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sflnjk2vg1/9GzaSAd2ilwpFZ/6YfhH/GBTe3Md+JFJzJYVaQyTkWmaSHnP68gARV
	 ABJLNUwUlHPo0kz2cTOB5heyVmAN1rqCohAp0ZOwlSdejdgGCLWGd2xp9+zhmfXHaH
	 S8CqB+vmGVqH3cqWnq6h2DnlSGekjuMQ0agbg0jetsF+gz+b2YSTkH2m8rY3mp5w/H
	 ThKmJ1q/ja49lBCIYH6yduVGLFnhJ3rmPWcgR6FiKi+FyggG9KgdWCWhN5xRkc8eRx
	 v6fraiobCT2i2m655o9Y5fWLGqPkOz3P7Qt9v1t5unQTHYj+wQAbzX6VGspekEvKnU
	 /6Xeta/2u52ww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117A5E81A5A;
	Mon, 16 Feb 2026 17:10:54 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Feb 2026 17:10:54 +0000
Subject: [PATCH v5 10/11] iio: amplifiers: ad8366: consume enable gpio
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-iio-ad8366-update-v5-10-7e6091357d02@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771261851; l=1270;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=dDdcU23HlSPG2yMMj26nBGlcwxQIvQ+x8qXHKCHZHlc=;
 b=2Y8JTqvWh8UqelxNGbz30ENpH9AGUnMeAT3aAwJOTOJ0R8j/8XdxpfiyfbkkTJgbRcP2NWZo/
 xJIZFsmAXxGCL8mp/rWGLELLwhFNwrIdkXs5P/UFOWRjHBIjU6Q6uk5
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
index fb787a512bff..d4499af0518a 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -217,6 +217,7 @@ static const struct iio_chan_spec ad8366_channels[] = {
 static int ad8366_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct gpio_desc *enable_gpio;
 	struct reset_control *rstc;
 	struct iio_dev *indio_dev;
 	struct ad8366_state *st;
@@ -239,6 +240,11 @@ static int ad8366_probe(struct spi_device *spi)
 	st->spi = spi;
 	st->info = spi_get_device_match_data(spi);
 
+	enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(enable_gpio),
+				     "Failed to get enable GPIO\n");
+
 	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc),

-- 
2.43.0


