Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C373B5306
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788267956; cv=none; b=QGHAT/jTmB9H5UN1q4vG7uDdEPQqbvVR9lAls5Vs/snN9JTz4IWIDMKM/PVBPl4e4xaMVBfQyBELqjlPxGExqw9fs+HdcV1s7svVp9VRC77on7VG+W+B+1Vr4IytalEEF+RJJOHyr57Qaddz1jDKoWU7WlVB0DNjPCVc+JEv/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788267956; c=relaxed/simple;
	bh=koUYc8Dq9lWw1oLPJynOIZpYM8lkDBbSyMSmWAIup4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZC0zz6IaT384PJ5RlQC0qdHqeL63S6wVJOstnUHgFDl99dfGRUvjQCO72f7r9U0pJtHiVi/EukA8UhkfC7xmRjGvR3lmsI+PjFf2nNLXDINPc1R9wqGeozWTjsp9FN/MGie72tS+eNlhrvA3R01vUW+7jusq0QRrB6WifBDs8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W87n/+rT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W87n/+rT"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so47452615e9.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 06:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788267952; x=1788872752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rw9tIl3/QFpv/y5nx3+oqZIVRAfzeLzBB+R0xa6GvSg=;
        b=W87n/+rTWKj+ZK8KaUq9pB93Z8llvenHW8dD6igD0G5/nheuplrilsOCLgqb3TaESM
         i0NRj2f6+/1sLqOngQ+LW0zncphdP1jLMmHmiAoKsTxfGPrLFzl+uii5JytYQwzn/uyF
         R93T2jWXGwah+IhnkJA99qSbKdklo4A92ZKKIBJVkiyUaeayrX/VBwXmXSS7uf4l2REP
         OF5j1NPEpG2x/HP/1i8vL9VTiTMd9TrAaR4p+eOZIaBa0yxv0juNLFxggP6PXR2Jj33P
         /MqqWR4fXucjEnxv1zU/xPhpJnrnGTQHczW+W9hdNbmHbdEJMqhDiZXS1qTVHT9ZB7/N
         bNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788267952; x=1788872752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rw9tIl3/QFpv/y5nx3+oqZIVRAfzeLzBB+R0xa6GvSg=;
        b=RIcsQDWJQee0Nnh68i5W/3t4jAxn8EOSPNdYwYQBWiGPnWOEYPkS7YyT34khpEnn3N
         AjWRcYHt0Pxno5kodZ3OQWydeAFj5Z2SIBWsXjyNn0roBnVKUIs9UD3uc+C8Egv0rnDV
         q6vVHVbCoz44oVZjgzKOYrxRZiCVVLneU1aoQ++fyxxHjCCktgs1jia11n2zeUJvrJ6E
         EwhaH2t0EFyfYGggD0Vg6VdZSq9LngdVjZXkaCQSz2BRUtfBKe95VrSGhLw2DK8a3eEe
         Q97Q/CBU+5GsgscOw1sFrW5SkYgdtshdZt1aDWMzwjhBwcm0npqyYsgpG124K//+d9lS
         Kdag==
X-Gm-Message-State: AFuF++kmN8RBn28eTzMlpbP3UDwF5pxDXFjBbC1OMbN9DvA+veHSk8zi
	sIN5FxnMlwPG1968z51FEKGchAd5fXZOrmAQCFW5RhyGMh7Dm9iksEs/cGMQRw==
X-Gm-Gg: AR+sD13v8Nds0950xZJ+v/N1Hs/Ld1PlFSe2EGE2LOT75mME2MzzR3YjZvRV/i6AiS2
	VpfAwBzMAj5mkvvp5cPwaWTBZDqCzMOGME6U2EjqwhGQB1kcEtJpe1OgXeiuNVhLIYbgDtawR9j
	U7+YGseboxKcyqpTByTeSs+MZuKnPjSjI+OaWEiFyt51cG11en0jCE4IIjC7Ny/1lnOMKzJ6t0S
	cmbNzUEhyQI+rT11viUeGzH3U5yLiOjb+d5bxH94/3tb64Cxc+lqJTcBKLoZ3i/vKmUDuNVvj7/
	D3fqVtA67VApoT29ucZw5XPJ/h8FR/xwY0v8jE144jnUM0+TYIRwNAOAiRIAKx7X41gxhRTWsVQ
	NGApU8G9L+LniDQaEl4jN4Qn3MkSFXJnu9ovH5gIfcdzSYl1S+a9El5l4+U1Ztg+w8cOaMSiNNg
	Jc2DyZVHD6lZuWnQA6sdDnWajF1ZpWgYLoJglvFNBDF34jTWvbcCFmDnfSJ8IPASUk9H3M30dmB
	/V/70vaju9CNUU=
X-Received: by 2002:a05:600c:6091:b0:49c:d60c:74e0 with SMTP id 5b1f17b1804b1-49cdc44a420mr161400875e9.13.1788267951549;
        Tue, 01 Sep 2026 06:05:51 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:16d:f647:6bd8:c024:aa73:750e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce3e0desm70343395e9.11.2026.09.01.06.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:05:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Sep 2026 15:05:46 +0200
Subject: [PATCH v8 1/4] dt-bindings: iio: light: veml6030: add veml6031x00
 ALS series
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-veml6031x00-v8-1-532cb4f2168a@gmail.com>
References: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
In-Reply-To: <20260901-veml6031x00-v8-0-532cb4f2168a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788267947; l=3140;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=koUYc8Dq9lWw1oLPJynOIZpYM8lkDBbSyMSmWAIup4w=;
 b=711sO0S9WECBjJ08DY/DYs9MHzPF/L1+ENIFdzthOPldIfuEO74ygU1WMyiYJixiYQMYt4sgC
 9V8K6zR6exJDFpFn/SrVzhlzhNHjqR9R15G1C6iIwReV/p4/R/hiEcy
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

