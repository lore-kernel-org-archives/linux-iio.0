Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72073B47C9;
	Tue, 16 Jun 2026 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619342; cv=none; b=PTfaH0+UYxQMWzJn3UBCFfBkkcX0JzKyRL7/OizvS346HJ1LspY+cDoxlw0Spycr1UUrLvrgbmlgekqzdJjOA50mlxf0TquG6nTNY4rc/V4IEmhZ05GkFXiZk8LTriufKhrzFu5yQByCsZ4jhkZDX0y8S0RHYyb0ANVQdfC+tEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619342; c=relaxed/simple;
	bh=6Uru3oiN+KUnWcz/gv4yCW62HmXWPmwm2tqYSe5EbcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EhJjMcqAl+3F2TmXi7XZmZm2phdwTJnZUJLjhrlvvPBrhZFdiPE20YmzP1U5h1fpFY+w93On0CHYY1OkPZMZaBseU7SoEorjgvqBmF8FOfaDNaoTg7NdlNHqgeU4rtb/Y2qszs+iPzzA0JxrzHAE24/QSIg1Qf2IQXBPOdo6foM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qubnNbcv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qubnNbcv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C57A8C2BCB7;
	Tue, 16 Jun 2026 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781619341;
	bh=6Uru3oiN+KUnWcz/gv4yCW62HmXWPmwm2tqYSe5EbcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qubnNbcvKZjEhjV+mJnGorrsB0ORuYDBW+yWOFGPViFLW1gqvWb3QpBPXaJzndvAD
	 n/oGrPHvlpHe8+qlZH0KGUBfzXnqAtIV41gXSRv6kMw5mAjm3ixb1Odz4yONizatMt
	 fav5xVdPKpBdSqoM6uxjfumyDAHqrrLL9r9FzBYiQ42V+E30bEPrYWAr2ernaNnvVf
	 6mikH61I3SgFnvs9nL0PT+ZVqXZkJB9kgv6pkPekb5i8tyeTdh73094x6f7hIpHHZz
	 spuNzBXozQAFExc66irW9DMTfFmJETOOR2tjzEEjT+wj1Lg2/8VtV0ivA7LMcbQgQ6
	 26FMwMazrlA2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE47CD98E4;
	Tue, 16 Jun 2026 14:15:41 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 16 Jun 2026 17:15:42 +0300
Subject: [PATCH v3 4/4] ARM: dts: mediatek: mt6323: add AUXADC support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-mt6323-adc-v3-4-1c27c588185d@protonmail.com>
References: <20260616-mt6323-adc-v3-0-1c27c588185d@protonmail.com>
In-Reply-To: <20260616-mt6323-adc-v3-0-1c27c588185d@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781619339; l=814;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=WC9jUSlABoGBdBqPU8PZ4ZIU5LJl1TAO11/EPH3tS8U=;
 b=cx8MHpOPsgD79V+yFNyXEm9LaUrOOAUnb9gXrJA90ceOaAZQ0r+3WMmBIQXs1KOCSBl5ODVrl
 39S5IKQEj72D2dsBdQJqJsDcRFBxyg0gZFfXGYLN5bGpXuOeFBLjUMf
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Add the devicetree node for the mt6323 AUXADC.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 arch/arm/boot/dts/mediatek/mt6323.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/mediatek/mt6323.dtsi b/arch/arm/boot/dts/mediatek/mt6323.dtsi
index c230c865116d..c070f4b0936c 100644
--- a/arch/arm/boot/dts/mediatek/mt6323.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6323.dtsi
@@ -14,6 +14,11 @@ pmic: mt6323 {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
+		mt6323_adc: adc {
+			compatible = "mediatek,mt6323-auxadc";
+			#io-channel-cells = <1>;
+		};
+
 		mt6323_leds: leds {
 			compatible = "mediatek,mt6323-led";
 			#address-cells = <1>;

-- 
2.54.0


