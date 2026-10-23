Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778368;
	b=kfbiLKSUVXUycW3FvwhzsQxekeKAo2mcP60jGBrtOos6hts2sTh5qLbg2CQmDPgN+rzu
	 iAGSMxNgvrcfAMKyKgHlZtkKd+gR4qtPnMHO7zy5vUzgGAVM3rArb6BaG1DdcQtxYk/9D
	 v8DMWa/xR4ueIF1ZorW44FwR0ND365+vf1eK8PuC2F01fVTTeNTcAawN+KgBQb+uPuR88
	 cTn0OOtRzY4O5LfwfXlGWHPFBZjqLE+wLRWeS+lhm0riOFtPnRhGN9zf57uztVkGD59OE
	 pZ/F1/CUxdAdNQgax+FhcNEaZYSH1dga31ZEoSHKlPNiAAwM/c4AAru9RRRJTkdR6LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RC9B4AsYtSl9NgZ1G5jNJR/NzNwSkJidFyB5V6bR/5o=;
	b=hMXowy2U6zspkUiewKOXI1uxFg50M1ToICbGgmv7VHFL3ZYDkmMaRIb+tGVipacXky2D
	 zB5tAzJZXHs9M2NmwatIfQo+RjNdBa/oUsXL3Zb94lgBO5dR1uASiZjdgkLFCIIHozJ+p
	 9hU2g0kmmY4mBS17+iedJHcTr5ZGz8zkc/byD193EtUE73/tF0Ueg9Wx8gx78Q0XAw+4q
	 hC5r0WAfFZEQaobSBClf4131vekmYRXXVPBb+GRaMwCwyOCf6TFmJ5Pbc7W1AUCRelkCX
	 dZ2kg8FntMErsfXNCZUdOZAPvLm1oHS2X2C4f0SO33xpgvcg/7isWITabb+3HXAK6Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UW1CsQmW;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908E606A31B
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 17:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5908E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UW1CsQmW
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso8819485e9.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778367; x=1793383167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RC9B4AsYtSl9NgZ1G5jNJR/NzNwSkJidFyB5V6bR/5o=;
        b=UW1CsQmWp71H8y3Ya8dgqs5sxJZmBbYOORQQ+AMwjIQDQVb76BLAGEYcIl17q9xPIZ
         uvXybPge4G98nc2n4WLPIgSppaD5S+7FH/X6dK19ZdDJpl+zWQ9S6Whyg8dzczUbgzQT
         4gg+GQVFGZyv40vw2UQibUrse/b6E0gBoCxrdFt2YRhZ52MZQJTzTvoraZiOE80wRlW9
         hl703X4LUXodi+Q+1wiQIuiIIZBXLbi2nvoYuZHoz70a4dlqQz8GTdf9yGYMeTEWmdcz
         EaSYOIfG8JRL5OwUbajKVaCsrFJcfj1WrGAHLxouW0MbyWlbHDMMc6ckTIBVUeKjs+1W
         Q8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778367; x=1793383167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RC9B4AsYtSl9NgZ1G5jNJR/NzNwSkJidFyB5V6bR/5o=;
        b=CXZVHI/2hetZivJA2bafsIkLaFRKLjD/pTDEbyK8YGJWhs5BA6QN4JFiOdFmFLkw9o
         RJ8ag1z9eGcoCJuC+zUXT/XJ/+DgR/N6wmb3NxnrU8DCNagnRoDY0rRxx5iOh2oWaaqn
         TOiuN6IX+T9x/t7lrKxfgyLWYTnhREQ52dBCsIN+9U8Qg0Ieah8giaNhsJyWot6YIHXB
         LeGmKbdQVrrRBx3znqT4jXn9ktymUevMMWg6GsLxItv1ebrLTX5UiPrZUn57IKq2YXH1
         bTJ5CLwh+3wkBvPhfBRhi22T1fKKVnQJLepCQiuiONGC/BjynUdbomY/kgfGwZgFWlJV
         7I9Q==
X-Gm-Message-State: AFq9FYI0BcTpuufofJaYwCGirlqKRjIOyZW0KHU/xuQx/UT4R3bc3Qah
	0vYvR/dvbdeiSwqJC3nSvsMLJA8nAVuS+eFhwlLfUL5S4LKKoONsISch
X-Gm-Gg: AYBFou2FSG/NUdzpZOQBKuDRwcLLKFqvaI+wbXbF3smprVelbfMXCt0ATS7svLYxqSo
	dvJG9Fdd/OjIjD0+avozPJvu0sWHkS0NEGbLU7ajSxEdaElr7i1uMc5G33X0j79XaTNX9NeNYmc
	rRRa42CiYVdPKLQ7oaInut8oY1t/2hgVhXqejVkPOWVDAGAqxG+21MpRc2JldFA29rMKqkorcGj
	MV7ZSTv+tz2sCpYhCsy1ldDLYSL9DAUwGGuBV0Gg8aVWfZNdb1SeCWdZmntMArNjNz6h5lGOKqz
	fDoqiejjIeZ5uqhLwlKfjzpxb2o/lXo/KXmLCJSZBlThRf+hDF6HGX/oSYX9Pk2pmnty/1/to6T
	x9hty8O33YX+CV+y+kwvUVbgcBESVz0TdhqOvDYqB+i6tFvFffI9cegkZNirsHKn/30f4vYrztv
	ee73QFKAo5oh/NnoXkz0mg5/w+8VHSuWbuuUIus16OAy+MwGJ++9/Fut14WcwauexwZyG45M5hm
	/80AcFZLBPhoPvq7PCkI6e4NSwIz0Qg/NpPuMg5JWlp9c0tpSWhU8H4sPwyda5vJv6xDH+zBMMp
	e8FuO/Gq1RN3ugYhyDGIjBOUUdHBzGbZV+q4gg1BtvkRtTr6IIqDoLYBJvk/3pbByjyDMXk8l73
	27AcEDSASJeY+qyd9EV1ndsOpH1z5aiZKeLUdXHsUiDoEEQ57E7zuJErcmNrDaBv4zeU=
X-Received: by 2002:a05:600c:2196:b0:4a0:2391:6540 with SMTP id 5b1f17b1804b1-4a211ee51famr34379215e9.25.1792778366577;
        Fri, 23 Oct 2026 10:59:26 -0700 (PDT)
Received: from iku.example.org (host86-133-9-17.range86-133.btcentralplus.com. [86.133.9.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d37ca2asm1342800f8f.8.2026.10.23.10.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:59:26 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/8] dt-bindings: iio: adc: renesas,r9a09g077-adc: Add RZ/V2H(P) and RZ/V2N support
Date: Fri, 23 Oct 2026 18:59:12 +0100
Message-ID: <20261023175919.160103-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Extend the ADC binding for the RZ/V2H(P) and RZ/V2N SoCs to describe the
ADC variant used by these SoCs and its differences from RZ/T2H.

The RZ/V2H(P) ADC provides 8 channels, has a fixed conversion time of
20 ADCLK cycles, does not support calibration, and supports selectable
12-bit and 8-bit conversion resolution.

Add RZ/V2N with RZ/V2H(P) as its fallback compatible, as the ADC IP is
identical between the two SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v2->v3:
- Added Ack from Conor

v1->v2:
- No change
---
 .../iio/adc/renesas,r9a09g077-adc.yaml        | 38 +++++++++++++++++--
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
index 5b496729022e..a0fed2f31370 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
@@ -18,11 +18,15 @@ description: |
 properties:
   compatible:
     oneOf:
+      - enum:
+          - renesas,r9a09g057-adc # RZ/V2H(P)
+          - renesas,r9a09g077-adc # RZ/T2H
+      - items:
+          - const: renesas,r9a09g056-adc # RZ/V2N
+          - const: renesas,r9a09g057-adc # RZ/V2H(P)
       - items:
           - const: renesas,r9a09g087-adc # RZ/N2H
           - const: renesas,r9a09g077-adc # RZ/T2H
-      - items:
-          - const: renesas,r9a09g077-adc # RZ/T2H
 
   reg:
     maxItems: 1
@@ -55,19 +59,22 @@ properties:
 
   dmas:
     minItems: 1
-    maxItems: 3
+    maxItems: 5
     description:
       Must contain a list of references to DMA RX specifiers.
 
   dma-names:
     minItems: 1
-    maxItems: 3
+    maxItems: 5
     items:
       const: rx
 
   power-domains:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
   '#address-cells':
     const: 1
 
@@ -101,6 +108,29 @@ required:
   - clock-names
   - power-domains
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-adc
+    then:
+      required:
+        - resets
+      patternProperties:
+        "^channel@[8-f]$": false
+        "^channel@[0-7]$":
+          properties:
+            reg:
+              maximum: 7
+    else:
+      properties:
+        dmas:
+          maxItems: 3
+        dma-names:
+          maxItems: 3
+        resets: false
+
 additionalProperties: false
 
 examples:
-- 
2.55.0

