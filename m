Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D34535E936
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780246604; cv=none; b=SoJq21Hu5wPaD1oty57qiRtSI55TO0hzyPZvabhBkjnyE4o/R3+ChFMXgAZ19dejHv9jicJS2hqP3vXrmEjWk9n3usox8wNzMglB2HqvCFnJeQaGffSwMOwMTiTtX9WO4Mq5AtkYYSnmB0yMEeAwxGZLPK4AB8HSTN0IIgL9Yws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780246604; c=relaxed/simple;
	bh=wMgstDTG3Htg8sV956v99iFXbhtolrOjZNrDTHpa1gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CGFSu14sYqeMGIeQc1fxIHoeIvmzGLCbehKt12AymQk3kmMjJZjxORwNZPuamvPNpnjfnBSLyzHlTs5gmaVm/nEhCjhMayoWDesuGaNoX6UtPK/BiEDaJPj6k25jNJwP5gjPkhbsiafm5tpp0AO/UOZDP38/ay+AGXKbotdLO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRT12y15; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRT12y15"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so71194095e9.0
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780246601; x=1780851401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auC75XiHji4m/5c8v8bWvJiaMsYrhK57f/6mbMWrQHo=;
        b=fRT12y15D9Kn0f95ggEpQSeMdUGzISfZ2O6KefSGnyQOISv1e3IhfgXIhmIwAec5gO
         dUTRHRb4648Syss++faNrKwTE8JuIRmte6PqHH9nsM0q/fvZDnIjPDaj8CLraksEIe9J
         3aw8meNGTUfjNWbw5VeV47rbLytsp5jInoEYgrsCxu081TFipDJlYP3rZX/fbHEm+3aT
         3bvCznBUyOMsDSzCca0bLAHIbz8dKsWsjbg/JqHhDn9hUJSnatfuZmcAxT753Ljfl4ez
         E7ngxmgkEwlOv7ojFMg7rWmMns1YFlQMtwnStVOI3aDsqGedkwrwX7oRJVfoTTxBz4wd
         LVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780246601; x=1780851401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=auC75XiHji4m/5c8v8bWvJiaMsYrhK57f/6mbMWrQHo=;
        b=YboBQDQTAPOkKgBU7UV4DRUkKPUKpfOvuZOUz9xwSipnlXuwxK2mvPT88/0/izQLqQ
         4RO2jRIWnhpYF9X+/79cK+QRhCbO/z+ZvbGgJVkLmgyJHkglbHPq+w5WKl68V3aIep7r
         nLfHyvT4UBmvQxrdJ6f8kO66IsP4VOTO6692E1bHjhGzdKu2qDv3LZtB3121bZiSN9QS
         Fez7P0Xf9pQ4rOJVxqh9H7DYLZxsTs6upLqX8B09Qtm5DNkOEsLdy/Eqe0UCJpSn7pC6
         BStJI5VpnmoaB1AFIl8Keb1PX5oYqwXVrWtaBf8fncesiOLtrh8rriOra+ctqsc1avMA
         mcww==
X-Gm-Message-State: AOJu0YyVDyPssNFHjN8DmIz/c6enxcbOvEqOKOSsvo8XJ97mfPPZhc6S
	53lr4JnXD1kzL258whqENxiLtrk9EvQpkd+bEVoCW/+ruIOlZesWsXpr
X-Gm-Gg: Acq92OGXBatuI8aNuysHDrQncMqwKcLBvWUBsXhn/zc5oa3gFiC8oUiRJbHqTfl6i1q
	qAYouahGU5j7IQ26Xgb+ypBba74DjDONg3+d9L0BsQlRbMFI2DZjws7fjhVOSajq7Wsg0QErEk2
	KEcQhDjJ1q8z/liuT7PuUb68ezzMwZv8M91Bmpx+CSEzIbNe6OSd5cxCcEL3AP94zjho4YAI/P6
	m+drvmnH3TeG8/Cdzv771xCm2Wcd8TMuAdpU5sQlNcp/KqYwqnCtJdBByylqjjDlBYvuoPvDHDH
	Byl1Do1xod1xoFeKIb+fhPrlORpBDn96jbgROHRVtvEQ5K514ryQJ8RHFJTdFFp/WbsT6dlr2F0
	WzADW3Mim2JW4FpO7iODmhkUIrfaFm9HVRQwRv6iXsZv5UGQfQ3ZI42jgk3g9ng7S/J+8GoB9qD
	vd03KwrsWWFuTQL5gq1Sa9WDyFYple/izeSCrc1mz2BdgF/zh1YKIEnwB7rqg7p2iu+Dgn/E5Fu
	Vo6iZbwwv/ay9jbt7PGCrfqLqkY0F23/xmVDpXt8L4eaYbjbIwOgiZqHymWrZtWuJwP/ehBFGTg
	RSDY0gPRPynzMHxEfuiQfnyE6mcIuxLTpCGveK+4xhRqC6ccJKEX81I+Ab2Agw==
X-Received: by 2002:a05:600c:3b8f:b0:490:688b:f9f8 with SMTP id 5b1f17b1804b1-490a29513efmr171988305e9.27.1780246600387;
        Sun, 31 May 2026 09:56:40 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09acd3sm57648445e9.4.2026.05.31.09.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 09:56:40 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 31 May 2026 18:56:35 +0200
Subject: [PATCH v4 1/2] dt-bindings: iio: light: veml6030: add veml3328
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-veml3328-v4-1-f9b65d71d917@gmail.com>
References: <20260531-veml3328-v4-0-f9b65d71d917@gmail.com>
In-Reply-To: <20260531-veml3328-v4-0-f9b65d71d917@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780246598; l=1857;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=wMgstDTG3Htg8sV956v99iFXbhtolrOjZNrDTHpa1gg=;
 b=erugobMBDiWIWTtcOd5ctWM5yy/wrv4C2WzYpqns7UQHsWsK6m9H1HFgHDxpU8NbQ5GnGs75s
 zx9hdDduGhpCE4ixB/TrLwc1GJ0Dv/qpVRvXd3/pJsm1hZ8kjSrp3kh
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Vishay VEML3328 is an RGBCIR light sensor that shares similar
devicetree properties as other existing VEMLxxxx sensors in the
kernel.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 4ea69f1fdd63..0041e1db6838 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: VEML3235, VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
+title: VEML3235, VEML3328, VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
 
 maintainers:
   - Rishi Gupta <gupt21@gmail.com>
@@ -21,6 +21,7 @@ description: |
 
   Specifications about the sensors can be found at:
     https://www.vishay.com/docs/80131/veml3235.pdf
+    https://www.vishay.com/docs/84968/veml3328.pdf
     https://www.vishay.com/docs/84366/veml6030.pdf
     https://www.vishay.com/docs/84889/veml6035.pdf
     https://www.vishay.com/docs/84286/veml7700.pdf
@@ -29,6 +30,7 @@ properties:
   compatible:
     enum:
       - vishay,veml3235
+      - vishay,veml3328
       - vishay,veml6030
       - vishay,veml6035
       - vishay,veml7700
@@ -79,6 +81,7 @@ allOf:
         compatible:
           enum:
             - vishay,veml3235
+            - vishay,veml3328
             - vishay,veml7700
     then:
       properties:

-- 
2.54.0

