Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA42743B3DC
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019245; cv=none; b=DEQo9TnzIMaPSCh4fzWL56vuWgnFPQsCh1JZCtELboG3TecxxZbM8rGH9zMet3VNpddv95Ut2ycusvjUGY1qkVX6f4LP5XwKK62DVFNCaLUcyZprM7PDRblynJar9mZ1AEKAEYMHiG2HPvdx88/lREwyJ/NUZggspjulx2jvDLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019245; c=relaxed/simple;
	bh=HcgU+VG1Oc+bIeWE7x5YCDCDMVvhSEyQh9IJhuIxDB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TB7YKARx1kBZnl9+C/0slVEI6d82CE2CPuR6cSz3pmc5FGWCLtaW99HJeGPquehHS0K7+eDpX5SYXvAX4vpBV53wkPmqZvcHtWcuTHqXlChrSey13sQP246VpOm1fThPVeWuCgu9owcVe+MMmBl0E0Wq/Wq1wkFqVnxxV9dV8O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DS2WMuMd; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS2WMuMd"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso1362763a12.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784019241; x=1784624041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LjuLXIei9hVQC9Zi0Wm9KUJab+j6Qn7lCqW1Es/FnEI=;
        b=DS2WMuMdqL8AV1/P/EG1/h7RygVpm9VsNYQCr8M8NB3BIuoInkp0/5DcNoslXa5pyo
         x3xGu3iDqmEPaLFIUie/AuMmcuNcbVYGigxAwqua+VGpj5oj9bRqon0rLuJiV4zMidZQ
         NLg1yUN2tpFW07yl81RbHe5csVhq5L28z64+U/QgsAEsRjf1/S6JxiwZqNlm34dbPqN7
         hpCBFXWw9En7pVQ0eHO3zWjk1XWSa0cKDQfY5rgW5apYpCJAsDtk3Ok0bBN9bMDTfGPT
         eMXGHGiiIrG9Ty2v1X1EGYN+h8pu8/KOZgpx+NvHLyUdfWc4xuBbJlO5vbopo3yu+nOF
         19uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019241; x=1784624041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LjuLXIei9hVQC9Zi0Wm9KUJab+j6Qn7lCqW1Es/FnEI=;
        b=IbvPb2ywqKDSa2vxw5tC7QOMxocND00Pl6KgygwIthETa6OIYK4ZumGkR3OgN93YCC
         6wV7Sdz5FT/TX37O29rBZKvyCRaSc2HbbB59/OKG1ILfj1nzGqG4UaL36iOGWabUxnKT
         wcov37yrrerO6U9JgBhYICEirbg//EjpevddGtFArVP7xU8K1zBBUutoMYhmfIRkU9Ki
         MkdCA2jcGk4kSyW0yynSMtns3bCsO3MgeXGo3RscWamBsyJj74apHez1nDZNL//tucsG
         PkpBEG0SYZMGfj604MNUGhhOxJpJOH7L3KAQKNBYiAiVorXZYNyCZV8gfZvJPyqNyiNr
         UQ1g==
X-Gm-Message-State: AOJu0YweQS1cWTJMDz6yJE/zPDjbXznbrX5x0uw6/tWy7ynQOfNiFsIt
	XKnkeu9YoNfEhnKZ0BxbJDq+6QMGgXGWL6AS+noJdSLK2LeF/suAhyc2
X-Gm-Gg: AfdE7ckyX66tq66ZKgFAkWJnUqZHovkrV91PIfPbqOySNzxi+9lPQa09pSwuT/8H09k
	veZZ5cn66LkU/QWDFh9yQ/7OrRfy9esd1pWtKQQ0Xtrnos+r5+ZGlWRmmnip2YR65qs6EatWbMl
	6zgGuy7fyJgUjoV7bVIjZgnC7/GvkY4JG34GUK3KrsRE11AASaojSg7crgY1bIVI/hbbr+3qLnh
	yTbVtQsetZSC6xa0jH9q0VDUHQPWXzt+c5sRPOJEodhqI7g2Zq1iU3HF2Txcy0M5a2ZCJ13bGYL
	Xsf9cU43hKFaVlRc3vPpaQjnsEUKHxd++TbkPKyuW/B6slr8tkV3a4TWsSPuweZQdaDqZrwABFA
	B2HEVvguDUwddl5JD8+4DL114ldgl7HK5J12jOaH9N9UF0A4jVXKhDs5OrJUFviHNvbqwLkk1Zx
	Pcio6adTyUCbwb3GWHK72SJVsxlSkr8Rf7IQwXVip6grcYSA==
X-Received: by 2002:a17:907:9610:b0:c12:4133:39ba with SMTP id a640c23a62f3a-c161ea2ad17mr666319066b.26.1784019240816;
        Tue, 14 Jul 2026 01:54:00 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad82279csm1143689366b.13.2026.07.14.01.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:54:00 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <maxwell@maxwelld.cc>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: [PATCH v5 2/4] dt-bindings: iio: flow: add Sensirion SLF3S liquid flow sensor
Date: Tue, 14 Jul 2026 10:53:56 +0200
Message-ID: <20260714085358.20842-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714085358.20842-1-wafgo01@gmail.com>
References: <20260714085358.20842-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the bindings for the Sensirion SLF3S family of digital
liquid-flow sensors on I2C.  The family currently covers the
SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.

All variants share the same register map and are fully detectable
from the product-information register at probe time, so
sensirion,slf3s-1300f serves as the fallback compatible for the
other variants.

The active calibration medium (water / IPA) is runtime-switchable
via the in_volumeflow_medium sysfs attribute and therefore not a
DT property.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/iio/flow/sensirion,slf3s.yaml    | 58 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml

diff --git a/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
new file mode 100644
index 000000000000..c054a505b75d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/flow/sensirion,slf3s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SLF3S liquid flow sensor
+
+maintainers:
+  - Wadim Mueller <wafgo01@gmail.com>
+
+description:
+  Family of digital liquid-flow sensors from Sensirion with I2C interface. All
+  family members share the same register map; sub-types differ only in the flow
+  scale factor and the calibrated measurement range. The sub-type can be
+  identified from the product-information register.
+
+properties:
+  compatible:
+    oneOf:
+      - const: sensirion,slf3s-1300f
+      - items:
+          - enum:
+              - sensirion,slf3s-0600f
+              - sensirion,slf3s-4000b
+          - const: sensirion,slf3s-1300f
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  interrupts:
+    maxItems: 1
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flow-sensor@8 {
+            compatible = "sensirion,slf3s-0600f", "sensirion,slf3s-1300f";
+            reg = <0x08>;
+            vdd-supply = <&reg_3v3>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b051eccafa60..f400b82520a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24296,6 +24296,13 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
 F:	drivers/iio/chemical/sgp40.c
 
+SENSIRION SLF3S LIQUID FLOW SENSOR DRIVER
+M:	Wadim Mueller <wafgo01@gmail.com>
+R:	Maxwell Doose <maxwell@maxwelld.cc>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
+
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
-- 
2.43.0

