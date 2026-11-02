Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650395;
	b=iTJmKQHkqk1UIL1u9OW3gsKqTaqL4yl7kbnPEgzcIgGIiO3DbpAKT6QhTFGn2Kn8t+4r
	 jGVsOPJfKpyExx0X2F7FNDQTl45kvGbd4cCemz4aB296XZSxxfeJMLZzBXOJ7CBv8ciJV
	 nJMjEfBXNJJ9WCBsTZEmfPDtRil/m8TR2BbsF/jrfkFOgqzZXKNrE2+GXNj7LqXUM/VxN
	 hd9kuc9SIdeOHFRfTXIOyxWXcbVeBSa5EUuRlpUhUbvVtpLgzgvitshV50Q/i5FUwBobj
	 sUrdocyGBIVeYNdtsWStHxOIdUmJaAnAHczqIXGZoGozmuRgHwAKlml3tWEeGq2fePA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=L2gEpleCd13p+gM0N/gkP9xykl7jsD9jHrOnDwV/TOQ=;
	b=PGlzRcix60vE/8aHt1GS6YkPmVSA0QPWFLqPhkDBp8EKfEDsL4GjCzCicsBblqMdBEvh
	 Q2QqJ8iQeBHVTibt+ibKK76RAV5PMsq204XJO8XML1PROk/jsslQuq3v/IpWuXwidW4sd
	 r0nmgQ17dNOnrJG8kVe6UjST/F16bmNcXLiBUq0ko6clDIzzvylfX4ZNiYiqyzNiP9qqS
	 fALsIDLTI6wLAyZGrMojsygW+3TRWzhCHiK2kTNE68VWiOwy7+wxPkG6E/KAKKuHYk4L3
	 6kTnZ3Zq3tNlNiaBJD959k+fwfR/sU6E4F1MsbGsjYqvYyeSFdivnLsRfhbL5N1oZrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MmSV0NDv;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C53606A32C
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 20:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97C53606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MmSV0NDv
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a208d93758so36579685e9.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 12:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793650393; x=1794255193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2gEpleCd13p+gM0N/gkP9xykl7jsD9jHrOnDwV/TOQ=;
        b=MmSV0NDvusZz1hnlGyvqH9FGRNZmkYXSSPUBGZ9aWE8hBkP1gA1S84f28JHu3Q+fx4
         BbxJzw8iFTkIWHedRtb5zP/sMHHyw0rS0m4/9xpAzCKQlbrJU+XJ1RFjP7Pts+malEhH
         GfC/iGJ/b/NZWaY2nrOZr64AQPXUy6yb/miV725si3g2Zq4p5UTTGejXX8aJEhQ6RoBQ
         FSNl2DzJ4Zp09b7qEHkWTHLcvUVjibmtc/3OucJfYU12u5xUQ7Ms27ql10t70oIiJyLP
         v63o0HjQGe1M1EHsuyGHqtieBL+2hLHmv/9iqzRhPj/INNxY24a+ckyrqtbOiBuROVuR
         znRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793650393; x=1794255193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L2gEpleCd13p+gM0N/gkP9xykl7jsD9jHrOnDwV/TOQ=;
        b=f6bc+zu8p/joTiSJj8RnEGDzWaZfaOLqf2SYKe5NY0fW2ABhEBqDp5Ly3G2Sdd7uPL
         4vhAVEZFuR1il3Cnap38RwZYPB+K7JVOTZa/PzXlb5x/OzJeGyCThvuFYO9DffGmvjNN
         N9Jf4s8cP3QB+SRS3ql0gchXfWiv9mCEu+Mlst/2JHoYOtoEYXiAvCTr7LLGZR7uX/UL
         qpjxI491IDJkQSTWL2wXySiVtceQIwoDomiJWgLAAMLfmpR5Fb+FPM24VXcRJ9iH/O/m
         ExGvu3exdx722VGeO1A72cCcSZ9DgtYDqpCOPcNj+yUNKOYKL5xlXVCGhGEyV1HwI1gg
         tMFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHPtdnPfO/Nr1R9G6wK/VZEHSF3hj62Q1iISN4WpvLc9T7x6sBAIBJ+/XKDJPs/hqGDtqdJ6uvnTs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlDM+prLotzZa/7j+HrmCeaMOqiQErQwx0yJ2+JvotRz/UGYLW
	+Yk5i5tghHhh7B02L1qhuYvuWdKfknFeoVhBUaNO2ekIexHZVXWOj8LNqLXvBjesDBY=
X-Gm-Gg: AYBFou3ZWU+q6BX4kGvZgJt3YMaKk0a5WdPJ/YerV384dP0iCCbG+CtN+0W80GaWlXG
	VTemadYBkbF4CxHIPHgLYarDh2RV3dY/Md+GL3BunFCNziQ6QzR8YqxJeypM4toJ988udeYSd4Q
	kZkhI1uBRiIjhEdQq4XygZ+/qGAZOVB+bLnoKeGlvg+OuN8T9lMikuzc12WFBDNyPh9UeDkano4
	Ut+bzTJimG70DW9DZb9oCvMft9kaN2L0DKOhA6flabxOP8QDWSKpbc4CJOsZz5ZVL+CxR2l2fdR
	o3zsCczr9kdHab7dPaQCT8N8R1NcLJwaqg1afbD9Z5gWzRcUmeoSeXdZEFprKqHkbc4AEqc84ci
	ZpErxPSGtQkk6gReuRt4dsH4ZYcEF9/0YoivzQg2O8ZrkIrlW6x8/kbCkOuKJAYabUndlFfybI+
	Ko5SszGIXylofUZV6RvACqYyikiMgTijGXO3S+PICIgJ92Oz5whGd32/xH5S7EeeDJrUVoIWB9w
	OxEA5AvJad8fRBiH/hfw1iM8gzz0/VxFzvp8QFAbL/S7TY7F8FEXn8kE9zlEG5RD1SmspKcPANx
	36jspTNHgbnZsn2uH01bOszNbeiYiW647XElUrG1nw8BzLEW0Ym8Gb2+jODo
X-Received: by 2002:a05:600c:840e:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4ac17d168b1mr286479175e9.11.1793650393215;
        Mon, 02 Nov 2026 12:13:13 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6412:7406:ded:3229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a82cf248sm13969155e9.2.2026.11.02.12.13.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 12:13:12 -0800 (PST)
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
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Date: Mon,  2 Nov 2026 21:11:54 +0100
Message-ID: <20261102201155.10948-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102201155.10948-1-olivier@mgcrea.io>
References: <20261102201155.10948-1-olivier@mgcrea.io>
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
---
 .../bindings/iio/adc/ingenic,x1600-adc.yaml   | 53 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
new file mode 100644
index 000000000000..f6356ea97980
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
@@ -0,0 +1,53 @@
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
+  measured against a 3.3 V reference.
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
+        reg = <0x10070000 0x30>;
+
+        clocks = <&cgu 28>;
+
+        interrupt-parent = <&intc>;
+        interrupts = <11>;
+
+        #io-channel-cells = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ecc22d1149d1..fd4bb5c6bf16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12925,6 +12925,11 @@ F:	include/linux/mfd/ingenic-tcu.h
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
2.54.0

