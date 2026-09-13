Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FC539D6E7
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789301924; cv=none; b=LzjJX2krnisg2fjVRKbJ+DrFgFzzX/kCJ7d1TuxlNuFXXk11Mq8vU0NMINDiMg+XM4j+7cPLQ+i5GCUeRa7oZ0pMks7+itTqxEeOUhaiQC+Qwy4GvY9Bt9Wqjd3bnEjjrsl3qaIqtx/G5MjMGsz+KGNszzSXyVrVG+DcbncMFOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789301924; c=relaxed/simple;
	bh=koUYc8Dq9lWw1oLPJynOIZpYM8lkDBbSyMSmWAIup4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VFc03+5lUJdXj4ANWOwAEoUhLZ40qqcu5P9bA0PS9s3GBJNgWsQqmHL+e4JTlhK1x1PF8nl/eI/nEPexkRU9lQdIbFazM/4hIkC4LvXMSRyTGMHhGM1HknXq1zHBdzQo4y0LLmn0nLsaIy37Xixirz71Mk7gPNeaRDeVDOf0TQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCG5d3Oz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCG5d3Oz"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47de0093c42so2300683f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789301921; x=1789906721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rw9tIl3/QFpv/y5nx3+oqZIVRAfzeLzBB+R0xa6GvSg=;
        b=YCG5d3OzyGdCUlesuTMbJTKpy6QCIn7v0+w8PR0TyRyV/+RCZMuknh1n48vNOwznRs
         HpQixigQcvNH/aIH7T+PHhuFMFZ3Yb/GNDoHMYvQ4kzIP2NC/3rhXc4s/dtnDncIPAMt
         MaVDRsWeZENTLXFaw6zt+u09TVmdEC73h2W5EUOU7Uz1V0bLrwnHdkcd8/PNk+6byvDh
         uWi9q2xba0nAZIhZeb2AiPGEduQ2/oHnUhupgqkI6mWh2G4Tr9sMsL+3V1XKGm2XzgDa
         zWGZLOGS+bWyZreDYhNNA5w8mOqcqcCym1jpZ3rAdeQwCEcjy51jgrkXoI41SJ+KD0nA
         veuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789301921; x=1789906721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rw9tIl3/QFpv/y5nx3+oqZIVRAfzeLzBB+R0xa6GvSg=;
        b=StaeJWqwN90uNjFFVCly5eo2JzJzDq3CDCMF7hBnyc7pzOg9zOP1zWiXLzUja+xW5p
         CRgcudjNt6mDt+5ccnuDfTPVU7eUUqaPkIRhe8335XCUV77FyMcr4LjRZO2erHUhpeeQ
         Z2AUOUeBKtQ2PkwJTDiN5SM3+KyONTpF1bUYap3k9rkP51TlkYVqxWCu+fl53NbYtnCp
         zyAzTYvYzhfypWuArEWE+CwWHhYOBxHLC7d0SycCXZV0NGAAV646R7MWWPeoJ7TXK8ff
         cwB3Xhj/gdqYZaNuRrPaIrc27KueQ2JUNIaZ7Uyjfva5/4ne+OA9id1XwfK8H1u57orn
         Uh3g==
X-Gm-Message-State: AFuF++m727X/9UoTpI5bJH7a1INWzFncfPAYPPFu2RaY7ZUiL6eX7ulk
	D8FHbFSCkFL15nT7DVMYQHmm7D1Cqyr808E17zW20Q2Sxcze0a/g4E/I
X-Gm-Gg: AYBFou28nR8DXScOU59+4a3G5X8q1J3i9OZzUE4M0ZM+67b76jJRltW3ZyW8o5jVBSu
	uQONs8pVOlK79eNj9BZElOHQIVFbvTIzzbxxnmvOEDsvmY45/aWDoepSx30cttJn/cE7Zy90loM
	4JsxFfnTWksz4LT4+E2I+yPHilBAh2N2M0tbV+8J4Laa69GmZJ/1hmDuITMvydWNG57iaTsRJO/
	BHdxdmAV6vdx4anvZ7n1DawBrIWysaVJM+jJvH3jIyo5t39goiEneijpa2EBsEKtxu4TNX2Vgur
	hj0suRB4gxiEUmlIRfP9E29Tchf2aQHMIv9DmKd8lJJocBBblsBae/+t8clLrpPjwhhaAWKEflv
	X34kcFBeeX1VM2ER/M6f+5qynnGBaTKTMJJDgt5W56EQJVqb5MLo6qyfiXCFkSXVX3H/tKSSgPn
	6LmUez7VqUKeWqxSfrGugzSjKQxfnkW3mjOqz/iRwmekz3C58uNfS5AZHWhu3aKElEaubbFG9S8
	7cgiC7/Od5292M=
X-Received: by 2002:a05:6000:389:b0:486:fe82:70a5 with SMTP id ffacd0b85a97d-486fe827223mr1200808f8f.16.1789301921174;
        Sun, 13 Sep 2026 05:18:41 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:107:bfd1:de2c:7b4b:8652:b761])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecf2esm20241141f8f.2.2026.09.13.05.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 05:18:40 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 13 Sep 2026 14:18:21 +0200
Subject: [PATCH v10 1/4] dt-bindings: iio: light: veml6030: add veml6031x00
 ALS series
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-veml6031x00-v10-1-adbc26c30d3d@gmail.com>
References: <20260913-veml6031x00-v10-0-adbc26c30d3d@gmail.com>
In-Reply-To: <20260913-veml6031x00-v10-0-adbc26c30d3d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789301917; l=3140;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=koUYc8Dq9lWw1oLPJynOIZpYM8lkDBbSyMSmWAIup4w=;
 b=31pPxfJ9k1dltUb1YNVk9Ckyljv03EUkaN0ugq2uqUTepqkmFP7x5tOVBp5xYkqqgBMxY/6uV
 ozy7lztO61BAI8UUwu8TwMmVTZwKQL8bWb2/nBm1R3FJVGLSJwWzDi/
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

