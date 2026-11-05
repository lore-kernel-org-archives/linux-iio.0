Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881039;
	b=xvnUsUW1jWOx0ZnOaFpJ1+WAMe5xNDwW4htUFymXJJ+zdc8Jp/1F5QGfSnXoWlyaTJ7S
	 VQDQtj/SmPeXaNMuBolrdv4/ixvktwHNfNwWrnGabbI0CmL7XexHYon7YO/VbWt8IVxHX
	 rT35vhdjpususHl/qUTiKYOZMDOIW8Do1Fzu3FMT2q/mWfWAP0ej3MSBrxRW0cKccSVyi
	 B1GKBQr84/DIUVjNpL5lrEY/C9ZO9R+fJTt5Cqd29hh9g2EyKDC6o0dTSXTsfs1yOcA+M
	 C1vlmLvXEvmZgNFa+m29lhYmnzkPevuv97a2gwckCnFJvejXKf3ve/fpbwbtAcT5p0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881039;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=It6k7UD5Hx6cfh+z/HI//bRLuLUB2Zv39AgYutsE7d0=;
	b=optY/c3WcKKsH5yWpJv0CVj0/k5hnuu4yYxTR8uRDhyKrXvfzEh752KqeKodxVshgo80
	 46dCbTRNv5K4pDtjbIuzcgFq5iPRVO043DJK/y+SZX3SYHYxxmkCuHab10gTFkq94UkCj
	 DXR+OTyH6ejPk3SI2RWXgmVYXL60e/tM03KeWpN7c8NJdHJGMRmJypJm1LQtPsKHByv2k
	 oZ95uqA8to7iOY2I1w6W3Ph1VV6IKYMNRlwwoxMrysLJP1sYPbwLu3g2EV4MaVG+Gc1Uu
	 wPR2XxPpzPRBTG8qo0fx9PtwxbKW78+3wTdO5pfpWFSc5zOK5fzef3eyU5NL6q0vEbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l+2qG/rQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD16606A331;
	Thu,  5 Nov 2026 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+2qG/rQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BF01F00A18;
	Thu,  5 Nov 2026 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881039;
	bh=It6k7UD5Hx6cfh+z/HI//bRLuLUB2Zv39AgYutsE7d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l+2qG/rQs7gsn8d/dkGLfk2SprYhH/NYAlpCKJM1SgLr+Oi+8qZDUV+NjRDluJYRY
	 YEAoqCEW/VI2wNdkgoW1a8XIIawzkumGa4kDWj2q14jQ7WsSpVGrw/cBGQLy9aGiPK
	 v2/hfD8ZUVBpaWMdmPd296hVDl9Ri1y3A7U6nla2voy6XlK7y/hgMSqxBB6btFVGeQ
	 JXxRkBJGpBosxMxNBj5xJ+O0SAqCK1A9u6bmPxxWLBUI05VYtCCA2WSjS9G/BSc8z5
	 r6sO2R2KLb7zTBvVrCfWnLUBiqLaF9PD4cL4ZlVU5RdBJeLUdCJyk3rrO3bCgqr0h+
	 CCWUrog44/6JA==
From: Joshua Crofts <crofts@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Eugen Hristev <ehristev@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH 06/10] iio: adc: imx93_adc: remove redundant pm_runtime_dont_use_autosuspend() call
Date: Thu,  5 Nov 2026 12:16:31 +0000
Message-ID: <20261105121635.1612-7-crofts@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105121635.1612-1-crofts@kernel.org>
References: <20261105121635.1612-1-crofts@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function call.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/adc/imx93_adc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index 797adaf371ba..1ced0c59609c 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -415,7 +415,6 @@ static void imx93_adc_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_put_noidle(dev);
 
 	iio_device_unregister(indio_dev);
-- 
2.47.3

