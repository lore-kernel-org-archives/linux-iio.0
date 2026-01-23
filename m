Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C198D2E973A
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200724; cv=none; b=HX9zoL6jLyjS6aC00nMGaNTw0pTQg4HLHSt9i1mpB2xw9ODK7C2XhK+VlUMEBcbJ9mdR4EeuzCvekeqXS+gmZ4IH4tvjRgJ73yD+qFsmE548dle0Bqvnw+epJI9ptJY6LAkue0fo99hoDLoZUuHeXotM9+ES0bDEguZUQumAOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200724; c=relaxed/simple;
	bh=h+Hpg7mAV/rUr3EzlDZhbxTF2vRK/83Uj6sS1/n0P24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=srmhVfDO0YI2L57XwNclT/HkYm87Y2gHqYBIOnYboxixcPk+zsD7er8RgFmBBQ1cNrJ15DIBQCeT+iYIZHaiW0Yuc1wN+VcxBEtSFzqsS9pdArsig/sa0JOBqvzYnKn20MevG0Nhu4w7d63ze35Bb2GZ9rmUMRMCuej7/wmOBdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QtWTFb7S; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QtWTFb7S"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45c7400259bso907816b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 12:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769200720; x=1769805520; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X31guPVFU+0+g2QDbsPtzUxPVvF8hORfxCmewEdgT3I=;
        b=QtWTFb7Sap5I2lNgkyWwgfbedNfd766WaAJfIgMyW433VuvbmpDJ5xQqGavCX+crc6
         lphRAUxu+sBKG7H/26KVz7s11jGcNEmH65SBK94ZcwzsY+i8lLor1hwkPXBYgw8wn2O8
         olIEaWt5wU+ylP75s/vFhfRyjPf8FMML04aoHcy639XIlq5P42HCSe643PuWxTWptBA0
         CnPb0H2XjMC8N71fWvQj9hmQRFL/WvUmpRe28MIfLJ9Dq5cA5hPaYXfT5QgS1xUXOEB9
         PF5AlL+2eSweGWiStJcu08kKsdOlxJ6Y2lHPUV/02JjjvG2CDD0ZBCvmCWYoEKmFiLNm
         V8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200720; x=1769805520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X31guPVFU+0+g2QDbsPtzUxPVvF8hORfxCmewEdgT3I=;
        b=IPYD+FGOAQj4Og6+RTHDG6ctzrLb3kvwzR7aATUQicvVpkGoxHXTLA89T0lfrj9aaL
         vV2CA1S99aSp03mZft/FXnAZh7RWazANsUPcJtbjv4X5AAnMjUSxcS7PHbQ799ae2cmm
         AZlkncvAXJNin7cZPGc2/W+j0bMk8D5MDjOAOwrtRWogDzXxHMCOTdlaG93YRyNZHowG
         rEB0j1jFVapTa0dK+dtr73eBcS+NR/nAALWPPw1yvFLU5ukVzFEWo0nEd0DfzQ1yLS65
         NsnppiEwfTivemUxBheGVojdhuiWdHJD9xxyPV1icVYmlBFBbzyJ6Xom/KU8TbmlW+4J
         ZquQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgyQL0LAJY6f+J09qlK4QDkjfJVFpjjOjXHdKty4++RB+JJg5Y2tu5NoHHcd+vTVTerju7eXTHYM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/2xaCgwKbp/kxNgpT9Q3A6nuTQCy5IxS03KLDj7or/mCUCKE
	0QUpYRwg1PdHC1dmryt6ZciIEiPm2DpZhfVA9vsfHzAW7YknZF8k5XIhwYSQc/zm/X0=
X-Gm-Gg: AZuq6aJMrSo25WSbc7Cv+UyMWkHAQweWSs8Q07XWxmx8yFPHPA6whYjtazP4J46eXPT
	7N1s6WkGupDkUGayywwdRzib619ecN2qmCF9+oAdGJBaMXinUN5eU32i12UlxXR1TNVB+Mqv8hh
	fzuEgf/R+GufxaJXvWa5bJ1kmt2/miUE18ksFRoE8iNHxPxD31WhPHfc8HT4exLJabydcsQ80Az
	ygRqvkpvBp+xaE2ZIXHXPNuBpz8vi3rIQjo5OQlurDN7s2Ck1E8ukH3q9Gvg5HFq8TJ3pJGNqBR
	N/BmW9AXCcrg6KPFinOH+iAlkPq3VctHYP9ZEa5QgAnNNpgATCm7ENXqWTDqX2qNNLj+few5b33
	7FIRgO5BE6Tkcd792nk5D/DZoG7s28b0oLMqrRlOgyrHS/4WXbtEeJXh1gGhD6wXkym1F7G42J0
	IX+a7qkJa14Biqcg==
X-Received: by 2002:a05:6808:f92:b0:442:2ce:46cf with SMTP id 5614622812f47-45eb1cbd54dmr1926865b6e.34.1769200720002;
        Fri, 23 Jan 2026 12:38:40 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af888da1sm2167805fac.6.2026.01.23.12.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:38:38 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Jan 2026 14:37:24 -0600
Subject: [PATCH v6 1/9] spi: dt-bindings: change spi-{rx,tx}-bus-width to
 arrays
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-spi-add-multi-bus-support-v6-1-12af183c06eb@baylibre.com>
References: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
In-Reply-To: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9966; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=h+Hpg7mAV/rUr3EzlDZhbxTF2vRK/83Uj6sS1/n0P24=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpc9wQqZDKLcDnrd9zEHZlWK7sz4Ww9Io0Qzt/M
 zWhNrfZjIiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXPcEAAKCRDCzCAB/wGP
 wLoRB/9XMTjSOrAEY36OQZc/Jvqp2t8wG2+pZqUiEg5iibEFWrwvkqbaCp+PvRWJm9BswMRWqJ+
 A8eYOIm6WYbp6WjaowfkT6B38kqVuwdwtIU1WqEmLARZVFzJ4AHe2qYg/U7sY0kRVCemj/2gOqP
 7vaTf68UpDe0Tp57aZDLUAygTMMvxeFhjfO718dE8PqrN7DTK8PbcNtEAkTmqOBUj3pgwQVCJkE
 Vb3vImkqkDzgedxFqA0Zz2pt0wJvuXOJLE8Ab05KnIPfu4U/iaDPysJ6cwxMmzMtxKk66RmfM/x
 iBXwKAuTIzGV0feHJR28DG+uv2nWjCx3FFvyRmgqn0u7vvmb
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change spi-rx-bus-width and spi-tx-bus-width properties from single
uint32 values to arrays of uint32 values. This allows describing SPI
peripherals connected to controllers that have multiple data lanes for
receiving or transmitting two or more words in parallel.

Each index in the array corresponds to a physical data lane (one or more
wires depending on the bus width). Additional mapping properties will be
needed in cases where a lane on the controller or peripheral is skipped.

Bindings that make use of this property are updated in the same commit
to avoid validation errors.

The adi,ad4030 binding can now better describe the chips multi-lane
capabilities, so that binding is refined and gets a new example.

Converting from single uint32 to array of uint32 does not break .dts/
.dtb files since there is no difference between specifying a single
uint32 value and an array with a single uint32 value in devicetree.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes: none

v5 changes:
- Added change for andestech,ae350-spi.yaml (recently new file).

v4 changes:
- New patch to replace data-lanes property patch.

In v3, Rob suggested possibly splitting the spi-controller.yaml file
to have a way to make most SPI controllers have maxItems: 1 for these
properties. I would like to avoid that because it doesn't seem scalable,
e.g. if we need another similar split in the future, the number of
combinations would grow exponentially (factorially?). I have an idea to
instead do this using $dynamicAnchor and $dynamicRef, but dt-schema
doesn't currently support that. So I propose we do the best we can for
now with the current dt-schema and make further improvements later.

Also, in v3, I suggested that we could have leading 0s in the arrays
to indicate unused lanes. But after further consideration, I think it's
better to have separate lane-mapping properties for that purpose. It
will be easier to explain and parse and be a bit more flexible that way.
---
 .../bindings/display/panel/sitronix,st7789v.yaml   |  5 +--
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    | 42 +++++++++++++++++++++-
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |  5 +--
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |  6 ++--
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |  6 ++--
 .../bindings/spi/andestech,ae350-spi.yaml          |  6 ++--
 .../bindings/spi/nvidia,tegra210-quad.yaml         |  6 ++--
 .../bindings/spi/spi-peripheral-props.yaml         | 26 ++++++++++----
 8 files changed, 83 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
index 0ce2ea13583d..c35d4f2ab9a4 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
@@ -34,8 +34,9 @@ properties:
   spi-cpol: true
 
   spi-rx-bus-width:
-    minimum: 0
-    maximum: 1
+    items:
+      minimum: 0
+      maximum: 1
 
   dc-gpios:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 54e7349317b7..e22d518135f2 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -37,7 +37,15 @@ properties:
     maximum: 102040816
 
   spi-rx-bus-width:
-    enum: [1, 2, 4]
+    maxItems: 2
+    # all lanes must have the same width
+    oneOf:
+      - contains:
+          const: 1
+      - contains:
+          const: 2
+      - contains:
+          const: 4
 
   vdd-5v-supply: true
   vdd-1v8-supply: true
@@ -88,6 +96,18 @@ oneOf:
 
 unevaluatedProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad4030-24
+            - adi,ad4032-24
+    then:
+      properties:
+        spi-rx-bus-width:
+          maxItems: 1
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
@@ -108,3 +128,23 @@ examples:
             reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4630-24";
+            reg = <0>;
+            spi-max-frequency = <80000000>;
+            spi-rx-bus-width = <4>, <4>;
+            vdd-5v-supply = <&supply_5V>;
+            vdd-1v8-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            cnv-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
index cbde7a0505d2..ae8d0b5f328b 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
@@ -38,8 +38,9 @@ properties:
   spi-cpha: true
 
   spi-rx-bus-width:
-    minimum: 1
-    maximum: 4
+    items:
+      minimum: 1
+      maximum: 4
 
   avdd-supply:
     description: Analog power supply.
diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
index e1ab3f523ad6..a34e6471dbe8 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
@@ -55,10 +55,12 @@ patternProperties:
           maximum: 4
 
       spi-rx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
       spi-tx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index 1b91d1566c95..a6067030c5ed 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -81,10 +81,12 @@ patternProperties:
           maximum: 4
 
       spi-rx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
       spi-tx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
index 78093468dd5e..8e441742cee6 100644
--- a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
@@ -45,10 +45,12 @@ patternProperties:
 
     properties:
       spi-rx-bus-width:
-        enum: [1, 4]
+        items:
+          - enum: [1, 4]
 
       spi-tx-bus-width:
-        enum: [1, 4]
+        items:
+          - enum: [1, 4]
 
 allOf:
   - $ref: spi-controller.yaml#
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 8b3640280559..909c204b8adf 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -54,10 +54,12 @@ patternProperties:
 
     properties:
       spi-rx-bus-width:
-        enum: [1, 2, 4]
+        items:
+          - enum: [1, 2, 4]
 
       spi-tx-bus-width:
-        enum: [1, 2, 4]
+        items:
+          - enum: [1, 2, 4]
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 8b6e8fc009db..59ddead7da14 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -64,9 +64,16 @@ properties:
     description:
       Bus width to the SPI bus used for read transfers.
       If 0 is provided, then no RX will be possible on this device.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [0, 1, 2, 4, 8]
-    default: 1
+
+      Some SPI peripherals and controllers may have multiple data lanes for
+      receiving two or more words at the same time. If this is the case, each
+      index in the array represents the lane on both the SPI peripheral and
+      controller. Additional mapping properties may be needed if a lane is
+      skipped on either side.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      enum: [0, 1, 2, 4, 8]
+    default: [1]
 
   spi-rx-delay-us:
     description:
@@ -81,9 +88,16 @@ properties:
     description:
       Bus width to the SPI bus used for write transfers.
       If 0 is provided, then no TX will be possible on this device.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [0, 1, 2, 4, 8]
-    default: 1
+
+      Some SPI peripherals and controllers may have multiple data lanes for
+      transmitting two or more words at the same time. If this is the case, each
+      index in the array represents the lane on both the SPI peripheral and
+      controller. Additional mapping properties may be needed if a lane is
+      skipped on either side.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      enum: [0, 1, 2, 4, 8]
+    default: [1]
 
   spi-tx-delay-us:
     description:

-- 
2.43.0

