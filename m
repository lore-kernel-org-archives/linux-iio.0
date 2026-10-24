Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792815245;
	b=UA+GeRlLGBprFekYlOW13SPMOqQ64lpAIK0f/zNXAF+/Xr3dvkpUY8swrbU+4QYTv6Db
	 KvP6j1vpOx/vcaor0A30zOi45zyZY7Q5rTlIm1kaWGgcRg8U7xdSDuOD75V3Lnj8uI6vN
	 AZ6rpqbmeM3FHx9VpLiJ18hpKamVJCZyh7p0FNBSTtW0bboL0x0kM8v4s08/DIzWpD6YL
	 soz9y2M8kcMGHMBCIGkckRyWcqnJz7W7T6ZXDEcN88JFDS7lm/QfbKMDnO11C+IySYZfT
	 CabwKQ58AffGq3kXeiJ9y2A1mYShBzg6+BIOTnJUXgDy5w0tHuQRWkXPh9kWJeikI5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792815245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2Wi9nFKnE/c4EPmrilG/KSDGcYcdbtVNJ4lOGd9J52s=;
	b=bE/TwyysFEhI+1pSi+QrhyqUcH/Yo+yli8hsPh60gbkmelOPN+sVs5pgcoY+SjOFax8r
	 oIsUM8oXrOUphM028OluG7ceoBUGR3KCIckN2ExGB/VozTQ2QV9t51LUHjX2WFFPMwQpA
	 FvXPghnlB41lkjzsS72M/iZptLQxKskACxOxjEML0qLu6hMGvH1pbvwftcLgL3pwT8WW3
	 EmDiiMDG78/apyq36R9tEilreOa+WmllAJg8Bp/VErwhvt76FHImyOmG8RCSEsF0midnd
	 ttkBy4JcWw+u26EPZP28NYBO4hF8b0Gj5xJ+pu3sZeOyyfkYrNisymegHETQRMGSgoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Os21mwMz;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3D606A33D
	for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 04:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5D3D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Os21mwMz
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so14879605e9.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 21:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792815240; x=1793420040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Wi9nFKnE/c4EPmrilG/KSDGcYcdbtVNJ4lOGd9J52s=;
        b=Os21mwMzsXCBmyGzcSB//pxKjuPPNQtlMHyV5HZEUycbuYFqplMtYiil/yIIRDD4pG
         ZMktH1avkIIZQbOBscNlCJXS3t5TwzwSKx0D0Vuf/RFdmXjn/UDizoPF8yIA5X2mayuI
         tIqo7OKFrmQ7wEzGip7I2QEQfMgwmGKZYMuzp0ktOkKyz8lL38MwKqAV6N7bwMpyh11u
         MCclCuNeyrPpw82x/LYLrCenNArl2/8gGzvUa5sz3eb/lU450+Dde5i12jvnMAOKKSms
         brtJ54qv3K27dCno6dJLsRGhttNn84om/r0VBYapQ5TZObqGQvPMnJ/c7AOAmE43axe9
         SdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792815240; x=1793420040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Wi9nFKnE/c4EPmrilG/KSDGcYcdbtVNJ4lOGd9J52s=;
        b=u/PZn4Y8LI5RKnOzTOnFjTqq6MtMdTaXMPgljbNI2OILoz96uRKoiEFshU00QFGGhj
         tXsDuUOaJbsdOqAR3QdoEmwY6Ui35sJCa1PNC8e3fcISxKAby8WqT7mzcZNlJ7udViCz
         oVx8BkUN/jXRY73FZii1w+NN0yhVCX79nM5TmxY0RadM43cWDwshLB8Hu/dolCkLoObW
         8Voso5ntWEVEGIv70Jg6fm8JTqnv9/qXvl5eBbACtqpR6FCpHCjBZXsNTLjwbO9IzvAl
         4BHOrx94byBVj/KiKB1v0nAMAZtxviq8GTBnd5LJEO0YFgR2TL20oNrlIy99RS9m6p0j
         2+uQ==
X-Forwarded-Encrypted: i=1; AKwUvBztXfmx0SEnZq9txhIFXjH+37pjj3RL+cNOipcWFkqgCSD38YCYx5gtmcamBQpxbIxvROBAOTTM9x0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbrHA6/JDJ6C7PAoHTHq0At9n0EnzN8j02uQ6LBn6eI0Y6mWxA
	mlsYsW2/1uJ78ARDHGJdy/2EFKxPCa+nw30OuRmFiUKEz8Omb0xwsBQmc6/gRCOiA9c=
X-Gm-Gg: AYBFou3I3dWw5J0kG/9g8tSPsJWracbK9SGBtuMM4pLUj/A4QY72SmINEL6yB9hj1U0
	jVwbcv6scb8Vmp85Q9RU/A8YjsgRK1Ybj7uL7xDPks3sPw2ea+1VopjUQ3Airljh1cnZEhQcy0b
	rbcSiqfGIBc13LQXb7++BVDvKZOQKEugk/eBY3A/3kWYBz0XFYHVUyhxM+0aToM6V76dtcNd2of
	59MM3QCLYj2UcDMiWX6VSDXbv7RUtmEXyBM67ZHgR8HHRnvOfhFXVM+rRmL3Dhgyol7kyO7ZjPD
	eqabL0WxUb49T5QXpFFC9/0PrQ6vFIgkHPIUxt67CXUO5ptN0YI6n7vBKBaZGvp+z19XBdKvkDr
	mpjCIie8H/giClHKKbhuWXJ6WxAMw5G1gAykTgQ4gnSDWC1G7mD4HbI1F3KpcbwhZY/N0/wzti7
	Wu5QvW71jm+jiJATWXSd9JwbLMIOfXIiopPfaEiJqzA6lEM6nFq7RitXgh+90BgbnmLpV+hYpzb
	mGfhdt66UZCcqbCJx3N3XUiKn1sYQ5Pw/UdTyRoTDhcqP1cmh0NJPxP8G0t00YGDuQ4E26Cyf/V
	YsAZBbP/E3I=
X-Received: by 2002:a05:600c:8581:b0:4a3:5da2:38ae with SMTP id 5b1f17b1804b1-4a35da23c55mr463285e9.14.1792815239806;
        Fri, 23 Oct 2026 21:13:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9c3:9990:89bb:701c:1852:56c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2c0458sm26332265e9.11.2026.10.23.21.13.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 21:13:59 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Date: Sat, 24 Oct 2026 06:13:56 +0200
Message-ID: <20261024041357.34346-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
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
touchscreen or battery engines of the JZ47xx ADCs in
ingenic,adc.yaml, so it gets a binding of its own.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
Changes in v2: none, resent with 2/2.

 .../bindings/iio/adc/ingenic,x1600-adc.yaml   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
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

base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.39.5

