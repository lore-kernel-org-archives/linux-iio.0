Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4B3AD514
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385614; cv=none; b=tLVqpS3yhQJqSXCIrIeeXRZH22ZxHAV55ZPeAxUy8vIckDs3FmBoyw7hYY0KmF2Ik2X7Q7yq6llF0ig7lVH4cAe8/M2QgXNebbv5zC0Pk7uVl3gda3qzkNoyKpNWbKslqpm5Vxt7D9rxt7eKgoBSIQ1ngMyiKlhJ9UX03DswSnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385614; c=relaxed/simple;
	bh=BVZeE+/b+l5nBGAuQ0yufIyCZ7s18husYqwSYGKFgEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JWPhOzzEtdZ9FnMJqQFWNdsshiq8uZmBuIEm5klXatJC7nKik2MIubwWsRu0f4gIm17E53osBmrObr+8+tUWQjP00UvQjHJ7kXVmp08H2URHaluZYQ/2a7Cxl61H4oDjlAJuKgB2aFmMUwx3BTM+j7nT+0kvGQLnYBroE6PPzU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fc0oK/BP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc0oK/BP"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-845b965c1c4so217423b3a.3
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782385611; x=1782990411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1nW/nmFOqYMEtyYiZrpJrEw0myJ3BtBDyAkNbadcU4=;
        b=Fc0oK/BPV+gPexCHijJ+XYsd2XMZOHlFDIt6x1aE+QO+VcHS/3/0DHBYXNG/ASSVjF
         YFwvjBvIMlHgbDzx7PkdrwQNL1RVCCaGjKR9KfXWWhxYdgUywEeht9U7WLC+KZnK5cUC
         GOZi2+7rcKrkHNpN2Ne/+JdbHnKtlEbj0pV/Rze6Ea0t+LNhcwz6B5UnAavxZe32S0/G
         r4yCJ1rqx0gmd/pgHsndq8BYCPyDMRe7HaRxSflCVVep1cMsr0NDQ2jj9CQ5afwxAD+L
         4bI++3bplofhBDANHV6e2w37JZbwpCFLypMePvUDnjODM2KHkSZybmxgPjP83MDOcse9
         NVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385611; x=1782990411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B1nW/nmFOqYMEtyYiZrpJrEw0myJ3BtBDyAkNbadcU4=;
        b=IbLMnaiIpuCdrIL0shHaoFti/FnsIz1jNosCCrZtb9CeCXpnfzqfTnoOqJyPi6ZiCJ
         h4U+jO9isS+eE5uSkj2W+XPqaHHkwkHIP+/y3xBq5h27Ewt6UyoAjpWXUH+ntqo5AzMy
         b1+IniRX4ErWGZ16EL4f1qkAWOyeDJRbnsHOcccm+bBihTj1HqaELUTq7Vi3I6qIwVdi
         2XNmG5dEzPi7Ekcps9xhWl+Xr8H0L/Mb3X/aHe42XHmbvLzqyWFPBYJE0ikeokPD3cv6
         m3zEF1PU2OsLZQEmw0rb5O6CKmSQwviFdrjhMuRzhOIyCBPApkhkC5WNInDHltB0I3Ep
         B6Rg==
X-Forwarded-Encrypted: i=1; AHgh+RpXrc7z0QYfc/ZGIxw2E6/qEjTkbmpwjUodzt71UznqHhia7nRDC6YxkBsnFcDAo6ImdjDQH48r9RY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlv5qXiAnJrYvzWOHOW191Xmxp+mwM//2VoVIEKYT+Re+cFltQ
	cUg+28zHj1g44bOxLEe8XgQ9hjp1wfiUqN0QNk8WFtlz9Y/NydG899Ox
X-Gm-Gg: AfdE7ckW9qkVwIndfpLlXaqCQbl/isUXA1o46dbGrGGo18FHZelmztXaFtf2tlHOb7S
	IlwXL3grC19KwrYSVtEbEHBczzRKzQJz7OvnKFQiWdOs2vqBP4GtbGtgk2w8rUagaIRvdPUtjGX
	SCxMNGyBZy8SDufTItF1Y45vtpJzNgYYPiz2l0LDUHxPwBinqj31G5t4Sspiek2g8VER7x/RxfZ
	vWYFm0IIsbWBh7tHPso97L/Tbom6PeuGvFQpO+3K2Q7M6cvaEOoqB2d24gGcfUt0pNBI4PviwK2
	FiGnl4OmzyinDmI1BejC24kbR0IdcKw/RYMvI9MVMi7ll/AGE2JDSlBULvRvv3VdouQYb0djv4B
	qlufdV9lpQPhpZpjHhGH8LMffhhIsmAGze0EEGmbDEvlmQRAUNrWA9GkHLqbnsNvPFIolOmNs0o
	NA3sYHLEk5w3Ft7Z4kvUGmpSlCFnjDyTh7cTTez6OvrPCAfJ5jVJHmwEZpGPKUl4wblAvywe6Pg
	do=
X-Received: by 2002:a05:6a00:3984:b0:845:a24d:9b65 with SMTP id d2e1a72fcca58-845b39e6b71mr2663793b3a.14.1782385611082;
        Thu, 25 Jun 2026 04:06:51 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fec0f7sm4412759b3a.22.2026.06.25.04.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:06:50 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
Date: Thu, 25 Jun 2026 19:06:37 +0800
Message-Id: <20260625110638.38438-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260625110638.38438-1-cwweng.linux@gmail.com>
References: <20260625110638.38438-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add devicetree binding for the Enhanced ADC controller found on
Nuvoton MA35D1 SoCs.

The controller has one register region, one interrupt and one functional
clock. ADC inputs are described using standard channel child nodes,
including optional differential channel pairs.

Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
new file mode 100644
index 000000000000..ae7ad0f7689a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nuvoton,ma35d1-eadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Enhanced Analog to Digital Converter
+
+maintainers:
+  - Chi-Wen Weng <cwweng@nuvoton.com>
+
+description: |
+  The Nuvoton MA35D1 Enhanced Analog to Digital Converter (EADC) is a
+  12-bit ADC controller integrated in the MA35D1 SoC. Each enabled ADC
+  input is described by a child channel node.
+
+properties:
+  compatible:
+    const: nuvoton,ma35d1-eadc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^channel@[0-8]$':
+    type: object
+    $ref: adc.yaml
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 8
+
+      diff-channels:
+        minItems: 2
+        maxItems: 2
+        items:
+          minimum: 0
+          maximum: 8
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        adc@40430000 {
+            compatible = "nuvoton,ma35d1-eadc";
+            reg = <0x0 0x40430000 0x0 0x10000>;
+            interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk EADC_GATE>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+            };
+
+            channel@1 {
+                reg = <1>;
+            };
+
+            channel@2 {
+                reg = <2>;
+                diff-channels = <2 3>;
+            };
+        };
+    };
+...
-- 
2.25.1

