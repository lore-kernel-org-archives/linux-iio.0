Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003871;
	b=pWp4MdqIV+G1sPB5mJwQsErd8GlBgoR9grOdK//MSdj0lyHhI2BLv7Efc7if8SkYKYOO
	 3wVRBRQYprTCjcihXg11I/OEQir+9uoM3b5/dhojqHxV1N1EnHs70zkFwNtHvlsLEVhvG
	 EYEe+Zzhg8VA2192SMXfqbfGexArgVtkpB/cIQ30a0kuKUq8OPL8i44NS0jg/VnJ56k7W
	 7rJxlnjGRGxKIzBY0X/Fajw6orJAOFBSfXLwbyCKvrZ1JNZsNNqBlJT0qehXeWQ8x9W7m
	 SO13r8GtMDETdFHaY4Kj4PlujyzBhqnwI1XNYSFuVot+/VynTPEpVutmjvanvbWsDFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PVzvJsl7BLFlmP5S+Z1OR1o7F1Ju7Lk49SqRaWPcnEc=;
	b=Hj3Zj/di1NIL7HU6N+pPJ7ol7qkaeQqJj7caSeTkQnB3Z7xrBppzLqGmcGDgxVX98RGn
	 rIuuP1StzsC8zoY7f0hGBvEvZ9wKXyeFSVEIFm/rDl/SBKXwTdqmzY7qH5g4myHh0+xZa
	 +1jKS19fp6/kvmYMHtxVJXPBQcQqoa4TH3I1TUZ28E5fh13/D4DWKRIIwxY7J4Bkt6rsE
	 vq1Nb/m5sUHQUwdtyapbPjkVTWpGc4ackX8RmrSUC/GHgoDaDMxrTOiWTG1pKF4WETRA5
	 N7XCwgFUEq4ny8bJrvZjdOXg/7DrBT/9YpszzEs6oLa5xaj6z0dyQVLKINEZEEc+o1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=z4ezabx1;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB48606A322
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 08:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FB48606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=z4ezabx1
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so15986095e9.3
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1793003869; x=1793608669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVzvJsl7BLFlmP5S+Z1OR1o7F1Ju7Lk49SqRaWPcnEc=;
        b=z4ezabx18eIoRMVxS9bqcLmnphuqgDGaaiWYxtzP88EJ2F29LetBPN7fnpWCuSn/vX
         yzjil+XS5a8aE9zYNqRgMUxOJ+JRBo6HjOIxMNpVzyisutWN2q3x0JaJkJsZxNqop6/l
         aaE2sB2YKvg16xm/qsEVt+bmeZUKtOTA8DPfDmTFjVYFNXJEMNXw8MR9WEDWLT0UO+b+
         kekA0ZaSA0baZV28NQCUi1dWUw4/LMv4aLD3POZkPIFYoE57NoiZb4rHOxOj6kHFhZo0
         I3kPzkYqHLJMl5edGXuDjJeVxyvIcbyJPzM7SAHStDAJKXWlZepZteHwfw2R7oEeHZL4
         U8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003869; x=1793608669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PVzvJsl7BLFlmP5S+Z1OR1o7F1Ju7Lk49SqRaWPcnEc=;
        b=IWWzwZEIhIveOp+tcXS2JEYa/T730q8Ngnjn24VA5EX/kxOvIs5l9rpK/pdA1M8xIt
         NWrwt7+XQe6Q71ByrettncuNAh9NkOMk1ObTkGzdNoZBPtiT61s5TzSZjOLEsZ8fGpPS
         zCnb0l/tF9pFTHEARGNFO5Xpy2QVs/NdWBMrcpTlrv/4uxRE3E5LDpvlfp6RCzlKMjdn
         lQKypPAwRs0aw9fuRfuC4Q6+HzmrfwrrR00Uk2qKeCfj0B2Pg/Ijc168k7xeP2VM8MJj
         6EyxPUxqX9wCTCngbhbX0XtPFTwymBsvskiWQY0y90vVCMUSAcfPidemc0qtFKMNcZqF
         FA5Q==
X-Forwarded-Encrypted: i=1; AKwUvBx9R1YHsZd0yV3vlQpFQvp6Ormh3TukNDzYWaZ/deIbID5VgqJHubHAsQqs99CqYNjbMqXxgwmL/1s=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5bxPQpTDYpWD1Eb3wa+++ePcQFgT5g1KEdWlQ974FmYr+GmhR
	tTfoMha5r/Z5rKowwgnoCFCK0QU3ItxEuxy+60fAXd8ga1S9MOvkl67D3mtgPupNLiE=
X-Gm-Gg: AYBFou1pTtBHxLA7JUCUss0NpEBXbmo84v+HB/0lGS3gi64M1kG14myAlZwHdt7m5s0
	k164+DH89LleSsEroXN2BAmEChG5c7f4Mua9w6jQ8OZwLKSrvISHV1m2EdXhRvdOcyrUmemsjYe
	/qjRdwuFAW6FxSEPwiSn7C4psGo4cszDLXaJ2xY5BB20YdMR7WYTMXNgOKpANMRwO/wSYQkBChc
	DNmLreCactsCceEc5b/KnULesaG+FLk0iTG45TqT6+a9qpGY3SYVf1BRHqFgOC2fTajF1M51GRo
	bFJRUQNH3TjkLQ+Ls344bEmbVv8MTnUesZHewar176QR7Zc1RpixnuTC3ymtilBLFMVOpgPQ2xq
	52VkO+hRmrl5HzKL/HLzQ6v2kckJj+V3PBgCQvWLj/v1FsZqmwhXJqUKLIZxYIzTgiBp9G4H+Pj
	LtChzEWm8hYg3Yo5ruLthVlcHPg5lq784J0Ae97JTddnshDYahqppHvpfst0GJXTye/b8ZU7ZkH
	kkadO3M73Cy+kanjXaLrzo/T/IVGIUoFDwG6H1NX00LHd3XBLsFSpUqzff73dQPoUappb7y+yzt
	N7ENi+txdjCRVw==
X-Received: by 2002:a05:600c:3541:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4a35acc76eemr102904505e9.34.1793003868610;
        Mon, 26 Oct 2026 01:37:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6dfc:5715:ead7:7540])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8dcfsm15091889f8f.50.2026.10.26.01.37.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 01:37:48 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Date: Mon, 26 Oct 2026 09:36:30 +0100
Message-ID: <20261026083631.48406-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261026083631.48406-1-olivier@mgcrea.io>
References: <20261026083631.48406-1-olivier@mgcrea.io>
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
 .../bindings/iio/adc/ingenic,x1600-adc.yaml   | 60 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
new file mode 100644
index 000000000000..7886836b10c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
@@ -0,0 +1,60 @@
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
+  measured against a 3.3 V reference. Its clients select a channel by index
+  through "io-channels".
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
+  clock-names:
+    items:
+      - const: adc
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
+  - clock-names
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
+        clock-names = "adc";
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
2.39.5

