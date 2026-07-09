Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B0A40D597;
	Thu,  9 Jul 2026 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594373; cv=none; b=qAhB7wDih+w11kheN2NLCMlgu3TI0aL1ImxqZXwFXHmyOzE9OTKMqr9q8KJHQ0l+8vX49ik2jMyOi+gMIRg+hEB951TKrAej81DKpFvHFWoCTVeCiuLLSP1B02hI0UKwpcl6mBPk5BKVbyGOf5dPJjjCAo4NjVtvoZw1OJivQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594373; c=relaxed/simple;
	bh=glxJF+CqpBujx/XexjSatsFoqsr1Dy7kD8mY2XgL250=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7NhWhI825YTPXmC9BhFi64LG/2EZJDHumFxnoi9eO6dtetDLEIjNmMZcWyPGt6dkz4CN4KlfWn0Fx9aVFGYKZ0SJrljOShxL1OHEvMAsMffYYTnOP2IXD+jsR70GIVvS3vFptdbqAILd4CPKaj5FvvnugH7gdLtvsAphwKprDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGp5PE/M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGp5PE/M"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A8CEC2BCFA;
	Thu,  9 Jul 2026 10:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783594372;
	bh=glxJF+CqpBujx/XexjSatsFoqsr1Dy7kD8mY2XgL250=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YGp5PE/MEqSqmr7uBWPBh8SEIu555k00+YpVOhUpEGIY34SX+PgfPt/8D1R9pZEOZ
	 7CfJx7L060PTz59FqKR958isGBJaCUtfGwU8FM5Mfzg81AUqWucoFEDHdEGzLKsRzl
	 2b9GiHC2pqlRCBsDThCi1x7eonxRhLwhkHyRJ914Y0rGtVsaooIPLKqheMEYP5ZC72
	 vxrhDlHxjuUQ2TRbCUsxZmNVj238hyuK9tMXiejnbmW3PZgDlVXnMnNGT2wLSPZ2Rb
	 dfCCwwdOR61/mq9pQ15d7oS/nPK6xkzsNi4Tt/QJ38tLyZTu7ASR6NodaS0ypFIhKR
	 x4OlG6oaNw5WA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199B0C44506;
	Thu,  9 Jul 2026 10:52:52 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Thu, 09 Jul 2026 13:52:49 +0300
Subject: [PATCH v5 3/4] mfd: mt6397-core: add mt6323 AUXADC support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt6323-adc-v5-3-d11b8332a735@protonmail.com>
References: <20260709-mt6323-adc-v5-0-d11b8332a735@protonmail.com>
In-Reply-To: <20260709-mt6323-adc-v5-0-d11b8332a735@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783594368; l=955;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=68AKxGY17xgvLKcWMAEv+kRO5Vv7EjiDlYPerXSrijo=;
 b=QPT+WszEFdc7kGDPIm4EMnqZgcuq4ZTrv/jn3odO58Li6Ril6Na9hDxHLIRMpC5IYDtR8UMLG
 h9/MnOXgmiXD7LaD87s0/idKya1s6Uc0GmksLv1aqSqitW9AmNburDM
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
Reviewed-by: David Lechner <dlechner@baylibre.com>
Acked-by: Lee Jones <lee@kernel.org>
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/mfd/mt6397-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index ea1d039477e3..9ec951996588 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -125,6 +125,9 @@ static const struct resource mt6323_pwrc_resources[] = {
 
 static const struct mfd_cell mt6323_devs[] = {
 	{
+		.name = "mt6323-auxadc",
+		.of_compatible = "mediatek,mt6323-auxadc",
+	}, {
 		.name = "mt6323-efuse",
 		.of_compatible = "mediatek,mt6323-efuse",
 	}, {

-- 
2.54.0


