Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E30523798
	for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685776; cv=none; b=KdHpxjkdsAY6nrLS/2eGiXQ24TqUn5Kf+MqlkyOZdkzowJT4/SrwiqGdzYs+J+wDsvVwmfDw3+j6NxT1iwL6+lQOgh+GNQTdmhWmSycLWfG2bfSvlAQ/5/IKKgBk/HZ1Ggpo7/NXHv5fFw/twI8aixZFMQWTdwG1LQsOK3wBo6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685776; c=relaxed/simple;
	bh=6Sy6vgSYukgx1flhb82E53r8hjS6KeohuIzJbCR1Vj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4nds0cB7riA7w6446xA2dLZt6XLjTr+KDs1CBbsOnKM1MndZ4HBKaevWpe9yS8hy6TIfCovGxEau6DzPXaJsWFZX8xwJePKKqgIQ4g+CCdCKvsyS4h3wxZczYseZcTWeb8+yOYLj3F6qJCLSlERottgu1KN1CuEV/sSkRlxQuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM7nQ0Ky; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM7nQ0Ky"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso30852905e9.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790685773; x=1791290573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4J1veNvmysC8QT8osypByF4KUi97wR8R1soWK43MPcE=;
        b=RM7nQ0Kyd/I8SjIqCOnMNn+bgE2V+19fWDEl1TZSO87meezXkSFYLMXb6IWucAX/XB
         y9mS6G2sjZ0oK/JJNsNr1httHAZjCRB4/nwvAmVlNI3frS0daLpMuCvf+dQgCDFCXtRk
         9O3NBLdZ3xABQSRfehSFdc3rf/Ha5HJayHWSTDb8YqmrX1UDlxVqsgiiOKT66Ne8kkO2
         oN4OfjAK0uuFGcFABnt55O77bKbZFGv7xjj8kpZvuxjAQZyXGVY4cOAYBDCrmAIjeZ+4
         jgFnzrQTa4RyxhvGKL7Lppn5mYktO8hcy1AHX+IRMbG6cqC2VVWa/52LhrMUkUeKp38N
         PGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790685773; x=1791290573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4J1veNvmysC8QT8osypByF4KUi97wR8R1soWK43MPcE=;
        b=1NzAod16ziLsTXU5iD/VxZ8caLTA6ZAJNXTZYUlbFNdFzdTaNG/mFOYNmUmNH6NTRo
         8BAW8eJ1Z2Tg5OgfSnifOG54MlEPq1gOOK3x66G1k3KSLR2NtlZKgg9TIvZGKeuYc9F4
         1/PLc1ws2lwlEK3FoHMc+7p2u9Rj+T2b+4UAemQ1UfU7bJ57JYzTJWfAkCj1he2RuaXR
         PVYcThTHkYcUlaGqaiiM+jL14rBC3FQJQKG69Ol9L6bS4r1pWWJmuzuMqf4LP7egqKuV
         pGCDTe6QkXFqat5wziaRneCD0BFFHfW0C6ap02fUx6F5idRHv4LKsG6xtN+D0uEepFVL
         TcHg==
X-Forwarded-Encrypted: i=1; AKwUvBw7w/9w5B0jAyFxGM+2qbcVgxT49izfbGWq63vcoMWsPgNus7vJLO5rEuFA4yL64kXrIxCYKvX6aCQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lQtV2mR7p+ACigsqatChqQBAfG6KC1E9VybzWDYtr648aD4n0A
	iC+AK64D7Dq3eOKHgQuPe2ivNjhGAdEavCtQZ2anKa+fCSMzE0obPA+Z
X-Gm-Gg: AYBFou2tovLo1Kq5D/AajuKYqrA+rPM0QQ5rEKzUU0PzeFVsLRmofWOAxA9oQTArS7Z
	1JMV89z2r2+in5ydYOqMvoADdlzqu6X4hR2E5Ji1+vpgP5IDfhk65otmLey2SiPHwGRet2LqgjM
	cpe7ZWqWWhKZsOZnn8buiW9EhtqdaVDxIYrxpV0QPH/uuwJYvbzDkTgFwnjKHdYtJ1u+N6i2eAj
	YMlxEfxONmgD+Pl9Xsoz7J/wRFJrqNtQ4Ho9mao3MBXATttsTv9AdhLzfcTA53KB35Mf/zznI/S
	tCbM/qQ/VkOZC2kdRpU5Aih31jlRi3bITDff293DCG9G4iif/o0Hqj4mVwyBenTGmfWKqxeQKjj
	RQGHRsaojmE9PmZijx3SIBoXcdifAglQwhdZuXiotnbjE9eCtHkDVhKmxSofBhN/QBivdumskKk
	I/i/tL0J6tl/C3bw4aqMkXgoDN3mYmP3ntZDrT2TllM6T4H24tCtr3bxSILFX8qCkuBgg78bY4s
	rUbNOszhQtXkIVCV1jViOkugMttl3cyKby8bUR+0mD4/UO6ix6dzBBv8OP9f6tpYnq2xrFPK/As
	9qYLMOZEkghCYU1LsQ==
X-Received: by 2002:a05:600c:19d1:b0:49c:d818:8764 with SMTP id 5b1f17b1804b1-49fe7b62c5bmr277276605e9.11.1790685773162;
        Tue, 29 Sep 2026 05:42:53 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:be4b:8730:c872:1736])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502da06sm4436630f8f.11.2026.09.29.05.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:42:52 -0700 (PDT)
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
	Magnus Damm <magnus.damm@gmail.com>,
	linux-iio@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/8] dt-bindings: iio: adc: renesas,r9a09g077-adc: Add RZ/V2H(P) and RZ/V2N support
Date: Tue, 29 Sep 2026 13:42:41 +0100
Message-ID: <20260929124248.237032-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

