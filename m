Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117974;
	b=DF8Nc8zmpO/nqW+AQUQzSz5eZtXV8K8qxcTlpLkyUSYt0kdEAMNqzd11XMiGJMll3hSm
	 QcXSNlwVQt3IrWoXyc7WF1JSYOmLmgPNAn+Ch7AKskDnMzLU0lJKWrFC9ztcSh7LDbRdA
	 iTjCeBfegq/ExJ75UxsPMjPGjoCUqyT92NvjsLGMSCnpRhr+MEiL5hVMxcYwwTCME4x8p
	 HB7qjqA8UPfa02txaZWgKZBSkFrp0qXS8Qd/EU1XZW4md+gZ3AZAD+jpDZXR5OkCMSn2z
	 4GXGWHp7eaIEH5S95ehhQlNOdKD/Bvu1ch4VkXIqkxqFQuSjGBSR4QuJm8cDknP1xpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117974;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LOEWIzmZfvzKtqLwr7oghZBMAuu5Uzp8c5ikEmkMcjY=;
	b=ytlQ5RL67UtjhiCzTJ6AgJQCDYeF/aytyfDB4PIDIMbBwOzI2W4k/llQibPukaQumy6g
	 DtRYkdcC9RSTRAo6Dj2YJOnZYdF2aTUipyeXMsaFfEUTOwRO7oImD1LZIKTWj66qI3L6J
	 /RwcsSZPFgQXOhXl2/Vpps8yb/aL2CROCOKUz4hjxHtqIHqSPSzqgFdFi9h+6GnH+W1HI
	 OYbUMKeYnpkA42Mr6CYpktKYZjXWfKHTKBOnPtehnlrZi9BkdQwdW02epTAdBIxq0gd6U
	 cagNQZbABEJvwELO96CRGAK6VUUq5TQaSAu0vJGnbG+Ja/u5twHfqTlg1Tqf4IgqNEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lJueSaT4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24234606A324;
	Tue, 27 Oct 2026 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lJueSaT4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B251F01828;
	Tue, 27 Oct 2026 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793117974;
	bh=LOEWIzmZfvzKtqLwr7oghZBMAuu5Uzp8c5ikEmkMcjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lJueSaT4sXIQk0wcIC+vLbzxcXJ91ocsXxQyBD5PChhnCE+3JiKzcuKBmsTDKuC9u
	 kqetXvJ4BFM9UigM0rC64gqOnGqoYlDM/H7dlGQByjIvcIcSHoHDMURjiM0SX3ECRu
	 NV6kiTOdby+AbduT570QrVQyCeMAUlwDt6OzMf8A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 17:19:10 +0100
Subject: [PATCH 06/15] iio: adc: ad7923: add the AD7927 to the SPI ID table
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-llm-char-misc-iio-v1-6-0d818334f6c7@linuxfoundation.org>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
In-Reply-To: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Edmund Berenson <edmund.berenson@emlix.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=p54QxaI+bbjLMNfvNTMdbHCPbwpnqzZkJOxmM72JD/s=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPzjOZHHt4pHDnp59v/Nm/T1jMHbPEo7DqkX3cVqmbM
 5auCOyp6ohlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJnJRgWDC7c+WLNXeOvmWQ
 lt/mtfGOVuU9gSsM8wPPrFo243rSw5kTBVrmFjXoZpuIhAMA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

The binding describes the AD7927 as

  compatible = "adi,ad7927", "adi,ad7928";

The OF match takes the second string. The modalias of the SPI device is
made from the first one, "ad7927", which is not in the spi_device_id table:
spi_get_device_id() returns NULL and ad7923_probe() dereferences it for
the chip information. The module is not loaded automatically either, as the
uevent of an SPI device says "spi:ad7927".

Add the name, with the data of the AD7928.

Fixes: 1140f96cd4af ("dt-bindings: iio: adc: ad7923: adjust documentation")
Cc: stable <stable@kernel.org>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Edmund Berenson <edmund.berenson@emlix.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad7923.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 44e014da9722..69fafb4aa4ea 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -366,6 +366,7 @@ static const struct spi_device_id ad7923_id[] = {
 	{ .name = "ad7924", .driver_data = AD7924 },
 	{ .name = "ad7908", .driver_data = AD7908 },
 	{ .name = "ad7918", .driver_data = AD7918 },
+	{ .name = "ad7927", .driver_data = AD7928 },
 	{ .name = "ad7928", .driver_data = AD7928 },
 	{ }
 };

-- 
2.56.0

