Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3BD3D9DBC;
	Tue,  2 Jun 2026 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404416; cv=none; b=eGfZRcS74VL1wFMgQOKHXPehOkzQihGV+2ogA/8MO5wgpBcpYILPpzgUW2mK598S9W/sqMtIXeianV0siBFov42U5BOa4Z0sVBecRcGeqFUvXjug8AWXSuGpX8Ga+G4AvKCWo+wbllLvsVRBAqbDkUO5gwTG7lTMNafOruWXd0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404416; c=relaxed/simple;
	bh=6Uru3oiN+KUnWcz/gv4yCW62HmXWPmwm2tqYSe5EbcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhs6ymCDUvcMuFMLXRTZcfn8tem2s/N8G3SBbNEh88TFxlNts7pkNhfeD4fmQ8XTLkfJ2WseoYa+Ia8wYOdODI8AswBs0HEkkUUpQcee9OdsjPZHxBU5/iuh10nklRb5QN2KDOiJgkQUEDRdrUb7VK6UO7QHt0QwyFXfB6zMhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeaFb349; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeaFb349"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CABDC2BD01;
	Tue,  2 Jun 2026 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780404416;
	bh=6Uru3oiN+KUnWcz/gv4yCW62HmXWPmwm2tqYSe5EbcY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IeaFb349Q+HRYXRQlupaSln8P+/YmYDtWARL5hQtpDhS6+qZj4GqkJIQxw0auVClp
	 U9rjEw7ufl+JdnoWeeLBng63EzFdu7oH/Sh7dEX46Xrl0f2e8//6a5sKTZ3De1pg8o
	 xtfA56FyOa/hjwnauGWzREwA5K3AxExzVf+rL1YTLydvgZBGslImwpFJJ+sqblixWn
	 3W16917Th+gNpr3WyFkMcsf+QtKCoa+nmJNPwWVxWLUZ7nbRWw8+NBUH0OpDG2iEZQ
	 YOVHFM/8HhufELzA+goCgi6frXpFCnZFd6W637cTPBagZylhdQWgWXz9Dt09Iu4wZD
	 zIughF6fl+T9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E64DCD6E64;
	Tue,  2 Jun 2026 12:46:56 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 02 Jun 2026 15:46:57 +0300
Subject: [PATCH 4/4] ARM: dts: mediatek: mt6323: add AUXADC support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-mt6323-adc-v1-4-68ec737508ee@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780404414; l=814;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=WC9jUSlABoGBdBqPU8PZ4ZIU5LJl1TAO11/EPH3tS8U=;
 b=p6K4bcmO7oG7L8/cv4DP5Dy2KGtC5QitgkODob+PUEPUi2NsUMycmvhmjhl7+oEORuDECXnQb
 8wpeVkby3ogCqga99duGgN2KLBpDFhGoKg+mv/CV+vo4Uu2lvvRjKli
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


