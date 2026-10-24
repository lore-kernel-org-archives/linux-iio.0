Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792883662;
	b=XYQEk3yDGVyRRkrMU1nHs3cwiE3Q10iC0/AaTZ+PjFhSmR8PuHdnhc0sEg7yqAEHvNMn
	 4+cIckbccMpXPcOTEtVRLxBOD7iSLQKrs1CxwMPeRqq6vWsavz8F8D8df+W+VCoE3HAdM
	 pBM2Kft4VLBlxOJR/xzWaRgxxQ3uYIDlakGeLQTszmYcEMuY3TJa83Jqt7m+37yy1lO3Y
	 9m2yHc+b4qVghOLukGimOge/ma8XawkaJ1RN//G+N/cdvLOS4ENg2c1vKAJDuA1kZnHaM
	 MWcAZIriXdYCndVz4VOOPl2yDPQ51SDfZJ7w6JaZ2s1dpoVNuv/d4uUGajy4BxY6cmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792883662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a4yYPyLDwJaAxxcWVkGzZx1PqQ1arhomrIXaNO8Hhig=;
	b=LQn8q2KXKUxOYQ35ujTUR+xZJUUoAkg4M/m6dO0Rc17AXe5KZWGIrxVfv46pJtCvofmD
	 u2xmvfOPffGFiB/jYlqGPFhR8oqxyL2VIGYUA8qFj5+LrrPz9KRsmEP/G3PXsSewTxEWr
	 NcvMeG9ikjx3tWTuC5f+UaP0zqG4ktt/q7f9pLUh7EDeR0gXTpQEKifc//RA1HctRFuqs
	 Y09uCsTKCR5GKOxiFuMZ/lgTgs+5hjg3a2AhRJkIMAT/C0YmLbkRx+QNLgnni6QNYyQYP
	 FyNjBZRkIhFNGYJj9w6X5bVcv8B5kD2BxJMyG4WOlWDwZLtJLSS3nXQpp0zc9R3Qgeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ewMIEmbs;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE19E606A31E
	for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 23:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE19E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ewMIEmbs
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso727956e0c.0
        for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 16:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792883661; x=1793488461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a4yYPyLDwJaAxxcWVkGzZx1PqQ1arhomrIXaNO8Hhig=;
        b=ewMIEmbsu9tOqj6iGT5IHVKFXdOvdSfNHrxKvbkbMeMT+n458VGwTw14rQNtJQ8/pd
         Ms7VQTQo5EjIbuZGAcXQ7o7di0Y944dfVi5jQl3GUHXWG5i2p/LavU6E56m5vvLR7RqN
         nk24TpKD4r00Lu080elWDjOFWOp9NMCEWs7k/nyFyIbECBGtDk/3jKnChnSSBMMLyDPk
         Zaju8bPvKTCLsgznD5yvnyp+5r0XF9RiUWAkB/Mq01JevH9LLrS/cC+0pbew+1EDo/zk
         V0niDYl3//VFtyAKCup3p8rShId7LnjwEBGVCXCFbtdEAil4N3aYmNmt1OIC+lUmnG1Q
         vzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792883661; x=1793488461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a4yYPyLDwJaAxxcWVkGzZx1PqQ1arhomrIXaNO8Hhig=;
        b=yNUdqYuDeYc5vy+Ba+fy0V9r2MfbzAFIvl32351UAB1D3sJjGxHQG3O6Gk70T6OT+1
         LaXvAAoBLQtdQnU0mtitncqZxmJyvwQDlqnkiZz5yi83ok4wSX0LMKRLmC6PJdVo/KVV
         bD69SsB1E2iK5QpG+SWp5OhCIEhSFxBQH85oVsONbJWWwSwuEVIZmRfzIRXqB2ZkCQgh
         XgpnLZaDJqst/ERbCN2LoJQq7/+Ewd59KdbLgbJR7GYgWcPiNv5S+LHiI9ojI/JMiqQ0
         gX0At25Wq9HIUunl5+zZAeVEu/bT39xrU51TwYa2MKqQ490WnyE1sPaqLm4CQsQ2Wp/6
         pGzA==
X-Forwarded-Encrypted: i=1; AKwUvBwO+7iYCmbFnxEjiwl9PYgCmtYIEUE17qfhw/zdLkFyfNtVGhqV8zYv2wnDdtST0Bj8eAhITz1Q34w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJR70FBgbEpZ0GC5SzAvdxLYFu4NVdpnY4fl3LpiNs4csk7Yv1j
	SM8QJqWjjzCbgaS7oN3J7APMqO+GTsbj/JR45zgOCAN73Qey11ns64za
X-Gm-Gg: AYBFou2xgGQfLw7cu4VmlbJCyGbVA2Wvmg/UQ5faxi2gknmpMRrb2JpnpoO6yYJa69R
	32hXbRbkcMdlEdKwsKWTdlZr8o1Z5/pGUPtB/qU00HBHUpFExPwqkmIcZmw8BZxKcCwW9OoD45f
	lK2/iidFMijqppxFt/w8X8MYOr3XEY5YFrTG1wSX2A+jLfY81MMMhGnEMUc2DnGGKazGc9vuDtC
	TqJ2u/cEc6bwiZMDFyL19oNA2bUBSi27ZiB2nJgaX7etyNQdlE2L2nDQ47E+ySJttV20Z6Gx9Of
	RAUM6FSrWg81zctaQwXaLjzOB5GxShPCFb5j6B424Qk223LJmvLEVj3bb/BEaGCGjZTUYp1S2OX
	Sz8rT2R3/+o6ad/VSLltN71o5gdsmeYnx7OQe4C5ihI0usLWCgXVMovJ+a8fFQXYTEdEMvwSQzZ
	1CWdUJnjKMCzvrp8r63CAAZ1uRM7IVZpY5h3/W3nY0dOWZb7npSwCJCFFPr4Kiuf2I1tWRMPEW2
	/tBRalG1FoYACl4svi6Bra5f+SwohtDvPiHP4b+PtsIroVIsL5Y2I7z1EO2wWweICW6tXfGf4fX
	RhB+
X-Received: by 2002:a05:6102:a4c:b0:7cc:776:6c41 with SMTP id ada2fe7eead31-7ce5cd7de50mr813317137.22.1792883660690;
        Sat, 24 Oct 2026 16:14:20 -0700 (PDT)
Received: from stephan-Inspiron-15-3520.. ([2804:5d20:6009:6701:efc9:520c:e99d:e5ce])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e7b8f0csm3775406241.5.2026.10.24.16.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 16:14:19 -0700 (PDT)
From: Stephan Costa Barros <stephanbrrs8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] dt-bindings: iio: adc: ti,ads1298: add ADS1299
Date: Sat, 24 Oct 2026 20:13:34 -0300
Message-ID: <20261024231335.280955-6-stephanbrrs8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024231335.280955-1-stephanbrrs8@gmail.com>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
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

The ADS1299 is an 8-channel, 24-bit biopotential ADC for EEG with the
register map of the ADS129x. It differs in its gains, data rates and
ID layout, and has a fixed 4.5 V internal reference. The ADS1299-4 and
ADS1299-6 are the same part with four and six channels.

TI sells the 8-channel part as plain ADS1299, so ti,ads1299 names it,
and it is the fallback for ti,ads1299-4 and ti,ads1299-6: the channel
count can be read from the ID register. The ADS1299 is not compatible
with the ADS1298, so ti,ads1298 is not a fallback for it.

In the same way, give each ADS129x part a compatible, with ti,ads1298 as
the fallback: the ID register tells the parts apart, by family and
channel count. ti,ads1298 alone remains valid, so existing device trees
are not affected.

Both families have a digital supply, DVDD, and an active-low power-down
pin, PWDN, which the binding did not describe. Add them, both optional.

Add myself as a maintainer of the binding, next to Mike.

Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>
---
 .../bindings/iio/adc/ti,ads1298.yaml          | 41 +++++++++++++++----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
index afcc683db..c88f0dd95 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
@@ -4,19 +4,36 @@
 $id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Texas Instruments' ads1298 medical ADC chips
+title: Texas Instruments' ads1298 and ads1299 medical ADC chips
 
 description: |
-  Datasheet at: https://www.ti.com/product/ADS1298
-  Bindings for this chip aren't complete.
+  Datasheets at: https://www.ti.com/product/ADS1298
+  and https://www.ti.com/product/ADS1299
+  Bindings for these chips aren't complete.
 
 maintainers:
   - Mike Looijmans <mike.looijmans@topic.nl>
+  - Stephan Costa Barros <stephanbrrs8@gmail.com>
 
 properties:
   compatible:
-    enum:
-      - ti,ads1298
+    oneOf:
+      - enum:
+          - ti,ads1298
+          - ti,ads1299
+      - items:
+          - enum:
+              - ti,ads1294
+              - ti,ads1294r
+              - ti,ads1296
+              - ti,ads1296r
+              - ti,ads1298r
+          - const: ti,ads1298
+      - items:
+          - enum:
+              - ti,ads1299-4
+              - ti,ads1299-6
+          - const: ti,ads1299
 
   reg:
     maxItems: 1
@@ -26,15 +43,25 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  powerdown-gpios:
+    description:
+      Active low GPIO connected to the PWDN pin. While it is asserted, the
+      device is powered down.
+    maxItems: 1
+
   avdd-supply:
     description:
       Analog power supply, voltage between AVDD and AVSS. When providing a
       symmetric +/- 2.5V, the regulator should report 5V.
 
+  dvdd-supply:
+    description: Digital power supply, voltage between DVDD and DGND.
+
   vref-supply:
     description:
-      Optional reference voltage. If omitted, internal reference is used,
-      which is 2.4V when analog supply is below 4.4V, 4V otherwise.
+      Optional reference voltage. If omitted, internal reference is used.
+      On the ads129x, it is 2.4V when analog supply is below 4.4V, 4V
+      otherwise. On the ads1299, it is 4.5V.
 
   clocks:
     description: Optional 2.048 MHz external source clock on CLK pin
-- 
2.43.0

