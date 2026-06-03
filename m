Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE5647D93C
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512572; cv=none; b=BkLHSTl2JkaXo+mjxP4DE4kSPnAbLTyzTdBzv/POrdD8betd6BXWRKPErN5MEqsaF3uezULfuJ4o8wlXJr2ATgkgto6ek7yHBe94s69JdxcLqRToyJwniJe0EpaBl978xq8IPDIH+ycl98wEMcOf+y/eIt3OS8lVKAKgOj/trpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512572; c=relaxed/simple;
	bh=40M2sV1ViupapFAfo9CoPrRZTe8sv4vv6buoDystY7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcy1ubKACmpdrgfTrNt/Z9FhRGtrHtkl5+gKnNNEurQ7hIIuChQDBhIH7xOXayaPc/FF+9cT7hVwrFDDvVQHMvRE3uNLlpL9RHr8SreGU5R7HPOudYPMsEd/fsPqEzVRALPYkNnMm20nvq8XiKRWP0t2MUb5E64bv447ohy3uX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N32nZj4P; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N32nZj4P"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso30032555ad.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512570; x=1781117370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6ML9c7gULfSe+6SlEf0Y7kEnMjS6nVo8dQzv+8WvZE=;
        b=N32nZj4PgsJB/OXiijJtRx7Amw03+WqvYCBEmYTk9bSLmEItvMtOuN5OSUsL/e2CL2
         y6dkHOcsVRcXsFTvHKZ/R4rs42/nSxDaZYKV5PAJoM3Utr8+PKiAJM+SmnK5jdYaANIB
         +hhHG/r61ny0fx79CL95oyl68t6+vgD3Qh5jQ4QuSd0E3ty7ajMIQhtqW3hEmgEew5nd
         nH6Xkui9lRf/OWX3v+In5e4CMsPup6YxXHnu+jVJcCIOMF/YVrzpe+ZJVTfhdSfJeoXs
         HOfsNAGcydzAGEJNLCh9Gco5kM1AWy9n3TZsF62WFqdkpbzu7+Mhd94YSzDDAMfsg1AU
         UjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512570; x=1781117370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6ML9c7gULfSe+6SlEf0Y7kEnMjS6nVo8dQzv+8WvZE=;
        b=Gbxwifibk8uMcCumrywM7gZ9HARSHI5dK4YZeETtKeTiC3i+AsevyKTiSc1VFtXEuE
         e0v7xbVUt7O6rSazqvjUNLv+LeNiAe/QB9Lc1sijE/QN+mJ6Bt7Uw/nq4eJJAp4okLPA
         sCrwnmEUMEfuLjXcQ982jaUEC9fkzPrxPHJCfVg3sbt6o1b8rSmP4M71nR9eMxpIV+kg
         /Qz7LN7PmfjVZ4zlA9os/9A+WnJugL6E+8n+J1h60jVsqdwRYDsXLcK+Pe5iDRDKqaDK
         bwnSNpD7jQCFMgb55zRIfUeb4qvdMjiJ+6g9CncQW+FfEqIwf9MdJ7xWkvkAZZMli8eA
         W02A==
X-Gm-Message-State: AOJu0YwJD6Xcp0TsIOvXpCm7eXPgjz3vsSEVdeslbl5QecaIrT/GMYAX
	RXY6XP2CzYO41Iv3qqqT1T1ep9IPwnXfY2EmUViYWLKCS4MB6V2ns1uI777Ahg==
X-Gm-Gg: Acq92OG4mkJfqGKVtn9+ITRaA/oOMEMrvdG1NBgGUS2gRn+uVN4khCHpJMSQO0MTQjW
	kHoYLXxFoHFg05TGEvRbV/e6kko5okdZvkTukZdEUB/OTv/l5jUDEBoIR/d0qDQd37147eODVfA
	/0xz0kbQCZdQN8vZsen4/KDbDhiEHHnN6ylbwySJEzddyJVlfGw6JBxs8XzGaK1x+3WJLvdHcjX
	9vqIEPncLYL+Nvq3ja7SMaZmscgDBUGcuNeaZ4kOvtGNcw/S65zV6SGlgCG6Q1VKx7CxnlpMh/r
	U/8gWqScVaEgazpRcieaZ0JOcpk7Dt8YF2r8fDw1gpidHsMspMNGpL52vCYQ0wcbvjH9cqaA7oE
	wac6N6PzEve0KGtNll1MIMQRJxYn7MB2TO0Ui9x/BBNIp8w3UuYd6aJ7sbINXlQhZMbrzi1ziCo
	YyWwGlaed4SxSk6h55+VlxAT7rKEZzcdZeSNElmOynPda/NgxY4dOzJH9uQe3yZSmdjMC18NSYD
	MFruYhKrKKcr7iWLzOzvHIa8T8rp3abzFvXwLnfcHtTr3dJNLR4SQ==
X-Received: by 2002:a17:902:e54f:b0:2c0:d097:51ba with SMTP id d9443c01a7336-2c163fadb2cmr48915475ad.26.1780512569723;
        Wed, 03 Jun 2026 11:49:29 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2409:40c1:4015:6e6f:ee79:7998:9a6f:65e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d59csm32139675ad.4.2026.06.03.11.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:49:29 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v11 04/11] dt-bindings: iio: adc: hx711: add HX710B support
Date: Thu,  4 Jun 2026 00:18:52 +0530
Message-ID: <20260603184859.89693-5-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603184859.89693-1-piyushpatle228@gmail.com>
References: <20260603184859.89693-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the avia,hx710b compatible and document the HX710B VREF supply.

Add constraints that forbid HX711-only properties on HX710B nodes and
require vref-supply and dvdd-supply for HX710B, then add a separate
HX710B example.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iio/adc/avia-hx711.yaml          | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 099235b5fd54..13a3a8b007e2 100644
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
@@ -53,6 +58,10 @@ properties:
       RATE pin state is determined by the board wiring.
     maxItems: 1
 
+  vref-supply:
+    description:
+      Reference voltage input (VREF).
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
@@ -62,6 +71,23 @@ properties:
     maximum: 2500000
     default: 400000
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: avia,hx710b
+    then:
+      properties:
+        vsup-supply: false
+        rate-gpios: false
+      required:
+        - vref-supply
+        - dvdd-supply
+    else:
+      properties:
+        vref-supply: false
+
 required:
   - compatible
   - sck-gpios
@@ -81,3 +107,13 @@ examples:
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
+        dvdd-supply = <&dvdd>;
+        vref-supply = <&vref>;
+    };
-- 
2.43.0

