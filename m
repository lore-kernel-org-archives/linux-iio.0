Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239340E8D6;
	Tue,  9 Jun 2026 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011941; cv=none; b=Vv4kCpEbJHzgop9cagPIFx49gBX0z940oKfcCAzE7zOywCvgGJXV/kRz9bi5fF/ouJWVgSje/CIThmfi/Jhhdqe1tzl4XGDCDHPB7mSesQTn5CKzraduHQurE+6yuEthQ4pMC31dY9dXcoA7fSX/SsJydC6nhac22JNgs7G6/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011941; c=relaxed/simple;
	bh=D3ikDb5iz89iLJ6uZVHjbY5rTXXDcPWKbnxCOlfwCxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YDzbNhpRb3vRHQeNNogo5XuKxejB6UIaf5paAMQFCvGLskgKqX1ljOKfEoxYj3p5eNDzPt78cclh2kSQbAaVEci+u4h9UeV1JfKhubcmGiwiP3ZnIqL+DKrXxYRlzkyzArnGwGSt9XNo1EPowfdf+1vkS9I6hk4ab/ja3DVvCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBzFP048; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBzFP048"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11740C4AF0E;
	Tue,  9 Jun 2026 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781011941;
	bh=D3ikDb5iz89iLJ6uZVHjbY5rTXXDcPWKbnxCOlfwCxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sBzFP048k3vOusla6fbqO6uvkr/TSuaO3Vc4q2Ajr0AgbaBXDVgRNRsOdJfGEq2Wo
	 buLx1GWkWoSjmaOQk2HBkt6kzqx7ELVOYTRcy1pNrwXQXuDHvDJRCeZv2mn9J1zI3F
	 rc2WHXb+sykVbDxQhE7M4p1xDM5gNNz7APBcj4L9Ga2QO1lqZUvhko/onyS+d9tczB
	 XmiS8Wq2y72fHydJPYCTZaZrvIK+OMZRgti3UMzA7188ihotyaBhriwPtCcgbYWoIT
	 2oVqc6UfvB1LZzszVTHZu4Vce5ZZwwo1HaOATfIUTCQfrCCxd/gcrY8BtsBOLi3Hw+
	 ApvqhWpR8UVgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD93CD8CAA;
	Tue,  9 Jun 2026 13:32:20 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 09 Jun 2026 16:32:00 +0300
Subject: [PATCH v2 3/4] mfd: mt6397-core: add mt6323 AUXADC support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-mt6323-adc-v2-3-aa93a22309f9@protonmail.com>
References: <20260609-mt6323-adc-v2-0-aa93a22309f9@protonmail.com>
In-Reply-To: <20260609-mt6323-adc-v2-0-aa93a22309f9@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781011938; l=903;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=AtpQuSBNMLgpeH1t4ADFZid08i2lKNvKchWt3/88KCc=;
 b=XYojOB2+13GRqFxOngC4tulPyc6t0pZvZNNFEOPiCzL6p6LlUCSxhwLrXt9bygu2hAEi2LCO4
 Ty0SmucyaZXBtFujKkWyRD/dCNTMzlSwwszMBxBPRp6+dzOpWfsBdIO
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

The mt6323 PMIC includes an AUXADC. Register the AUXADC in the mt6323
devices array to allow the corresponding driver to probe using compatible
string.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/mfd/mt6397-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 3e58d0764c7e..013b0857fb54 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -125,6 +125,9 @@ static const struct resource mt6323_pwrc_resources[] = {
 
 static const struct mfd_cell mt6323_devs[] = {
 	{
+		.name = "mt6323-auxadc",
+		.of_compatible = "mediatek,mt6323-auxadc",
+	}, {
 		.name = "mt6323-rtc",
 		.num_resources = ARRAY_SIZE(mt6323_rtc_resources),
 		.resources = mt6323_rtc_resources,

-- 
2.54.0


