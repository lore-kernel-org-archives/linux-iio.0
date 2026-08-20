Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473F4476054
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235307; cv=none; b=TQN5Uqzlx+3/FoZDXyT1onWohUGU+a3XfzP5sPzpME5Uu3PfWCrNLkCXf18nVuFZSduHzOkCOCyuy2m1fetPzkGIxEuSHw66itrsJouyWLAMPBQ1n7Oel3X9zbSbgl+zmsBa7Nikw7iP4Wc0bwtbU5TsDC1c9J0bAqNLFo7Gznc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235307; c=relaxed/simple;
	bh=fobC2ACicWUtS4EVSoqMhRTIFqc8DCROa+NXAsIN2vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8JoMSqrcHVXZvEyObNgvKDpURww042q8bTMZHHQipWE0wiNcdCVFeuybhTBR8GIJiZNE4PTtvKID0EMFpPENGORxJ2HzI3Z6H0mFPwPfTs5GgoO1Bsyrl/li7OXYTGaS3B5YHHIGByc9RYAFh9boNKcy6oPrPoU6dJEOMUT6iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXn0RS2P; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXn0RS2P"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e85499ffbso185780985a.0
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787235304; x=1787840104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bch+lsxb6oZsNgL15N5/ZS8mmmvNTFFa+M0d0DpA7ME=;
        b=QXn0RS2PCOFOrsLRE/OZv2eLHpn4vLr8gRa6TfY+fVZwZq6kGgW3cm/xs4AWRu5gwF
         8J6wYET9B5GZ5ja40UwmernE4Ywe0w65Yl2dQlUiiz0T55PvnZaUH0zTDmAWClo/YNOs
         wpo/5uPm4r0d3+Wd83xbilW9hAdjbJUy68ETBhmkg5QLWo5FNOi+iOGxBmp9Ie7DJ0Hn
         LC99lIH67F8ULz+lcTBlSxQJHxtytch54ArSPW9d7IebjNXEelHdgoRjEFf0CQsGOelx
         apMKG5Onj0QVlZKtSUGgINEOqXEeKegkojuw3EllCOdCSF4PiCRAvxXoAq8JmJ90UD0i
         4Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787235304; x=1787840104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bch+lsxb6oZsNgL15N5/ZS8mmmvNTFFa+M0d0DpA7ME=;
        b=Ri8UnBc0Eeya8mFaYPhzzsxP1yyMHB424vDWesOGOHCktTP+A8neV8ga92sYm/jfNI
         L2Uhm27UpIJMZgIv+Ei17juwu1llAE69paXNOS0TvszrBIOGPcBbcZMAvG9PDEivuh+r
         3ZM2I8FWa+Vx17K9Zo0U/oF3g/XleSljvDGqjNTYZHVnfNBOPuCDKmilgkRezkYD4Pr5
         d1/HWHMjUVjYWkL8J9q75MCXodOK17fKnig+WMlihnxwYmZLMHgdr9UZanVOJWjWQ+CZ
         kq33vJgElW//nIuORVbxDlnJo/xUg4zSRgM8D8vZIdfcaDYiFukH3IHMGOTAPdh1Qdlg
         N3iQ==
X-Gm-Message-State: AOJu0YwMQCsXnW/YOwrhcmw2GkzArmNWUhn90488E7Yl0UauSDoK2i51
	4qYkrK4VNjtFxqITJs0fzwDDSB7PvhrP4dXtfxpu/aSdRXRY4Z1TLuaz
X-Gm-Gg: AR+sD12HwdAtdCIEFZ9MqaWOczmWll2RGjxTAqdeQeymXWklIJL+eO2z4B+L//9IPGp
	lFGyc1qcSPAsPpk83T8Unj6xwKR8Mh9nTP6sXmPtXi4VD2HM5zu6wIPUQD3AN4Fjsl3WTc6XLeh
	aC/tnJvF0MrdxLgC5baJx2n706B3uFA/QE6M4pff0NvL3SWXqC3d20Dcj8t/hLEvSe48B3TU3P7
	8k+2vXX/htnOXAX43mKQfe0awog8bA/Km/L09GqPbfn+GI0NtUWH0xavg1cF02B/YTjBRs1cDh8
	ZcL2eYjoL3qY88lzMI/nkfpB0QTk+2JibIjjl4uh+SPiIiAXFVdQdZQhIjlr/GcovbgkFckRQrQ
	fb6Trs8d5sT9eIg+0wyWcC6/ERgXKXKRbU2aJWD/cTXzro8eoW3bvcugBMudaaSD2QZJTuNrPZa
	C6fAudTW9NdGXTrBe8CCbWweh5FyW0WvWySwpAFo1dVDd4Pjdp2opHE9lABzse2xc2iXhQ7xbwY
	w==
X-Received: by 2002:a05:620a:630b:10b0:937:2760:deb9 with SMTP id af79cd13be357-9372760e7a1mr619301185a.23.1787235303958;
        Thu, 20 Aug 2026 07:15:03 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9372059de87sm372738085a.47.2026.08.20.07.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:15:03 -0700 (PDT)
From: Louis Adamian <adamianlouis@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Louis Adamian <adamianlouis@gmail.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] dt-bindings: iio: pressure: Add MS5637
Date: Thu, 20 Aug 2026 10:12:18 -0400
Message-ID: <20260820141224.23730-4-adamianlouis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820141224.23730-1-adamianlouis@gmail.com>
References: <20260820141224.23730-1-adamianlouis@gmail.com>
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
them. To preserve the DT ABI the existing compatibles are retained and
mapped to the -02BA variant of each family (ms5637-02ba, ms5803-02ba,
ms5837-02ba).

Signed-off-by: Louis Adamian <adamianlouis@gmail.com>
---
 .../bindings/iio/pressure/meas,ms5637.yaml    | 93 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  | 10 --
 2 files changed, 93 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml b/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml
new file mode 100644
index 000000000000..befd81d1907b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml
@@ -0,0 +1,93 @@
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
+    oneOf:
+      - enum:
+          - meas,ms5637-02ba
+          - meas,ms5637-30ba
+          - meas,ms5803-01ba
+          - meas,ms5803-02ba
+          - meas,ms5803-05ba
+          - meas,ms5803-14ba
+          - meas,ms5803-30ba
+          - meas,ms5805
+          - meas,ms5837-02ba
+          - meas,ms5837-30ba
+          - meas,ms8607-temppressure
+      # These generic compatible strings do not identify the sub-variants of
+      # the part. They are retained so that existing device trees continue
+      # to bind, and each is treated as the -02BA variant of its family.
+      - enum:
+          - meas,ms5637
+          - meas,ms5803
+          - meas,ms5837
+        deprecated: true
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
index 435c4baab436..2671040e8802 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -240,18 +240,8 @@ properties:
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
2.55.0

