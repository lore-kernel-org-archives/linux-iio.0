Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF343030E
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177110; cv=none; b=uy4GaI9fGwFGoJ8i4T9OEcrnEq/xxD5VaEjBoefbHOZ3TThP2kQFfeJEFsU8vkPQ54tJNhko1OcWHoMnXIzhFL+25TVom455bT6lP93z039znG9b5v2Mp0uCgGdD9rin5bRjTsZewoIH89GZQXEVQN/d7PxT11WwV4vmvPBJFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177110; c=relaxed/simple;
	bh=iOCG8b7/pjSOzD64efIJ1behglzXOvSbc1WAdG1bMd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGlXLAjToGjBd/5LPp/1EMoj3w8NHrBhMM8yvKYJCpeIEdJXsCdEhgoAibef/6jm1FU20nDGb6wo5jhU0wQh3FGBNuTRm0QTWIuMdI4CEkKUqyGNUiFhpWmMrB7dQyNbIopknm2fYi4seQAAgL4J311+RUBCfzMbMmWDU+HTLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2Zj/aD6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2Zj/aD6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49550ec592cso1302935e9.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785177107; x=1785781907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I8f0MgYjmDa4xg4Ix9HYtI17++itS/LjzHYnQiFSpWo=;
        b=c2Zj/aD6ofuTXIFB44l2krXC0iZxUnYQQawq9s9oSQPD9sid5WIvKnqL9HlmsRzGdE
         nRcG1Upe9lhKEUgy1MrIBin7rBATLZE8WFDJvfaJnNcnRYNhSQyYkccKK6Yl5DvMOnVD
         CdQaITgmb/DDtn2eN+/jADPTv0259X7MsYbOa2h7qdgcEWAbM2POw6xpSe1bfKcQOzET
         oXiV+Sy3VwOfvOzkUSLu5ASx+1vlqYQHjOZ2wLCNs4OPCPWGl8Wo/M4E+BLDWNJFvx1H
         7czDcgy3lkrIunznRDKY7UYysdc6UaLHfzRb9HxDlGwrbByVVoCb6npv1xJIHEXtw1jH
         A8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785177107; x=1785781907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8f0MgYjmDa4xg4Ix9HYtI17++itS/LjzHYnQiFSpWo=;
        b=DiAfk+jk75U+GMYJSHtiF8UVdoyZFDateaqqtCLZYNUs1VJexiY60qd1FSGx+UqhEd
         /GL1a97PHDO3R7RhnHkiJ5YHmmg70l5Deh0pGzFLNYnhB0RuqldvweWjk7Vi56sE05VN
         0VUNJtZInprZVwtK2eNhtVp+Aq9GF7xUPC6OZdg0jbrforKzEqiRMaaJpT3FsEkC5yDI
         ErbqB1bsV92H27tsZQFUToPn3oAw36OhJZZmGtvqWME4tD7Zt3cxpxcPUwIq61KNi5dm
         uZ/R9ud+t3dFUy0B2Rqc37CQK3b7WmeW0NGlBWbgzZVhJZ5YbZLSU1cUMcwx996BNB3q
         Qc8A==
X-Gm-Message-State: AOJu0Yx7Fq5+abAlBMKbrztZl0JhZ8jwys1YbyUIwfktW1YSf5mlthG2
	Jbimpg+2TvSd0C5/87Mfrsl2+dEMGi1WWwxPjqJ8jPgxaa4/RIVz/5/+
X-Gm-Gg: AR+sD12CZQqSdRIxojtTyaxbtgD1twoZA2ekAJ6qCTllJxbG6Rh3976lb5i8gK2qwwY
	qwAYUodkjAPH6JDPKDwH/pSpihnS4E0t5hVs+F9Fy68scMAimJMgqgTmVwXyhkFRiSSBnAH/PA2
	GQKk6lh+biao9a7xghxrGo7kJFohnJsN3bAf0ydZMc98da4k1xmDeEZXHCijyivzIKgvMVNEFSG
	N9A0mCQdp6kBJ0oE1rIc0kfxL7xYHMOezG2lD+4pJT6M1wPw++3EjBRcQyCMlm+0teKfLwKBCRz
	fsu0g1RGVJxsDgU4gkg2ydCJ92QCquCiUnlTrt90lNmhBG0fh1j/qLJLAszbaKipe0cm4dxScQ8
	9fEEaqKEcV7HFofx9hpuU7IYFHtX1SV1gSP7O+K1CDZDQdB3qzC5O9wcy3dfjIZRfK9QCigTlmQ
	9xA5NmD8qAKMwy5Q8LVx9Zl+yhqWdypssi+fObhpAjD3VYpwYVnbd9vnxtZ7lNqwOAkl50Wif7+
	p+kw1KzInt4uXyIN3EPOJuzxMSMseBxluL/M71yufZIdOEdnWQ2gEw/1ILQ4id/99iHQErATY+g
	WfjQAa5rHiZR0I4lj64eH305g8i5i4SukHIqNVwDa3kkB1OvmnkTsmnVHEpFKA08xUgcbhmgfyB
	QogbqFYPhGlpnjhg=
X-Received: by 2002:a05:600d:848c:20b0:495:69eb:27d3 with SMTP id 5b1f17b1804b1-496c4641946mr5177775e9.8.1785177107023;
        Mon, 27 Jul 2026 11:31:47 -0700 (PDT)
Received: from [192.168.1.187] (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c44b84edsm17800535e9.5.2026.07.27.11.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:31:46 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 27 Jul 2026 20:31:24 +0200
Subject: [PATCH v2 1/2] dt-bindings: iio: dac: add support for mcp47a1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mcp47a1-add-support-v2-1-d4591a2ce69e@gmail.com>
References: <20260727-mcp47a1-add-support-v2-0-d4591a2ce69e@gmail.com>
In-Reply-To: <20260727-mcp47a1-add-support-v2-0-d4591a2ce69e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785177105; l=2425;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=iOCG8b7/pjSOzD64efIJ1behglzXOvSbc1WAdG1bMd4=;
 b=RmvKsuBNiK53lXBdcVeiLiU6APrqvR8CBbuVPS9m7s4ctvIWc4ws1jSnwajmMspi0usl16HRr
 9ViBZQwzTz4BEcvKRGYjaTrOkm2KcCRj+TMp+Mp+lZ7jVCfEhBkAQTB
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converter
which communicates via I2C.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 .../bindings/iio/dac/microchip,mcp47a1.yaml        | 50 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
new file mode 100644
index 000000000000..b181fe73dce8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/iio/dac/microchip,mcp47a1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP47A1 DAC
+
+maintainers:
+  - Joshua Crofts <joshua.crofts1@gmail.com>
+
+description: |
+  The Microchip MCP47A1 is a 6-bit single output volatile DAC.
+  This device can have different IDs (0x2e and 0x3e).
+  https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/25154A.pdf
+
+properties:
+  compatible:
+    const: microchip,mcp47a1
+
+  reg:
+    items:
+      - enum: [0x2e, 0x3e]
+
+  vref-supply: true
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          dac@2e {
+              compatible = "microchip,mcp47a1";
+              reg = <0x2e>;
+              vref-supply = <&vref_regulator>;
+              vdd-supply = <&vdd_regulator>;
+          };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index bcdc00999ef8..8a0b23418a64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17699,6 +17699,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
 F:	drivers/iio/adc/mcp3911.c
 
+MICROCHIP MCP47A1 DAC DRIVER
+M:	Joshua Crofts <joshua.crofts1@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
+
 MICROCHIP MCP9982 TEMPERATURE DRIVER
 M:	Victor Duicu <victor.duicu@microchip.com>
 L:	linux-hwmon@vger.kernel.org

-- 
2.55.0

