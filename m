Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD4848A2D8
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781728; cv=none; b=eSoeF69zCEfKsq0Mlxfall1opYbgO+cp7IYwQO00zhY/mLk/72mcjx4suhB2AYWbCcfK2PFfrhwB7QYQn6BX3SqMx9r6PVQo2cJDHG7uq+8Jks+HHY2ouySbeXpKv60L4nRflH0J0ixqx7sMm06FoGPmtCULsv3yRq1BflBUYMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781728; c=relaxed/simple;
	bh=koUYc8Dq9lWw1oLPJynOIZpYM8lkDBbSyMSmWAIup4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uDMhNYmGOqyPr2ZxFoHNl901aUwfKyYR1yGF9zFh1f6Ct159J05ls6gMLf1sk44kO7Tu8DotedYFs25M0uFBYLxvolCatmq+3P+SNKnSokukPO8OIZX115ChX+dm3OiKTDUHu3zjPL7UtrdKpS+F8aO+UXAUxYlAzrQGe5Xf+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swGf0eJF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swGf0eJF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48441a2ba14so3035646f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 04:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788781725; x=1789386525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rw9tIl3/QFpv/y5nx3+oqZIVRAfzeLzBB+R0xa6GvSg=;
        b=swGf0eJFmiE5IrDGTek6g33CyneOMdBx161PB+GbvaZJsa1D5sCypbFmvMlBwk2krk
         86eL8optMZmmBZ6SsFO7QgidM6E2L+FdWUTIGFwIuNrQSt1TDa9DXCYAjqSZ8CWvGq96
         yzoZfcvYb3Ozdfju+TtYGmfWHTEeQyNHQNnilknMBoIcdmTEY4BGpme9mguNTdiE/v5A
         3TPHKd7LTcdojuruBbDRmYh8fPaCz4KGCGqWs40oynOb71fYd65PZ6ksFXa9X89aGvAe
         7AgiRLeDZl7VTjS0a0JZWZKEKT8AtoomhZOI4cy0W33YRh5TgNbSX3U9qvl2qYR0Buza
         1A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788781725; x=1789386525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rw9tIl3/QFpv/y5nx3+oqZIVRAfzeLzBB+R0xa6GvSg=;
        b=PLy+PGanZSUpYsJYL9Rp+jIDl5VXLqkqF98p06EBx82809AoPSFroIII0Mv9lxa98l
         1xz/e08SAslx4UAQnbxWJL5q4+f9YDBlcts2H//l1Cbq/58ygFHYowGr2j5/CJBwljwr
         2F4F64SIAJyJeMhh+eESjr5OiYjZQJaSGnSlD1lE8ffe0tlpSUaI4vhw16yIMcbbFyro
         BQtpBZ0a6Shlsz/pAI3PFp1fs1PA3XyBv11ddB2pDVcw/Sk2URovFM4/zyQclebadLhG
         6WLmlqvKRwdRZnLYqmZ1vOhCMDCuQQ8huOAxXq8W2xyl776dUNYsHTKbE5T/KmjNYbfD
         8g6w==
X-Gm-Message-State: AFuF++lcHLvZp3cbBEeLxRfn/O3wCY3fX8rkb3DFtjplIf9LzzRQF3rk
	m10lOhOnIfe0ZfxNiQ0fh7C+b9yznNWN7TluVj9gN4FQh8gAau+Gb1/p
X-Gm-Gg: AYBFou0DT7uot22cJliNZM9szQI2mE6BmBa8GXRX39a4CKqGdiYwYkdfj7yC+E1AVk+
	V7VyJUSVltKI6b3MkpgLtBU0w72UwB4DVXfp/h2Z3t9KiJVkckh+WsU4DSM3C6QHnBNRm4xre3u
	6vaIzCOvzGazFam8VsZfDu3WqG6JPSxYFRPI6AH1txscbAW8jYZiJmYZ0VD7gIlkqPpkKIKXis7
	jPadEJ2d9jkk0yABzwWtbG+ygVYN8PFobJQpH2JgRG8TUxxs7p97ldOrjfT1ECLaHHjIq9g1n+L
	V/uJ++ddiwta4lfTEzTdeBFqa6G0P6x8FouHhnmmVjg/88bd+ApBSF8WV9Ec1Cda7FBOddCSi+V
	aIbMinPn9RANlUWeEoIaYtnUCk1ie/jxOqaFQTu2bb3XsVsIh0GFoSho4QEs6zVT7zF4zLZlIDO
	J70CgcKKuAwW0T3a3ZR3pGd7hcUcwumV8GHmvCqzo4mPHjsF1gOunyqB3Lc1nI5bKDxgE/qgJeb
	yIw
X-Received: by 2002:a05:6000:4a1e:b0:482:f0dc:b4f7 with SMTP id ffacd0b85a97d-48587091b97mr25343836f8f.4.1788781724964;
        Mon, 07 Sep 2026 04:48:44 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:178:2f30:d3da:48f5:116c:5642])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c5bc5sm29597421f8f.24.2026.09.07.04.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:48:44 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 07 Sep 2026 13:48:39 +0200
Subject: [PATCH v9 1/4] dt-bindings: iio: light: veml6030: add veml6031x00
 ALS series
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-veml6031x00-v9-1-8c93a6c66a4d@gmail.com>
References: <20260907-veml6031x00-v9-0-8c93a6c66a4d@gmail.com>
In-Reply-To: <20260907-veml6031x00-v9-0-8c93a6c66a4d@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788781720; l=3140;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=koUYc8Dq9lWw1oLPJynOIZpYM8lkDBbSyMSmWAIup4w=;
 b=I8KOaew5Y3C4NAz38zM8zmjM3wQWdKLTZUK3KUULJRWZyKUyQmLO7ekmyOxIyRmC/BA1oB/DS
 Q/e+RwQ0oySBN9KuXlyYNg80Cm3GuZ9lG+Oz0/c4nPiIDtmQZXsPH2u
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

These ambient light sensors share their properties with the ones
from the same manufacturer that are supported by this bindings.

Note that only two datasheets are provided as every one of them covers
two devices (veml6031x00/veml60311x00 and veml6031x01/veml60311x01).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/iio/light/vishay,veml6030.yaml      | 13 ++++++++++++-
 MAINTAINERS                                                 |  5 +++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 0041e1db6838..a44de649184a 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -4,7 +4,8 @@
 $id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: VEML3235, VEML3328, VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
+title: VEML3235, VEML3328, VEML6030, VEML6031x00 series, VEML6035
+  and VEML7700 Ambient Light Sensors (ALS)
 
 maintainers:
   - Rishi Gupta <gupt21@gmail.com>
@@ -23,6 +24,8 @@ description: |
     https://www.vishay.com/docs/80131/veml3235.pdf
     https://www.vishay.com/docs/84968/veml3328.pdf
     https://www.vishay.com/docs/84366/veml6030.pdf
+    https://www.vishay.com/docs/80007/veml6031x00.pdf
+    https://www.vishay.com/docs/80008/veml6031x01.pdf
     https://www.vishay.com/docs/84889/veml6035.pdf
     https://www.vishay.com/docs/84286/veml7700.pdf
 
@@ -32,6 +35,10 @@ properties:
       - vishay,veml3235
       - vishay,veml3328
       - vishay,veml6030
+      - vishay,veml6031x00
+      - vishay,veml6031x01
+      - vishay,veml60311x00
+      - vishay,veml60311x01
       - vishay,veml6035
       - vishay,veml7700
 
@@ -69,6 +76,8 @@ allOf:
       properties:
         compatible:
           enum:
+            - vishay,veml6031x00
+            - vishay,veml6031x01
             - vishay,veml6035
     then:
       properties:
@@ -82,6 +91,8 @@ allOf:
           enum:
             - vishay,veml3235
             - vishay,veml3328
+            - vishay,veml60311x00
+            - vishay,veml60311x01
             - vishay,veml7700
     then:
       properties:
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..57202b51fb66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29095,6 +29095,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
 F:	drivers/iio/light/veml6030.c
 
+VISHAY VEML6031X00 AMBIENT LIGHT SENSOR DRIVER
+M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+
 VISHAY VEML6046X00 RGBIR COLOR SENSOR DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 S:	Maintained

-- 
2.43.0

