Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF5248F57;
	Sat, 16 May 2026 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778909713; cv=none; b=G6N3UwSCUtGsrON6aypYqwXSAKNHTDPguu/RM9t9E6lpLpjmoyP2n0dDSU8bGLMsDJlfIWxiAy26kbWmgJrJMvYL1D0PG85SDk917T/l5FkXZhMZ5AT62/CsFOEQK/8eqdBWGLI5Uw6ncuPW9BXYyCFGCMC32uixeQ2fnEyJXyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778909713; c=relaxed/simple;
	bh=iVKolaSgIipYjQbKkBTYus5BLxNsCP7aniEDBmtsS58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ptiHHMgIknHxl/3r7oSFERf3snxJfaAzq8Nqd7+yr/4NcqNwHbZUp6gOW6gsadRhUS1VXYST6V0UVfKfIE0FH/IZeLcva758EjxKJ82mfRUcS1XReD1RVqdpmNP1rO+hWfn6UCUXJa0WdyJwCpPLdHMaspzWkmzhSNQfL3Wkcak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=b6bn1rz3; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="b6bn1rz3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+93HxxN7yIZfnUG0TZsyW59HsKIWE1ABkVgFQlDrzjw=; b=b6bn1rz3awLLRdlWMDVCgd4ubq
	0Fhy2oT6Ng/PS8MtrWkt2ewNCbSlFU81lWAz4d/gupJFIOIddjczsTUbccqG/7WoM7PeGqsx01M6e
	SEbkWA+wV90mlWWjUweyBt6wEJy+2hT1N84pd5JHsuRg+UQA+40gNKyQliEOzERLAAzJLKkoPb72l
	RFAvpx/ZkJlr/eyY/McD0mWdaKtRWEShZhhGXcqqjYcDZjCwARtP5FCJ0GiI5t9Rmq416fktTUeaw
	cD4ShUFlVB7VMwtywHoYOdLK4IunbS4URfk+DZwjfn0KYQoaFdElL1QRyVvY53vDdxoSEj9ut7/s8
	gHubnyxw==;
Received: from [91.102.182.218] (helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.3)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1wO7g4-0000000GeDC-10wA;
	Sat, 16 May 2026 07:35:08 +0200
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Date: Sat, 16 May 2026 07:34:14 +0200
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: Add GPADC for Allwinner A523
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-sunxi-a523-gpadc-v3-1-a3a04cff2620@mmpsystems.pl>
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
 linux-kernel@vger.kernel.org, Michal Piekos <michal.piekos@mmpsystems.pl>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778909655; l=1829;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=iVKolaSgIipYjQbKkBTYus5BLxNsCP7aniEDBmtsS58=;
 b=dNa6nvUg/GEDjIL6hyUiuVL4nymIy38aSx4UJanAcfJXiJiRgIj9YzMM5w1YTWqpw+EonPSdz
 XBCZ7pufOLtDNkWNP6ubVt2aBmr4n5gzqbCDD5Nm/H+GNVvodpaj+Vj
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl

Add support for the GPADC for the Allwinner A523. It differs from the
D1/T113s/R329/T507 by having two clocks.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml         | 32 +++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
index da605a051b94..6467800d30e2 100644
--- a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - allwinner,sun20i-d1-gpadc
+          - allwinner,sun55i-a523-gpadc
       - items:
           - enum:
               - allwinner,sun50i-h616-gpadc
@@ -29,7 +30,12 @@ properties:
     const: 0
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
@@ -40,6 +46,30 @@ properties:
   resets:
     maxItems: 1
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - allwinner,sun55i-a523-gpadc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Bus clock
+            - description: Module clock
+        clock-names:
+          items:
+            - const: bus
+            - const: mod
+      required:
+        - clock-names
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names: false
+
 patternProperties:
   "^channel@[0-9a-f]+$":
     $ref: adc.yaml

-- 
2.43.0

