Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122ED40D58A;
	Thu,  9 Jul 2026 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594373; cv=none; b=PGrYcbMPgntuTmzUoUwVkNHyucCRxLKOs9zpm2tZgB8aZG2RrT/JMj0Sol3OnDEpcT+hOhtJEhwKqno6xFXG0t3fIwki7qhtMR3k+FZIPzUE/3yMqT61WR5qtdtwQn0KH+jLnHn0J9gpa3FeJwRa19ORxdxUoIlkDzBeYRz+FPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594373; c=relaxed/simple;
	bh=AL+6cjS+Aq23xV5C0GZ6jVglJtlvdb3jharPXO6eVtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/XV67WOrEeA0cP5wBaEHPfqSsTNDljRruscTmhvY6y7RABSUuZb6lL4BhhYbiU9+hev86RpFrAzRiUHxd5Fxj7a0H7YXpGqgKN0cpWyEjSOStwp8QTACeSTqZvSiDX5yiFbAZwVgq1YgZ+n+tTptZzk8sib9uCo+LuZH9egWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRwE7eBu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRwE7eBu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38C15C2BCFC;
	Thu,  9 Jul 2026 10:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783594372;
	bh=AL+6cjS+Aq23xV5C0GZ6jVglJtlvdb3jharPXO6eVtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gRwE7eBu11JWC35IbYbkGu2puijlISPepAScWBPDPHrPAKnweJ3kP1ILYgJlL5hMe
	 M0lqFUaB3JiYDX3DZJ2+o6Jo+eDlHt4mk8J778GzUIbcSxV3deW6blo0qAls4FgCok
	 69UslMX3GTGnx2c2ENfprjA7ySPUFl208n98vmNg/x+s65rAPYyYJOws0zMlQ2ayzg
	 r4/4k27OOK/PJlnmFf1MN9TucmKF0iwtHVQ/565At9cO3FqQ1BGOvsl947w3UpJyNS
	 MjGYTfmHgSjUY+jDmWXrs/cUDqIycE3CmkZT/jEOTUtcdQNaxzQU1bawEbKO8oHONE
	 T/+05oC7JDt9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282E1C43458;
	Thu,  9 Jul 2026 10:52:52 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Thu, 09 Jul 2026 13:52:50 +0300
Subject: [PATCH v5 4/4] ARM: dts: mediatek: mt6323: add AUXADC support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt6323-adc-v5-4-d11b8332a735@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783594368; l=866;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=Gm5yHjWd+okdy+GbK+XrT9mjlxYBCgUC9x8KovsgFk0=;
 b=/csjgwGmhCRCc7gN/lLpul7ac274/mSOrm/l/CZz82mruZpXO0y2ZKDJb684iwDJNKk1nOgwC
 RNTmO/XkKV5Bw5PngIKKXPvRC+zUHJYKWEboC3cBo3z8A9EPW1YO6p4
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Add the devicetree node for the mt6323 AUXADC.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Reviewed-by: David Lechner <dlechner@baylibre.com>
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


