Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654425;
	b=AqD4PUmtZw5U/m4jk+PszhxNnPOKaTsclEV25naYpEepj6gacBM1aUNjVLd7tpKsUZ/s
	 /5vlFyCgS4wwbt4ylEvTDiQDClJtWtTA1lXczYQukH6Ued+eIxmMqE8V/6OoQ5fufrY4o
	 M1B55BIWwRwwyt48XQ7uoZYpfy2rc7pIVRUDVYda1ZX7SDa5MVc4NtSr10eiiwyJ36cGg
	 xlRynVbcxPm+E75cDX/Pq1ELYpyJMkQyhoQ2FlYSEoJiLYmJLpBoF2Lse8LOxlaFPOXAn
	 iBQpABgjMFZ79IIDj1mIKkPtMByTIm5g5fcKaR6k6AKLM6filQ3T03wyqh/S2RUAKjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654425;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=He0nXqA4GAkg2v7LtFnh4QNSUKt39aT0rP365F15xKo=;
	b=02UgNKc50WoU5b4LEUNu+Pwy5r06psIIkMtyt/+ez7yY1hSXrMDZE/Gu4ciBFwpnUuub
	 IVCUBmbNgLBTS7QYBG2App2s78iC9+sluYioPhsJbhTcbhSFdsrHLlsuR9OwJkQH5+7dY
	 ZUTiN8TdjS3DOYUCZFbz+RtK48R7UAqduSks/LelgE530vJhKQbq6V4uiHAEay9EyuUix
	 OKh+C4sPPyR/6zowNtHknwfcHcwK3wMNKFrXHj+zKwpkdjRkvFKxi9QQdXg8///DEUr+3
	 Ly8J9Kwben+5b6DunLP32k4adD6OE9duysv8G0iU99snzHS8MnQDw91oxkzB1dkqt/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuY46QAH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AD0606A698;
	Thu, 26 Nov 2026 00:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WuY46QAH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795654424;
	b=gb+Yx551e58AB2yzR7OGOmNvMKXyJZHzvGsGcNvFN1RroQX/SWdAUY3gu5I3lap9B/3z
	 EHdho+mUU+ezzUXYy89GXkKMGuX27xVPJYBc1aHluG6MqmzCI5sT9ANwDwBy5rgxG4OGS
	 WU2KXnk9hSTGlbYoFVsTwZZChc1V9Re7AEUgSaOf7tEG27ChFauQlQfxQk4bsVyAMZSBr
	 dQbLWi8qv5/z7yIqBEZcT09MnQbUgsli99hNRK1JIDXM2C6QvUF8XEfIK/PNSJptBlQlL
	 0w5P/yx5/v3606sgSEkgsJ0o1zORYdVEkAjZcFEXjPjA53wVJhbXEvNTGR680iSApdQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795654424;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=He0nXqA4GAkg2v7LtFnh4QNSUKt39aT0rP365F15xKo=;
	b=BKc3NSAfq+RKvQ6qdmSQk9pLeGPmo6oYY7SJ+2ZABSgE2XSXUg3SdUjvDy/82LH1kBqC
	 Y/ljAPIFwHctmLcMoNO8odIZwYWF4w3p7M86e2TfHXlHUtOuLDUd/k88lwaxl/4RbAkYv
	 YGTwVggURl8KvPo3HYgcyWWAz6kDdJhu0VMU85m/PfUf/ALUlw21kDwWQ0XNHd831Ub8g
	 lJGGvZrAgZdtqBnzT/jRGzUdjV6WUW0enpaN5v3MklkTCEpYVs9e/b9++B1I5xwN5g/Tl
	 PyRbqS6qKRNEjm7I0Bq2OPrGpuYOHfEnDI7yCQFeg5x1TEcMPZrSti7wHmP1HgMhf2A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C29731F01579;
	Thu, 26 Nov 2026 00:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795654424;
	bh=He0nXqA4GAkg2v7LtFnh4QNSUKt39aT0rP365F15xKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=WuY46QAHf8YH+FE2jSpitaELq7NNVKflIAK5YlV637svqNEAxsz86vXZ3r6uaI6eh
	 /mCvlQUqZNFkRxTkbWYDf2cHi3MDhha+pcWG9+gcOkLHKjBlYhG+sO5D8P9F0lisjO
	 1qd8/LKNVhJpJ7X9t992Kj3mzJXFS0IHlVcxWRefvARIwWRLhRyKllxRSV/kDohipy
	 FFeL8ZThyL8m/4l6NvZB+CkxPKReEpRtILTkmrl/mC7O6qI0ilzjFTif+24NwMzeBY
	 YAm6cvALD0Qd3t6y0juAHgZFoqz5YQVpLXkMHp8Qn2DL+xSrJr2aZfm+YvBnMe7Mvg
	 na2+kbFiiYKMA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 768EF4D14F;
	Thu, 26 Nov 2026 00:53:27 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
 andy@kernel.org
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: adc: mt6359: fix MT6358 VBAT impedance resistance
 ratio
Date: Thu, 26 Nov 2026 00:53:29 +0000
Message-Id: <20261126005326.71926-4-iasnezhkov@gmail.com>
In-Reply-To: <20261126005326.71926-1-iasnezhkov@gmail.com>
References: <20261126005326.71926-1-iasnezhkov@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795654406; l=1270;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=WrCKZo+xyngHjDeJ+R154khb7hjNavDC4cJWvorC71s=;
 b=tDW7Y/NLthcr2DkwF9JfTPOHU1B/Q3OlOxtv011CpCaAlHi/aqsbFLxy/dDtM/1q4IZVwtlh+
 a7F767JsXh2AhE/JlfZVzakSpHE7Jq5UwxhZ8fvAEcz5v9kDVXqkdvE
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com
Content-Transfer-Encoding: 7bit

From: Ilia Snezhkov <iasnezhkov@gmail.com>

On MT6358 (and MT6366), both BATADC and the battery impedance VBAT
channel use a 3/1 voltage divider (5400 mV full scale with 1800 mV
VREF). mt6358_auxadc_ch_desc[PMIC_AUXADC_CHAN_VBAT] erroneously uses
7/2 (copied from MT6359), over-reporting VBAT impedance readings by
16.7%.

Change MT6358 VBAT r_ratio from 7/2 to 3/1 to match MT6358 BATADC and
hardware.

Found and drafted with an AI coding assistant.

Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
 drivers/iio/adc/mt6359-auxadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 4a66253..915378c 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -285,7 +285,7 @@ static const struct mtk_pmic_auxadc_chan mt6358_auxadc_ch_desc[] = {
 	MTK_PMIC_ADC_CHAN(VGPU_TEMP, PMIC_AUXADC_RQST1, 10, PMIC_AUXADC_IMP0, 8, 8, 1, 1),
 
 	/* Battery impedance channels */
-	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, PMIC_AUXADC_IMP0, 8, 128, 7, 2),
+	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, PMIC_AUXADC_IMP0, 8, 128, 3, 1),
 };
 
 static const u16 mt6358_auxadc_regs[] = {
-- 
2.54.0 (Apple Git-157)



