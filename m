Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174246;
	b=Ugg74UIXtpDBMCUPoS2YWzYk3QZ6j07pPzRMKALWcs5TTIHvW6BsEDPHaF1sUghKpnHz
	 Nc1fRquLQOkk15ahS2I7HyZ0E1IR7MR/Q0KpkGt5LzmJ38HV7PN2P6x/XQD6RSklqVzd+
	 +kdR9ExvTGiAKG141S2dFrjRIlKErNbA2gdRIg55iKbnKaVLEuz2+WEHAphhqMoE+7l23
	 LKXhhSIpByKlZ/y8ug6Xj8RefLRdRKF+Xsi+YXJbI5HC7ZEXn0NXws+GjQblZkbOcjNBj
	 CoGBFOE4t2P+eO08o29ExZUdwItSr8VSrZCcOEte10pqL8BqM2LSEwuM+IqNSKSd27Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174246;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=+047z846aobeT6SlqVSXPjajZwL65DqY7vA1g9DNMvM=;
	b=ZBPBUQcxWNWCD6mfX10GbbRGQQ3JcLh3fLhBqyhzftAYecnMy01Gf+T5PLrNkTUB6d/I
	 QhWpY7xRT5r4e8Cw9QlEZpS66QtbyN4UCBllP/B12xSlbLj1wquA3QjEq6ir9AIyBTJNb
	 3y8lNE2mRPQ2AgWjKnj+q+W9vivwleVZiP6apPbUrrHwG8Pd2fLrV9dsevuI6KvDoL9uI
	 eF2pA6n7Bf4Vyzep8R644v8XdY4+btnx7ssPofgJAIDYx3rkZdTTUn7AV5CQLh+dwuBe9
	 XlpbFfgOI/wZ99ZjKnvLOqfjTNaWztmL2wumivCInG0LwxjlX1siP8773Lv4ZH1rtVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fmfovakw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F103606A320;
	Sun,  8 Nov 2026 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fmfovakw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123871F008AB;
	Sun,  8 Nov 2026 21:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794174246;
	bh=+047z846aobeT6SlqVSXPjajZwL65DqY7vA1g9DNMvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Fmfovakw2tTBB1DSjDBcuLa/R9lBo+js7BUA+0M8uqmd9dBUH9fkDW5nR9X8j4ELY
	 fmhYBq5SdO8xMon6td+FOKBS+CnZH/245Nwi+mXQkRoetqkEn8z3DcN3daNMjIrKZB
	 /Xk1OBYNAEtT+gSdzgSpyOdHM3VQSOjD00tEFxD1Z3soCH/OqF7WVIjCW6EjO7jgj/
	 QFKKFL3T/mnzx4u9/rVVEm4p2qPLgw1m9+HUNk13rFe81Mg5Y7fxLpVrfHKt3RS+UK
	 mkpmV524uU06h8da7gHjGwcr2L+xoXXStif4XmepW9o4l8FZ2Uu1LpcShaZSWH2HZy
	 9busFOu2xBLkA==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 08 Nov 2026 22:43:59 +0100
Subject: [PATCH v2 1/5] dt-bindings: iio: light: sharp,gp2ap020a00f: Add
 VCC supply
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-gp2ap030-v2-1-24eaa1b9fe59@kernel.org>
References: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
In-Reply-To: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Describe the sensor core supply as vcc-supply, following the VCC pin
name in the GP2AP030A00F datasheet. VI2C denotes the I2C and interrupt
pull-up voltage, not a separate sensor supply pin.

Keep the property optional to preserve compatibility with existing
device trees that only describe vled-supply.

Document the existing LED supply as the infrared LED anode supply
(LEDA).

Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2ap030a00f_e.pdf
Link: https://global.sharp/corporate/news/110721.html
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
index 3fabf1f576cf..afba0b005b34 100644
--- a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
+++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
@@ -22,7 +22,11 @@ properties:
   interrupts:
     maxItems: 1
 
-  vled-supply: true
+  vcc-supply:
+    description: Sensor core power supply (VCC).
+
+  vled-supply:
+    description: Infrared LED anode power supply (LEDA).
 
 additionalProperties: false
 

-- 
2.56.0

