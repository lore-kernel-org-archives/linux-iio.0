Received: from s106b.cyber-folks.pl (s106b.cyber-folks.pl [195.78.66.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83687DDCD;
	Sun, 10 May 2026 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.78.66.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778418171; cv=none; b=p9XnIB+lj27gcbw027ZHJQHWg4FztVnKFy1G3QMAEjgE1ESpzwyeH2cEbwXftjHGqD05i1BtI+NjXJGDn7LaTitYNBTPJgu9G300UGxh1J7AiW4ttHaN10y5nrOLV0ayuAxTl0WGQrRJUvxIYKYlCS2f8ERwV1uPaT7MKz+ZRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778418171; c=relaxed/simple;
	bh=xdbmT5ZW7GBoQzuCduM7GoLy1ivg6Gv7iVshcr4SKOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqxqDkpThDW/EaIUyrRtGD0ug1Q5ylI2h3l+a0QckhPzuKC8X9gf8a8G5nPaSdFFTb1LrDTAQQ7Ywj/8I+koJojc65dnBS0OkGIuUIHqM7IB30oCiYiN0UBalBd2xfi0WP7SYjXHkO8LqbfJKeSYdx5k/REIPQFrPKZDGgiWhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl; spf=pass smtp.mailfrom=mmpsystems.pl; dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b=JXtnoFOT; arc=none smtp.client-ip=195.78.66.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mmpsystems.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mmpsystems.pl header.i=@mmpsystems.pl header.b="JXtnoFOT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mmpsystems.pl; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sQf9HV1kJe9QuSV63atEChSm9EINfgHOzkniR1z+XIk=; b=JXtnoFOTyvcCFbcT5mx3MDXD1j
	fi/m5EU3GBPzTFUFimzzNUeohg8xvNmoXOASWvb2MKR7KHo1XdiuEwYrnY+enjjKKX/juVRBxQMTh
	8Mnf86+/og/CSuMp/8vKqCee39VBfK6BHuyeEyoG5b2qfHGlG0qyUffRWmlq6qinguG0Qusdcdywv
	DrDaPp1W1p3j+0iMFUfn1V+wp/Ni8+BH5MuIAdrJHUP2OJT5skvMS2stgJ8pyaXyV8SYsPfEAwiLN
	5R9gR2+waAyuvpjfNgh20AyYZQbR6mD3l2KasZTt1Kgx2YaH5hfKPqOLxTl97cabM4A0ujsQZncMp
	Dw8nZCAA==;
Received: from user-188-33-36-99.play-internet.pl ([188.33.36.99] helo=localhost)
	by s106.cyber-folks.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <michal.piekos@mmpsystems.pl>)
	id 1wM3nS-0000000DQb8-2khN;
	Sun, 10 May 2026 15:02:14 +0200
From: Michal Piekos <michal.piekos@mmpsystems.pl>
Date: Sun, 10 May 2026 14:57:22 +0200
Subject: [PATCH 1/3] dt-bindings: iio: adc: Add GPADC for Allwinner A523
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-sunxi-a523-gpadc-v1-1-4f6b0f4000fb@mmpsystems.pl>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778417853; l=1939;
 i=michal.piekos@mmpsystems.pl; s=20260301; h=from:subject:message-id;
 bh=xdbmT5ZW7GBoQzuCduM7GoLy1ivg6Gv7iVshcr4SKOE=;
 b=+fLEdNfcGSL6q7kzk+Ig5Sr2kuXJVWe3+SHYOmbUDS87rrnQ6fhMO9DC/AKCCxgCFF3Q10qPu
 X+6KaQkpiD+AIwZYYzl51hk38WXOrIVbGw13bG+w05h71LjATWN5uwv
X-Developer-Key: i=michal.piekos@mmpsystems.pl; a=ed25519;
 pk=Aixyx03If7ZDamiKKN0lsa+0mtA+WjIuIf2ZQVYNBqg=
X-Authenticated-Id: michal.piekos@mmpsystems.pl

Add support for the GPADC for the Allwinner A523. It differs from the
D1/T113s/R329/T507 by having two clocks.

Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
---
 .../iio/adc/allwinner,sun20i-d1-gpadc.yaml         | 37 +++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
index da605a051b94..89da96cd705f 100644
--- a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
@@ -17,6 +17,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun50i-h616-gpadc
+              - allwinner,sun55i-a523-gpadc
           - const: allwinner,sun20i-d1-gpadc
 
   "#io-channel-cells":
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
@@ -40,6 +46,35 @@ properties:
   resets:
     maxItems: 1
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          items:
+            - const: allwinner,sun55i-a523-gpadc
+            - const: allwinner,sun20i-d1-gpadc
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+          items:
+            - description: Bus clock
+            - description: Module clock
+        clock-names:
+          minItems: 2
+          maxItems: 2
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

