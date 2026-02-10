Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751532E751;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752537; cv=none; b=iHG9QJa/FLqUq7w+XPR8VxSvWRrN5L5Thx3ZcK02KRJd6GGQ10gc2eIyMydhZ6RcQHcYOBFZ7iEVc5AZacFun+Gth69M6Mh8F09jGYTQjs9o8xwcBg2DQBWbb529kAA1xJsWRqDt2aQgg5Ak4nPw/Q6Qvv9h1Yr7EishxsBtov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752537; c=relaxed/simple;
	bh=t+MFc6Y6ftKJJVBy3r8wUyzt4+z9BRslvNWo6wZERl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DB3qZJepZi0uIidmDsLDvjvHhL75GNFMyPu/yYto5J0ScUclnNrQ/XdlFFzH4KXJlkRt9QHqiWJZr0nB1rBcAe4ZTpIgRtJGVv+KZHRf7SAYdhgeG5pU60uP+1L8vvKTqVcrotJec0KDGFBLTYTwaVqzTpYgioyr6WVYB5H1ylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcsrR+GG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcsrR+GG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B732CC2BCB2;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770752537;
	bh=t+MFc6Y6ftKJJVBy3r8wUyzt4+z9BRslvNWo6wZERl8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HcsrR+GG7nVa9PKqsbxImGIPhg/CDoPVpHK29h9Wp+CsLlVNwFbGQoy4/jkhPEDfS
	 bIZIOUyTK0n0DKa59U19d/fmnU2kT6QhYxp2IvPpHOKYYD41aQSDUrhtbgWAdmwtE/
	 YI5YzSntt/CXEzQgZmonqUQn16Xfn3DCjIx28zbortGC1LcEZumuOmvzD5NqBtjqJi
	 UX4X9ntuMvTL7pvX8Zf9/Rn8MR/z4gtcqQd1fCMt3UJ6DMLHoIdZiBWXLfqgFq7To0
	 bniFglUVtiwAJdhprwS0OpLg4/7st7rQz2lGO9SSBCEfVehWuZDr5QR6ViAnNlPs5U
	 bqQZGAWL9dnOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7FBEB2705;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 10 Feb 2026 19:42:06 +0000
Subject: [PATCH v4 06/11] iio: amplifiers: ad8366: replace reset-gpio with
 reset controller
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-iio-ad8366-update-v4-6-15505f7b15b4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770752535; l=1768;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=xxSuKq9E/6bGxE6XgUkOFI+Qx13kgVsTJFs9X9iiQRc=;
 b=dcB2HBQADW0sFtiSzhEK2yJtDD8iig7v+7Xgvf5rjLDEUT3obH+6oIRmcXverU7+0qfG0sNR6
 ziDzhGVfElqBjyssVwVTjhFQU9ReFlABf/kXoAkzP3pocd9D5BOi+8l
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Remove reset_gpio from the device state struct and use the
reset_control interface instead, using a local variable,
as it is not being used anywhere else.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index f0053a09cbb6..67817dedd75d 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/spi/spi.h>
 
 #include <linux/iio/iio.h>
@@ -38,7 +39,6 @@ struct ad8366_state {
 	struct spi_device	*spi;
 	struct regulator	*reg;
 	struct mutex            lock; /* protect sensor state */
-	struct gpio_desc	*reset_gpio;
 	unsigned char		ch[2];
 	enum ad8366_type	type;
 	const struct ad8366_info *info;
@@ -242,6 +242,7 @@ static const struct iio_chan_spec ada4961_channels[] = {
 static int ad8366_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct reset_control *rstc;
 	struct iio_dev *indio_dev;
 	struct ad8366_state *st;
 	int ret;
@@ -276,9 +277,9 @@ static int ad8366_probe(struct spi_device *spi)
 	case ID_ADL5240:
 	case ID_HMC792:
 	case ID_HMC1119:
-		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
-		if (IS_ERR(st->reset_gpio)) {
-			ret = PTR_ERR(st->reset_gpio);
+		rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
+		if (IS_ERR(rstc)) {
+			ret = PTR_ERR(rstc);
 			goto error_disable_reg;
 		}
 		indio_dev->channels = ada4961_channels;

-- 
2.43.0


