Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783524;
	b=h2e/1+N5OeWoQ9JDMwE1MgE+4MWH9iHai24yeYMhVi6ce+DRnO/8fVigmhkaPUzCMZbk
	 UKhui5scyOSlmFIUzxMcVagbeQkgxHfa3zicMzOR2NDa8449DST3MmA6h6+UHUAvApM09
	 y7itfBEawylnAPrHy2rcP+NqrnjXkwJQ9Hk8USTZE9xszKxxrcN5V5cQTEmnBPSjv9qfI
	 964K9QtVNH+zu8I65m7FLghG20ELWpmdi48Mk53hWS3hIhSGc0q/xqWtjN5s1DSrbmGBV
	 QWk+TVWR85/YMoOFPGZOdemi6+AwOcZDyI4eP26WEJnKP80+Qfytt2ipxgcPa5nCTmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZRQErjs2YgeDf8s5xj884w9gADjkocnjTDloPkEx5rw=;
	b=MZHBly6j6BDgDgPE9BDlNOAgfazBUF17a2/B1xGvLxHwanpmgQ3eeGtJlNc1NKNcdgrG
	 PDKgSnHg3KnSGKF9/eSPod0t5FnZwvH1dXNDeE31OKfkosDtYk3VG2u5oMMVBcgC1TZUy
	 NFEfMhI0UbKKpmAMBPjJ1FGJie/Z8veSVQ1DN7h7ddHVcwbcqqLlOCrE022632h+RRPBf
	 twihKOjskslYm3HNluupTVDHBTfSY7xLPv02R3TjOSCH1x5ldXboXCujtNS4GyWAp1nGG
	 aes6VJSyxuqej0bjUQ/hesipQcrayskeabLvd1KmUCh01Xl6cqQ2zgMD8I/CMCc7sKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NPx0TTzM;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C21606D801
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 09:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C21606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NPx0TTzM
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so179444a12.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 01:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793783523; x=1794388323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZRQErjs2YgeDf8s5xj884w9gADjkocnjTDloPkEx5rw=;
        b=NPx0TTzME4v9IhTPB7tIMVNxniMALp6xCidYN5AwnJycBTkqqFjJZOyibn/MMvqNMe
         9VLCc6txK/ECFU3RWxPwWWAAuhbvZ6GJbDM0DCKSLiFpPwZ2xyji6n7epw9h6qF9jYif
         0p3UYCqYy1pvFwmicFXGl20fLdsMJl3BQ8ZJDZvIsASOzvaf/eZCeujx2ShvvRPh/5uC
         7NmKz8ZzowyVPkt3Os1YUKW9VhCxZpaVHHtr2IK+4nAbRyboE0UmswCsG0b3sMyY1Gvd
         Gf3JTPAQb1GpwnxMbzOCAdeoWNnXJq7p2YOL9+TKpvdN1/NxG9Q2hFDi0ZY5iqm9eDy/
         QQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793783523; x=1794388323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZRQErjs2YgeDf8s5xj884w9gADjkocnjTDloPkEx5rw=;
        b=mvZnKCOlM0BYZ1cPqWH3xQjfC3CeNMDPprf1zBswsXtlCMPKTcJM8SVLa0NnCL02nW
         U13RdSSCXcOA1caENkK819zRAInu8ES1XnQ7FqhBnKr+7JVLlucKubwREBr1f09ZbZFG
         3O7tuJwY4E35SAiS0zg2ZLCzBmbIGYRTOmB+78IjpqgXXWeGlsdd2uuJM6pn2F6gndRL
         rYkbWaUSkvX8iVttPKri5dYmvBf19LpzXD+V68x4aDCIeu/1NmEZFclSlcNT7u8h3fTG
         AVeL3sBtV5ZgLf7WKnBHJ8krgxMJhhcVyPtWgxwcTNPMfExV69DriB4ykrM4FeIZB7aE
         a/wg==
X-Forwarded-Encrypted: i=1; AKwUvBzTB5FCP8SHvljU5U+yArJQFdtdTPO5UIFL1MFuTZ2RU3XkXLI01z9PmfftHZL33PAlKMCldEPROOA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iLd5EtYNwY3ftVa7oDqlFKkqJwD4Uw0qjzb2XUqNH66z8luoY
	C2lRP9vXolqyayfv3VBB6lXpI6Whk0DAtHo9NtkkQCRa0mWwIV16KW0h6v0Mzg==
X-Gm-Gg: AYBFou36D7j6WM6nLTgRS7khbOuw61BtCWqelo2AYVJB9fc24dyzjETcs3x9S8ha24t
	ZoeE3a/WOzewCjwPbW6p3/03xofgCKDHxne30GQgWf3p8B9i7j7P1HVKhFDCkb5HE5s/7L0dQ8v
	U+nYxMoooo6qxT53UnKJkjP6p571307fLpbW7WhAQ96YwZEDjJhxe7y1gL6q74+qfaEtLwftDuy
	nbgeYmWmLOgK8/90FaQWotzA67wRU2+zwQpZR0XGzjPW8o9ZhmjTAAkHHe4rvvlEjmicRonyjlH
	jiUgLt+VOrF1ANdcTBbtesoFjzjYu0lhR145xQCPKdQ/jrRfyXIbYvMd1VcLPMS23dLeaxEPSzW
	GTFnadmKlufeWpx+hjLi/vTPqh7t5FHBlPy/tFhK+7IOym9nfhsOgixv3Ya7ZUoWkbY5ixEpOjy
	DIbH1cSD6heEaLXCug3jGmikzQLrxRK1umhJVVyYcbixPyVoH2ewV0YcWLhKfwZ8bQypWJPTo8v
	ud6RdAYFFCNcROjQdK2a94R2ES+1JgJ8JiQos8E9CBGbQ3IjhlzLEdEB/Q8r3XrIcdJxyjbcfL8
	ptc01zIpxLTbMDRYaE6MZ8oQqUvlRM5QVUl3zUX6/oNkZdAEVacWY0PYDJfBrAiyXrZVw76ckes
	BMOGqyPWDhFWR8m8=
X-Received: by 2002:a17:90b:33cb:b0:3a0:ace4:d2b4 with SMTP id 98e67ed59e1d1-3ae8973643cmr10988729a91.23.1793783522643;
        Wed, 04 Nov 2026 01:12:02 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09369c638sm3167257a91.0.2026.11.04.01.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:12:02 -0800 (PST)
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
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
Date: Wed,  4 Nov 2026 17:11:35 +0800
Message-Id: <20261104091136.151269-2-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261104091136.151269-1-cwweng.linux@gmail.com>
References: <20261104091136.151269-1-cwweng.linux@gmail.com>
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

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add a binding for the Enhanced Analog-to-Digital Converter found on
Nuvoton MA35D1 SoCs.

The controller has eight external analog inputs. They can be used as
single-ended inputs or as the four fixed differential pairs 0-4, 1-5,
2-6 and 3-7.

Use the common ADC channel properties to describe the physical input
independently of the logical channel index.

Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
new file mode 100644
index 000000000000..85b0feac0236
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
@@ -0,0 +1,163 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nuvoton,ma35d1-eadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 Enhanced Analog-to-Digital Converter
+
+maintainers:
+  - Chi-Wen Weng <cwweng@nuvoton.com>
+
+description: |
+  The Nuvoton MA35D1 Enhanced Analog-to-Digital Converter (EADC) is a
+  12-bit successive approximation converter with eight external analog
+  inputs and one internally connected VBAT input.
+
+  The external inputs can be used as eight single-ended channels or as
+  four fixed differential pairs: 0-4, 1-5, 2-6 and 3-7. The internally
+  connected VBAT input is not described by a channel child node.
+
+  The controller provides four interrupt outputs, ADINT0 through ADINT3.
+
+properties:
+  compatible:
+    const: nuvoton,ma35d1-eadc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: ADINT0
+      - description: ADINT1
+      - description: ADINT2
+      - description: ADINT3
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      Optional external reference voltage connected to the VREF pin. If this
+      supply is absent, the controller uses its internal 1.6 V reference.
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx
+
+  '#io-channel-cells':
+    const: 1
+    description:
+      The cell selects the logical EADC channel identified by the reg value
+      of the corresponding channel child node.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^channel@[0-7]$':
+    type: object
+    $ref: /schemas/iio/adc/adc.yaml#
+    description: |
+      External EADC channel description. The reg property identifies the
+      logical IIO channel index.
+
+      A single-ended channel may use single-channel to select an external
+      analog input independently of reg. If single-channel and diff-channels
+      are both absent, the external analog input is selected by reg.
+
+      A differential channel uses diff-channels to select one of the fixed
+      hardware input pairs: 0-4, 1-5, 2-6 or 3-7. Each single-ended input
+      and each differential input pair may be described at most once.
+
+    properties:
+      reg:
+        maximum: 7
+
+      single-channel:
+        maximum: 7
+
+      diff-channels:
+        oneOf:
+          - items:
+              - const: 0
+              - const: 4
+          - items:
+              - const: 1
+              - const: 5
+          - items:
+              - const: 2
+              - const: 6
+          - items:
+              - const: 3
+              - const: 7
+
+    allOf:
+      - not:
+          required:
+            - single-channel
+            - diff-channels
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - '#io-channel-cells'
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
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        adc@40430000 {
+            compatible = "nuvoton,ma35d1-eadc";
+            reg = <0x0 0x40430000 0x0 0x10000>;
+            interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk EADC_GATE>;
+            resets = <&sys MA35D1_RESET_EADC0>;
+
+            #io-channel-cells = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                single-channel = <2>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                diff-channels = <0 4>;
+            };
+        };
+    };
+
+...
-- 
2.25.1

