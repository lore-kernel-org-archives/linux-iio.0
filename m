Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904168;
	b=LVAz0PWpoYueoMRJsf/qyfA+wmSXadHuWicY3Dl9wJcMpepBO5cZbbQgzyV4XQU4StfU
	 PvOs6sUfX7uFtN5TNeez5KuFchgQ9zAjwz13fuftXsz7ZLK2pMp+kpsOvnTqSyeaGVdZ9
	 RIu5oDQdpkndokQ9KYcbQGxf80YjTNM9Hhxl6kDB/OgoudAIt6SCi8/ZNwfHAFxU8RyKc
	 4+r1s96MXuC9AIbDcsTjjIPUFbyCOxSSDb1vu64845aDFytebbCpVKP05ZyBUfkFeN176
	 F4OA6y6lh75GlvWvUAaINIu9zJ+GzZRfkac57jLhb9Hrys/Ylk82bqtNyX7RgKaC2PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ip7WW9LYq2XaFn3cz3EajUZgkrneTRdDmQiuR96TXKk=;
	b=T+jiy8DW8fZP9Phe161SahWYgfp/lUfbLZOBqWQfXcy4WfC0LgNrNOrKTtEqEVBIoSiT
	 7+hklUTg0Zez+bCw3Tmc5H6ceOs2B+32qXH/Vb3uhCIto6NBq+3C6HwDytbeP5amn5Vg3
	 ngtrF4dArBkCGr+K1IzZkfnublzPmsM3B2YBOC5s86Yc6wd+DGwappmwtCPGIINz3lp0m
	 EpSIs9Pe7b2VKkq80bktOG/ExYzSC/2T/FW/dwyY05ouz15uNhT7aQFSrHhNu5+H38jii
	 Rwl1jz6Cp4wIpgvCij6j7Go4p09Dvxt8tWqqumcfyPoM20nt+UHGKUd0amRLLMIwnbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m9z5qMMh;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7DD606A8A3
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 08:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F7DD606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m9z5qMMh
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso1743140a12.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 00:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794904166; x=1795508966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ip7WW9LYq2XaFn3cz3EajUZgkrneTRdDmQiuR96TXKk=;
        b=m9z5qMMhTCwVGbK0jltnORbane119HPk76dPICM/qyFTH57ccGkF/WJoF31FUR3RsH
         Iy5OH03dik5q+0Y1DrATfpeDLLaBMordqf3fnpfvhKhDJqfEqCpismAAVqFOkoAKpAe8
         jbvcUhFpwossrGkTj+nr6uGeqxCxOqKSmggzCkf+J1N/es4XpsPiUlzCD/7XV8HLvXDO
         gGoD5KQqiwrhVOvHRJ5FuQbWYRGqr+3h0VTmlV5ahvMaKHLk9P9c0RIMqTYuAn8ZlpyR
         8DdyVSGtsb960A/HBKtPSbLu120swOcZ4MTEEVfanV4IeMHrsd3GDJ3L+9ZEbG7lRF1X
         ECgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904166; x=1795508966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ip7WW9LYq2XaFn3cz3EajUZgkrneTRdDmQiuR96TXKk=;
        b=0MygC9c2IRBapmvJPxn2wsBmFqAgfB3Vjw3futgfB+l9Uq/mUYTgiXxyAX5B+Db6lI
         6oQo4Ox5Hwv75KppRnTcHKj9015s+YON7AIR4areXfxixhClaNRlqIFV6wD99AaubqHB
         +BGlKyR2oqs8QgNxod80RsF7a/lmrQCudo9QbzgLrIIHm9tWtgnKm6ux4qoBA6cQjsBJ
         QctlFdJcYj70USzXkc4h8RMMNirmLCTrUrVoKC1apNIX40FlNxLp3Ksr8x6R+G9lYnpf
         O/WLGJGk9M9jTCMaaDbkdkbAnqOm3W5emTXGPaZRfE0fQ+gxPWHWMKJvU07X+6sVLT39
         NrAg==
X-Forwarded-Encrypted: i=1; AL+hErHYlVMmuGvIBRqVrTLIf/IRxqS6WmKsb1S8+/2bAbbNGNI1gc9a5Jot5ELK4NomsvpFh9gYvXZ0psQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/RT/e1nDP9g1jAAkMyt2EH67IRWhDiSGD/UVl7wcEtfYbuVyg
	bpl6OmP4V/8gu25r4x/ec+YzSR9t85Q9OeBiOj0nw1AcIEO4fPQgWYre
X-Gm-Gg: AYBFou3Emt4CQ/V/pJ2xWXKA3GqaERXCztkos4q+X7ttRkl1OeX2bobltUGjmOBDRID
	jGqKCVDUMbBLVh7FVnQdsNMStppzeZSd0AxGK8q39TcFLaLiPF9I85PQ4TPrPU4X7L/O6Xkv52j
	zlx8W7YcJ8BCDZ09NZY+UwJDqnJrk/tTbh97I7FywxRdq0mzHCJvFbb/5eVX+olgcSJrhbI12B5
	3P263fbnU6K9rG8x7hfWAbYTCeU5J7L6w/y9P4gf3EDCOzPDu6eR5fLi/JPJrWdOLDD0eo69ERc
	XIRg1KUuhCoQzDuZ8bGSa5UYMQw9Y4J9Eg5Wm6ZN8JI4MY9/rWe1qD9tov3AOpjdSU3+ks8UVaA
	iP8BR1a3Hjixx/KZST4j0UQJZmNHRtJ2VX7oqtl7/V84NfQFssPaewu3hk/OWXX/bTZj4Px1BoU
	0XKnWFaQZhrK2535f5ZcTE3Y1gj993zJrpqQJvja5qV9k5OreTCOVTP/Jnyy9b7584AK/gPKqG9
	SWq0wEYltIhATEMdVJ0JUZuM9ZZkAqaN5Elww7T3Pe7Fqr4PvcKMYw3BIvqJLIqJNQdKlY4/QeA
	0Ch5751W04I9jCmLruLegO2HcvYZ0og73OV/mhQm8YV9/KLwuXD7xHDBDH54MRyXjzY82lI9AVC
	TlZL+RTlWLSjh3dA=
X-Received: by 2002:a05:6300:6f97:b0:3f8:c147:955e with SMTP id adf61e73a8af0-3f8c1479944mr7741046637.61.1794904166400;
        Tue, 17 Nov 2026 00:29:26 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18a2191sm5422907a12.21.2026.11.17.00.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:29:25 -0800 (PST)
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
	chernyakin.victor.j@outlook.com,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH v5 2/3] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
Date: Tue, 17 Nov 2026 16:28:31 +0800
Message-Id: <20261117082832.1551574-3-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261117082832.1551574-1-cwweng.linux@gmail.com>
References: <20261117082832.1551574-1-cwweng.linux@gmail.com>
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

The controller provides eight external analog inputs that can be used
as single-ended inputs or as the four fixed differential pairs 0-4,
1-5, 2-6 and 3-7. The VBAT input is internally connected and needs no
devicetree description.

Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 .../bindings/iio/adc/nuvoton,ma35d1-eadc.yaml | 174 ++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
new file mode 100644
index 000000000000..1bf64913d67d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,ma35d1-eadc.yaml
@@ -0,0 +1,174 @@
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
+description: >
+  The Nuvoton MA35D1 Enhanced Analog-to-Digital Converter (EADC) is a
+  12-bit successive approximation converter with eight external analog
+  inputs and one internally connected VBAT input.
+
+  The external inputs can be used as eight single-ended channels or as
+  four fixed differential pairs: 0-4, 1-5, 2-6 and 3-7. The VBAT input
+  needs no devicetree description.
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
+      supply is absent, the internal reference is used.
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
+      The cell selects the logical external EADC channel identified by the reg
+      value of the corresponding channel child node. Only channels represented
+      by child nodes are valid I/O channel specifiers.
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
+    description: >
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
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - '#io-channel-cells'
+  - '#address-cells'
+  - '#size-cells'
+
+anyOf:
+  - required:
+      - channel@0
+  - required:
+      - channel@1
+  - required:
+      - channel@2
+  - required:
+      - channel@3
+  - required:
+      - channel@4
+  - required:
+      - channel@5
+  - required:
+      - channel@6
+  - required:
+      - channel@7
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

