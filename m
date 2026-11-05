Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881036;
	b=LgEOXJsV7h0XuHYtG2x0+zrZZnT7NWetWUQB1CAw46K+6jfRdSBy9H2Cl6dFoEXu/DFP
	 IGGPbB5bav882OTDCENOMRInyi71x/J3MMCumNieoII8GjRGBP1G6vqDAItN3yJ6ZULXK
	 cwU6o+1pVfeU7wnMeOAUDU3UNr8puuq7NjBBN9oOOnzH4YxSl2y+lpLtDCyiTsecuYgTD
	 KgZS+K2wAktBV2XwfMfFjXAkQ5TXXO8QYk1cQxlZZmgy+J4lFnlgXt33MtAZ+DlxVa/iM
	 C5zuN2Sp+5j78wypp66umi2xKLKf/QvbKUdhTnofkyiraAsZe2ApRR775TG3QJEV7og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881036;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x0ny1hflXgtAOuLHGShrT2M6OxxVHd/PDiWsnRTWcjY=;
	b=Sjuull/8EyvYwB8TBDVsx1JkO+EVTQ92cyz7Apw2jiHS1lXlIT+k4vhg8faChRp7yWqU
	 hx/TUb/r2qC2Z45BVpdqjptzND8Eugm9IJytHHFTdg/NcIW7vXtv6q4GriJYaYJz4i5ZT
	 Rf9PrL+i8o4v5nIqYH/h6XmZGpTkqwvPqR5icFKvMNwqhA3sZFBcVeygXY4X1x2Vpwd2s
	 trGuV3NrU/7nfOTkLVknDS3AJ9N5tkanaUqomP4gSSISGAaf+4dddmsSijx0xLPIBRjSL
	 cUFp+dlFo8jgKG5JOGB3cgiL0xSWdawe69TznLKKYjMQL91qVtsdoVxl0FFcgy8eUOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W03p2Rq5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691476082BE6;
	Thu,  5 Nov 2026 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W03p2Rq5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCCC1F0093A;
	Thu,  5 Nov 2026 12:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881036;
	bh=x0ny1hflXgtAOuLHGShrT2M6OxxVHd/PDiWsnRTWcjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W03p2Rq5CL81QfWCncZH9oAde0lsNirH2YQJvZDq39dSiNjT7JvzmaaGegLiBqhW1
	 82lMIe6ZE3uTxSITrfbOCSrbDorNRjTVXol9PGQcbS6RXAEV5TdwbigOSMokFgG3es
	 IxSHnYtxOrMSWgm/+qMBJM4qPuYTFY+FMH+DmsZdAqAsZh3bZ/KR6ljXnhDn/81r1D
	 M3aVV07GMM6+bVh1caEtBz8xK+1euELNIkHFbFh0pwVvfZeRAiXpFmITyjtjh7Psgu
	 Reghd7D0THinh6rNAe74h71mG+vl0AVjU3YyohuiXjUze6/UwBNr+11+0wHxr4ovfh
	 0+1Dekjchv7EQ==
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
Subject: [PATCH 05/10] iio: adc: at91-sama5d2_adc: remove reduntant pm_runtime_dont_use_autosuspend() calls
Date: Thu,  5 Nov 2026 12:16:30 +0000
Message-ID: <20261105121635.1612-6-crofts@kernel.org>
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
 drivers/iio/adc/at91-sama5d2_adc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 78081cbfde5e..2f7d2cee81f9 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2469,7 +2469,6 @@ static int at91_adc_probe(struct platform_device *pdev)
 	pm_runtime_put_noidle(st->dev);
 	pm_runtime_disable(st->dev);
 	pm_runtime_set_suspended(st->dev);
-	pm_runtime_dont_use_autosuspend(st->dev);
 	clk_disable_unprepare(st->per_clk);
 vref_disable:
 	regulator_disable(st->vref);
@@ -2490,7 +2489,6 @@ static void at91_adc_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(st->dev);
 	pm_runtime_set_suspended(st->dev);
-	pm_runtime_dont_use_autosuspend(st->dev);
 	clk_disable_unprepare(st->per_clk);
 
 	regulator_disable(st->vref);
-- 
2.47.3

