Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795662640;
	b=oaeN5yBw1RF+Fp8q1k2Vrs9xuS+3KopLVYuhbi7NQNJXteFRr8nx/mG4K966Wsctm9qE
	 ZXrHlBamRY2wsfr03mC6aAhgoK1bLV6xqxSt0mzSf56DYuQ+4EC40fxoYeco2C7RnCN9R
	 yYVhGB9AzOIHi0wNRaYgvepqQqzXJTREiZoV8WJyOEsJcMkNjNSWef7qeCfoSKVEKYLQI
	 hSm0ajnOrjBBVnVcmxoXl6KnVgIYGsVmNs7hm6NL1JfR4pKBBAJGJAccp2YAhNniPo7j7
	 XRJvT2gJHC1IQvAv9SDvKJxCX+h9N0tRIJ36bqV1YxHtsH4gIlwGDP743/IRjIaiuLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662640;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Xcd8RAsEVEjiV3LkvRveg5qq9poJ0EgfM91ZZy4Bye8=;
	b=XK7ONznxnAlgPrO6t8kPotWQSmbIOz2cyNeI4wldDsCsqqUBlabF/MGk2pYdrQeML1gI
	 yig40pAidO4B82cPRJe2D/EKx6dTrk2DPSxXCOY/nmN8NzTOTnfMFzTKUx41ezqeDCllQ
	 c9Wg2pCkXISdZ6jQfRTLMeM3H+AK0xQUrXpEOWwhkKdA6oFdQP76O2Wd60VlULE7C8IqN
	 TpCvD9YMTXOFmoB06bOr3QMnuuasqVFXpKw/pfXmUQLTlUlZdoyZ6oNEtKbIcX67nMLTf
	 WaiRBJaycppWe+VmGBKvdgTLw1eHF5//hWcle/ggGPIQ0fBt1WcJ4M1k9Nw6kApZkwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVqAuRGR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E306606A68D;
	Thu, 26 Nov 2026 03:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVqAuRGR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795662640;
	b=dOrREV5Ci6fkLAGRQIxsdmR4QonSBlcngjcLBrV7VfKOFvP64zrF1oR7sAswpQvw7nmj
	 srcvO9KftLkK6w5s06MkggPePTcwNpl60+3EIfpZ/Kj3YUH+N+9M6iVpB1TymjME2061d
	 SFts5n9+RXj8MK4t3BflnLjnHK1spm/K6BzN7+HhLe1U54Vu7EIQBTkdxnbPVhOHLmOVn
	 wAGR2nxrAlA8PmUFLa7ZNmGgcKwNBs1/LZJ9sunwZYXt4EWqGSXex0KWXBYyEUGQ2rgkt
	 7c1jocfq1rSTyAMZwfg6vHIwxkdVKgxTit9zpfxNMH+5pHXnivSb6WTEpa2fmRVeQCA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795662640;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Xcd8RAsEVEjiV3LkvRveg5qq9poJ0EgfM91ZZy4Bye8=;
	b=rYKedey3thgCd7t7OvFQP/12PA708DXTgL4KLCsVShQdEzpqTFqVfnC/5EGA3NcYQ6q7
	 rt9RGa7zgaDC+p/toNEt68nuSKO+AViyblkX8RcSoKF7+88u4TIWwXIC5xInbZOk1twXo
	 56wagsmWpYrZNeOFrsBFA8hpGEawBRziZD8BJz3eHBaDBWRfBQrswzl/TvvoPZUUwWspj
	 0nuGhz2KUnZRnWeV2ggyUOEEblktJnNv7WJzhOv5obOUU4Vl1R6hPKJCHaiWEVQbIjm9/
	 i+oFBXds8mMTepkHMdCapq6mB/RnFz0gaIe3QUaaZpfaBWQxOeOB4tEZLIyTsdIwT4w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B946E1F00A36;
	Thu, 26 Nov 2026 03:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795662640;
	bh=Xcd8RAsEVEjiV3LkvRveg5qq9poJ0EgfM91ZZy4Bye8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=IVqAuRGRiTbcsAr37s+CpxPcaj9LlcJBmzTTCoRTpJctgZH8dzYM4HpOgDWRDy+Uw
	 QCuIOXhqRpkdsGU/Wtpz7/eaOa6qNl/vFHFEyDUxlNvQEVuBpOcUyLchJ1PHO1bFWJ
	 /LaDl3On/FwXHrr0EuRFnhC92pFbahRUqid08w0wp12fnJ/dGDlZBvCMtO4mXSAUiG
	 q+9CEBxGsBZgFdWn08Zrc7tA/FMI9f/WgI6OGLwLcsojfwzuaMFhmj4aHkYQWN7PlS
	 k8QTmIjJ95fO2L3jIerT4WidJGOZGDLn73RsjSgwCghGPLWSPnsdBrWjOEpiN3OSzq
	 iOT19vL+6akYw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 593754D1FE;
	Thu, 26 Nov 2026 03:10:15 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
 andy@kernel.org
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] iio: adc: mt6359: fix MT6357 ISENSE/VCDT and MT6358
 VCDT request bits
Date: Thu, 26 Nov 2026 03:10:15 +0000
Message-Id: <20261126031013.27701-3-iasnezhkov@gmail.com>
In-Reply-To: <20261126031013.27701-1-iasnezhkov@gmail.com>
References: <20261126031013.27701-1-iasnezhkov@gmail.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795662614; l=2570;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=Tm2foiR76Y5F+c07n1fWMZO/zetnJqISUTM3KZbbJ1Y=;
 b=3GIxGW63svjr+l/NjC6o6Ty65Pl/a8/SpLlAM/aXmKmB3+dXDCsTdEHbDIw+FkQx862VMUgYV
 exOlE95VR5BDNrC+pr8EEnInI5ddM/FAWiCw8tlqTfAvuOC3ELz/Vgs
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com
Content-Transfer-Encoding: 7bit

From: Ilia Snezhkov <iasnezhkov@gmail.com>

mt6357_auxadc_ch_desc[] sets req_bit to 0 for both ISENSE and VCDT, and
mt6358_auxadc_ch_desc[] sets req_bit to 0 for VCDT. Bit 0 of
PMIC_AUXADC_RQST0 triggers BATADC (ADC0) rather than ISENSE (ADC1) or
VCDT (ADC2), so polling the ready bit of ADC1/ADC2 times out unless the
channel was triggered externally.

Use the actual hardware request bits in PMIC_AUXADC_RQST0: bit 1 for
MT6357 ISENSE and bit 2 for MT6357/MT6358 VCDT (matching MT6363 VCDT
and the MediaTek PMIC AUXADC hardware registers).

Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
Changes in v2:
- Move AI coding assistant note below ---. No code changes.

Found and drafted with an AI coding assistant.

 drivers/iio/adc/mt6359-auxadc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 54c9048..4a66253 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -224,8 +224,8 @@ static const struct iio_chan_spec mt6357_auxadc_channels[] = {
 
 static const struct mtk_pmic_auxadc_chan mt6357_auxadc_ch_desc[] = {
 	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_IMP0, 8, 128, 3, 1),
-	MTK_PMIC_ADC_CHAN(ISENSE, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_IMP0, 8, 128, 3, 1),
-	MTK_PMIC_ADC_CHAN(VCDT, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(ISENSE, PMIC_AUXADC_RQST0, 1, PMIC_AUXADC_IMP0, 8, 128, 3, 1),
+	MTK_PMIC_ADC_CHAN(VCDT, PMIC_AUXADC_RQST0, 2, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
 	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
 	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
 	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
@@ -271,7 +271,7 @@ static const struct iio_chan_spec mt6358_auxadc_channels[] = {
 
 static const struct mtk_pmic_auxadc_chan mt6358_auxadc_ch_desc[] = {
 	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_IMP0, 8, 128, 3, 1),
-	MTK_PMIC_ADC_CHAN(VCDT, PMIC_AUXADC_RQST0, 0, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VCDT, PMIC_AUXADC_RQST0, 2, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
 	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, PMIC_AUXADC_IMP0, 8, 8, 2, 1),
 	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
 	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
-- 
2.54.0 (Apple Git-157)


