Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894044;
	b=z1gRFVMPUQFREJAldy6aJrK2kY4GyNOtD4ENv6f2FFiUp2iuaPXnMwDHmtmocylE0PT1
	 slWwey3M1owL/JdhKULDo8UFprL3AX1gA5pQhzoEgQXCr/ijLOgyh3masv+fM2hNqpTkn
	 kxQkbEvVZpaBnzVIDkNHHCkFyToYzV8HsBrlbqbe4bo/TieHwBSN6OnxgNT+R6jQVdKkt
	 wgUZ9GuqJWTg/ulaSxHbf0BxO8x/+2AlqbAmei6n+1xOy6aYCX8IUdpzG2u5+0oYqh0Q5
	 fXjg4Xw4eMWxawOSFOPNibUF/vQCByZvDnhjEXHhdo3CphHCIm6k48/dZyvUz7nE3mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=7lRC6CWOVikwkZ28NfqI8YIi29jv4pscxSqAe8AOmBM=;
	b=XCCquIrx7BY6YesLzrd0KbazbEHkY4KeyaxgoH7rxtewQAcOXe1KyTqT2uBTERM6W2HL
	 7xV6uCnulDg0nwXdQrDARGiFHOUfuC8NntG+oJs7fNkb7s/8mLI+4U7BBqMJvQ/4VGcaH
	 BjJYR+fbYWVQjoHzNWUs8Vi9ubKf7pIh3TLo/cQ5D6XB/Gnb9rBCbicof4TxDaBLjnMVH
	 0+OwKKHA5nMtfG6GtoF9nGns1hAqGhD5UDqCPiN72Q0rzPXPRCz6ioqwXH2ooApCZ7Dfs
	 UJg/mMHpfoThYYL9MNz4aTabGQnPXPx9LIF9Cpc2D0/QYT3gLRHYX4348wK1u9NGC6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ugt04DdM;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97514606A622
	for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2026 15:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97514606A622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ugt04DdM
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so1768590a91.2
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 07:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793894043; x=1794498843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7lRC6CWOVikwkZ28NfqI8YIi29jv4pscxSqAe8AOmBM=;
        b=Ugt04DdMvXNIQi3CXkpq6YOCaNigKtVrwiH+cApbnptfKsc3875hQ8SLzdVvHnp1BT
         dDJKJlt57BhJ/VRTJXF34zczoA/aVp5goduL7Ghdh5Us3RrGs3LoOL/AsaVHnWTxn1Yt
         yWCn/Vb3vePRNkG3+cBgdBmV0XE4n0miN8b5mHWpzbyQRZ2XIoBZaiF0Iq54jw5ycBTL
         atYFmOBbhhDiuO4wc3GLBxcxNsj/EgNPc8K2pi9jYNhuIshsfZQ5kGY9JrzJy83XlDZ9
         Tbp26ETT/OdIgT2qr2LwwoiTDpKy9aEYZyrTmyiBc9jmm/JdJlTVst3dMSpSWDKet7UW
         vIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793894043; x=1794498843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lRC6CWOVikwkZ28NfqI8YIi29jv4pscxSqAe8AOmBM=;
        b=jkLi1WKPf4/+T8gWPF4HzNPUyfbTuHYBVgVDSkiT21u636gO26RhjnWlSo4hEzXTZ4
         oYG1KIAc3+whDwFj0nNcuxfAz2XKLIyaD7ehB+/CHZFPMs9zccpzCuJOsJeOuFbDk+BV
         bR63YNp1yOhBtfM5wbwwF9fOZlnNpZTEFuhobeQqKt79JSpG9B27KNeANKxkCtx2IBpd
         Jo3qMu6Uc87Iu+R37cZalX/qYq6KqTdeuYwSht5xH+eDh7GEjmjQELleeSDbkZcu7Ce3
         pmwtoRfNGBaHTF6qsKntz9sxNyT0DUWQzJWUWVE74sLVwGAChon0m9LnbbG+84x0+hmd
         JyjQ==
X-Gm-Message-State: APuU4Z8wzpilkNo8LILSCcb7/CfrIIBrXW/Ik10FOE1Pw0HLatZ7Cmgp
	ZmU5Ck0cRgPEb2nh/0LCLHUNKWR2sefHUH2rx7LdATV6f/IIlyP8oQM7
X-Gm-Gg: AYBFou0BbZRNi5EnInTiceOgvIHOa7wsorrYghl4Zka1SDhsfQdMRVLzgB/zd9VF9Rh
	XOBfKvoWpmYBbmVqe0xXeQ+bzs6PeWd4aPxpw+uHXHLDGe0ATUcl1LqiYxjHNQghLbyKqGCOAqb
	At84uAWqK3g6Qfz503uULLQyOQjM6tQ/zvXdnj/7Qmx3QGf9YuW4oi1bK5OTRfWrTZeOq6Wk/Ms
	UkUGzfE9wJDDE6tneGMJvngznVJvhbwVA5lS3r0+VcZTc4GQbkzJMje5q9VEcnK3k44ZJohAS+B
	7HoEHUE8Sj80Fs8d4g828aHU723kz6ymMyDVrvBNYFL+N4z0TBXgjrk0DoLfFLIMvKURPYkRyyq
	uoBGl+0fEJ6V+sf15zSXewJ5vYKO93TPnXrqSrhL6kN2ofSheXr2OWTlzfLZMyLI8heiRxilzxc
	61FUOwG0wFMv9Ao1bTAFXIFaF8ICpmunzZN71JNbLL8YRzb29Hx6i3hqUcagwAbHt+9gGf5YTrB
	ho8F4NM8d1yw7WFvRfCFKU=
X-Received: by 2002:a17:90b:4b90:b0:3ac:da41:ef7e with SMTP id 98e67ed59e1d1-3ae89851099mr16476018a91.52.1793894042835;
        Thu, 05 Nov 2026 07:54:02 -0800 (PST)
Received: from [127.0.1.1] ([2405:201:201e:816f:e3c3:bcdb:ef3c:2956])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b2cf80c9sm4518780a91.0.2026.11.05.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:54:02 -0800 (PST)
From: Viral Patel <viral8854@gmail.com>
Date: Thu, 05 Nov 2026 21:23:47 +0530
Subject: [PATCH 1/2] dt-bindings: iio: magnetometer: add Infineon
 TLE493D-W2B6
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-tle493d-v1-1-3246e91e6394@gmail.com>
References: <20261105-tle493d-v1-0-3246e91e6394@gmail.com>
In-Reply-To: <20261105-tle493d-v1-0-3246e91e6394@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Viral Patel <viral8854@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793894033; l=2848;
 i=viral8854@gmail.com; s=20261014; h=from:subject:message-id;
 bh=FR1ySw/9hgFNGeOtC9yaVRejdNXl5U2rc2d5645AYE8=;
 b=ntwaFkEjnDHWypKRs0NxTxwu1QSP1xhgCTyTbCwd1OAgwx3t9TnJha+6oOgDTsPg4rA7tdYPf
 Y+fa81qBonxC/rkt5+A+zUBzE3QQJpP6QqS/vOgkxJHdZzHUwjSuw/P
X-Developer-Key: i=viral8854@gmail.com; a=ed25519;
 pk=UC+UDB53t70pTK4wncXf3tfh0hsYMCqpxYnTaKX3MYA=

Add a binding for the Infineon TLE493D-W2B6, a 3D Hall effect magnetic
sensor with 12-bit resolution per axis and an integrated temperature
sensor, accessed over I2C. The A0 to A3 variants of the part only differ
in their default I2C address, so a single compatible covers all of them.

The sensor's /INT output shares a pin with SCL and cannot be wired to an
interrupt controller as a separate line, so there is no interrupts
property.

Signed-off-by: Viral Patel <viral8854@gmail.com>
---
 .../iio/magnetometer/infineon,tle493d-w2b6.yaml    | 48 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tle493d-w2b6.yaml b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tle493d-w2b6.yaml
new file mode 100644
index 000000000000..46f9c0e77e24
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tle493d-w2b6.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/infineon,tle493d-w2b6.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Infineon TLE493D-W2B6 3D Magnetic Sensor
+
+maintainers:
+  - Viral Patel <viral8854@gmail.com>
+
+description: |
+  Infineon TLE493D-W2B6 3D Hall effect magnetic sensor with an I2C interface
+  and an integrated temperature sensor. The A0, A1, A2 and A3 variants only
+  differ in their default I2C address (0x35, 0x22, 0x78 and 0x44).
+
+  The sensor's /INT output shares a pin with SCL, so it cannot be routed to
+  an interrupt controller as a separate line. The binding therefore has no
+  interrupts property.
+
+properties:
+  compatible:
+    const: infineon,tle493d-w2b6
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@35 {
+            compatible = "infineon,tle493d-w2b6";
+            reg = <0x35>;
+            vdd-supply = <&vdd_3v3>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0017755f593b..c8916e1286d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13110,6 +13110,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/infineon,peb2466.yaml
 F:	sound/soc/codecs/peb2466.c
 
+INFINEON TLE493D-W2B6 DRIVER
+M:	Viral Patel <viral8854@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/infineon,tle493d-w2b6.yaml
+
 INFINEON TLV493D Driver
 M:	Dixit Parmar <dixitparmar19@gmail.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0

