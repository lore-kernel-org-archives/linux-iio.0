Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310D381AF1;
	Sun, 10 May 2026 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778418147; cv=none; b=hh9bQ1AsCi8cZ1Pj65y7rdbEZdGvpm2t0sypD0fJy0BJLHqvQSG9DZPX8QMh1r5yDfFwvd9r/4m85LOi8VZ69BeGFtqXVs5tLtbSp3wyn4NNt5VSDbT9/0Uy31oU4MYuLSGdUISfb+1Z+alNYDaG+VJWHGjQsc3z4DsiMFWzuOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778418147; c=relaxed/simple;
	bh=kk/Kv+yUGHkaembPD17CeakLfOFr5UBGS4OjitWw2zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TUnhDQzhR5GEMPXIRwquLlg7DiM6D9chC9FhcKrdEfTdEaQglFSRJhYuApOeUXOS/dQBuh4+VWoEX0EN0RTkP3PKUtcorTbgsuIEVwtPWFIoYCHF53gF4tNsSmZZwqYqXXpeUnR/aVytprvbwsv9PIzodrTkqPIyZAbRrNmhPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=C9XIALUv; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="C9XIALUv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bk1+usnQxKo9zlT0kt7v9vUgUzuHKBDGBd6rmMGP6MA=; b=C9XIALUvlilj4W7U65/tlvytPj
	zD2Yj7KDYFTN3QY1f1qts7DY5Bvivl6ysQqe/Yw+oI+KpeRm+6TLpmpTz1N//sVxHfNxU5UessXvl
	1yr+ADzMVFh7HocxHBvoFNa2ill9uBV3S/hRNMyL2LSbd6XADhZETYa3/2AcKXLxrKVMadLOjSnQt
	5NuVRqTj0OwPkRJ4NN+Cw/S7t5TJvj8ykAVXWiwxZEG0VLOLk+V5acshabLwYsxjtrK3rhE0TCjLh
	9FBd9mvPo8QoqduVctVT6qkMvcwJ+jNXq3/5MWFYd7+Yuu1mC213jqrg6hMOPLW1gSxjMz30wa4mb
	xWtzGneA==;
Received: from user-188-33-36-99.play-internet.pl ([188.33.36.99] helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1wM3nU-0000000DUlu-2xGf;
	Sun, 10 May 2026 15:02:16 +0200
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Date: Sun, 10 May 2026 14:57:24 +0200
Subject: [PATCH 3/3] arm64: dts: allwinner: a523: add gpadc node
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-sunxi-a523-gpadc-v1-3-4f6b0f4000fb@mmpsystems.pl>
References: <20260510-sunxi-a523-gpadc-v1-0-4f6b0f4000fb@mmpsystems.pl>
In-Reply-To: <20260510-sunxi-a523-gpadc-v1-0-4f6b0f4000fb@mmpsystems.pl>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778417853; l=1354;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=kk/Kv+yUGHkaembPD17CeakLfOFr5UBGS4OjitWw2zk=;
 b=MT0kpsD0qYGYaYgOEk7LMsEy7riZZdlLe4+LkTYoTeE3QvDJN9auhYeeOBDMOtmQvSkAKixrm
 AaySUpkb7Z6CE3Xr+rV/vThta038nbZ52KINeycdrHkVBQ6EioNYmDW
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl

Describe high speed timer block on Allwinner D1S-T113.

Tested on Radxa Cubie A5E:
- 2 connected channels are showing voltages in agreement with
  schematics.
        BOOT-SEL-ADC ~500mV
        BOM-ADC ~1800mV
- 3rd channel exposed on 40pin header is showing correct voltages when
  connected to known voltage source.

Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 5afa8d92acbf..f6c5cae5b23a 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -340,6 +340,18 @@ ledc: led-controller@2008000 {
 			status = "disabled";
 		};
 
+		gpadc: adc@2009000 {
+			compatible = "allwinner,sun55i-a523-gpadc",
+				     "allwinner,sun20i-d1-gpadc";
+			reg = <0x2009000 0x400>;
+			clocks = <&ccu CLK_BUS_GPADC0>, <&ccu CLK_GPADC0>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_GPADC0>;
+			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#io-channel-cells = <1>;
+		};
+
 		wdt: watchdog@2050000 {
 			compatible = "allwinner,sun55i-a523-wdt";
 			reg = <0x2050000 0x20>;

-- 
2.43.0

