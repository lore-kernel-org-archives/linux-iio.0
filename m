Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745392EBB84;
	Tue,  2 Jun 2026 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404416; cv=none; b=RXSvzeyDQ3HtnPbAAJByn4Zl6vFQtzBEOBvUbE/dgN1RHFe7eilEvGSW00czw/eFsgaDnooYXS4fvr/K0eKash2ZpQ7DHagqMuZb8roi8NSGK9+5fk/y0TQqutlqMHI2rNsmxp+rsk8PHDlx9oQzg7+/iVVrIW+Mua6QYNyPFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404416; c=relaxed/simple;
	bh=D3ikDb5iz89iLJ6uZVHjbY5rTXXDcPWKbnxCOlfwCxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BIcA5rsL2Qa2+GCuBghLyKCmlhrdJpKcySzOwzobURaJigGS6FCrJkjpMwTxgd6lCAgY3IshnZsiHq+4Lp9LMU9Z4nbeT3nCEwSSA9gH20J8/gh2VEhHyawH2SERi63y8NwU/HqbnN+Bw5Dluuhta6WuZlyCRCeX8FIKtxGUE14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIhrwPwi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIhrwPwi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B2E6C2BCF6;
	Tue,  2 Jun 2026 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780404416;
	bh=D3ikDb5iz89iLJ6uZVHjbY5rTXXDcPWKbnxCOlfwCxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BIhrwPwiM8g4fttLy9aIsNnH/HXqmS1h9CdqhY01C/OQPCYcWgWgjYIjKZ4N4CP7h
	 ciMvQbX2Gd+MF8zYUksYOa8g0JyWeGHo8OQQAusZTTdxtOKS54UBmLgKLg1bUi3XBM
	 yG8uSJU9L9o7OWz/CDC7t3uS2Ap96o/sJbaArFhJFohnXqzU5uRUGKCmTE7kjPCvuL
	 vsip9xGWa+0yJoNLBQJgP9nQX6DSUPvgZq7JzZc2kzLCQqFGuCyHEMLbZZ2pyhkd4G
	 ahTr1BjWp37NghpZ0VUz+eLQfu3l7h3P9nNRru4fx83n6zWk6P5qTb+S4r3cna0M54
	 WoLtks88FWkJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9ACCD6E66;
	Tue,  2 Jun 2026 12:46:56 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 02 Jun 2026 15:46:56 +0300
Subject: [PATCH 3/4] mfd: mt6397-core: add mt6323 AUXADC support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-mt6323-adc-v1-3-68ec737508ee@protonmail.com>
References: <20260602-mt6323-adc-v1-0-68ec737508ee@protonmail.com>
In-Reply-To: <20260602-mt6323-adc-v1-0-68ec737508ee@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780404414; l=903;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=AtpQuSBNMLgpeH1t4ADFZid08i2lKNvKchWt3/88KCc=;
 b=hHqTj3fiBKUfx1mwToFKMg4mxiYBDhSI14CHc8RKMiNrj+xTjK+l/K5VUGG2PIddhi2qRwmaj
 +WTRIg8qJBBBt84gGp+lU+/04LQ2r9hJCJBrTx1/qokAEpXre49nNFw
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


