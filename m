Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836833D6D5
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778336559; cv=none; b=GXm0gO23NA2j2BWwlqK5r1X7SlEJO8Cl3WdBdvkoD6O2S5PN28ZyYlvaFqrDU6JOdykE7rk4NSqZJ4VM5Y6kRq7hJZTG9RTVoqXsSdDG8AinIHmeqtsv8oWnxnvF6tb2VyeR3qlmOXy2OSs3jWIkQz587cj1hZmxqO2bW22AbpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778336559; c=relaxed/simple;
	bh=Is77detragqtoD9J1EJ55/9pKE36jnstRpS4hdnKrYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KquG4NJpB9y1U/e5TrXkAevLVF4anU21l37Y6FE5uFYbZZ/Ky0hmpsnTGlQeGGb+eqVkVB8pZRJ3cTfmFK+wXxsvOQe9CcxkI0r9HOATwpNKgwVlqO2XeKt1J5fxAS+ll/iY30B3prGAlbB+Z3JQqenOG57gJrHFJW8YN6hzdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1tp/vI8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1tp/vI8"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so1712479f8f.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778336556; x=1778941356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tUYnfT7OoYNSnANZCAI0KuF7oC4DPgTc2FTMQNskm0=;
        b=N1tp/vI8TuA0u/ZbBqEeukS6RBNQw/0wJLsqoqdvgQIuJF/XXhRZA+A4YzjhfEieO/
         Gru3plEIjtVeN9HZo3n7d5TiJo0XvRpgFPcS2e58utY5GMjA0PDtME0HBgsUQHskm4Wx
         tHoLEWO0nOpvJETuSsVMEryGB90XpCQdlc/XFlS2eDGrXPB+uk2iC3xtV3GSVmEnn8Ol
         /au0pzdS8tEnpGIGyolY2XQWOj+DNkkBk+uJIesTpU2DX7by9SoEWpKUxi2m1IBdgWE5
         H04u1D/oHyGtGrt+wMo4Q5Q/EsyGZd9Mv4Qqaw1gs4giagz8jGJBermgkeSL17yF384T
         g/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778336556; x=1778941356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/tUYnfT7OoYNSnANZCAI0KuF7oC4DPgTc2FTMQNskm0=;
        b=NZLpsYBPWGbK4Lx8xvk5o3lyR8DkzNzV/eriruBvENLMps8QjdlLEGxDu9zg/fPdM2
         tAjkaWnygEGJcKsFH///T9o3gLofvM+i9NivW6dWKz0ciNkcNj5P0g8J+9KrGVcnANth
         6fZhxjWvL+JKds9HhJsdSstUDMHFuHxwcCXXgryGmIJNzRH6vmB5tahW0wXAblFWfvhz
         VAnu6x89nMbl7DPjWfbDjenQg/SVMtU1JcrAGG8Fgx0/akypAbZgPnehM5v262F6k7dn
         fDnBmhzG3oV2NfWtEKqk3WAnLeRsXtcHOFrLCXPMa4P88zbRYB19Z+UH1vGCPsmsnGn3
         +GUA==
X-Forwarded-Encrypted: i=1; AFNElJ/0icLhRu/cZ/Z/R0zbcGVnYr0zFiKTV2cUhCniZan0ebGdJocnsNjEgjpizhErE1T6ExazSn7RVDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpa9z1KsMAABdCF01XEOxIM1fsuoLFxK3vjU1Mo1KHkDKmquFq
	okgnAUKYxV0w0TqmXEDdBBFIjw471FW0BiXEzQbkXKsTsMN1P4nQW05r
X-Gm-Gg: Acq92OF1KM0ENyKr+MctjAFD+TnnHnYCjan5AOcpJW+qXdOi+U4AAfmbja9sjG5r8VQ
	dfPbG38sxSa9RQxTzHJfWlzlX05kOcr6QsM8bevmcj6pkJH+/W8I35gsBqoJVy1T8Kbd3Nc0trl
	qGYvyvqPL1oYmOkZ5rKciJlkbqhNhF8lnN4LjrAx8WTZy/dF01vIAp/RnNv1qBT92ucF9LwWgvH
	zeBjv5I2AGHlmnuGiF2kkn71hWyZEO5cpkGQGWDP3WcQETV36pZzjSI7It6rYWtFKKxWZHvDUzV
	Rx745/oYrKVXJvSXDkivoY1NaPlCjlHIjy7pihDAPJZ187Y6NPD2XP+aqvPq8iM24tZVnlvNZUJ
	ZQEyC9oVs6pGY8beKfwKqxMQFqsXvwy1Au2WfQgtZd4LZZQBbukJDWjygEjHqpgAAT6Nkj4VHAR
	AJhGItjmjkUWSA4F6Yxj9y9FqbuETo0UhF3Qbv7J5ilFxsk3pbIrdFHWpiCKK7v1lg4bjZ
X-Received: by 2002:a05:6000:2c0c:b0:43d:7e11:1b72 with SMTP id ffacd0b85a97d-4515a6c32dfmr26267242f8f.9.1778336555910;
        Sat, 09 May 2026 07:22:35 -0700 (PDT)
Received: from DB-07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45492271510sm15127763f8f.37.2026.05.09.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 07:22:35 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v3 1/5] dt-bindings: iio: dac: ad5504: add output-range and missing gpios
Date: Sat,  9 May 2026 15:20:39 +0100
Message-ID: <20260509142047.30302-2-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260509142047.30302-1-0rayn.dev@gmail.com>
References: <20260509142047.30302-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD5504 output range (0-30V or 0-60V) is determined by the R_SEL pin.

Use standard output-range-microvolt and range-sel-gpios properties to
describe the hardware configuration of the R_SEL pin. Ensure mutual
exclusivity using the not/required logic. Additionally, add missing
vlogic-supply, clr-gpios, ldac-gpios and datasheet links, and provide
a complete usage example.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 .../bindings/iio/dac/adi,ad5504.yaml          | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
index 9c2c038683b4..e0123dceaa33 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
@@ -10,8 +10,10 @@ maintainers:
   - Lars-Peter Clausen <lars@metafoo.de>
   - Jonathan Cameron <jic23@kernel.org>
 
-description:
+description: |
   High voltage (up to 60V) DACs with temperature sensor alarm function
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5504.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5501.pdf
 
 properties:
   compatible:
@@ -27,6 +29,29 @@ properties:
     maxItems: 1
 
   vcc-supply: true
+  vlogic-supply: true
+
+  output-range-microvolt:
+    description: |
+      Specify the channel output full scale range. The R_SEL pin
+      determines if the range is 0-30V or 0-60V.
+    items:
+      - const: 0
+      - enum: [30000000, 60000000]
+    default: [0, 60000000]
+
+  range-sel-gpios:
+    description:
+      GPIO connected to the R_SEL pin to select the output voltage range.
+    maxItems: 1
+
+  clr-gpios:
+    description: GPIO that controls the /CLR pin (active low).
+    maxItems: 1
+
+  ldac-gpios:
+    description: GPIO that controls the /LDAC pin (active low).
+    maxItems: 1
 
 additionalProperties: false
 
@@ -34,9 +59,17 @@ required:
   - compatible
   - reg
 
+allOf:
+  - not:
+      required:
+        - range-sel-gpios
+        - output-range-microvolt
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -45,6 +78,10 @@ examples:
             compatible = "adi,ad5504";
             vcc-supply = <&dac_vcc>;
             interrupts = <55 IRQ_TYPE_EDGE_FALLING>;
+
+            output-range-microvolt = <0 60000000>;
+            clr-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+            ldac-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
         };
     };
 ...
-- 
2.47.3

