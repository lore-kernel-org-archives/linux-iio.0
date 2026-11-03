Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793723746;
	b=zopnTRaC7lbrkHwsiUXQisE/YV0jnfSETaVeaUOe01NGq9pGy4/e/6x0tFZxLF8pEupx
	 TY+5OoWup7arMhdKWHe4RX+xKO3BdOEt5XHaiW6SMgaFUGypSKfRvFk31ZIwaEQWAGsYt
	 H4Y052k4EwsL24NcPiO+UKvf0uNKaSK79rlAvTODh8e18xCx1gAMJhkiotCAu1xty3wJw
	 mxybBr09g9XS+lV0xar3ZqOQBFa7/ZPS/KzIs00/3rDwA4ufLzSKqko6D9veAWX+V/lQR
	 TvKD3KsF4bUnumbVRYAI6E9MK6/HKalMBxY8xXVvvqkoaAApdUKtAKT7Lu/xLGFWdeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723746;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RJUGZOoWFzjXGj7HBosfKmIH9trO+YlXBEC99HJVpAw=;
	b=EoxvV68yTY3UFC/G4rx+bqmyadrPvC1VlPh6OetvytCl1is2GeHgoRXOYLcLcEilhblk
	 8Pwl2wmFeogtI9unzw4bl28dbTHcBV3cLsW3Se66zEATWg1feM4EI4wD1cVAHb0hlmN/b
	 bwICJ4RxpYF7CeDohOjoINJUdvCIkRGtFtleZwYHkjKUCNcw1Vdv/94UrYrZw9d7iBLcT
	 sE/5/R9DCy2KHCrc2f6pHbFniQJDWbS1WO1wCakrgY5kwSRZ+QLYaSQw6qj1bYDsAPL7l
	 nxbty3tJdem29k2F28TAAf1ICglzTttc2o+EcH8eJvYbyz2+0nmf3egCKjCV0nmzfSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deegLFnn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F389606A324;
	Tue,  3 Nov 2026 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deegLFnn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793723746;
	b=pONuBpSCKNWWQ7nMk5SXNcL1jVRaxc5im5rR027z9LquqhOLvI8qGEd+RsXgf+bTWgUY
	 lni9cr03R87KIH35oZ2ySGGS9MZTHbbXcpMsk2YxpWZvcgAQqQ+KwMvuW5pzM6zqtij+s
	 pyyFDPLt57iZNo2/x4BuVHm8NMXW5iIyJPLGVO6C3K95wKkimgxBnAFbb+fZMWMVq85c6
	 bZ08d2CtcRGwXtjPk+2cvrJSqqtuP0jlAGCo9omZ9ssR3guhGXkyzZKI5x5/XeqoPIZxZ
	 zjnsoTERIPJAttOetvIQ4qsPUa7TYQsAC1jLmIm34O7Tw0viB/Wn/5en9bTgCckjBJQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793723746;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RJUGZOoWFzjXGj7HBosfKmIH9trO+YlXBEC99HJVpAw=;
	b=pbXm+J89Uk6C4VMX7wV4kqQef4xeBPHIjfEyLoiIRXIUkROHIYJoozIAXAqcaVhb9a7+
	 ZHsjyu8vYr+G7ilXBZojMxABd3egki5ESqiWP9OImIBL8ILtwmo3yohq+t1ALmu9qAKBY
	 MCWIAGCv5bOduY8jrC1NmThPlDnSBnAr5XZBulNzZadT+9FrRhF5ZumebMvm+Z6IWV8k4
	 gkx5juEZyrLAnsDJf4j7/Tcc2vpeklL6hN0AR8pjepAyCSzAYKr0OPzdjPXmhdRcTpRfF
	 Xw6fw1Su93dg3Cqper9g+DanR1/ZPSyt7HnyrZJMg7dZucRm2YaIqpsgRZXR+8+NOpA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 53A5B1F000C1;
	Tue,  3 Nov 2026 16:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723746;
	bh=RJUGZOoWFzjXGj7HBosfKmIH9trO+YlXBEC99HJVpAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=deegLFnnBRiCFClbYSMoewN7ye07SiAELhyHEQlfjmbHH1nfWeD+jUt9CNR69iwrn
	 fY3qoybAUkRaOdlyKrEdagu/Stmchh3FJLDOnBld11wSM+PhGEw6zNkeeHKiUFUlQR
	 5r13a9N9UxGQrCFuzKfOaKAtcm54JXxOBJNLY10y7EjsJdUZVHWHltvwMoYDri5bBi
	 9n1oRyjuVjYUdAT9UO6SjbXQtV6AcIOSPVZxOz1i/lzD4nvhnxeHbowWt95VYBsxZg
	 b24MMX4/IzODXFfzBuG79dEGZtRLoSAqYz8B+6KGOm+YpA+lIWi2m1hNPTgcOokwy5
	 hS5gWfbkiDT3g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C871B46A3A;
	Tue,  3 Nov 2026 16:35:44 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 03 Nov 2026 18:32:08 +0200
Subject: [PATCH 2/3] iio: adc: mt6359-auxadc: mask conversion ready bit in
 mt6358_read_imp
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
Message-Id: <20261103-6768-6358-fixes-v1-2-2a868a33152b@protonmail.com>
References: <20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com>
In-Reply-To: <20261103-6768-6358-fixes-v1-0-2a868a33152b@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793723743; l=938;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=jjtR8g7xmupL+XnlrkZOXO9Y/4V6fAf1ol/Gk6qBx/4=;
 b=PcG0apM9yu+7SfOsGLh2XjIaQra7NYavUchHZ85lr2Omw/dKnkzYLD6wOGrGXJVvSfg6U4pEr
 7RlGITrGEsUCXPqC94DM43/U8X4Nv02n4iELKlNhQtcHUltkgrPGxJc
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

In mt6358_read_imp() the raw ADC value is returned directly without
masking out ready bit, resulting in incorrect battery voltage reporting.

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
2.56.0


