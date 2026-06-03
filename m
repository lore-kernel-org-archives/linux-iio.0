Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74088477E53
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512566; cv=none; b=P2DtWlclF8vlQuK8vHOcb5YgCeots9iPYWro1l64c8YD/art4odCeoHgwL4R0zhemOqUDneCW3KFPKlw3WP/I+uT9KtbEfEMKuf18xJP/aObjcjrquv5mES14d4JLTMXxk7Rs0i0f5f91e6awnB+jI2XUu6hUnyX9HxhXo/1WwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512566; c=relaxed/simple;
	bh=EoAF4YHy3iYTq0qtbpAuxEpwDtw0CacTgV3exikXeKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukrO/fzRdDvKOZh0B4vDoG2uMPEw9A9Hz25egMDJSXVbbz0jFc5eUeq7h3thQ0zH0Swd5bcAu0gD/B55/PnQIuN0TzjdwasGhO9KX+O5JmD4Z2HJ3DcgkdcA7mSvENOj7S/Zs1OHekvuSnZJK2zdlvR2hzrrm8VknqchncWKEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=By5iYhgM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By5iYhgM"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0bd02d97eso48681315ad.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 11:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512565; x=1781117365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygX2OtS8jtfRsEiUpxVA4rgdEOhC6dRMuJ3m7A2/544=;
        b=By5iYhgMccAyHP0G3AmAW8m1JxG/irSmUEA2V38OpJhdE1IJ8XjDZb4eo6+akZhqkC
         klqDUb7QT4HmcG+2ymEEg4O+ywLDwe7Bt1fP6u97Qo5MtCwYEvJwm/ZB8N8WFbswVnVV
         b4x28BsgqZocg4Sc9MNDAe7IkHhHgZFr0zMAk7KpY09GOQKYWRJ5SQLjdMeOKvB41JsT
         D+3+XJOupsjz475itgT1INKdsDKOcoPftPeeGECZr/0vYRLQffynkiunKmZjjt3GcC/D
         yPJ3fILGC+StIv8VGVwQfVrxq+SngbFTMXKmghWV+AHlT6yT9xPiEWdJAaFvRQvoA7Ne
         KjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512565; x=1781117365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygX2OtS8jtfRsEiUpxVA4rgdEOhC6dRMuJ3m7A2/544=;
        b=M0ZvK25OLOVQnyJ7715Pez+RdYdqLqqbQ82JBSSQGrdaS0XAT0YvapAb2VYXPfyMlB
         kDEVnVCAgVMJG/s5wTmab4N0EaqtffTIbGMA8tZ50vIMho7GVdg3BXR2nHrnvfb2bVdU
         9/bn0afmp2xRs5dAsYXVHtsf6Zv7sWD9yZanXCDJVUz8nG1TIutN6m8Zc6gGd4uIRNRY
         d7GoFP+O+k+iiawZhImCGEFp26wllIWCMYTzz/2xi3yHw4XgJ5BowiXk113iAZM8LYEj
         lqEzsSbIjI9oaibrkGu+DtQHrNzFOx4cDL+wEdLrPgYwIM2dfTkAUusKTKHAQC7YSn79
         Z6lA==
X-Gm-Message-State: AOJu0YxOHZ80AaclIIUV7+0KBiA2THPp7a/+SxOfvAaZUklQt7u3BRe9
	GeTHRbAxkBxEaWoSJ0t3P5A7YrA9oEgXa+LXGBUc17R3Z4lnF91EEDMnapogKA==
X-Gm-Gg: Acq92OF2zV0fgbsLVPI/ogaK87Sw2GlzMNX5goCpmLI7IAGFc2uGWNU5scEI7QU4+5W
	3QVtUG696FZc2zYBHt1mfvsclkHxGNk/1M9Mn7Sx865OscJXviQo69n/yUjjPZ83km0CVcwzLnZ
	2aLxKQhuxT8M0Q5U21cb6rLkJYMsDaBK6MpPhJ6nLvQNT6tigG3nHaUCDObDZ3Rcm/X8OF61Cqw
	1sa9CuhmZNMeR5l3E/8picma8AXkJftTlQY67Xu/0tdBU2QBc3L4MaHCafsJF7ojYQo23aX6DwA
	CYOHzO3ql/SeJ2BHbAd7zEiZCUnACieljtnMiczi8BTiUUXcfGEeNR6r8K9+4fpbsd9MTINh8D3
	mIkzx9JbafGlvfRTWjw/v+8sRRYNZ9wDqDZGFiGkmI85S3MAqLMZi9s+pzmwDdrx/8quPfkAA9J
	EQw/md6lx5aDdirrmsX2ZKY7nQNtKDmH0AqfQBCDewVVX3/1RFh1rVB6xV0oYvpZ683J4n499s0
	bVUb00V0gvqHHwfrItmvcojlwrg/ZdsLYXq87S6EZlOwaJ4pmeI2w==
X-Received: by 2002:a17:903:2b0d:b0:2c0:cf44:3b3b with SMTP id d9443c01a7336-2c163fa3a7fmr55072575ad.24.1780512564599;
        Wed, 03 Jun 2026 11:49:24 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2409:40c1:4015:6e6f:ee79:7998:9a6f:65e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d59csm32139675ad.4.2026.06.03.11.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:49:24 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v11 03/11] dt-bindings: iio: adc: hx711: add RATE GPIO property
Date: Thu,  4 Jun 2026 00:18:51 +0530
Message-ID: <20260603184859.89693-4-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603184859.89693-1-piyushpatle228@gmail.com>
References: <20260603184859.89693-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the optional RATE pin GPIO used to select the HX711 output
data rate.

Update the example to show the property in use.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 0baf620e9057..099235b5fd54 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -46,6 +46,13 @@ properties:
       one channel monitors the DVDD-AVDD difference for battery level
       detection.
 
+  rate-gpios:
+    description:
+      GPIO connected to the RATE pin. When driven low the output data
+      rate is 10 SPS; when driven high it is 80 SPS. If omitted the
+      RATE pin state is determined by the board wiring.
+    maxItems: 1
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
@@ -70,6 +77,7 @@ examples:
         compatible = "avia,hx711";
         sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
         dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+        rate-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
         avdd-supply = <&avdd>;
         clock-frequency = <100000>;
     };
-- 
2.43.0

