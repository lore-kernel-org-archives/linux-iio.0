Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881051;
	b=ipFqYQejOKEuqsi5KQi7RNgJMSjQVb3or8gTd+ZLxMjStx3HEhOsCKmuTTBU1WsWVFvc
	 6ssLslObgdExif05aIJB1TSc/Ckvut5SC0HWe1yZqzFAry71zWvllN6HeU5smN97dc6uw
	 X22hwwWxdyh2hx0JKxTA12u1YOtTxKaYRFiRJ7RIKGvbH/Blk0aWGG5bp12jCuJNJWtWp
	 tQ7yjKgIGtVs2ri7PBaTFoDPJ0Bqrt7OPwm1zswo1RMDAL8Y4Y2XweVb8q91l5M+beaH8
	 OlKy2d0dIwlDcLaxwiyD3IHPwhu041fbGqsUg4QRaIydBy1lHwjOJS7s0MbKCIV2x6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881051;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QUHMmcOW+XDbVYGagQbDFPA+A/AMi6QA2veHRlPHrFw=;
	b=FdseBCw82pi8OamYke5EDqmZu6nfCY4x/bMx1awifz8WnRBGQTBux9e0MlWiLzTMbzvM
	 brPyZY+bowpq5eeZJCai24wxnR+V8c45HxSpnvPYHiywmysiYbXmSvYck3RuRIkzkUn0A
	 CF/SeNURrhkEZOTvxgSXxfGfoVBJJXEnazKaT3jVgooMc9WrsmJug0DWMTtg+MsZjp0f2
	 8PbqnGpENr6cfPRHu4qQZ5MNy+RnV5qxDr8JDtsBU/0nzTTMtxjG/jYo7TE/viLsVfE05
	 nkG5sPUtaZthehkgjRIikWsqCVckuT6T5OxqOJquOd6mU6Z1xqCaMpapueDwsciHqyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwHYYMQA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656C606EE93;
	Thu,  5 Nov 2026 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwHYYMQA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AAD1F00A1B;
	Thu,  5 Nov 2026 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881051;
	bh=QUHMmcOW+XDbVYGagQbDFPA+A/AMi6QA2veHRlPHrFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IwHYYMQAUcTz0BPOF9YL5ylp7tRiBQ8L2QBWhjH8B6Z8wvbhFgukxk2ghxPFhbpDw
	 Wp15i9YaLCSBRaU4WGZy5xUFlUL4hnJoSU4N/2OPH84eQ1h58AXcL1mLtJPdwFYCRl
	 aRKZ6lbbcXnsF2HUrBzXe3ae04kFs7Qzz+erHrmK+NWe5D2qflKw17GNh5eK5uaBgq
	 fvBCXF0KFCmclAtOAC5ptxN5MfinwC7mHv1v7T7HnoMVDv+fBVaKwPJQ5mJn2+2/tj
	 tokI2+Ah2o+OGIfE7U7Kr5lsMZeJmYJy5VbDXWL4Y0YKiatf6jWDWW7R1mxshyGkP2
	 s58VwXVwx0XVA==
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
Subject: [PATCH 10/10] iio: magnetometer: bmc150_magn: remove redundant pm_runtime_dont_use_autosuspend() call
Date: Thu,  5 Nov 2026 12:16:35 +0000
Message-ID: <20261105121635.1612-11-crofts@kernel.org>
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
 drivers/iio/magnetometer/bmc150_magn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 32dff9cdd0f7..16b5c2451728 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -934,7 +934,6 @@ int bmc150_magn_probe(struct device *dev, struct regmap *regmap,
 	return 0;
 
 err_pm_cleanup:
-	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
-- 
2.47.3

