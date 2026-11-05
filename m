Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881024;
	b=r1gdwN2mo4qAjPEMdcrVG82tl9rven0ECa+7wub8xtRfFUUvgSEPVs9KtIyo3RHiYxLv
	 pm9nsLl8yhKzrSSE0RUmp03VKXxbDkvQ13sF0Z1UwLVcwkBr823K0mjUv96MFAoyA1i6K
	 ySNCoUCqn4C4xTFhmBITU5lYfCOgvOsOC4eemNpZpbbRrf3aKKrJS8jpTL3CbT1xwaAeT
	 QCEW5axdd/T4KnRRPzlG/Ni/G2iRGerNalaykozc71yLLVaHn0bB+H598rAA/StS/qMyk
	 M/le+3m6xJUxYNMHAU4aaGkQ/cX3hIPqs1j6iB8MwhN2PisA6pmeAY4FJXmZVWU/O2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881024;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=A76kbWEYMEb2TumRomVF4HcjLv8I1DTgmrx99YMnpQc=;
	b=yAPRBRZ85Dt8cRQ1RmqlslTCuWwnoYPCYCs4+NP497BKzFwMBQ9q3joXUGjWHYy5CSeE
	 G29EHT/X8u4MqiUOJisHVNC6p6SI+0BvRKlNldR/S8JtkC1QHq4FYO1/1jC6lriFF6sWt
	 KLyiscimSNO6BBS0pugJW1bdKaalI95YUGUwcPqKhV2klhWUehdQWWVVC5K3Nqn0mGrvc
	 j4q+CJbjl2EnsCWeTHPdhHtTkh6RoUrogBB2jCly2Pct7xA15bsBQUiHUK5xL3rBEdW93
	 ghTK8e3GQSzL+PvdnR67TnwgEeaekzzIRllLEJcBjgU+wfLwS4BS0EjmDNpTQnSahvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bm3rUBsv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA30606D803;
	Thu,  5 Nov 2026 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bm3rUBsv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6297D1F00A21;
	Thu,  5 Nov 2026 12:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881024;
	bh=A76kbWEYMEb2TumRomVF4HcjLv8I1DTgmrx99YMnpQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bm3rUBsvFPBuIMHPjlu+04EArvjSDHF3OUCcrDgbdO8nu+agGF8RxE29uqKES+j6c
	 VciAWXxbDS5KWhzZpyEqQSfLzLKUPLu77oA+fevIJH+XN21+YA5EDhScM0S1JCCEP5
	 EIBLTxpnWWB1TPnS66Cr2pMMQW8giAtMG1kE4vw64sLJk2fAq5sd8b1XdLRjmq22K9
	 6W9tyDNL5lKHnut2m+QERIgatNOLncOZJLIJ76A/Y9VHfaE5+TrsHS6xbTmnJnPVc3
	 VfRYGAGpUDRYaVROTwETCxH35Cq/MaKYUBUOJ4eopargUr8XkqPA4LNNXBOI3MABtY
	 jc/iNVxY0coKg==
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
Subject: [PATCH 01/10] iio: accel: bmc150: remove redundant pm_runtime_dont_use_autosuspend() call
Date: Thu,  5 Nov 2026 12:16:26 +0000
Message-ID: <20261105121635.1612-2-crofts@kernel.org>
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
 drivers/iio/accel/bmc150-accel-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 46bb36d9366e..754607d1f38a 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1751,7 +1751,6 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	return 0;
 
 err_pm_cleanup:
-	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 err_trigger_unregister:
 	bmc150_accel_unregister_triggers(data, BMC150_ACCEL_TRIGGERS - 1);
-- 
2.47.3

