Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5741739D6D4
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141763; cv=none; b=sVULhCaQpIFqjatAw8R9KKAlpd03WeslcZUC7T+vTHjUhJfsPiP8YEhvv3YM82JqhxWi01hKD7j/Cby5UDkkd1vLgfEUmkWdwuCu8IH17HF28PqM+bb62Ajyibzj9CyTwKgCAunfGgKUWHPkjPyg04nUxod5qOApq4pkRJLxMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141763; c=relaxed/simple;
	bh=+3gyUX7aaxHg4IEnt/cUPAS4EOyirl10zVxCVaQOWKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPukPyxzEB6/+hMQlY6QyMCWkzzUkj3eXoi+AWjq6/gVtq410f2mK2v+Efj34aAiFzgwlqc1wW22I/id8KtjXlYjZc+FE6srvMlvIEqZxDgiRnp1SRyyLfKfoZiY+kQWuq8RIPT2jylE0veY2a2UlHT9hqTudbuYERtzbkoNMvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfUKKFCN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfUKKFCN"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-838d0b7c950so1964091b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141761; x=1779746561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRHhm0urB9xrof3Z10YFKkp6gED8PHSdFFw3oxkxeVY=;
        b=DfUKKFCNbsn63+wnTq/ZUkqu13WQUxWJIDG+mp5BN54sIwY8pK0qyqMt+F4VEFMdDU
         NducPBw8PzknezmbMgxRIcNYptrXhD50J92f60AAYZRBwwHLxwDJKKOoytULaC9g097j
         KTxeWuIIy3ZwEhdz78TLW5Fcd8zeoUj04u986AUPH60nY8Oy+ygLgUCP+OujkRAYCzGH
         6B0br76JdeHD1x4Qsig+cBD5r0hDGL60VB/XacJJPNWbnerz6Buxcdh8IQQrSkOE+Yai
         EkkiuFziGYJ+g84Ho7SG5gsmNxaUJvhU9ckXcNsdDe7cpZZaFpGJFRMruTh+BAC3Xknb
         qnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141761; x=1779746561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRHhm0urB9xrof3Z10YFKkp6gED8PHSdFFw3oxkxeVY=;
        b=q1Eh+P5HBOkcDnoCuyO5mYbUucAy4iDuPSbJDTcPtKP6fIPMYo/NdYVMyw6ks3zDGV
         Mti3OwGCp5IMLq7a4pkC+Mc6bQYm4bCgITrptOXwS8tgNlGtC5NYS6fEcWMmOQNxXm51
         ef61J52skVoV/ORCcpfUZoK4ymlq5n+3PinlepDrQuEKLeGiOUp2gZgbIqv3mfiCV7Md
         dOU43djavtLo1/1Fcf/gokpwpjIk/a1SWtNcEaMMjFLlAfBG9me+hq6MquvfYVu6nCfl
         f2Xs+NvXAhMg0n4HEpjzbRU+W0hNYVJWWi/LDhJii17FgNM/P6gTVAkhcmorOB8r92OS
         YsuQ==
X-Gm-Message-State: AOJu0YyDKuFBc7UJPWszW1Xr8GD967kf0+XTXZ0nfKX6+rqF5zf7iEJU
	zcM2pDhQrHIGubqo0szyeKQNFRe31htKjNhMzOZKLvqzS16fOwAkt7la
X-Gm-Gg: Acq92OFvpToM1zU5xc1pScLVkz3gLQ+WDGomM/Yx7b9qWuxTQg2MvKv91E0puKmqpVE
	Mdwgy2O+aLgSLWD8UuZ2Mg6B78Y6jzdmH1mdyg3GmbzDIgGvWz70dtLdKGjFXGvrCSzu3jc8Igr
	51L8B8TBw9XknvTP7GVQOPA+Ep5omzk8cK3C0FUdPE+7i40pVZSQXvGHj49+6g37uEObIlRFkb/
	FoJynDRfnfnVrZHXtWDOjhNR8wgEieiJUHFEksDycPcdABaxBe68bU6ZdEUHGJ6FxVEKyTMoOd1
	hF9yzkx8J2t9+Al64uVCr0fk6eSfyO2xhr/QmPMH8Ckmgpk7T8fX0jXwbccu7lCLqcXMNVIzhfw
	crt/DAl34ib9p/xm41sZgpB6aOl1mfKHLu6LZ1dJ0v4alHNkeu15rQtYIVuGYE8IvTlbVfcSrko
	1IFyPazYKlLqvJF9KQ7G9KbQmViRaeL/zOZBcprAMS36s8gPUh0mw2o4vjA99PUXYk4i7mnZ8He
	AQxYjgcqj7RWggtcHxQrFV1Mfw+i/Lu2FpnJYRn9uXCo+OLfXAGIHY6xiqr
X-Received: by 2002:a05:6a00:414e:b0:82f:4a4d:377e with SMTP id d2e1a72fcca58-83f33d9d741mr17598050b3a.28.1779141760496;
        Mon, 18 May 2026 15:02:40 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977b128sm15772960b3a.22.2026.05.18.15.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:02:40 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v9 01/11] dt-bindings: iio: adc: hx711: clean up existing binding text
Date: Tue, 19 May 2026 03:32:17 +0530
Message-ID: <20260518220228.63322-2-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518220228.63322-1-piyushpatle228@gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite the binding description and property text so it describes the
existing HX711 hardware behavior directly instead of documenting old
driver implementation details.

Also clarify that clock-frequency controls the SCK bit-bang timing.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
No change from v8. Already applied to iio.git testing branch.
 .../bindings/iio/adc/avia-hx711.yaml          | 25 ++++++++-----------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 9c57eb13f892..1ea60dff98d5 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -10,14 +10,9 @@ maintainers:
   - Andreas Klinger <ak@it-klinger.de>
 
 description: |
-  Bit-banging driver using two GPIOs:
-  - sck-gpio gives a clock to the sensor with 24 cycles for data retrieval
-    and up to 3 cycles for selection of the input channel and gain for the
-    next measurement
-  - dout-gpio is the sensor data the sensor responds to the clock
-
-  Specifications about the driver can be found at:
-  http://www.aviaic.com/ENProducts.aspx
+  The HX711 is a 24-bit ADC with selectable gain (32/64/128) and two
+  differential input channels. Channel A supports gain 64 and 128;
+  channel B supports gain 32.
 
 properties:
   compatible:
@@ -26,23 +21,23 @@ properties:
 
   sck-gpios:
     description:
-      Definition of the GPIO for the clock (output). In the datasheet it is
-      named PD_SCK
+      GPIO for the clock output (PD_SCK in the datasheet).
     maxItems: 1
 
   dout-gpios:
     description:
-      Definition of the GPIO for the data-out sent by the sensor in
-      response to the clock (input).
-      See Documentation/devicetree/bindings/gpio/gpio.txt for information
-      on how to specify a consumer gpio.
+      GPIO for the data output from the sensor (DOUT in the datasheet).
     maxItems: 1
 
   avdd-supply:
     description:
-      Definition of the regulator used as analog supply
+      Analog supply voltage (AVDD).
 
   clock-frequency:
+    description:
+      Controls the SCK bit-bang timing. The value is used to derive the
+      delay between SCK edges; keep the SCK high time below 60 us to
+      avoid triggering chip power-down mode.
     minimum: 20000
     maximum: 2500000
     default: 400000
-- 
2.43.0

