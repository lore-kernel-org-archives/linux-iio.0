Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990237756E
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778968267; cv=none; b=C6bpdKGebL5UE2pqUp6V6st8GPaXAx1gqDWbcHI7TSO0WKbrZZ4Q/NQfE4fsD9VlCYUV9o8Ea68+u9LHiJta2redzBQ4z3W38NjziMsFpq75SfdMUMB70yi4QJeQUxg48b2LCy5OK43Kk3NnN9yL95ev8gUO5+hmubLxkoxJZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778968267; c=relaxed/simple;
	bh=tkKwJSzX69+ZLLlj6f/6N0J5cQ65rcLEtHoMvxQDG5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5ndbx7z4iHsedBbMPzN8Swrb9Aus4OlKty0OarThkuTnUFWnMs/dBfUhR5PfOGJkB5qLg9k1OEsewk+1LVkZ+pJd9aftDz+hhDk746hGVvY0q48m/dwP0rmt+n7h/5Rrhf7X6iw6y7sBDoUOtTBhAtv0+BdJb4qsWzjMktVD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSjs77FJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSjs77FJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso15649955e9.1
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 14:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778968264; x=1779573064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzj9hVwXyoEDx7FHjAZ2Q/bMDZ0+nBcau7PpEfZAqlI=;
        b=dSjs77FJvnFrsbnFB9LCnsV1gPY70fOvDa/ttwiO0Vke1jq0K41sVOA/BA8WmNH709
         zcuL7Gj64UOpky8MpMTHRuVxORQUUeSNld5kpi5aC48H7yKs1ewrlnxliwsxCzlIUp2L
         gL7XdhdFP2i/04y1IgL2ds8b3TAW9GX+0Z/V6Cgb4rX9RhFAdQJq368F5QhNFpVdaX0R
         Bibx4VJydyTtLmxlfzzLfXoiHtAUM9DhKikb6OTwN28F5SW0VZ5+1kHOADS64tiNGpCf
         Y6tCFZl+AUyLySGg9YJj1CH/DYAGjlcNezAQerH0JDhaYYMXPPMoxBBhsa3/zPqSCE7h
         IO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778968264; x=1779573064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qzj9hVwXyoEDx7FHjAZ2Q/bMDZ0+nBcau7PpEfZAqlI=;
        b=Pa3ggc1pMqfrTjkCffBCTRkCwMQ4vaezg8qgke8OIS8oTXgd3I2HMYTqQ/ZSgQF+AK
         ulbDtTttlAJWjdjrs0iYUoGdO2LABDNrhBdGAj1juHcB8GnTbf1W/XfSgZVzi5eiHI1G
         LdadCuUEZqJMm2tz9KxaT5jIeYy+FfScQKjop1zypotOe9CYk+smV1Hqh4UJpdLdj2SC
         zCtb2y+6WKaXKktzF7dk4BqGCFioi+WLpXf7cSo/DZu58/uMgvHOosyhgX/OYhsxE2CZ
         fj0AdF4NoREYDXzC7JvBaNhqc+sUaB1ydJcwY1GZ8B7pig6cjjWPR5Ou19tRkFK6JNnm
         qwdA==
X-Gm-Message-State: AOJu0YxjphJTA253b/wVbrbRUNHR+TmDSSFvSegNloSnQVacPRn5LILM
	SF8wNR0+IcGBlngDG9edcjfF9FR9V4O4KYaAPbFSD8xc5YD7lXqzvPMo
X-Gm-Gg: Acq92OHhPND5klwGcs0ApS8jDS176ZeHmuME1UYRlWjfogFfHO9e8Fi6l4tsAnu6XS/
	HNyOhdGwm3Xv5n8gl/ugg49rCP5WxR4VHgnBmBsCYdGk+sHq9HR3Afa00LOd6SaAGVVduuBQGaK
	C3bI0WDhKn4VzUhNBet8wwHUTKnBDRue4tojAJ09lkjT8Zcn4xHhrEjjRK2qnIxstzhxpsRPLbI
	I/x0sO2METOartPOzmxiQ6IvAsvEMb8kLG4EqnHXzX9vfjz4ws/KlOvZWg0lliZTzw0nP8i7Z3V
	yXjbRXi6FicsYdjPEvz5awO6tvvyG5FRgwyJUCsXalJrvBYltuGtn7u1ARiuxu3vPzASD7lrOfy
	0KcWB93a7K2KOP1/pTtxFCA8b3J/0+1DybUOHS2elwhT2bRvDUPCJ/aKsr3SKj+D9WbHwmwfj8u
	6xgMRhAiKQwgZkZwDWhFG2m5cYZS3Gm+aimfWqnth50F0VRATge8eRCAlTeRpr3a+WtAd5wD24S
	yPIUJs9lb4L6tHsJZ9jmoQDyrp7sqE+wmfwAk0L5QLPgBD1LBCPQ794ZQhZTzwO2C1aGhbKDTpv
	p09hnALMyfUm//psAWKR/Mz0gGlhTZxFYdr46PqCvSw1p/7D
X-Received: by 2002:a05:600c:6d83:b0:486:fcc7:6811 with SMTP id 5b1f17b1804b1-48fd635966cmr148714055e9.10.1778968264181;
        Sat, 16 May 2026 14:51:04 -0700 (PDT)
Received: from systembl0wer.localdomain ([213.194.212.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a5653sm25819528f8f.35.2026.05.16.14.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 14:51:03 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 16 May 2026 23:50:53 +0200
Subject: [PATCH 1/2] iio: light: veml3328: add devicetree binding for new
 sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-veml3328-v1-1-1d4b663e2fe3@gmail.com>
References: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
In-Reply-To: <20260516-veml3328-v1-0-1d4b663e2fe3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778968262; l=2270;
 i=joshua.crofts1@gmail.com; s=20260516; h=from:subject:message-id;
 bh=tkKwJSzX69+ZLLlj6f/6N0J5cQ65rcLEtHoMvxQDG5g=;
 b=iEKIzV9vvk2IMuBpyftZWBWLzu3zX2STOBRWsNY2pDzg0kJdG/WEmOHvfsDuWlNlOu0yEKtcG
 PYts8cP2dw8AivI9/Rqcor2qz0wviGGt+j+GOhcw2JnuCdLFge8iRGV
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=d2X8EVKEB2uF4AaPPi3iSSI+IJF3/9kOoDYVVmc+G1o=

Add devicetree binding for the Vishay VEML3328 RGB/IR light sensor
connected via I2C (SMBus compatible).

Additionally, add an entry in MAINTAINERS.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 .../bindings/iio/light/vishay,veml3328.yaml        | 45 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml3328.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml3328.yaml
new file mode 100644
index 000000000000..1a30e8470fc6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml3328.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/vishay,veml3328.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Vishay VEML3328 RGBCIR Light Sensor
+
+maintainers:
+  - Joshua Crofts <joshua.crofts1@gmail.com>
+
+description:
+  Vishay VEML3328 color RGBCIR light sensor.
+
+  The VEML3328 datasheet can be found at https://www.vishay.com/docs/84968/veml3328.pdf
+
+properties:
+  compatible:
+    enum:
+      - vishay,veml3328
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@10 {
+            compatible = "vishay,veml3328";
+            reg = <0x10>;
+            vdd-supply = <&vcc_3v3>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d6c3c7d22403..134690aa9866 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28386,6 +28386,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
 F:	drivers/iio/light/veml3235.c
 
+VISHAY VEML3328 RGB IR LIGHT SENSOR DRIVER
+M:	Joshua Crofts <joshua.crofts1@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/vishay,veml3328.yaml
+F:	drivers/iio/light/veml3328.c
+
 VISHAY VEML6030 AMBIENT LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained

-- 
2.34.1

