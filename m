Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA62314A90
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792113786; cv=none; b=qp7nBzGzXA724Y+EGW/g3FQMklWlcFyMgsdfNsYbQbtHLo5VxchrDS0w0KR3+0b+0r0AsMypBBzu+p2JQHaH69M8uCBhf3h3ZaZxYb8cjPC5aa7rd9AyPY9dO/t/NI++QacwDxSpQmfV7vA/Q3tLfVN7M7gHKyojM6GHLEl3/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792113786; c=relaxed/simple;
	bh=lR1tSuCtA96YAlETO2wgxJDz/NogluZKvBhIR+zMhC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frAnEmJ/liQbyziVgbL1IRtyPLFMYen6z6S+gIKySr08ZRJ1ey3rvjoj7nBl77nBuB908vaghVXsoOGvp+gtyLHdIsoCCeDpW4IftbYPLoMkExMKpcariB0TTd1GQ7A/C4+il2uQqHFSy5VE+N2xKmcJWx4xizfRT5mZT2lcBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAjCujfS; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAjCujfS"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso1377796a91.3
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 18:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792113784; x=1792718584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ojMddD78KtiEJw96nEVmaSGc9IJ9E6LLxgP735UZib4=;
        b=QAjCujfSsjZEgP5u8fyeNnKAO6S+GN3UzdJFVWqI4u4p5mE6JHfODsHSy8uY8XyMSx
         0agyM6sJlkmqUpZAGXtDA3rtOCyqshKyVTpcSa/3nOEkGvYgMYQG257BXtxY9kqAZPTG
         q0GuCztpDrAxlUt5dEGdSbJe4bVikcucd9cHOqJL0wdhENs6CucDlV+KTzK6mTvPKVVN
         sz+cxDZQJ9FLs37zeTsWOMXA66DRNUmGnEMDIEE4EnQA8146D6/SBLvMoOFXwaWJddhF
         HMummmcRZELpa8vzgR4itPweEXJu8EncWbAvn7Kcuz7ltGEOw/PcD9vt+ur74ZaYjGH5
         cMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792113784; x=1792718584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ojMddD78KtiEJw96nEVmaSGc9IJ9E6LLxgP735UZib4=;
        b=RW0gZkpCrPhiz16e7GocmaoMKmuqurW+uH4MGX1t4c81HRUqEWPTu6urh6SJh9PdFy
         LviTZc2qGAGrPimFewolgE1sANPfHqy5VtjI7kdPigvqWXgIMz4/Br5z39gdRl+mrloE
         ga8krAogNQIvrO1+OBq27hUm1NiSDFsgNpuu0DY4SeFmIXFTKeJm4EYYfXzRXUCTrJ2x
         1MX2ZGP8wkVNK55+Z6pa008IoneAm00LlKKAlm8XtFOlU1WyzKmJU0HUO/3wVqz7K2zZ
         tpgb6b4aYE2D82QOkXLlIMx3xZZB0kZ3PQSnbbIHWQjT1RE4ZgVEC17apPaEzy6bwHWw
         PIqA==
X-Forwarded-Encrypted: i=1; AKwUvBxeTabWK5msnSQ4gZhgSibeqx6PmI3xto6clojn+X/UXyNmMzNXbuP6xTb5vZ9KH9oNijt7m58Bz90=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8zOzhfLY3HEjnYddha2I9Z4FBnuMI9FUlab1L7oaxi3PuM3Wa
	3yqydBZuDt2FN5xxJBKYQwWLa9AbS6Laj7WIEn0Tj8ZJ0knSZXOOMMHS
X-Gm-Gg: AYBFou1yTWcipSIipvxzMRrf1ufdkx8SY26nROudQyNCCkfmC+MTBrn+X2o6aAarcPz
	s7DB+6pbR/MIYirbwOTG9MBpfSrO6eJaIddYqIVp2UeYTHlCCQ+INe5q5yBiCjKi721vjwJ6+R3
	R4efZoJGDpWOqy54IMHwoS1qpwovpySpDyo++IaHoo59IY53Q4wcpvVzdP+NRfDScRAqKKS8dgA
	CdI5vpVt8gCCK/fHMbuDQZmtT2qywWUUiXSANywVXz/R0QgxP4GKOEhybbikC3OhH0cZ8Em1Xox
	ZknRXh/eRsgbU9pnCVQMRHQdjsNl8sxY2JIPOiH//FGW/4V+BYFRRkNItmGtFX4MlZz4tqfouoM
	mgBys3v0FbTJGTBup3nFO+p3uWixUd3du73Lty9Cw/au0THH/cOsiIDKmmlIm42+Khmuvo/Q/Mi
	Zfodedh4vRwHG1/Fo9/JqPBzJONdAb2rtPJIwQUVHFjzYcHRlDhMbodt/mcCQQTYdFTaAp/BVhR
	zAdtCss6T4zkZhI/xhxKA==
X-Received: by 2002:a17:90b:4cc3:b0:3a7:bb1d:3688 with SMTP id 98e67ed59e1d1-3aca9a185e8mr2849279a91.27.1792113784397;
        Thu, 15 Oct 2026 18:23:04 -0700 (PDT)
Received: from l (ec2-56-155-112-168.ap-northeast-3.compute.amazonaws.com. [56.155.112.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05fb680sm474327a91.2.2026.10.15.18.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 18:23:03 -0700 (PDT)
From: Liu Yufei <lyf98405@gmail.com>
X-Google-Original-From: Liu Yufei <lyf98405@gmail.com
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Yufei <lyf98405@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: proximity: Add Vishay VCNL36829
Date: Fri, 16 Oct 2026 09:22:17 +0800
Message-ID: <20261016012218.40223-2-lyf98405@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016012218.40223-1-lyf98405@gmail.com>
References: <20261006100943.78971-1-lyf98405@gmail.com>
 <20261016012218.40223-1-lyf98405@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Yufei <lyf98405@gmail.com>

Add devicetree binding for the Vishay VCNL36829 proximity sensor.

The VCNL36829 is a proximity sensor with an integrated VCSEL emitter
in a small package. It is controlled over I2C and has an interrupt
output. It is powered by two supplies, vdd and vddio.

Signed-off-by: Liu Yufei <lyf98405@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v3: No changes.

 .../iio/proximity/vishay,vcnl36829.yaml       | 55 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml
new file mode 100644
index 000000000..6f20537ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/vishay,vcnl36829.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VISHAY VCNL36829 Proximity Sensor
+
+maintainers:
+  - Liu Yufei <lyf98405@gmail.com>
+
+description: |
+  Proximity sensor with VCSEL in an ultra thin small package with I2C
+  interface.
+  Datasheet: https://www.vishay.com/docs/80580/vcnl36829um.pdf
+
+properties:
+  compatible:
+    const: vishay,vcnl36829
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  vddio-supply: true
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        proximity@60 {
+            compatible = "vishay,vcnl36829";
+            reg = <0x60>;
+            vdd-supply = <&vdd_reg>;
+            vddio-supply = <&vddio_reg>;
+            interrupt-parent = <&gpio>;
+            interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f82..e6ef84b49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28754,6 +28754,11 @@ S:	Maintained
 F:	drivers/input/serio/userio.c
 F:	include/uapi/linux/userio.h
 
+VISHAY VCNL36829 PROXIMITY SENSOR DRIVER
+M:	Liu Yufei <lyf98405@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml
+
 VISHAY VEML3235 AMBIENT LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
-- 
2.53.0

