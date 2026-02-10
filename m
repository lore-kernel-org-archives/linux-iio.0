Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2DD322B88;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752537; cv=none; b=FBA9UOSrhey/13IikP8I9+XzAiauVahynKsyqJjVchSGaubYAGl+PZImryGqeuc+4PY7RfUO095hVapvE5hQKjnpVHiGZXNb83xrD0SJTsSZ2mxXu3GM2x+CEMTN6eVaxav257FT3YarkJiouLcyUII+l6sX/qp/kRVoP3xlmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752537; c=relaxed/simple;
	bh=HnXuDL6EUjqkpXjKEAnK3sdeskqhNnNnUmEFEmQP8fU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UqLSod8Vm+dsdSiCytBV1b00bp2RcKBw540rdGlE/S8UUdp/nxj/B7RCUZZhqRnTjr2zTArswxLRZQ4A9gJe0uf+GiMLx99P7BJfdgboWtfv11WgpNwGLxXx2Vq0O97ETBzfQ5/t+cDrBN9coasy6BAttoGDN07RTmjhAtpUIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZAjwwXK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZAjwwXK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FC23C4AF11;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770752537;
	bh=HnXuDL6EUjqkpXjKEAnK3sdeskqhNnNnUmEFEmQP8fU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YZAjwwXKxqc3guNEJVZYBkgUAiDJpRv5SUsnAX3nMPNGrFGIyKs/ask4jtm0vP3nr
	 +6/3StJiCt1hgef18MTU61NawmOk2Kiq5JyIm6thWJ5bj+ZvyhwwzDKlyQPTlTsRhX
	 bIistFcd8VTIyEvPJ0mknnrLp18q4dDvVYyEnfp/m7pw+b0gtI0nJIZXPerQsFxENR
	 goiBTgzoPemepK4nqb4DNCdJ5BPUa0Yb9TzyTqC+Gnhk2OgtbEAS4wkWZtRwgsichv
	 /yTaU/7bzbfexTRlFIBkniA631XMX+CTndoChvlCVpybhfRqEuNS8YThzy6mezhsyF
	 x/z8udVfN9VTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D11EB270A;
	Tue, 10 Feb 2026 19:42:17 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 10 Feb 2026 19:42:04 +0000
Subject: [PATCH v4 04/11] iio: amplifiers: ad8366: add local dev pointer to
 the probe function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-iio-ad8366-update-v4-4-15505f7b15b4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770752535; l=889;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=JmFUgvP/u+bpyvqN7DVDvcGwocNFLn+PaOaZRRviA1w=;
 b=584fxEGTc98Iyh2c5wyNxfeEZUj5uTEhH/qfrQIsFQtLMGoZjcN0tkP02tGbZwVVO3GvBo8Jv
 OUFeYiB13X6BpR4UC7+wcFdiLBKeccHnKv5OY0uWz+vDJeHG8v7+/aH
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Create local device pointer in the probe function to shorten lines,
making the code easier to read.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 6382106ee6c7..3456a31cb1ee 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -240,11 +240,12 @@ static const struct iio_chan_spec ada4961_channels[] = {
 
 static int ad8366_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct ad8366_state *st;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 

-- 
2.43.0


