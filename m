Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881027;
	b=Im2yMecQ+Voj6DDJ+QsPxfalSOH35SVhl+GRSVmNLuV8EWxBTaCBEpZPIGU70Y0VixHi
	 g/noyIPgNFF8DeRSty7KopQzKrHvdNXzrhUEVJhD7hkptK056s12xUXRAEBh5D6VIIk7E
	 Lz3hExTGAMW6/k6JLptjMpRAt7fkFlAiFiLgrh20Hem6bV1vDQJq/G/07LRDiNIWcAGWZ
	 +FF/0JrWTCRtYrjUQNSFeDpNy6k9RDKSJYW7ehX0vSSoInBdeAEllbhmQRYDS366o4qgn
	 yvCnERWjDadvj0tgwNRPV4k/CSJDNunQjetV8K+do7zUICyIutAly+NIesaLF+ZChwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881027;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JZWUGcZ5u7WJGAMaT+eTPSh/6aXL9QXO1uj0eqCm/8M=;
	b=E73pXT1UFBq9gBKa/Qim7xqCce6TPgkjI3GV+lEmQLn082HJM+BTsPNCfp4ucTWFL/z2
	 AMuwOtr7N/rL7eCcCtBhLkY3dZTIrBz/QbGUlMrA8GatRhsi5s0u+UsOYAn8Wq7Q12I6K
	 lJ/g9rZ6I9Z/jqKcvBPUO1U4YNVjiCfhPNPNrww74cxUC8eyPxpcTj4GHeZbtpy5kZT61
	 aF7SZFv08g6fAIcs+oJwHzoV8GED81uUPvgqL4A4VEOzm4t+sBhUXebf5mcY2QoPXwanY
	 rUnnP5Jp4GWqqOT3NAv3sLBvGYI8aYKCEbTZxLiEnLlbKxK3xyGGFuhq87JVmOi2Ywg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzXB0Lon;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F65A606EE9D;
	Thu,  5 Nov 2026 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzXB0Lon
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4F71F00A20;
	Thu,  5 Nov 2026 12:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881027;
	bh=JZWUGcZ5u7WJGAMaT+eTPSh/6aXL9QXO1uj0eqCm/8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OzXB0Lon99UCSymj6rvC7HShLWnztmNTotIk344eHS7e8dQhxPcKs7l3Lt6aBMMqE
	 evSwMkEZd8cfQ+CFA7+Vf/eC4Cu0p0QxqA7EbwsmpBZN6z8Vo+KxQld8T5pAMyvvkn
	 FNY7OeBQ51A+zjlSI41SqL1rJ4KT55TlxVy5hrsbyUFQjh0AWQstpO2job2ekJNDbn
	 RdAKowoNfBxJj2g+t39ycGKZbCG2qeXdHONIEjRc18lQO38OWv32X1iyQhgzajLP+1
	 Pz3PRc5ACzjtJi2fGvnRMgUMxMesZreG2m7PCmaDS5A+oEInELMWa0UMJLBzvDPLu8
	 lsjxKjs4S+r0w==
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
Subject: [PATCH 02/10] iio: accel: kxcjk-1013: remove redundant pm_runtime_dont_use_autosuspend() calls
Date: Thu,  5 Nov 2026 12:16:27 +0000
Message-ID: <20261105121635.1612-3-crofts@kernel.org>
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

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/accel/kxcjk-1013.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 336914eb3b3e..18b1ba365f78 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1525,7 +1525,6 @@ static int kxcjk1013_probe(struct i2c_client *client)
 	return 0;
 
 err_pm_cleanup:
-	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
@@ -1547,7 +1546,6 @@ static void kxcjk1013_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.47.3

