Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C791E5B9F;
	Wed, 16 Sep 2026 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558979; cv=none; b=alA0DRwnWSuL4BFFFVWeiL2epsspaFkuic01vNEKT5HZMXcp4u4CbNt3xzUdEnZpv8R+6IJCIOoVv7sn8p4W0UO1py0de1+sG/kX1pxwsHYFpNr63k4lRuH3OLwIipYASqceZeLY5EUyKqzii2u4B5y50gFCnLl6s3nS+HdVU3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558979; c=relaxed/simple;
	bh=2Mw0UYhkPwOelAjKAtaWqRpuJeZGpm+KZh1S53AlCb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=drJ3Dy8xRXnbgJ7VM1VzIdn5A241EkNQRrX2ICOloC139RuiHfjatiV5Ou5pX2ODvcNLrfz82m618i/72iziHvRUcmavu7C4IX9Kl9H2+U2c+UHfvXplnsVHsx2AmOaNyk0oelipjpWa5yPGy2EgXMT1U5XqxmJxSTszL0c2RRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNrE6Yav; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNrE6Yav"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF9DFC2BCB9;
	Wed, 16 Sep 2026 11:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789558978;
	bh=2Mw0UYhkPwOelAjKAtaWqRpuJeZGpm+KZh1S53AlCb8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kNrE6Yav6mYlwEQYXSU9AUQaWn9TGkSwHRPX4vobJoPMw/tmU9Vgkt8BBwsrlDekM
	 HAgiudLMv+8tslEFlSftOzJLvJ5S0bLCKo4v3pKXspheiznp4tult+7O4ed9456rFR
	 839zQNR9PvS1Y5Vw7xE2xwuUpGqlkUrEbO6e1XlNrK3j8aEnr8uioH4PuUI+DCgwVr
	 HLwhPnVedMzWD4J2RTE78oGoUWKlZlsde04kIMJ1giv/nBUEUPxCwufVQQMTYjNgF1
	 APw1Rc4dv1U1LepuBuU4sG03ZyJEfGCEo/7yJC08CdxIDMqynikpG770sta39u4Voq
	 Sh4NIfuUI7HFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF81C88E7D;
	Wed, 16 Sep 2026 11:42:58 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Wed, 16 Sep 2026 14:42:35 +0300
Subject: [PATCH] dt-bindings: iio: adc: mediatek,mt2701-auxadc: add mt6572
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-6572-dt-auxadc-v1-1-e8190d614c33@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxA0asgz1gKJk0RV0EMIXFadwCUAEJC3
 J1Axzf8f0DiKJygLQ6IvEmSacyoygLc144fRvHZQIqMaiqN5vUm9AvadbfeIRsfSNmhJt1Ajub
 IQfZn2PV/p3X4sVvuC5znBTiodohyAAAA
X-Change-ID: 20260814-6572-dt-auxadc-e6df20ab3248
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789558977; l=1058;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=RZDlKUe7DkcNemzM8RoN8vGwJ99E8wZHTiCH/d1P1qc=;
 b=sAqCN+D1D/bp0wpWn6DIoDT5q9AaznJfEIUcDQ7I9fdG5FPPYC5pfDjIC9wSL6V3bOBTnmb/7
 hqK+o78k6yxDozFO2zoTZfpaH3rmXvvXlR9HVzsEf2JetXl9yHjHDHS
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Add a compatible string for the mt6572 AUXADC, that is compatible with
mt8173 IP.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
index d9e825e5054f..750e1e837fb8 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml
@@ -38,6 +38,7 @@ properties:
           - const: mediatek,mt7986-auxadc
       - items:
           - enum:
+              - mediatek,mt6572-auxadc
               - mediatek,mt6893-auxadc
               - mediatek,mt8183-auxadc
               - mediatek,mt8186-auxadc

---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260814-6572-dt-auxadc-e6df20ab3248

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


