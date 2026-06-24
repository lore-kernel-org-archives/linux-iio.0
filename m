Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE0309DDB
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325971; cv=none; b=NSk18EHxHJIQhVWRwzyETrXsQNEszXszqb8EF+MhdA3y6gisaLGr0a2YKDBF/B/9hOEJmWWmeNA2hmEO4K1cJM/B5WtBp49EALCGRlUBaWVUNc5TUHPdDSS/neTXfJ2CMlCQTBmRkcIc8w0/kjeZ8W6SXh2FzvO9sgomP2hKiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325971; c=relaxed/simple;
	bh=fMKaNCHqvdnEkQNOcz/+Evogzl4yJdpF2G3aArECXqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLSeGAQShA0ujmPfJbCsPq/0JqvmxrJIdW5+oRSdU0CFRtXjV4btD3EmqlGPy2kVpMsSMSMhLr9edG+A2Xj76hEuaNimVRN5WODtQ4q9Ipr6Bs6bAr2FeDNk1eKSXNOOjFv+buaToSWTUuas1CUMRPOJ+rSM0DFONYCu4DiZtzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aek6dUXB; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aek6dUXB"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-446c53679cbso945923fac.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782325969; x=1782930769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG46e6wh0vfo+H1QfKvpne8/nrh3wipAUO48FCP+P1g=;
        b=Aek6dUXBNsQls7eidScbN5RuR1LZ3GowJRw6mB8/RIcNQSDhQN8n1iE/SfceIR68Hn
         toVULRRMNwmjzWwXRXEvQfffDQpdthf/EiwOcIfUJRyzq/8b3cSdhy+jKf1YSdtzmXNa
         b5Z9LZeMVj31oxoL0EYUXP9H9hZ0bPPuCIbT2ynjQR/NVD0lVOZiBmj9UKNmDyq47BSX
         I0yxzPmNjm41Akx1ei9upWyy8lQcD+BgQqET2f9XFFp5FCuOhLBjGlCwm8EQqTZ9HrP4
         pUKPa5LzLt1fJ7AluAdMtAzuq0oIfn47rHmMUDq8kwVjC54wZYKhOauyojMHS+lZpf6M
         7C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782325969; x=1782930769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AG46e6wh0vfo+H1QfKvpne8/nrh3wipAUO48FCP+P1g=;
        b=I+EpWTMslWS1j6vMcXIVzMAITb26D2h6//siS3ZDHOTgmzhogrYbL/zO0XavZ0Q31X
         +dhv7iTC9cneVdUMwwH1AAH+nJGHOa/w1oIOuRMXTehHQ/qrF2Qi5lRH/n8p6ICcQUx7
         ONem5+gK4qM2Vxo+24IJC/3f/jeUP324SLFkfuemXFXZpI1aFrlsgDSJ3AmoC/gEPF83
         mHk3tM8urYF2pTd8u4b8r/QDPEby73SzQ5JQlGdF/04HinVveEDHrfqSK8alSLpn1Nj4
         AtyonNc7vPYJRu57quHuQVxY+wZk2xNMKEYRvMx887ef9pzTAmOBVo4NG5NiGciGheI9
         m6Gw==
X-Gm-Message-State: AOJu0YxlY/ovSKoRlAKtFx9dgbV/fkOhAUQJQHQx4p56+9AFcwP9+CLZ
	AHRwMiT6YwG7RhQXMtWI6QDoEl1yLsxniIEQncLelchv/lcA9wWnLrk0a12kJe/M
X-Gm-Gg: AfdE7clwsZ4l3OSjDKyK/UIGMnh51+0KTptenqZLd6RrmxG+IJu/hc/nECxIBG9xmzj
	BInpIjWYcfrMro9RIkFnNCp3RUNF1LAthAGs41v2eNOeQPyK4U75/wnitQtYMe0f7p1UYkll7ZJ
	5wC9PQgDLeMhq6ba2Zy29nq3cDPu9IIAeW/7Fa4aAx1wRJFBhyFn/1YscDjdu8laPsC7e9ZCMBZ
	ovkv8mKa/rtJNurE0YpR/V4n7X/NtZFbK5BRGg7KDwAtpaJk8Nno3avgCIC7NKD8T644omQdCts
	CtGHQZUet9kd8GcYkrrZ0bql93ZecRvOmMqvm5iA+Q/XEMgwcRo27LLeOnCxHHn4Idg2xc1mSn7
	eOZaQCzNxBnY9ibKA9JPd53dRFovC72lOM9j6T5AHiyb6iKybHN5JtIex8eyhspYCaYZ0ytkpVc
	bo+MoVjLqVI2c=
X-Received: by 2002:a05:6870:2c86:b0:440:67b1:cd2e with SMTP id 586e51a60fabf-447325604a4mr16071643fac.33.1782325969008;
        Wed, 24 Jun 2026 11:32:49 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f042517sm9968060fac.13.2026.06.24.11.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:32:48 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V14 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Date: Wed, 24 Jun 2026 13:23:41 -0500
Message-ID: <20260624182350.50467-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624182350.50467-1-macroalpha82@gmail.com>
References: <20260624182350.50467-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the ICM42607 and ICM42607P inertial measurement unit.

This device is functionally very similar to the icm42600 series with a
very different register layout. The driver does not require an
interrupt for these specific chip revisions.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/iio/imu/invensense,icm42600.yaml  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 9b2af104f186..81b6e85decd5 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -30,6 +30,8 @@ properties:
       - invensense,icm42600
       - invensense,icm42602
       - invensense,icm42605
+      - invensense,icm42607
+      - invensense,icm42607p
       - invensense,icm42622
       - invensense,icm42631
       - invensense,icm42686
@@ -67,10 +69,24 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - invensense,icm42600
+              - invensense,icm42602
+              - invensense,icm42605
+              - invensense,icm42622
+              - invensense,icm42631
+              - invensense,icm42686
+              - invensense,icm42688
+    then:
+      required:
+        - interrupts
 
 unevaluatedProperties: false
 
-- 
2.43.0

