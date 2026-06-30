Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9522156C
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828198; cv=none; b=b9h9nPb84bqLH29PJqwBRZZaUys9u0cNjfYIPvcYndx/fw32LvJEzlLKN99//+6GOQ/9qg1m8R8Q/BpR+m05WINA2DQPBmZvgGUB3n9QgeDoCkUMaVr1ZGyD/Yx+iB7wSxLwMaECILzRMo75nxdfDiHbGk+SKNEkuszP+XUEqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828198; c=relaxed/simple;
	bh=te6yQ/vh13KPOT8v7c2CmXqIR0YWG0FCzDunJJ2/n4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtrBsczdrvNeTlh4YK6MXtM2sLzqp5ml01Pw+vlyIpRy2yubclpP8q3J4hwqWZh7t9f9J+KZprSQySPttBQl5lZSt9o8e4qz6i5DoZmzy4wvooEqKpgcU8pio2OtfGiBfYjlIihOSCXw8CTEgogRkc2HgfgBjMu0hKkdvQ8uY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZCxBo9g; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZCxBo9g"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aec201b582so51402e87.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782828195; x=1783432995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E5myFV2lUvsbUXFZwzMTNcvCKBKBwVWQwQUk0dFgQmo=;
        b=KZCxBo9gj5446lUwH5ZYMsOlpTU57x3lMtBQ9LnKCPNbhfSLG+qNM2BBpnh7MllfsT
         fcDZEpaIxUJhj3fLO3sFWmdPcCQiui5Qxs9B01sl/c4c96c5QnDoebAR0TVMej2aocXN
         syQ2oi8aYhlIbJMCXnH4x3h84Xwll0SeLmQTS/YVjrxpLjfuSOdU5Fhf7qp+uKcSZoWE
         MWRBbhkGRzGEczi83ukW7FWC26pIairE0WK8lvN7qJB+hP/bT3MbKfXRlBKkBgZacesO
         imw9g+HESC8LdDB0bdji4ftuIpAcxPxHQIx9dd/ubAfqSMfLz0P/3O3RHzwQerKReJU3
         aiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782828195; x=1783432995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5myFV2lUvsbUXFZwzMTNcvCKBKBwVWQwQUk0dFgQmo=;
        b=hzo0F2NoYLr6QHeGGXR1msPPvZAepHzIijJI1yhj+rbEKSc0cgZcVa2+5ACUvbjh0p
         DL/A0bsABkPu+DEydQBqiSEzzxTvGg8Ppg6BAitsz0oFjwNCdnCT1PAScoQEq2LtuzPU
         KlgfrRn6QxJ6iCSh+4bJpTvdgIs7jm6acGyzI6XLE71eIm2txZpxlfP1CB6lFKv/f+Nx
         kJe5r1KIzeBvmp0El2SVzGOh4KUzHnP02dl4eVpjMaWipeta67pa01QYkOdC2N+XXTrQ
         3aCJR8u6p0JBIavdAlzcTLsWcuMr1Vv/rzMyusdXcjbJebXjxe6g3FpiS53mxddtuG/g
         WozQ==
X-Gm-Message-State: AOJu0YyiYBQpNn2dbJlwER8QhsGIhC3zVRJfEgdM1v79Ra3me4Ub90gK
	SqVDhir7jPnCLPlWtqiSIZCPLGCth8ZSuZlEQUOuqf5vEuO5iRfRB/KFh9RPKxu5kcfDlw==
X-Gm-Gg: AfdE7clH57WseOK8sLZruOvVobdJ8SCN1XI0x6xdW0gYZ3mBFI1GQ4aNkfBIGkZvYX9
	TQX1jaG7lzOSiTOM6xaZx0DN3+mfglx60wLP+6OkvwlSEXiQaX9naPkrUpMKVHtlXWsoky7kRXX
	Xr0a0BAuSrzH9MWIGt9tnfZC4vLdCtAyUH+jcaSXIQpxD8K+feOeX6Q8eeiABvI37TCbZOAIQkX
	UvMu0v4vY4I+3SOTwvJwyQI0fOYN1pJbLAHeC13qhjAS4uxwshR4Uu8rNE4/a/1K4PCogJi3DY6
	lLhtpbW2FoZDzLPgwQvCefgGcrqjcoibZMnQP5F1XKjkE9dNc8C/LY2tXNWxv5rvbkVh5vlXVbn
	e+Z1d3rk8QVSIOm2NbBzXBneox07Jm/ksq6zhkVsnY+Hw17LGhcjcEVRI4hjM3DxtlCHCQTjWCn
	CaqMb6e56fOpkQgjxagC5ROAKavCMJ+Nr3GJEQfdODNLPKQw==
X-Received: by 2002:a05:6512:3589:b0:5ae:a76b:4bb2 with SMTP id 2adb3069b0e04-5aec10c27aamr163435e87.33.1782828194753;
        Tue, 30 Jun 2026 07:03:14 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aebe4aa01fsm599564e87.75.2026.06.30.07.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:03:13 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mike.looijmans@topic.nl,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: adc: ti,ads1298: add ADS1299 EEG ADC variants
Date: Tue, 30 Jun 2026 17:03:10 +0300
Message-ID: <20260630140311.1473031-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADS1299, ADS1299-4, and ADS1299-6 share the same SPI interface
and register map as the ADS1298 ECG ADC family but are designed for
EEG and biopotential measurement.  Key differences from ADS1298:
- PGA gain up to 24x (vs 12x for ADS1298)
- Internal reference is always 2.4V (no 4V option)

Add compatible strings and update the vref-supply description to
document the ADS1299 reference voltage behaviour.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 .../bindings/iio/adc/ti,ads1298.yaml          | 31 ++++++++++++++++---
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
index 71f9f9b745cb..82c5181126df 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
@@ -4,11 +4,16 @@
 $id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Texas Instruments' ads1298 medical ADC chips
+title: Texas Instruments ADS1298/ADS1299 biopotential ADC chips
 
 description: |
-  Datasheet at: https://www.ti.com/product/ADS1298
-  Bindings for this chip aren't complete.
+  ADS1298/ADS1298R: 8-channel, 24-bit ECG ADC.
+  Datasheet: https://www.ti.com/product/ADS1298
+
+  ADS1299/ADS1299-4/ADS1299-6: 8/4/6-channel, 24-bit EEG/biopotential ADC.
+  Identical SPI interface and register map to the ADS1298 family, but with
+  a higher maximum PGA gain (24x vs 12x) and fixed 2.4V internal reference.
+  Datasheet: https://www.ti.com/product/ADS1299
 
 maintainers:
   - Mike Looijmans <mike.looijmans@topic.nl>
@@ -17,6 +22,9 @@ properties:
   compatible:
     enum:
       - ti,ads1298
+      - ti,ads1299
+      - ti,ads1299-4
+      - ti,ads1299-6
 
   reg:
     maxItems: 1
@@ -33,8 +41,10 @@ properties:
 
   vref-supply:
     description:
-      Optional reference voltage. If omitted, internal reference is used,
-      which is 2.4V when analog supply is below 4.4V, 4V otherwise.
+      Optional reference voltage. If omitted, internal reference is used.
+      For ADS1298, the internal reference is 2.4V when analog supply is
+      below 4.4V, 4V otherwise. For ADS1299, the internal reference is
+      always 2.4V.
 
   clocks:
     description: Optional 2.048 MHz external source clock on CLK pin
@@ -75,5 +85,16 @@ examples:
           spi-max-frequency = <20000000>;
           spi-cpha;
         };
+
+        adc@2 {
+          reg = <2>;
+          compatible = "ti,ads1299";
+          label = "ads1299-1-eeg";
+          avdd-supply = <&reg_iso_5v_a>;
+          interrupt-parent = <&gpio0>;
+          interrupts = <79 IRQ_TYPE_EDGE_FALLING>;
+          spi-max-frequency = <20000000>;
+          spi-cpha;
+        };
     };
 ...
-- 
2.51.1

