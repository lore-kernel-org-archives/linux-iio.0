Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5E38886F
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 04:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647835; cv=none; b=in0J+V6LmRngt0XFUR4yVdABChscdRCpjEWlqP6pOMzeeGBl71lyjAehAgsBYg0NGs69ld6ncIUuo5L32WwuG1B0Mn5qoHzS75DoIV3hKs9hBLp7xpZRUCCOmiCVoWvdyS6Tg65EvJ9/coqH13Lz96wbO3rm4YV1K34jL5Y4MuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647835; c=relaxed/simple;
	bh=+ccVjW/jqDGXe+Kpx9slzAPr+lCSpT3yVLJ5GehwNBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=te0Wh7g1YeCSfnP6s1aD7J4eJdLxWTnHPb/T8NtlmGkvEVrQQgLmx6MnEMXO9OIr+DRBlK+op94yhi1Xf5kLy7O8AiXDXblKyrG14vfzCEfHQTolC2QgrWUBKtbyuatlXYhv2fLL46MqKhLA6RC82wkKJ+mtiqz95GF20zeE9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzEb02HB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzEb02HB"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-83945063f70so3389639b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 21:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778647833; x=1779252633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AkLS3ikcXWyd0nEsg1ckmOLpbRPjWnuu6CMO4iUAjs=;
        b=MzEb02HBErtYTHwwwDgjQSY/If1qJdS8SuLjpr2Qs8q6V2hL/gtbmp/SVnWDYDUS2h
         uBq+nVKkJn64BTyIAP8v56MzwfQS1WsELH8sfaU/055Y6Rshn4xWbETm/4IUKyOiGITo
         JGOJA605uReDyeRbZ/eNboBLVr7hNGhZ9oF4m3NAkqjh4PxyQ6jg4wtWRAM6WDnteY9N
         QH9OArrm1Mnnuqeo2MSa1ALMS4jBvtsIlaWzZb07WhqZIzs1fX7+ODHL+t2Kh0vqWB1D
         IYOlKo27OcwWm/lHfaHHZIq0Etm7nwgDZILGKJg2P6fSH1UhF3EcL5v8n6fpQAZxXYkp
         g0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778647833; x=1779252633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+AkLS3ikcXWyd0nEsg1ckmOLpbRPjWnuu6CMO4iUAjs=;
        b=L2YRqfF3kp08oJ1yXPTJ78Oe58fwlG4L0JTRO+lpJIFldiNEzrK0OdBjZ5YdSsXHuG
         LSe11MnLg50y5JiPl1KBZAt8fzQTDD9Z9K0Tk47IyLxaKOR+lYQRx7cy0C1gFPkUBHfd
         GcvwKEsGNcHKs351LkHGHBXSyj1p9qaGYB3+vOCTMh/fzGtFc2We+s6ASUvOHm+MZ9Jm
         w5TPLwWIfkRmZGd6iWLY2hI1latrjn8MJeKUvaITU0iBUL0qYFS9PwQmt0K07TqAwtQ3
         ZA50qe35/o5pDfk+XRFXRhwYDf/VCf9Dd9pHCmm/bHBEw2uSr8HfDrokY2p/trcGPDLk
         zYvQ==
X-Gm-Message-State: AOJu0Ywd1PGJRfI5E7TSF9D6CbULTgLqKCyn8jS4UUfJ9pQiD244XT1e
	mLeVL2cUa3xqde3z1JEcJNBTtCeoJCVW8uCpAEfpcN3l4CegqcIdSTS8
X-Gm-Gg: Acq92OE2tQQIuDk/rCXwW9DGX55abwIjhJNhdjS9VlTfOXP66Jj+gEBuCKQ424izuXe
	TCHHgQekebtA+AyIPKTgMD3kZKXLte+uGEnCL6qPyMorC4pRdXXKjxm9dEd7zFLeqVvRlZ3yq0X
	gwkpWm2vEpJNeoOUZLMrLT+CKdd9wtNEKDWh2qb9TiAB+kiE8/DQn+M2IRZ39XB9Czi9jabP44D
	by2wfXddtuwZJM8Otkt70vSCHk+sSjOTG8xqRUoS+U2a5dslkBZfFXqwVHR3kOdf/ZbMofFHvkS
	2lUw65xEJhgbXAKzJTVLjxHjJibSF9dvn8KqHmjv3SrNoIBmd84fONPonHcygRx90QeG/iirlbq
	kGPUXft9gRmrGsyKxjWKf+1md2h/0OXABZFOo5pRp/xJoPMdINurYtVqnE4SD/pP88o0d9V22Bc
	ykOy9vGT6pcWApfGXx+cYImLeb0+VlgW1lbB+D
X-Received: by 2002:a05:6a00:2e85:b0:82f:7762:3eb2 with SMTP id d2e1a72fcca58-83ee83ab8d8mr6611338b3a.17.1778647832891;
        Tue, 12 May 2026 21:50:32 -0700 (PDT)
Received: from [127.0.1.1] ([203.99.159.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965c30ddasm32311914b3a.21.2026.05.12.21.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 21:50:32 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 13 May 2026 17:49:43 +1300
Subject: [PATCH v2 3/4] dt-bindings: iio: light: veml6030: add veml6031x00
 ALS series
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-veml6031x00-v2-3-4703ca661a1d@gmail.com>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
In-Reply-To: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778647803; l=2675;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=+ccVjW/jqDGXe+Kpx9slzAPr+lCSpT3yVLJ5GehwNBs=;
 b=EDok/p/DvyVNEPOElCZ4OUVjZIwbNbKHzGBiYvurGsYsbvYh3hhg8Kntf+FBZ58lQbBQpwzYC
 uG1WhK6e1j+CCXI47GnaYWGs1gAtqj0ahFbdkUzTxdvXy5/jwsUMZqx
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

These ambient light sensors share their properties with the ones
from the same manufacturer that are supported by this bindings.

Note that only two datasheets are provided as every one of them covers
two devices (veml6031x00/veml60311x00 and veml6031x01/veml60311x01).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/iio/light/vishay,veml6030.yaml        | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 4ea69f1fdd63..e01e8747e47c 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -4,7 +4,9 @@
 $id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: VEML3235, VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
+title:
+  VEML3235, VEML6030, VEML6031x00 series, VEML6035 and VEML7700 Ambient
+  Light Sensors (ALS)
 
 maintainers:
   - Rishi Gupta <gupt21@gmail.com>
@@ -22,12 +24,18 @@ description: |
   Specifications about the sensors can be found at:
     https://www.vishay.com/docs/80131/veml3235.pdf
     https://www.vishay.com/docs/84366/veml6030.pdf
+    https://www.vishay.com/docs/80007/veml6031x00.pdf
+    https://www.vishay.com/docs/80008/veml6031x01.pdf
     https://www.vishay.com/docs/84889/veml6035.pdf
     https://www.vishay.com/docs/84286/veml7700.pdf
 
 properties:
   compatible:
     enum:
+      - vishay,veml6031x00
+      - vishay,veml6031x01
+      - vishay,veml60311x00
+      - vishay,veml60311x01
       - vishay,veml3235
       - vishay,veml6030
       - vishay,veml6035
@@ -67,6 +75,8 @@ allOf:
       properties:
         compatible:
           enum:
+            - vishay,veml6031x00
+            - vishay,veml6031x01
             - vishay,veml6035
     then:
       properties:
@@ -79,12 +89,23 @@ allOf:
         compatible:
           enum:
             - vishay,veml3235
+            - vishay,veml60311x00
+            - vishay,veml60311x01
             - vishay,veml7700
     then:
       properties:
         reg:
           enum:
             - 0x10
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - vishay,veml3235
+            - vishay,veml7700
+    then:
+      properties:
         interrupts: false
 
 additionalProperties: false

-- 
2.43.0

