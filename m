Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A81336EC1;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117859; cv=none; b=GZr4lvEVMoh9SCgY1oIkYQxSdgLH90SuqHjzmkFgjIAJbPcDUXbCwZoOjSLWQCv6ruDbY4tq0NzmVEe4BOwkFC5aSz8RYAZWtMOl1HUjM8L7TZK1OCsr+zOLt/l7HMt2szisSYrSl/91NOl+dML9u9GKSTZcswo08twB0RagTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117859; c=relaxed/simple;
	bh=4TpjQU7RKnPyWX86KGp8TKTM6hGi4/wBYH7Z+MEZlEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FJy92SbX01fwOBmWE5aNDYavBBPQhXTcqy2mb+IRbzugvxzqaQNT1VU78WkbM5eJBm7gKq4guNyMzdIdeKFfbjmdm1Srk+3pvvNGlRauAP01RmOuBl3m47NvVFfSroi+7AtclIXCG9iI0DfWaGNctfC/kjj6NAcDDRc6D9C+c9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxOq34Z+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxOq34Z+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80B43C19425;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770117859;
	bh=4TpjQU7RKnPyWX86KGp8TKTM6hGi4/wBYH7Z+MEZlEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oxOq34Z+oy3D0z+4zyAeQKP1bsgyhBBHp1DAYviAK16UGUN1vT5s/zMjobpqZ+z/C
	 ucvoaexh91OtTD3dsB+dhi2NSMYzZ9/kxGqE9TDmR1xhlxEqr2djEMdKFoOyC4k5bV
	 10I9pLfJsaSwN1mOql1WETG/KG97PhRLeDzeL6tb6VYDm6nXPiIPjr0u9tYQgh4cxp
	 MdQn8bTZ0CGd06CDFx3p/R+rDnL7xpbBmdrbnZVh5hVCEXJ99QlmsxJp8Ca/23k7fC
	 3Fo74qr9rXFJ/GHoUUcJcP1aVp198eempDwFlLNe30/0BG39cA+3/Xz09PZC77oPYR
	 2mu8MT82VXZZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F06E6E814;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Feb 2026 11:24:10 +0000
Subject: [PATCH v3 4/9] iio: amplifiers: ad8366: drop reset_gpio from
 private struct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-iio-ad8366-update-v3-4-5d5636b5181a@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770117857; l=1514;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=7IwKgsiwuYgVI5syKodj5406ItZPM82hCN9tX04mYFY=;
 b=i15+QkMb3ey0jb7qHzqL41jsRwkIBTZZPa6FPCCPautCrcfENc09gcuKI8Tzvrri6MBRTsYV5
 2BBjchX6bsqAQidMDp/bQKMKEJzBIsrvwet+mcb+x1aZ7AxYHSzDK6f
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Remove reset_gpio from the device state struct and turn it
into a local variable, as it is not being used anywhere else.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index f0d44f2769ca..d6e18eb71bc8 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -42,7 +42,6 @@ struct ad8366_state {
 	struct spi_device	*spi;
 	struct regulator	*reg;
 	struct mutex            lock; /* protect sensor state */
-	struct gpio_desc	*reset_gpio;
 	unsigned char		ch[2];
 	enum ad8366_type	type;
 	const struct ad8366_info *info;
@@ -245,6 +244,7 @@ static const struct iio_chan_spec ada4961_channels[] = {
 
 static int ad8366_probe(struct spi_device *spi)
 {
+	struct gpio_desc *reset_gpio;
 	struct iio_dev *indio_dev;
 	struct ad8366_state *st;
 	int ret;
@@ -279,9 +279,9 @@ static int ad8366_probe(struct spi_device *spi)
 	case ID_ADL5240:
 	case ID_HMC792:
 	case ID_HMC1119:
-		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
-		if (IS_ERR(st->reset_gpio)) {
-			ret = PTR_ERR(st->reset_gpio);
+		reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
+		if (IS_ERR(reset_gpio)) {
+			ret = PTR_ERR(reset_gpio);
 			goto error_disable_reg;
 		}
 		indio_dev->channels = ada4961_channels;

-- 
2.43.0


