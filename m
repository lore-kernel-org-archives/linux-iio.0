Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EAD37AA6F
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782680578; cv=none; b=AGcEJWT5sC4a9VIqbCToCfSvgksRX4wfTJMaLeXHqi1gjEHiz1WaaAFmMNEsyhLGQ3QDI9Hbwel9UT9SQbOcMl69UPcpj81TPAVd9UdcXUEkSbhZHLZevAtXMBj/KB/+Fm1tQ8uro9cPQ1ut1vOlKqfWWnLJlLu7pdmJP3N1zjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782680578; c=relaxed/simple;
	bh=EoXg8YRSGFrNb62Ri3nWJRasxX45nsi+d1TAdqBr9is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7qeQIVUFqQ1Nml9p07AEZqd72Kg8oTJIUpodxigmiUIeh5s7YU3WeTx53BH14r5SSXo8wynJ3YQrx8hGucYerSrRK7/r9QZFt2178KDSSuDWSt/ahjBYlbcZ6yfhtdxdIgWHgMTTa/1Y7Dz3KC7onYGWaKqGp29fWj1cpiWxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaYSadsg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaYSadsg"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-693c69b97e7so5170960a12.2
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782680574; x=1783285374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vh2WKONUS0wyNpH+ymwwTp/zqPOZYSgw0F9CWH+S7A=;
        b=DaYSadsgOamxCWXic2oOBm66cnTzPE++vD7w6j/Du2Gzm6uIWcxZf+6HQ7z7Vo1TRP
         YO1N9lVRHWOHp0iyzE8UFhD9C7zDUSecv2a6qOkT10hlt5vuj28HgjqpRWlNGP0RfCqT
         QrPfaVrGrNxUOVe4n8hVcYwVyFumqpmHhH5s+X5dq9v4h6/cXsdvxxwcyGKvZLiRKHlC
         xX5QxIcrmANGWFKLR/ArWXoBr5Dar5AyuqSyzgWOPfMwAyo6sCssQh8hi8VRVYsAgVpk
         iZd2pfeurDZJXgZLgtVJw+QtcC9jpcY87f60U7IcCWrwPAjbfXMREEiPtVa3kEcUdKqB
         LuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782680574; x=1783285374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7vh2WKONUS0wyNpH+ymwwTp/zqPOZYSgw0F9CWH+S7A=;
        b=InTk/a9zpy54EMVdLixck4zyOoGY1DLLz6J3NPky6hLzw9yXHoX7lNckVSC4jAEIKp
         bo8RKsmyBUe/ddBVVhxt6g66MqagaounVQzbDxvDNoENPbHkjJGpDcDDM9onl/jTdaM9
         91arS9GdmDLfH5ApwvaqMmSkTBtGGLUnwlJ0hcz4NnaVTAZyP/5Q9W3xFNzTnQ0owoqu
         zVI3HaGBcRjbrA7oVb1WtOG8olrX9P5aT46P62L/irDe8HOLE+zbM0NTWTmXC+gzPJvO
         2XcC3EWrevNPWLNjVgLOEMEnx7jd9pApC6U6y1SEE1nfmcy6agjfxASEKrkdpoRboSTC
         8Q0A==
X-Forwarded-Encrypted: i=1; AHgh+RrpzQaAd0gGPNc5YDft7fC0aLKsMEc6e/QPU2qdikja5XwVkZZVHNd7bSVIlHP1SThzdujj1Ik27JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7kURQJQt1OYtEU3aFVnI4eAwsl4dbbaaVS0YlObvYQwtzWZ8e
	p1TQbVkrsQOS5p5VL3AMJObTFomN74OPrLL5OdY6S4Tdrk/Of2WVxgBv
X-Gm-Gg: AfdE7ckkUfaXxiJKxnv/yrbBw0EtlLuBTEPZL+Nk3w+sW7hTOcps4VW3RhqmhEYYZ7p
	wKysTslPgU2se5sLGGCX/uKXHRNmbkRf3eYJrjQQ81yHwh5zlYLd1fZiPWxzzJ4xsvRH3tNZhll
	2LxJhr4UzNMBBNZ2/9eJNJzE7Xc2TFvVl3DddO0J+uis6K3pE4c0BmHOc8FK9mNRQ5RtcVVWGzM
	Fo/SZzNVzIOSj4wolaRS22xt1TW5FIbpx6JnbpAtgBlt/pSwg02+FF+FLA3vLu0fXQWHImsTY78
	DEFP3TAy9f+Yert0jrRU/zHiczvLhIty615NeekBI6wLVnIxEcN5iTQ5Rb2ff8vTsMZLooRnHG0
	PbRrKGbkNtIlagV8KhxNoLkVB16QRooIgZ6NtcPHo2z47FSNUgRIbb5RIHAtUY2pyYZPX6g==
X-Received: by 2002:a05:6402:254e:b0:698:6f16:2290 with SMTP id 4fb4d7f45d1cf-6986f162860mr84807a12.23.1782680574152;
        Sun, 28 Jun 2026 14:02:54 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69848e5ebc0sm2205656a12.3.2026.06.28.14.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:02:53 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: wbg@kernel.org
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	o.rempel@pengutronix.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wadim Mueller <wafgo01@gmail.com>,
	kernel@pengutronix.de
Subject: [PATCH v6 1/3] dt-bindings: counter: add gpio-counter binding
Date: Sun, 28 Jun 2026 23:02:39 +0200
Message-ID: <20260628210241.119825-2-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260628210241.119825-1-wafgo01@gmail.com>
References: <20260628210241.119825-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a binding for a generic GPIO-based counter. Two GPIOs (signal-a,
signal-b) drive two Counts; optional index GPIOs load a preset. The
counter function (quadrature, pulse-direction, increase/decrease) is
selected at runtime via the counter sysfs interface.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 .../bindings/counter/gpio-counter.yaml        | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/gpio-counter.yaml

diff --git a/Documentation/devicetree/bindings/counter/gpio-counter.yaml b/Documentation/devicetree/bindings/counter/gpio-counter.yaml
new file mode 100644
index 000000000..79b7afd7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/gpio-counter.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/gpio-counter.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO-based Counter
+
+maintainers:
+  - Wadim Mueller <wafgo01@gmail.com>
+
+description: |
+  GPIO-based software counter with two Counts:
+    * Count 1: A + B. Quadrature X1/X2/X4, pulse-direction, inc/dec.
+    * Count 2: B. Inc / dec.
+  The function is selected at runtime via the counter sysfs ABI. Each
+  Count has an optional Index (Z) that loads its preset on rising edge.
+
+properties:
+  compatible:
+    const: gpio-counter
+
+  signal-a-gpios:
+    maxItems: 1
+    description: Signal A (phase A; pulse input in pulse-direction/inc/dec).
+
+  signal-b-gpios:
+    maxItems: 1
+    description:
+      Signal B (phase B; direction in pulse-direction; pulse input for
+      Count 2).
+
+  index-gpios:
+    minItems: 1
+    maxItems: 2
+    description:
+      Optional Index (Z) inputs. First entry indexes Count 1, second
+      (optional) indexes Count 2.
+
+required:
+  - compatible
+  - signal-a-gpios
+  - signal-b-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    counter {
+        compatible = "gpio-counter";
+        signal-a-gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
+        signal-b-gpios = <&gpio0 11 GPIO_ACTIVE_LOW>;
+        index-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>,
+                      <&gpio0 13 GPIO_ACTIVE_LOW>;
+    };
+
+...
-- 
2.52.0

