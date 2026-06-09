Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCFD4183C0;
	Tue,  9 Jun 2026 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011941; cv=none; b=W9lR0oAeCZwp7+AT/JO3O1QIyLbtShVId+75j2xIhBK5cM/RnC6iysQ08ndR7npJe0yPdmvMRvz3pIksofP9kd3C3xur5ZK+2odQlbQXQfgbzxJPegBq5BP9d+UYAzQE00z+e18f74ai8P8ZKarz5BlOJcje5uOHRneR+HEnKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011941; c=relaxed/simple;
	bh=6Uru3oiN+KUnWcz/gv4yCW62HmXWPmwm2tqYSe5EbcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HD9axx/1gLFWhL0jyqWd4pmsO+cOqnoD3bOq5M0G+zJfK84hVR5c6oqVvEpEfC94syMm16Ikf6mwkwgs6816ytUpg1p93LpIFmerCfeujP7CjincGXOmIH0nazD1UCSOxgrrbFHQ6rvgsLDZSnIPsZWOpF73UVjliZLHTDXiOag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdEsk3I7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdEsk3I7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C79FC2BCB9;
	Tue,  9 Jun 2026 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781011941;
	bh=6Uru3oiN+KUnWcz/gv4yCW62HmXWPmwm2tqYSe5EbcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VdEsk3I7snaayRqhsC5jOW8A5WUJ429olZtIDdhI7TQBazVj64yBaUaUryruwXkZK
	 HECknAIbhbLBUgTokqhF4KFXqAdEHmEw6/eFB6ODMHr6lhGMqGX9m1QpUysIaa8Tnv
	 bS6OFyPwIpsuP4dU5psba5+ZqEyGddnr4YZcPBr6sgtaEuKn9GqTNxLoK4lwyhKBZK
	 s6ZUYZ/puxUOoEXkk6sIaR09oSmQd/BeY3WUCKvUel93yIkYZnXYfadL+oHDQqUbw7
	 SPhnzNT2sov3qMdXGe84AlAJmOyaTJsjpAItrU2pzWaSOHngd02zSFtV/g/1JHAVnU
	 gcdqmNWWUyNlw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2049CCD8CA4;
	Tue,  9 Jun 2026 13:32:21 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 09 Jun 2026 16:32:01 +0300
Subject: [PATCH v2 4/4] ARM: dts: mediatek: mt6323: add AUXADC support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-mt6323-adc-v2-4-aa93a22309f9@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781011938; l=814;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=WC9jUSlABoGBdBqPU8PZ4ZIU5LJl1TAO11/EPH3tS8U=;
 b=HFUzT56ILN51Q0406hTTlmGMy18dIgDy0Qp5Xo0PO99fY1Fg8K9SZT8TkVk7RWS+3O4hoHTqv
 BDOlKuXR4WuCYEUHVR45DELvdSpOPavOAN1RW2VEKupUhbdumuX5xM+
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


