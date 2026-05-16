Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC7280CF6;
	Sat, 16 May 2026 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778909714; cv=none; b=u//yyGRL6iF+fS/vmDYDl6r4AUKMreAKTpN5RpT8UzMdAtNEFjZPb8JIezb1l8PIO5E7YdksMgewc4QFrr0HxbFEA2MnHXYm35y/g0Q4rshfsMkVsu+yItqwZ3t0w8XvlTc5JejncUgMPyINMv4jwLzGim0vg0/Qcpw56XrUAkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778909714; c=relaxed/simple;
	bh=xWAvvoMq5LCEzQv/vm2HNnTrN5pD+nZbb55gDWJixMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGKue4FoTRbAgu37TTQPxeV0mnOFzVOTGxtpWVvWZR3oErwYSppgo+bM9G1j4oL4ywnC9YZjD2kaeudryn8doLI23pnRiTFI3GC4YGOmNelOVc6x+AzuXa+AHYl9p2gq6g6nkrE4t8qDIzJwa5Yw5NXggipVxTg4TNRjUGtvTm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=jZ0mSXQG; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="jZ0mSXQG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y9IFjwpBXb5Eq6QrzwBTcKT5UjHu61JRQwaFlcKHFVs=; b=jZ0mSXQGpFt1zrFaY1HHHh/pwZ
	w2NB6Wgf7Iqtcr4TMI+qLqsBnQ9srT/atrhUJH8frm4N+8xl0sxfamJ686tUuTOuhQLDXeINbazVT
	LM2TjC8523SMmebjgQ8Q+rqrjUnWwXoWUYXdZusaDat+QfACfE22Q53WW470FbcAqigkg/rerYnQI
	MD6vE5vBDVkROSW8RLmHXYCpvh6xNpb1NckSVFuMH+y1owsWUhgeAHEFe229xIF31ewausY9Rq+Wv
	oEqmQQg4xdFPkJEzj3yDIsgAoncx4SOY3mvJcDaD2yX4f0LzxKTXWmS/uQK1xiaUN1uOK+25JxxbI
	VmaWaJ3w==;
Received: from [91.102.182.218] (helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.3)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1wO7g6-0000000GeOG-2UNT;
	Sat, 16 May 2026 07:35:10 +0200
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Date: Sat, 16 May 2026 07:34:16 +0200
Subject: [PATCH v3 3/3] arm64: dts: allwinner: a523: add gpadc node
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-sunxi-a523-gpadc-v3-3-a3a04cff2620@mmpsystems.pl>
References: <20260516-sunxi-a523-gpadc-v3-0-a3a04cff2620@mmpsystems.pl>
In-Reply-To: <20260516-sunxi-a523-gpadc-v3-0-a3a04cff2620@mmpsystems.pl>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maksim Kiselev <bigunclemax@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Michal Piekos <michal.piekos@mmpsystems.pl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778909655; l=1351;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=xWAvvoMq5LCEzQv/vm2HNnTrN5pD+nZbb55gDWJixMI=;
 b=2qjIp0RnVxwHNmNSMtJtEiN2QANkFEmCQkeYhsi7Mz70uOvrLUZAydlbFraE3WD6vXjLt2R+z
 adkBULC9lWWCOjNv5jvr8IoAPytXTlgPLQelQQmd1Kuf31FX2PIurvV
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl

Describe GPADC block on Allwinner A523.

Tested on Radxa Cubie A5E:
- 2 connected channels are showing voltages in agreement with
  schematics.
        BOOT-SEL-ADC ~500mV
        BOM-ADC ~1800mV
- 3rd channel exposed on 40pin header is showing correct voltages when
  connected to known voltage source.

Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 5afa8d92acbf..fdb60539aa6a 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -340,6 +340,19 @@ ledc: led-controller@2008000 {
 			status = "disabled";
 		};
 
+		gpadc: adc@2009000 {
+			compatible = "allwinner,sun55i-a523-gpadc";
+			reg = <0x2009000 0x400>;
+			clocks = <&ccu CLK_BUS_GPADC0>, <&ccu CLK_GPADC0>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_GPADC0>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			#io-channel-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		wdt: watchdog@2050000 {
 			compatible = "allwinner,sun55i-a523-wdt";
 			reg = <0x2050000 0x20>;

-- 
2.43.0

