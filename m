Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AB934040C
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781057113; cv=none; b=ZXE8LGT4uU3SlDzU2uJdQpm4wa+Q4aJcMgY3g9RIB8LhcpGwJr2dZssMcG/yC4TPanO9lhOm3kvybW5bvnj5rR1tdSg0Z55GEqY8UNQOl+jYKCema8C5oEZvdrB306otBjrbHp3YyvwD4+ehQBIg6PewIWpvSHuiHW6OuDvtvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781057113; c=relaxed/simple;
	bh=c+PFEYG6ni5DWFhYlUmO1aNqlTR+2wCBDhpWe3tJOoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6fVDeK/Y+gH1xZtaMN20hsYY15flvSRYR2x+T96YLIgqRp0qpaLPaOoittRjpu7lcr3zClEBagCOvwsJ6a653Mh+oRbbQGZBtONEPKVsWNklpju5xVElhn97sH8jEcYulXC/0tjwENzzcZA+3kTIPIbiN1cfPzAyk1t0oRsM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6HsmEFO; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6HsmEFO"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9156b74006aso449763185a.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 19:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781057111; x=1781661911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1oKhnq8sAcCQ1/AgmLgq7v5eloi6h0buEgHTVAGai0=;
        b=W6HsmEFOokF9qpk3vagj2W2azrMVqSPCyW74fuRN6/gtQAmGuNkmFcsPMx1fZ5t53v
         dj6XNTHnSHjzBku9oohjrnOikNF3qRDux5TuTr7xxnJGT0E5jP8KFhGo2LN1m9ZbfZWU
         0nAmXWuahwf2tjbCnNVgrbJ0SBhJaqEJ7iDd6Gi0OQBRCHKGTjjIp4tDfH0zOWcjH/Ky
         ibh6C3e6yE4XPrjYkA83xQ3VwB+DdIfoXcsZdp+R/B1GtEQ0n7yOdwFg8Z5Qc5OhCGOh
         CgBi1delpgVNJ2nWX2JdUMrRe9jVNDbqu/8GlySFm8ykrdkC1iheW71OTFehLwUzpVoP
         wf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781057111; x=1781661911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a1oKhnq8sAcCQ1/AgmLgq7v5eloi6h0buEgHTVAGai0=;
        b=tZpAU5FzdVSOp9V82uW2UXsnWhreY/rLBtjqXn/rV2hrbDytXWDzVLsKsSaBTL6B9W
         xU+QtfljMCQREhuUmRHUrAjbvoBkj6YnxpmDLIOIhGPGyMadgKTGh3YUAlX80hj1pjgD
         zNmNw46E6YT1iGUxJHBYqRRyjVu8CfQAbSVYlD2LR/M0Y0vaxRC4ixXgSklO+9Qny0Zb
         mdrygm2P03/G9Ri7LGIOYx3UGAa8NFeRN/SkWGvEd4UDS35+N+ZxMjx3z33cRMjTjKcR
         zvoVyGj+2GE+Bl3yF7BXLtyx4RxIae9nQgPptbK5XuohdkA7PNmM0GE55Pfe3inCnZe+
         b1/w==
X-Forwarded-Encrypted: i=1; AFNElJ8t5kdD5IpcrKnnD1AMIvJcf7ahrEbdmWRuBoe/IEoyl602imjJFAR45VVMaWsOxn6mrc/jvABB8pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypr8TSt25tANWyKMu31FkFV+NOgh68edNnvP3zUR9E7SBGTCK5
	HeypBjhGP+xtPPf7pboG/aF17+kP2O5YiQxGZuHrpFCBUR9MayfSpeLb
X-Gm-Gg: Acq92OF4eZuvDhEp9DFhCywYmKGKX3BDOrWaDQKZPA0oCRiUOS7MJTRqBS+BLaadIKF
	AYR10i6r/kvk3QtpFyGGoKVXgMTbieON3CF+i6om5Yt2dclp1KrjOS4u0p0b4wVbOJUQ2fXpigW
	PoZLbGtjKDNFm8sb6V8SiDSLOPLt3HYECOUJnWGlJ/Gdms2Hp16S9DEmltQ/nZvHguP+K6B91bu
	cY2G96ISqvUIIYsDU7onG04VAFbIVrGOzPPcxDElnEcXldOS3Vkd9+XZ37KTvSTwjDR4rlJ5Ow1
	BosJ/+aqxmTnyCwAFKWjJHm4RP6b89zMOsYFZ8lafi9qfFhhTWk0yCEn18Gga21TXm0ETWFjw24
	fTcKL1ripfLl3bTVWfq2DZNd/B16FR6+VIjrJQ9g9OXrWI2/WbhIJW6vfBOr6id2cxEicz8b89k
	8tIV735z9oIWJnvWt7GuqXE0R05mOqMpk6XHInkO05t2iUTng=
X-Received: by 2002:a05:620a:198f:b0:915:5cbd:1d96 with SMTP id af79cd13be357-915a9d60cecmr3704954885a.33.1781057110535;
        Tue, 09 Jun 2026 19:05:10 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a40d566sm2267004985a.47.2026.06.09.19.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 19:05:09 -0700 (PDT)
From: Louis Adamian <adamianlouis@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Louis Adamian <adamianlouis@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: pressure: Add MS5637
Date: Tue,  9 Jun 2026 22:04:57 -0400
Message-ID: <20260610020458.104818-2-adamianlouis@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610020458.104818-1-adamianlouis@gmail.com>
References: <20260610020458.104818-1-adamianlouis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create meas,ms5637 devicetree binding and move existing devices from
trivial-devices.yaml. Explicit compatible strings are added for the
different sub-variants because each requires different constants for the
second-order temperature compensation formulas. Previously, the driver
exposed the generic compatibles for the ms5637, MS5803, MS5805
and MS5837 families and applied the MS5637-02BA compensation to all of
them.To preserve the DT ABI the existing compatibles are retained and
mapped to the -02BA variant of each family (ms5637-02ba, ms5803-02ba,
ms5837-02ba).

Signed-off-by: Louis Adamian <adamianlouis@gmail.com>
---
 .../bindings/iio/pressure/meas,ms5637.yaml    | 87 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  | 10 ---
 2 files changed, 87 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml b/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml
new file mode 100644
index 000000000000..f17ac3ffefc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/meas,ms5637.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+title: Measurement Specialties ms5637 and similar pressure sensors
+
+maintainers:
+  - Louis Adamian <adamianlouis@gmail.com>
+
+description:
+  Measurement Specialties pressure and temperature sensors. The MS5803
+  family supports both I2C and SPI interfaces. All other variants are I2C only.
+
+properties:
+  compatible:
+    enum:
+      - meas,ms5637
+      - meas,ms5637-02ba
+      - meas,ms5637-30ba
+      - meas,ms5803
+      - meas,ms5803-01ba
+      - meas,ms5803-02ba
+      - meas,ms5803-05ba
+      - meas,ms5803-14ba
+      - meas,ms5803-30ba
+      - meas,ms5805
+      - meas,ms5837
+      - meas,ms5837-02ba
+      - meas,ms5837-30ba
+      - meas,ms8607-temppressure
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - meas,ms5803
+              - meas,ms5803-01ba
+              - meas,ms5803-02ba
+              - meas,ms5803-05ba
+              - meas,ms5803-14ba
+              - meas,ms5803-30ba
+    then:
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
+      properties:
+        spi-max-frequency:
+          maximum: 20000000
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@76 {
+            compatible = "meas,ms5637-02ba";
+            reg = <0x76>;
+            vdd-supply = <&vcc_3v3>;
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@0 {
+            compatible = "meas,ms5803-14ba";
+            reg = <0>;
+            vdd-supply = <&vcc_3v3>;
+            spi-max-frequency = <20000000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 23fd4513933a..a1516ab50a40 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -232,18 +232,8 @@ properties:
           - meas,htu21
             # Measurement Specialities I2C temperature and humidity sensor
           - meas,htu31
-            # Measurement Specialities I2C pressure and temperature sensor
-          - meas,ms5637
-            # Measurement Specialities I2C pressure and temperature sensor
-          - meas,ms5803
-            # Measurement Specialities I2C pressure and temperature sensor
-          - meas,ms5805
-            # Measurement Specialities I2C pressure and temperature sensor
-          - meas,ms5837
             # Measurement Specialities temp and humidity part of ms8607 device
           - meas,ms8607-humidity
-            # Measurement Specialities temp and pressure part of ms8607 device
-          - meas,ms8607-temppressure
             # Measurement Specialties temperature sensor
           - meas,tsys01
             # MEMSIC magnetometer
-- 
2.54.0

