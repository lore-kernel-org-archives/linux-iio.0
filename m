Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9342BEAF
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071365; cv=none; b=rOFKAWDsTdTXtB0WGVxyfw/Y/KD+KMFfqOZwU7+/YEgUQ3HL6NVyVp7aOPG3gYobz4HLf7C/webvODirMmXbDk6/6AWU/9hCp+IC8QlHlPiWr6CJIMoDCgJMD39CSokRQcnZ/d/1sfewATVJxx+m+5BXZB80IVa/p/mUofmsSoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071365; c=relaxed/simple;
	bh=LEjJwrRNUy+HCSKs2f61e3PZbbPkd/lwRYELOdd5SZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUY7f66eqktreO0lFtGctbJcnQNS26p2MKdt7Z6ONP2Qu1m5pPRlNXJkoYoRFt97/JFiakzb2ZGkixHHPKL1eFFwczkZ8/3O/tP9xGmPMF21ZI7ae4J0BLsT9Q88DFdSCwQszgpxhnRu9bdf0HADuwhL5sQ3lDLPmsLCXcDtzNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=eBpoK6kU; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="eBpoK6kU"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a2c1edb210so1017980eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 16:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784071352; x=1784676152; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjXBokAks/glcKCcc156LiwQ/sZ+5R4jJR8EnJbEndw=;
        b=eBpoK6kUJVcGbppkra7KsyT7rmKqVcUte8TvWcL7jU5SLj5ucXpJiIdBMHIKzpRMeC
         GcMf3tmZTAFpaOesV6L5NMPm2ms3hduGarnS6Op013G/t3SaquwKx/hgtVfpnx51X+yf
         52ddgML/yt/HfUuCB12Uz/92lvMkzSjlCvoDF3BlrdJX9XPGbAuZMS7lf4KrUw3yaSrW
         +FbUycxdsUm/JklnAsuRgazeEju8hVS402eE7ZVXkF3E985x3Ar9YElqJN8knolDvnWb
         TIIUOxrOpVAmGRyUT0W62JICTii6aRPZzZMjJuq9S5yuefG2TQTG5tUOC0HXhhev6KBW
         f/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784071352; x=1784676152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sjXBokAks/glcKCcc156LiwQ/sZ+5R4jJR8EnJbEndw=;
        b=RgH71EXvH4Jtlr8g9lkApebmvcmnSRB3jxXnCXWbIF4XXAt32I1tJcrbGqFcQlw+oj
         hqM88dEzutRPv96sZygkF8wQEjrtVSJn7iOX1T82bStouNqn/9H8+gjKHkXJxUSGGFbE
         UWu1UBFbmCg83MWBkszJ8GdXImmJ+lF3fk0tw1JGsJ+fvhTzh8mTv4n+reMJGpA3UYA6
         QLeiqpYheyllPbhkU6LfTm3g1YKvW7v1BJ4fEwxLY3xgvyPft3Ygpl7Lze00/HUddfgx
         1OW6DP5ji/LO/wLAnhhS841Tf6P+Mli8Fc/1pvioQeByDDwi+q+tZqhKecqyZEgNGjRu
         4T3w==
X-Forwarded-Encrypted: i=1; AFNElJ+Bnj7DDJpUYk2OfSeVbFNxekP04DLvSOYFwfUJLxoJFrPF0V8RkvJfdq12zgWyts2j1fa0S0mq5q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz675F8k4JODf9Rfba+mzIVfIDdjklkaYu0cJa6jY48xYMfvuY8
	+8cpdkaEu1IGxYVKvpoekxAWJWBHummHTHv5a8/MwymdO5nDZRwxLxbOxwMMN4mlSIIchCClcb3
	/umSz
X-Gm-Gg: AfdE7clv3UwBZCot2kfqKjv8tntDMvQK1kFJFIKGzbp+1a7nruWkcSh57SR+6mvtdvp
	7ZY29JanQ91cH6dSOURhdvTUFCS7ziZMuqZd5nBJPugXAbu3MzKICIFHlMS5aQpdTJdvBPN/hpF
	yKJ7RTJALyzfyeL4Nk4So6nx5PoyuNNrCIa9mv83rsXjGbbO53AgCnvET56zEk4dtp98qCNn/DU
	B9+fM3V3ESveFh4BqrFQ8G7ylzphi4ky3s2maXZtwyaIItjulvIiQLta0nXwYKLUMUkKmBhKE+L
	rqghnvR3JEHtptEDG1/jksovYXa90Z+R4oMe13B9DO4sTf8mYzRsPGHcS853zuToi8P2tWSyVKJ
	EUIq0p6Sa73zq25kp7wmw4rq/i3Ei48nLW8balVU0WEPfDPj3xPxvlUAUT6WCFqJcswZaJnes03
	mEiIY1q7/LYqvLEo5HjQ==
X-Received: by 2002:a05:6820:f0a:b0:6a3:bdc5:5910 with SMTP id 006d021491bc7-6a3da004a17mr410773eaf.37.1784071352423;
        Tue, 14 Jul 2026 16:22:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a39af0e953sm7561978eaf.3.2026.07.14.16.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:22:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 14 Jul 2026 18:21:24 -0500
Subject: [PATCH v4 2/8] dt-bindings: iio: adc: Add excitation current
 sources properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-iio-adc-ti-ads122c14-v4-2-25f8e3084485@baylibre.com>
References: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
In-Reply-To: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=96e2F9/YVY8qwuX8Jw8IiU0nLEgtbp30DvDE9oQfRe4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqVsSEZ8CkvjR262q2YkB685P0STJushRPgz7KX
 6YT/l22ByCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalbEhAAKCRDCzCAB/wGP
 wCXgCACbIGSHdaMyWKeHrBYL3DjmFKDNe+U6zIL00vffpkxo0o7CwPzkDvh9bfOD3eJNg1u0y3l
 2xhc3SF24o50+kejshbKaX4PzpbDcZJ0t8S8JOPcMFfd/E3mMcrgsCQMV1dX6ghs/J5n5IEBXX1
 6y46iTfBKTQY1YuHgB5BVAYDgWHUZvB1kHGRDuFpsFFyUa68XKzJAP94bADwZUHfRDaoU+e7HpS
 HRJSfmhroYvGTy/lqAm2E3qiESIO4th59V2oPhi47QFXm5adH0yHBovRqu2zUejJErGzqNtzahd
 YFwqfJZ0PxWU+UgZ4P8XunFvJsnncTCYRMuXRTIQKrF6s4dw
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

From: Kurt Borja <kuurtb@gmail.com>

Some ADCs incorporate current sources that provide excitation current to
resistive temperature devices (RTDs), thermistors, diodes and other
resistive sensors that require constant current biasing.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v4 changes:
* Add sentence about values being pins like diff-channels and
  single-channel properties.

v2 changes (compared to Kurt's RFC v2):
* Make units nanoamps instead of microamps to fit known devices.
* Drop bit about allowing single value for multiple channels.
* Add bit about semantics of the array index.
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 8f608bf0b24d..9f7196d61ac3 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -80,6 +80,27 @@ properties:
       ADCs usually allow choosing between internal reference sources or a pair
       of external pins.
 
+  excitation-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Excitation current sources provide current to resistive temperature
+      devices (RTDs), thermistors, diodes and other resistive sensors that
+      require constant current biasing.
+
+      This array describes the mux configuration of the excitation current
+      sources. The values correspond to pins similar to the diff-channels and
+      single-channel properties.
+
+  excitation-current-nanoamp:
+    description:
+      Excitation current sources provide current to resistive temperature
+      devices (RTDs), thermistors, diodes and other resistive sensors that
+      require constant current biasing.
+
+      This array describes the current configuration of the excitation current
+      sources. The index in the array corresponds to the same index in the
+      excitation-channels array.
+
 anyOf:
   - oneOf:
       - required:

-- 
2.43.0

