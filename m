Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A1633B961;
	Tue,  3 Feb 2026 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117860; cv=none; b=ixDkdQdHlWLHsPnEU9BBNMHT7UlFXGWoRXkqTV5Nz4JjY9MdT4FQmJX6YR1Osi8AksDa5xaToMQaOQnSwi/gSQpq32fGuuKAalhl4RNvnui3ehPuH+KbQVnBMs5Fr4dp8GAeu2Nc78fgBbBRkPVc3/5uMXp9vfTb8FfIGszKh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117860; c=relaxed/simple;
	bh=JvqRvi/KRBjYNMnk26SO2KrpKQDhXOhrqtEVadrdH3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMKOocfTOW6H0pYA6GSof3sdyZsL6ltNkuiwWgUh3ENDHgJe6kEAa6gEOjkSlguLtcqPdd8J0rPdPWi99XyjWBCuffUS+GI1hlOK+m8UohTrtxj34m4RSkLS2ySJwKiaMPpi9nSPQr+J113yMl03ABnJP9+1ebCoFDOFuFk3JfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqUsNAZu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqUsNAZu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08372C4AF0B;
	Tue,  3 Feb 2026 11:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770117860;
	bh=JvqRvi/KRBjYNMnk26SO2KrpKQDhXOhrqtEVadrdH3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rqUsNAZuYOspCotY7SXlu/kxEEOa2/tEHTJdC3BiV5i6KFVq1pX8nWYysP8FQjDO4
	 JlhgjWh2hJn6RRuZkClyBgUFUrFwLOfr7XQHYPIXh6L5AxZuTpGayg2O3uUER++OXI
	 u+z9Bn2w26yrXI8/hkd/n/2I37DyeeKathhj/VQTekqvM8f5Im2LrMrPw4qdHOLXdI
	 kuRvFUXTbWM5BEkpr/L4ZADH/gXABWBHKkti8v5MHs+DLbokzOWubJ3xsa33iyzdO2
	 5WN3ihyW/FQdDS6REC45EI70/1i14tRWrf/KpLgbWGQ53YbZ5gPN8f4zDd9iR5iTmk
	 rEF+ojP4nImQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAC7E6E813;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Feb 2026 11:24:14 +0000
Subject: [PATCH v3 8/9] iio: amplifiers: ad8366: consume enable gpio
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-iio-ad8366-update-v3-8-5d5636b5181a@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770117857; l=2016;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=NI6Xmsw6qw3e0XQ9ey2GDgpNHtC2qQOpsDhpudcrNSs=;
 b=ZER9ogdVMM1LC5NtTAY6EUzYEivRrdqa9Z7JDK8lrB2+9ayvCpIvxFYbFnrfBO9qWiV9YtaMV
 WU8YXCibjV5BnBBKUU2aTvOAu0vFUDlB8gHQ3ZyiIFv8fmlsueHNL0u
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Some parts may consume enable GPIO to enable serial mode
(HMC1119's and HMC792A P/S pin) or powerup the device
(e.g. ADA4961's PWUP pin). Also, add a comment explaining
that even though chips like HMC271A has a reset gpio, this
driver previously considered the reset pin for parts that
don't actually have a reset gpio, so it might have been
used to enable/power the device.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index dc2fe94c53cd..92865ab96ade 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -204,7 +204,7 @@ static const struct iio_chan_spec ad8366_channels[] = {
 
 static int ad8366_probe(struct spi_device *spi)
 {
-	struct gpio_desc *reset_gpio;
+	struct gpio_desc *reset_gpio, *enable_gpio;
 	struct iio_dev *indio_dev;
 	struct ad8366_state *st;
 	int ret;
@@ -226,11 +226,22 @@ static int ad8366_probe(struct spi_device *spi)
 	st->spi = spi;
 	st->info = spi_get_device_match_data(spi);
 
+	/*
+	 * Previously, this driver considered the reset gpio for some devices
+	 * that don't actually have a reset pin, which could have been wired
+	 * up to the enable pin instead, so some users might be relying on this
+	 * to turn the chip on rather than reset it.
+	 */
 	reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio))
 		return dev_err_probe(&spi->dev, PTR_ERR(reset_gpio),
 				     "Failed to get reset GPIO\n");
 
+	enable_gpio = devm_gpiod_get_optional(&spi->dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(enable_gpio))
+		return dev_err_probe(&spi->dev, PTR_ERR(enable_gpio),
+				     "Failed to get enable GPIO\n");
+
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad8366_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;

-- 
2.43.0


