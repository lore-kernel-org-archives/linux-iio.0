Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59D51AEFB
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571298; cv=none; b=HvXXWmTdO3yC/7L7ozRgRx35TkQeUCaO2G2LLM8dAxnzbAHnEFXD5oBw4FtTDLJXaRaCL2PNSOdq0agm7T9LvuqOepO6TZEzvDAXahu/K6cNwDRv8ZLydyB7mLS/3UiL+R6fRrplMlpckAdylrvUh5+AWrr0WMhmGKS7Eb33OMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571298; c=relaxed/simple;
	bh=j08aYASB6LS+WJ5kaNHUDCP1fFUqnKBgkh7i9u4e6zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9AEuyLYX3yvHjOGctuh7KwSsjxl6/GdVVBLJxLm+mcyR/fhpyDfunxRdASh9SlmUjQ8zPN0V8asuc5woxbfErE7dSz1SP9QRqBxF85sED5S24Q06kF5NWt/nEgwQ/RQBkocba6Xz63xAw/a64QR/PN3ZZWli+61Ef7mzJC7cHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJUUx5eC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJUUx5eC"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48af27fe287so107996f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 11:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791571291; x=1792176091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxKQIPxia4ixdYC4lHRZWf9Ikjne1BwduNCNHTIEt2E=;
        b=kJUUx5eC3u4jMydYpBcqIPPrW0DwuOO1uxql/Ci2jjdCBllEw5Xz39YmwBHYFZvCUV
         XM1VLg3RM+GJ/wSm58TrJACBwtBYu487NXaDpqJJUptdL8jJMD4y2/K7oo08nX/qrq0A
         TXCU46enxeVafaEKbyr5fPpq6rNseHpKvQXMcd1rnYTHGH+qZx4CNoHvmmgUwQnoF5jY
         CSeiUTWUY5fWt+jYnkq1LsWsoA83YpJHLxABYSkx335YV3NKsJw3c0eqBhDJi01HQ9FC
         8i2RqK643gDHtYZkQhDbqBP0oyUVV44DjN2LFX5EJ3JApkcGCd0nBO866D66jwxOJrF8
         WAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571291; x=1792176091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pxKQIPxia4ixdYC4lHRZWf9Ikjne1BwduNCNHTIEt2E=;
        b=twCQic2oyeuP8SlMXvt8UZTL/r+Ub9kAm/Qe23+tkGJvNdWcle945Pbvpt/03nbVop
         Ld35mdvYXbs4Rc8oliMnANfe4dKhntYtu1SZaj494zWa3wl+4BUpC1n7y51rbp9to7uZ
         M75jkn+pR8AE7tXCP02x4Wi99f9Rik2tLhZaDk6EDKKt8igmvEhnAsvKGRrpXvfPe0MY
         NRY9YIvTVvBnalWmgQiL5mocAj8C4/atBPFu3D+fleyR8eDxEnf4jmu3Na8Vi+1s1snh
         aYaWuYBUo9NidQ95sbHtowL9pliq4ulWoCiU8qQohwK2BiW4Wb9kxY6Kc51l7M0up4EK
         s/Mg==
X-Gm-Message-State: AFuF++niI1KAv7aWv5PqjCryRK1l4BCtH5a2KY0DNS0lZtT+qB8v5jSY
	So6SsEcf7apBT5EbZli3afT+6WjeNCjxNFLWztbokUyqXyoP8I6Nm619
X-Gm-Gg: AYBFou3TPdtBq8ccHFw6aimMYgjjsBtQDRj0TM0/VFVX8Gw+wjW09U7l5+JfHJYHV1w
	RRuRuZdT+5qQnpznYA/4EwjhKjbJDENGsqidQmBY369wpPGq+JJukNgrYtM4UZtpQESkPXzUr6L
	37YHphJ5LnXwSOK1PjOwgYYlkqinhe5ct6J5Mi7UR2L+4Qsptb30nxgeBJhSeo4Fbo8IVi3f4jb
	7NNLogK6SHq7XIa7anSbE2QSn/RTVIjahvTwxh/cuaXq9okSwqDNebtGoLhprVs66a8Emr0zYqp
	77YCtfEJWtFx+7fZvfQFhPjmTXY4htpnWVuD9Xtt/dUT0FAmQ4QJ5Ri5E51bdutPhBkj+QgoILx
	aFxgQeBpOEkb/JQhi3p3cOwCJc4Ng1aQmTmlUnmKmYdPSw7bLaENJa4un27vtnS0j/NZRpGIyWu
	p7jbfYvogRM+VtrvlwbUrmbPsj8WT+gBaYhldwxgRWWqWbhfckedgM44RE759ppU5/72chxdQ4S
	l+ShDjT1cQuhXf6wvvehe2Z4WA8vNr2Tgt7eJanvAmSD/4aJVmRr8Dz0KIrdfggZBHdP7SDL37z
	uD2Ui/BcdiplyShajV8=
X-Received: by 2002:a05:600c:4fcb:b0:4a1:811c:8083 with SMTP id 5b1f17b1804b1-4a18e4c3600mr53574345e9.33.1791571290395;
        Fri, 09 Oct 2026 11:41:30 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:e93d:161b:5ff8:cb57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4225f4sm91761705e9.0.2026.10.09.11.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:41:29 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/8] dt-bindings: iio: adc: renesas,r9a09g077-adc: Add RZ/V2H(P) and RZ/V2N support
Date: Fri,  9 Oct 2026 19:41:15 +0100
Message-ID: <20261009184122.1378797-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
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
---
v1->v2:
- No change
---
 .../iio/adc/renesas,r9a09g077-adc.yaml        | 38 +++++++++++++++++--
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
index 5b496729022e..a0fed2f31370 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
@@ -18,10 +18,14 @@ description: |
 properties:
   compatible:
     oneOf:
+      - enum:
+          - renesas,r9a09g057-adc # RZ/V2H(P)
+          - renesas,r9a09g077-adc # RZ/T2H
       - items:
-          - const: renesas,r9a09g087-adc # RZ/N2H
-          - const: renesas,r9a09g077-adc # RZ/T2H
+          - const: renesas,r9a09g056-adc # RZ/V2N
+          - const: renesas,r9a09g057-adc # RZ/V2H(P)
       - items:
+          - const: renesas,r9a09g087-adc # RZ/N2H
           - const: renesas,r9a09g077-adc # RZ/T2H
 
   reg:
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

