Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962466;
	b=DEvGZ4EJ/IX0OsEqXsU3/FsnxQx/d+fajRBrxe7wDMVl22OnAHshFAcUFAhDtG/eQ7xi
	 xTZ21P9Q/SSrwU8DG5MhbiAGFfOPYVshqSoF0r9WmJfCDV+53ic3sQrIaQDr6i7V16FGZ
	 VUil8giB6EiJydn3H5ANLF/1UKWwnUNMlzEcGev2lzWiJGAk4yfbAOJcGYz7Pr2IA4J6X
	 9LE1MqEnGIexSSGt1ncPrQe1/0WXTb11abvy9PS82IIEZrX8QCpaOGg3HF5DfPnD4XRz/
	 rGlCWi+WFwzZ0JzXNCpDGdL1WGfuFn2KI00/zOkuSRcdTkt9/RjvzHBTEb0Qd/0plSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5NEqsMSr3pHjqorQElx9gtqmjSxhKtX5m0i+RDOSZyI=;
	b=JAmPXHbzg1nOamZE/juKVQPwdNeJRGZoCldL31IzhCTqlBw/Iqn4a2zrIyTDrO1cIWLv
	 0DAHCui4fd+/3RxGcZbeG7iDLIOE4+MDok97c2S9+JrADLKkGpjXn5IZzosLyQJHRIjQU
	 zQfBZC/DjWnS5vviRczID1RTNqdqa/EmEF15ebM/HlPUHZpmUoo8a+5uK/WaNcgltnUar
	 t1evWkLDPyOK5sLdU7bkk+0Q2M0QVWSlOjU1W5dLosi7AU9Iiw32/RjBsgcCkF0VShNTC
	 zvpjiO2Ws2um9AeSv7DgUtC18lSnDb9Fza0VOmCyKnybLwBUUENz3X6iAhk/dMQX/ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iD9Dttiy;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5C8606A333
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 10:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B5C8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=iD9Dttiy
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so6163525e9.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 02:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793962464; x=1794567264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5NEqsMSr3pHjqorQElx9gtqmjSxhKtX5m0i+RDOSZyI=;
        b=iD9DttiyokGWik/9lX7kkjGlj6NpUKTvyqyOFRbsvGvAn3SQU7WzguD5EG9JtCHUg/
         /hNC5Ls1yAVelLYySciMLDUyIUeKEUde4sxJqCXcaSc6mNWV/ifUyug7cPQBR03EW4hQ
         SyANdz8UiuD+iTx1FYEEl64Wk+jgc/rsM5YK/dzKMtevh7f5yfZHOo6dGGXrNw0kciHe
         3q0QDYP8XfkG7rQKkfqMPUlfwy13zlF2E4qWDrgrCdsUubVnGcpe9bGw2Bh1wyM1eNol
         5djgFmvx6dEPXbOnCkTQa1C5ZoBtfr/3yCyeWapWOqcPEf6y4x6V6UK/I3T+Vfr2WDOf
         k/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793962464; x=1794567264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5NEqsMSr3pHjqorQElx9gtqmjSxhKtX5m0i+RDOSZyI=;
        b=jCdbeFterABaAKzlgxusCMp6vN2xQcl+CuClgGVpwXLnKcVmb8jBUNPj3M7tQ2isDO
         THuaJsxe51b4GQb7hqXvMzaaNnV/ODOfcIYD6bYhum3Nn6yW9SP/G3iOrr4eSSc0WhYF
         TV9+SMBSbHEqVI/YtOsoN61FnEmbSQaUXhbh5WqL1tZxVtBbR/4ztpqZZJNn0QY2TLxp
         s6X/oEqLuqMwyCxa1hqZ9rc3+VihOCToLqN/mNnstYo5hQG8hFgYs6JfQDwln6w9PqtY
         FxrT4a7MKpK0af+MeNMuJNbm+PC7GsDxALK/KBpc04JJLozc9xmhtcrviQaFDQFst0mJ
         3p7w==
X-Forwarded-Encrypted: i=1; AKwUvBx4ZV2hfg4IHzN5MiA0PrzO5v+Q7o4ZVmCyKjd4kvDZjgyw8vrn+pqjX5bCtwJaApBLywd4mjJNzME=@vger.kernel.org
X-Gm-Message-State: APuU4Z80ZXKu5qxsoQFbgp/ipe6JRSVrwHgdspCiqs8LSGjHWQRMnSKw
	IB2wYycMs1yel1D3CiIoI+WJPE+ZoWcbjH0e5Vinuze7T3/eqPS1vPOA7Z281TtX/NE=
X-Gm-Gg: AYBFou1eOchSVfGUXN3b5HuxswwFsNTyNoX/LdfPhpoQjz5iJz6hG3RhOiM0/FEhU8J
	YHbqBO2W1uBn4pTvUe6d4WFI6gd89+S2AXxeBwGJG0UT9OQSlpTSt2BQVUgekV9zRxpf9YndopC
	eGSmEt/yt2LPnwwQBV1VsZSXSA2SmDJS1KqrW44NyaQ65KIGqXynV/VRD9Hmt8kSawVvh0dxwEf
	Wyi4CO81/y1VQ86futYr6o7CQwsvAodz8EWuwODRZ64C2h2OLdoaK6rjqEZF4irao/xllVwI8xR
	CQ7kBDUubLjG7IfBx9H20g1XtlzmWpcpvBiPbWD+9rwG3HL/D1Z6iywVdTp4Qkk90V8ghJZI17p
	KbGHtE83daXCtVPpF1q7iKL+RWl5XF/RxSR0o7gOPqI9Zsp4RXMGfA4KJsFS75Fat+rMG7BrNBp
	v7m9oz6fmW5IZLKFs6LbZqYDyjL/uOF4ervd6Mhvzc85Vv10edTshQeJN6gO+36rFIVBiN5M0PO
	ecQBujwXJWdVLT0GzpOMcr4M7ZDTvKtGwTWDTa6Eanvh75TYl10Oy51bMQ94ahEHf3V8Sc7bchq
	asYLRRgCviu3R8H1+eUTcrTCC2YrDo4l5BnH1+AZugZw4SKMMdaNruvf2OEJaao=
X-Received: by 2002:a05:600c:4e41:b0:4a1:f68a:9736 with SMTP id 5b1f17b1804b1-4b6dfe8f3c1mr33593735e9.26.1793962464578;
        Fri, 06 Nov 2026 02:54:24 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:5c25:f8d1:d9d7:54c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm125584065e9.5.2026.11.06.02.54.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 02:54:24 -0800 (PST)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Joshua Crofts <crofts@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Date: Fri,  6 Nov 2026 11:53:57 +0100
Message-ID: <20261106105358.59616-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106105358.59616-1-olivier@mgcrea.io>
References: <20261106105358.59616-1-olivier@mgcrea.io>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X1600's SAR ADC has four auxiliary channels and none of the
touchscreen or battery engines of the JZ47xx ADCs in ingenic,adc.yaml,
so it gets a binding of its own.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/iio/adc/ingenic,x1600-adc.yaml   | 59 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
new file mode 100644
index 000000000000..f5d4726fdbae
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ingenic,x1600-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic X1600 ADC
+
+maintainers:
+  - Olivier Louvignes <olivier@mgcrea.io>
+
+description:
+  The SAR ADC of the Ingenic X1600 SoC, with four auxiliary input channels
+  measured against an external SADC_VREFP reference (typically 3.3 V).
+
+properties:
+  compatible:
+    const: ingenic,x1600-adc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#io-channel-cells':
+    const: 1
+
+  vref-supply:
+    description:
+      The SADC_VREFP reference. If absent, the reference is taken as 3.3 V.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - '#io-channel-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    adc@10070000 {
+        compatible = "ingenic,x1600-adc";
+        reg = <0x10070000 0x1000>;
+
+        clocks = <&cgu 28>;
+
+        interrupt-parent = <&intc>;
+        interrupts = <11>;
+
+        vref-supply = <&vcc_3v3>;
+
+        #io-channel-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0017755f593b..4ab4ae67f788 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13176,6 +13176,11 @@ F:	include/linux/mfd/ingenic-tcu.h
 F:	sound/soc/codecs/jz47*
 F:	sound/soc/jz4740/
 
+INGENIC X1600 ADC DRIVER
+M:	Olivier Louvignes <olivier@mgcrea.io>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
+
 INJOINIC IP5xxx POWER BANK IC DRIVER
 M:	Samuel Holland <samuel@sholland.org>
 S:	Maintained
-- 
2.39.5

