Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914410;
	b=215N1BWFHMgCcnNJ7Xwy7pPyIdkb5aCHnOmmlUXTbNx5ZlX6g+RSOfTySv9nln3mb6f1
	 UCg0iJOnDcMcgnl58NDDWt029lxKrfIKp2CRAnBB6LK/zXSfJM74hDeO409WbfEsmGMMp
	 9Ved3v/MZxf4I6RKocleCAxoHdmfDMgfsWisrzdrxsb35vQFYqA97paHbbOyg0Zh2xG4d
	 UF1zmcpSjHae2PfcSzTeOTFjRIIXul850NhF4vP7QWm1Yje5/rb689mnuphZMNqSU/yln
	 M1uc5PYDYES6cFcboOPfG1BD0duXchx47nlNAK+SgmqvtOTtWsCISP0TU0KHtuY56PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=92o1r3unVdbWRpanlWf2vvjYntsWPitLGDtBwxmza24=;
	b=oNgfRXzMOKCRoLoIUNO/lMygXvQtBiUr69wB8KdpSLz9fNGzXnZcGJP5xJ8z0tzsnPXT
	 wmk1WsRYQXYDwLcWfuZQlDitTj7y9V/gf4Trk3fo4mbxnowvkMmBLDX/WCUCSXTNh8qhN
	 AFI/DBnlenutc7uNiZKkircoBy3S9iPJKWo2Gx1LpJd4fwCJ/E69o4vIscFa5VZwM7Dlg
	 aUMKciw4vBNq5UqH99qAKLDqdX/BuKh0veq1OxiAKo5DquDA8i8OcGYvrqWBnPqAKFGI+
	 I2eTdkKbthVxQKbzqzerowE8r3g3cMHUHklfKQ4S99H29wmjQYLRa0ghtVAqmfXvX/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=C2tDiP55;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071BC606D803
	for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2026 21:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 071BC606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20260707.gappssmtp.com header.i=@mg-crea-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=C2tDiP55
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so15012555e9.3
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 13:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20260707.gappssmtp.com; s=20260707; t=1793914408; x=1794519208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92o1r3unVdbWRpanlWf2vvjYntsWPitLGDtBwxmza24=;
        b=C2tDiP55ntEzCyjE4ep0O7QdsCE3tAErlxQy8pD+FUet+BE6r/Xl+endo6B7ro0tlA
         OL/1Ju7mKCz/oulfSwGbpbCY0p4GqEg9uObBSTLm3MWfmCjAgeSUZRdtY7tkx2kUMWwe
         WBu3BwGrCYXkCvjfTb5kdi7fHjQwV3JyZli+czE2QWFlaqd2jQAjM0ru6Dwo5mzVt7Hu
         Nnwz/L+Xe7mWqmfgiDHAs5TpfmHSj7Sz/RY0k6kJbp4G9ewXWJ2oRcRTf3Fez01EJ1OK
         3vV1HsMuGPKvYW0/IL7VQkWX0lZShj8FsPaEeiXwgkDu6ipNfVV7X28Jjgl4acCUZyCM
         78Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793914408; x=1794519208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=92o1r3unVdbWRpanlWf2vvjYntsWPitLGDtBwxmza24=;
        b=yM4RIL+4KSddnqb1GKpWxqP4SWayBsnHl0D8PKG7MkWKqlbMZ6sMD3tpI1SikzZZ8P
         7hrY6SGuQ3i274T2kIxSL+CbfNpAxuhstxmAKKtYyerueLfAPCF7djZT8Ynncli0qk/1
         dzFOVvJVIAIo3peX657iJTVQd1ufTiLpR1pg4zp3NhjZvMXD7p6VS1jvbbQYir4Euvaj
         BrwKiBCVBP2kKWqaRDRssmsiKYKlspw0cnuUOxSM3Ox/95sMDW9K4/4QNuZi28GNd3xQ
         DF39IE5jcJvwt2+TlSReLeFcfIhOU88ukuA9lKLWGu9qtBV+YRIhYLqMyebxHAknhpCw
         HxIA==
X-Forwarded-Encrypted: i=1; AKwUvBx4X6xpxRiY/AuVoVFyLOjRck2mRyhtROYeamn/4rEoND/hTP20FQP7dFEj2uYf5s4a0r2yFmvIVuw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hajbv8SyvlHYDK+TP77cEa4mo12JbzNgO21fafvC7vPs3GFka
	a6kX1x/O+CvqNWtOSosUnluvfwnB3O8LZw2ligJZv0RQv50HxcWfcfVv9Zu0m70nr08=
X-Gm-Gg: AYBFou17poREHVti7dx296ixdHkDMpke2Ylv/r3zisb6CEWsdYG1Wk216+MaUQ2NbJQ
	Vd4J8/Ej7dKUgsP8Kz3v8I6rPQFx4g4iy9X8tvDlUrfBS4+s/oFOt0K8LG5XobS5F35s6j291l7
	J6zOZ3Qv3EwBB4JAhmXyyXi1sqp0XIEmO9TTgcF61VFulJdnQlz7c2M7uSLC4McyxooBcSRQ5QE
	X9UL0oWOV/fwduBsjx+pe8dfr3HE2enQYSvE4R2QqufUuWotmlL+uL7dEp3Wq00Xzd782fpwASn
	5rSo6EcCqzeA2D6CbNHVWBxmycELT4dD1Eh2xPgksObsxZnjM0wIWKeGWchRwEfHWR9IKYKQ+RO
	dAWhVMUO2B/djvH/bilUeSx7QbAOTT4W3+3YJSgTOU0UfX/UHdcxO0qFIYxas3ap0GV6gzp8vXZ
	6PQSikfaua+HjL21L7LUi0Lzdde2o15k5MmGSJA5DzAg0k7us7+lM3JfVQx1XU5YjrrnyOlJxi0
	buy/QM/nxKomIlO/DaLoOQhvQClC4MU1Mg3GBNQzdoGMpE3Fl3DfTS1I4Xbx4sTRp8xlSlMZXb8
	UePINsI8MDeV3dxs3sfm1KxC2a9ciRfuCpcdEiD4EYNtBPFvsJPvZA2/8zJw9w==
X-Received: by 2002:a05:600c:a015:b0:4a2:1612:6367 with SMTP id 5b1f17b1804b1-4b6df11d637mr5657585e9.15.1793914408338;
        Thu, 05 Nov 2026 13:33:28 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:5c25:f8d1:d9d7:54c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b411de95b4sm107798385e9.0.2026.11.05.13.33.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 13:33:27 -0800 (PST)
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
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Date: Thu,  5 Nov 2026 22:32:09 +0100
Message-ID: <20261105213210.87457-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105213210.87457-1-olivier@mgcrea.io>
References: <20261105213210.87457-1-olivier@mgcrea.io>
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
Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # LX16 - driver only, no real world test
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

