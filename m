Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECCE37BE8C
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311780; cv=none; b=EuG1oWUqyP1WqCuyA/Dp2ATFqpWOPXmP95z103TtkdokwoyyS5CJDp3hGDE3uZkNbH3OL1z3zlO+gLocs0Dq7BnMuBrD2rL+lG3qFQqPjDmqPiflrmAuQEr78VihZJPmVS+9hsvhG5MrLkxY8i6YEOUmFCFFx0DdUOO64Eeft2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311780; c=relaxed/simple;
	bh=1XkYcOKA+WTVn3JK4BNV1oCNe0e+OpnigkVRiFBguZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lq5lZ2z+ABX81VJvac0nhSCTa0DtsIoDdNaifjXiqm3GpxbG/IDz+w+d0AifTsHAdVYipxF3G8Tiny4BveC+aUuSf7umfnQvQ4vHUpvqktKquAn9rc4TNZ5LGFvtfqucmy+JgzikVjA4tsyHv6x0aowes+jR/hJUHVH0sMCF3Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quzjOIeZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quzjOIeZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48e82c23840so43788105e9.3
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779311777; x=1779916577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZst/ZH65PjeWDA2ZWgHjBmvAcSOI8pmTlTBG3lg9wE=;
        b=quzjOIeZJXtWTeeiz3zJjKxmpzNXsjKwMewy+XpfYysV8eW6bjto7D0yTdLYIVtcVD
         Ty2Lc12IJ4SgRVP1mnBFEFZhXjnbpWV91cyDg8WGeuLQmOu6KzAQNvJJ7zhxDmz/TtV9
         VHi/OGVUhPlrDjleQBoeEyk+KGf1FXx+/kN9ynB6D5BqG5LL1+jgFGsyayJ1uBYT818i
         5Alxq7Z1tL3b+a87EGf4om2UI3yrpuQkl8UOOiYNzBY2a1yyVZp1Dg78Qx5YDlc0hVyy
         hNDZLUv/C6czFqsnHOAOYuPqxNUbh4EXc8V3c5eJPGN4pS1izhmHElGRKuHsSLybbq5S
         0gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779311777; x=1779916577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TZst/ZH65PjeWDA2ZWgHjBmvAcSOI8pmTlTBG3lg9wE=;
        b=Bx9O3AMXv+r62X2btinyMeVhXhSWWSJDlgLxQQh57wnnPw+fjJlj6zGiJCzo+e3fAH
         alwxu6Bjw3tWbZf61mWh7qJx73+AJo5B16fCEuK64jujOFcTDDDMQNgl5fijGzANcrGy
         klK9i52LRlc9amZdoB6Ltyz3FWNv76GMdgfpBxcOzeWytCp6+DDHyweiyJRfBVLa4x5C
         fKQeBeW7MYtiOxPpURvbdVoiT9B7qdWBn/cJppGmchzEJ4PjfDYxKCN7new7lwkHU2uW
         zQTBpq8K/HwUFQQcWeuoEUKUzWiy2os8mlLzqlqPA5zASfETD5kZjBvCSlsE+cdcIkIK
         XxLQ==
X-Gm-Message-State: AOJu0YyRuQ4ZpYDleirNSaoiMJwv4kS6pSXr+QZ/x8anztKUtmm05KLN
	zU1QMoo5GN+Nh6rAHu8rByJpC3DIuW0FNneHz5eJO9YC4FPHNvBJX2bV
X-Gm-Gg: Acq92OEIxOc2wvyqyV8c5fOTUwLiJYjQR3C519johxKXeBL3EUnTuxTGjauBQDGY/xw
	NMC8R0/klxE35yQtrrineCCZ1EH81M6WBRAtt7MdonixjT8bNbnYNUS1lKak8A6qJgVKH9GR33x
	nVF6zagUSf+5gssD4zf56I2WsLfiD3JQZZkcxzmoJ+zFBo5uThqfWOc//QlYdiwHPa6AjoOpch0
	TlOT/bJkWFVGxiDHUbiFkNjBhymmN3LyQooquGcgI5yCVOtJUbRqyFEgyK4rDpy3unI1IW59rG8
	66mFQj+QxlqkkiML0IPZlmr8UttPqpaO8/ttFcIPEMM+zJDfEQ9F4v+iwKCuyZretSiOFAKvvvR
	Nk7ZW3ZS/885OI2k1oqns1HOr7V8pMdPBoKBfMetmkfWwk9vNyeG5MzTeJJgkkffbtnTyQVs/uO
	isRI11p8LxkYgkhpCxHzQ576WKKxs3vvUpJ7gw2YQSdOav4hCz4ovsR+ynCG/BYJ+rZQKH8mx0n
	iNHX9VfmItYkCQgHODhA036vkcqJ+U6M6TKSWg83FRfn1luAyAbsXPMHJSFuwht7URi3SDtxVuK
	tAd+6iyecVEaRn9mAgFmo0KJ4h971EOR5uhJaGTY3sRSJTfJRkzWJTmzaqHeCgwkuhQEA2FfBBf
	GIHxgZ/Gyps6aJQ==
X-Received: by 2002:a05:600c:18a6:b0:48d:366:b962 with SMTP id 5b1f17b1804b1-4903604cc9bmr433635e9.6.1779311777048;
        Wed, 20 May 2026 14:16:17 -0700 (PDT)
Received: from systembl0wer.localdomain (ip-86-49-246-187.bb.vodafone.cz. [86.49.246.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d5987esm16499845e9.12.2026.05.20.14.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:16:16 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 20 May 2026 23:15:37 +0200
Subject: [PATCH v2 1/2] dt-bindings: iio: light: veml6030: add veml3328
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-veml3328-v2-1-a57f0d9e28d4@gmail.com>
References: <20260520-veml3328-v2-0-a57f0d9e28d4@gmail.com>
In-Reply-To: <20260520-veml3328-v2-0-a57f0d9e28d4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779311774; l=1787;
 i=joshua.crofts1@gmail.com; s=20260516; h=from:subject:message-id;
 bh=1XkYcOKA+WTVn3JK4BNV1oCNe0e+OpnigkVRiFBguZQ=;
 b=/xdMl8Am2N49J/H77VcjWCtkO90/twCwwNZUre+UoTEK7iRlXJnQ2fAcleGu8auCgpC/OUOqo
 uXe69X4PUs7BBSYy8wN751CIfkWX5fFVqiTz87YfL81wgSZWqB9f065
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=d2X8EVKEB2uF4AaPPi3iSSI+IJF3/9kOoDYVVmc+G1o=

The Vishay VEML3328 is an RGBCIR light sensor that shares similar
devicetree properties as other existing VEMLxxxx sensors in the
kernel.

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
2.34.1

