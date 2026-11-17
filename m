Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938206;
	b=aBrB1WLDsTriaYiQflcxdp3rIp12euHlAjGaKtwnU9LsI/yxtV4xI7+uT4Wm4e35b4Tv
	 6STgOqCm+w9Qkakm1l0KxA+NgqBvd66HZe7tVZbetAAcbCKllR5R0d3IvEZYdk/JTA4Lx
	 DZE9OxFXd/4uVEyDB3T8AMcZV6S+AscXy3Grhfq7wvMrs84rjjW8yItVRVR8JYr5OI2Eo
	 qufRLbqfW1MeychbmtG/rIQMEekrmos5s9uNxVGwROuRgNK/+YZq6SiN6RfingIeFmLqT
	 VjD/4fVTbn6kfSbnhz2VfS4pB+7x7KlXeGKX5dBZktDeUvTOk1kA0xhYxSWWAPrgXhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938206;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=37uGohoQrLHj2USu9UhU96IUxbYg5olFY/6kdsoRNco=;
	b=pljOe9Hvzczfhx54Kxp2QS6YLnfwW7Hwa90xfbMr5SjkR/LCyc6tZ935baJBVtTaCbVo
	 Kl5mqGrtYp7+zRMkuctWu43eqcXIZuj2svx2lC2QPe49xEp5msk3PI9lFaVIWRvdjAigJ
	 87ZgqW9gXefC1gw5lo5E6oSYloilNyqA/tbAv+8F7PqV3WjYSM+qyTzD2xORg6Vmrnoy0
	 YNI52gVeDlGXRBRAxsSVlQ0rTvaM7L7WYSFtL3T3Sd26T9VnIrUJrlC3PmdPYUS+IK2Ni
	 4kcolYavXGhQDLXr0PFwmqNOga9UqDChR71RIAJnzMHKURTUBkn9a7Xr+wgXqq4cIUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q/iaKNLl";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7053F606A335;
	Tue, 17 Nov 2026 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q/iaKNLl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794938206;
	b=iz2roCO7X9hERV9Pf2dAFWjv7S0Amxd/l8/Jg/MwaxHqZEFkLO4hVo1z549zB6256JIs
	 hYMnnyj5JzaEF4cJD4RZbnNUBiIqd7j2nHwkBdQlmRv5ga+PO1sUZDH6mppUTCAuZrE8V
	 OALahacFNyn8iZ5aFSmgql1OJ7/oMxlg1TM+81qN5cROXR6OqCRh7Q4qocrNFzI+DTOcN
	 7i56ofFGX8HOoUOu5JYtl1vcQqpZ2UC79I57y9a0AobJi4pvysGKZbAEq2ucVDwdYHf5g
	 Eo0dcmX6MN9D6Pafe+6H2s8G9FYBz84Qm/s5j3s498/MVopMGzsBzPtdq1r/Ve3swIw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938206;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=37uGohoQrLHj2USu9UhU96IUxbYg5olFY/6kdsoRNco=;
	b=l3u0l1ZNdtSkqBlqAyPTEFAptuJDjAC1+WeEnu8DJ5KBTxPCo+HA1RCuQyJFWvyGKZfd
	 aWtUM/OaYfBJRHgkvmlzoG22ACwXvhf21sOuFvpyAfcDs9xm4uoEK4cjj+HSzt5uxQFPv
	 UqhEBUEehNnkqB73EEnQDyyrtAIqFU2U+jd9RFHi/oR39c25b+OJO2vYxe6chTBMv2kuo
	 KEZpugywRnEgWUMA5IAwBE153cAIa5H4ltH70fqdgqmu3fTYtzQ9ONQ+lT5N32iVp8yET
	 Ur55Ttq8igixGeVxlQ1DhuTOYEDC5imUXsAqU+2bZDtg/fCcwdXK88RUXoSZ1y5W1ng==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6787B1F000C9;
	Tue, 17 Nov 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938206;
	bh=37uGohoQrLHj2USu9UhU96IUxbYg5olFY/6kdsoRNco=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Q/iaKNLlBufYPlZbtZrnh/h7jMfujgz39Fz49GIWzLBxcMKuh5jyMsxX3YwuJJeHp
	 rVsjkFgBiuZ7gYlfoa6yXnJvk9Vt9G0mvFQCRRu+oY5hNFEsz3bvYkGki2j6JOuhAL
	 FVd6I9F4/ntadqJiz78Max4iGaiffSrlTlhQnHUcMYimbJfCzdAaBGk3UBykPPyzZC
	 k5QXAJxDykE1w3uF/ALGEtMPaVOd3k+kpOacmzkfRi5BAEHs8qYF7WpCDyXHn7wLaG
	 FSEiFxaRCu22jS9sHXztBj2FG23pUb03bF6vnMaKQUmkf+9GLeGJimJ+kYswwQHJlu
	 lBxRg7N85QSvw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DFD0F4AA2C;
	Tue, 17 Nov 2026 17:56:44 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 17 Nov 2026 19:56:33 +0200
Subject: [PATCH v2 2/3] iio: adc: mt6359-auxadc: mask conversion ready bit
 in mt6358_read_imp
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
Message-Id: <20261117-6768-6358-fixes-v2-2-1ffc3c2f3c80@protonmail.com>
References: <20261117-6768-6358-fixes-v2-0-1ffc3c2f3c80@protonmail.com>
In-Reply-To: <20261117-6768-6358-fixes-v2-0-1ffc3c2f3c80@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Roman Vivchar <rva333@protonmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794938202; l=935;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=bZjW/quYiBMjfPjx4Er0DwmCVZ9DiZQDsN1KE4x1ONc=;
 b=OusJTjkZgLVAQdFTHc5MWzls2x8KOggCi76d/hEZKW7sLdQMmQUGtc1+S5huPfcnIAGMHGrZz
 AeXtIKS1cu7DL5N75QIwAQGFGeJmi1NS9rmUiPO/OWlXCPD2UIP9KsM
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

In mt6358_read_imp() the raw ADC value is returned directly without
masking out bit 15, resulting in incorrect battery voltage reporting.

Apply the mask to strip the ready bit, matching the behavior in
mt6359_auxadc_read_adc() function.

Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/iio/adc/mt6359-auxadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index 951d236f972b..09432d0974cf 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -502,7 +502,7 @@ static int mt6358_read_imp(struct mt6359_auxadc *adc_dev,
 	mt6358_stop_imp_conv(adc_dev);
 
 	if (vbat)
-		*vbat = val_v;
+		*vbat = val_v & GENMASK(chan->scan_type.realbits - 1, 0);
 	if (ibat)
 		*ibat = 0;
 

-- 
2.56.1


