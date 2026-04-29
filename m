Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C937A349B0D
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 05:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441572; cv=none; b=WWExzmE125bFpiB5gOhJg/Az3KdmBXYbaBPgI4fc0x3vY9xKBa2TjoalmTKzE2dHb/3mpP6ISrXgUgeu3RXzXw+95aS0DRabJ/Nx8w4FKVKo9VwptggA8a/gdUEaqYwxLBXqje/6fCsLNt/oDxPZaAWN+bfRcV4XVzel+46t0Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441572; c=relaxed/simple;
	bh=rK4lvNmkMm633W8/JNjJJXCQe0WllFArMfDDBGRU2Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=by+mCeacuh49Bmi3/lFGuQJWrcChjuQAfhAbSYs2kBuwCmNS+EcTzkkEzlkpAxkPpgkvu1ZYeiJ1ckLDFz4uC8ZFiCbGyf1H2X8Y2m1lb7R40VhsPC3gMTNL+tzrVXGsI0ThM24b5LwUUg2LArGE5yvSK0aha9sSuVfv9ycNSOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxkkjIoE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxkkjIoE"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ad617d5b80so74359575ad.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 22:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777441570; x=1778046370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yG6eLDM9IfMZdVUIJDp52SWlVGdhG5JSrqqETcLRiA=;
        b=mxkkjIoEVm6J2DiH1o1M94kZMGacWv6bTCdXi0vo3CbKFD3DhUqi/BWeTS26oZmgSs
         nmkazPzbHI5e4A1nU+dYEkKJ3lHKn7TQClkbBgmzIcxmRIvpMIGqshA1ou7YoZmrdgxt
         N/bDxFJoIfmXzH/LN272fdqq2X8S/a0nR/vEt1VQgjrLOFwe3vzEeeO4UlICMZKsuLo3
         RLJthiqrMSFU6WhKhTo0wbYyaiO3gBjeM4Jf/kQ+S3WwlBJARSN1Kq0mmg3bJeGbp6bT
         rs6VYBtDzLIFzgaovxrkMkb9FfCx6VdQlFXV/bzcT72aUszLzxe7xGglhSEhxR1+AT46
         TjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777441570; x=1778046370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8yG6eLDM9IfMZdVUIJDp52SWlVGdhG5JSrqqETcLRiA=;
        b=FE1niH9Px2dlRJOVS/M+fnOZetdPTRAtgCQmqWsAeyHIBY/mPaLafUc6ZJtyBQVYpV
         2cuKHWgdKglqQNswjumE02PZRmimEQy9LnnEejyiuc1puVMeLExWaxl67HFc7Sp91AVm
         hluHBS7X5RqTRKRYziXZZDk+VCWflYWbavsn2XTpcMYbEByBwnuEZNvPzhSIeSAF0uG3
         xJ70esGdzjY8p1aKdEAODRhtWIZzdxQMaD3TAnpugAjCmffulQcwjqyjHP8Lz6HhlHeU
         hKlreA0yF/TABytyyhm3q8q7CGsEBjr0MfvY7eKWJ6NdA/4DA5GHlIW8KeYLdPjhiGaB
         6wUg==
X-Forwarded-Encrypted: i=1; AFNElJ8ZNpmjJNvnx7/+6/ozgwVCU2/5YNJEnObymuq0dXPR4pRxdgEqr+kzxlvhIp5UGfcGInJVgrOTcnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmXkWQ8AiiUauBICoaIQM234N+1VT26CmdD7BeA/VSCxxbOPdW
	MOsrNtrJpLiU88GAYEO9NnQ9B5PhA4LG7LP9kugeiFkVqhgqR0H+fZEt
X-Gm-Gg: AeBDieszNOHaX6EyCpy9KpdwGGv2JPoVuRBgZ47eHfI2L65k/hUaZABZCWOZmKMQKie
	xK+MBMlsIUXsM/Ipkqe/Rv2qjaNp7VDbUi6nUDjG8kvib346I36QYbMDS3hQsQY2MjGKJa/pLyR
	ihCpvWW+gkLFZa7pi8zXFaJdIIuzsi2WjedUd42i3XzO/CGMaGW6/Xnm1WF5mljcgqPaxy8C9dy
	m5FtdqaqqztDfcADOY6qB3lk5LU1Nz1AZet3cwZC4wvisedsgnGCFRa6IJjo5S/lojOwgJDQZx1
	r3WkTNFgmK77NcJfWKpq32QEX9L17J8McxMpbkp2pt6/ME5WkLyFa2ALl/scdFhKMsBPFZjJ+96
	1mD5UDn+b4kN3ZLrrtW2RUEE78JEeSekjLXbPFfNBQUQUbHSGrPQH9fs6TDsdTWiH0Vvrq0bVDn
	DVbHBYm2PcZPiVxWSXiBG0POlmaf9f726fwwYRyOxpx8CDkIMrD2tOFUWMgHsLV3wd7YbpaqwAg
	WsnV10vu2cRsoR2iileu7eqHEXf0dOGLLkHPtmifQZqrluESQ==
X-Received: by 2002:a17:903:1b07:b0:2b4:5c20:ec7 with SMTP id d9443c01a7336-2b97c4ca086mr58037785ad.41.1777441570041;
        Tue, 28 Apr 2026 22:46:10 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:5fb:20b2:c2f6:85bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879656dsm9346365ad.25.2026.04.28.22.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 22:46:09 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/11] dt-bindings: iio: adc: hx711: add HX710B support
Date: Wed, 29 Apr 2026 11:15:37 +0530
Message-ID: <20260429054544.123862-5-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429054544.123862-1-piyushpatle228@gmail.com>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the avia,hx710b compatible and document the HX710B-specific
DVDD and VREF supplies.

Add constraints that forbid HX711-only properties on HX710B nodes and
require vref-supply for HX710B, then add a separate HX710B example.

Keep the existing HX711-only binding extensions in earlier patches so
this change is limited to the new variant.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
Changes in v5:
- Split this out of the old combined binding update so the HX710B
  additions stand on their own.
- Require explicit vref-supply for HX710B nodes instead of documenting
  an implicit fallback.
- Use a single if/then/else schema block for the HX710B versus HX711
  property constraints.
Changes in v4:
- Add vref-supply for the HX710B VREF pin.
- Remove dvdd-supply from the HX710B forbidden properties.
- Add an HX710B example and the vref-supply constraint for HX711/HX710B.
- Update the HX710B description to avoid channel-number wording.
Changes in v3:
- Drop the old vref wording from avdd-supply and remove the separate
  HX710B example used earlier.
Changes in v2:
- Add the HX710B-compatible, dvdd-supply, and the initial HX710B/HX711
  constraints in the combined binding update.
---
 .../bindings/iio/adc/avia-hx711.yaml          | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 9134bbe41379..b2b5c7bdf05e 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/avia-hx711.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: AVIA HX711 ADC chip for weight cells
+title: AVIA HX711 and HX710B ADCs
 
 maintainers:
   - Andreas Klinger <ak@it-klinger.de>
@@ -14,9 +14,14 @@ description: |
   differential input channels. Channel A supports gain 64 and 128;
   channel B supports gain 32.
 
+  The HX710B is a 24-bit ADC with fixed gain of 128. One input measures
+  the differential voltage between the two input pins; a second measures
+  the DVDD-AVDD supply voltage difference for battery level detection.
+
 properties:
   compatible:
     enum:
+      - avia,hx710b
       - avia,hx711
 
   sck-gpios:
@@ -44,6 +49,17 @@ properties:
       RATE pin state is determined by the board wiring.
     maxItems: 1
 
+  dvdd-supply:
+    description:
+      Digital supply voltage (DVDD). For the HX710B, DVDD must be
+      greater than or equal to AVDD. When DVDD is a battery rail and
+      AVDD is a regulated supply, one channel monitors the DVDD-AVDD
+      difference for battery level detection.
+
+  vref-supply:
+    description:
+      Reference voltage input (VREF).
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
@@ -53,6 +69,21 @@ properties:
     maximum: 2500000
     default: 400000
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: avia,hx710b
+    then:
+      properties:
+        vsup-supply: false
+        rate-gpios: false
+      required:
+        - vref-supply
+    else:
+      properties:
+        vref-supply: false
+
 required:
   - compatible
   - sck-gpios
@@ -72,3 +103,12 @@ examples:
         avdd-supply = <&avdd>;
         clock-frequency = <100000>;
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    weight {
+        compatible = "avia,hx710b";
+        sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
+        dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+        avdd-supply = <&avdd>;
+        vref-supply = <&vref>;
+    };
-- 
2.43.0
