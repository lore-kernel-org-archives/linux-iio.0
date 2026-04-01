Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932AF44CF29
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060749; cv=none; b=A8vvWyNyD0SCMNoTT072d44zdr/NrjoODS3DfOglwFRpny4FuNCjwTXhwmxmxIySoooV1rsxhCLPw5riXAQjPfxvhi5ybajUiS8wUqdQSskSPJA+zJ6peVqwcQe+NtvpJOOP4MUzVdZkwRbqG33LctqznVL50D59wANDxIbpmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060749; c=relaxed/simple;
	bh=y1smEGww2o/rd+W8nS0LWLrCoTwSm+mdCkNguHQRh2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+/3itM/G+1hWbw7UQjy+6bouJxc3R/CtYmpiUJkKbqNAAJx/n10uMRljQTKGSm/+/b97B+E1laRT0Qz0Qk6lhPdzdeuhayHFLdeFFMA0hGyDV2svqKktdYa+izF8WWTLozlGtZCapLcydKAV5zU4KuZATCuW+jlPI3Pvrr1OFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mirrorstack.ai; spf=none smtp.mailfrom=mirrorstack.ai; dkim=pass (2048-bit key) header.d=mirrorstack-ai.20230601.gappssmtp.com header.i=@mirrorstack-ai.20230601.gappssmtp.com header.b=uIT+dRHa; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mirrorstack.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mirrorstack.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mirrorstack-ai.20230601.gappssmtp.com header.i=@mirrorstack-ai.20230601.gappssmtp.com header.b="uIT+dRHa"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so2746957a91.3
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirrorstack-ai.20230601.gappssmtp.com; s=20230601; t=1775060743; x=1775665543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LScsGFwS6nIpkAboe0X19u7lqZkR6eLlyKmDNKTD1Lk=;
        b=uIT+dRHazz7YL1Wru9T9TfYPikCqMhwBef+Dtch6msm/6wd4dcAwxAL0ox1IJc4znk
         V8r5IXceynT8oUthS+AT+/ZyYm0h+r45QSQ+g5KzT8cTvJ3i08c8nn3dWr6v3dtt8K+7
         Q4F9Yyx3YPxHes5pH8xsxdgCRxIbhSJd2ZU117XeJnce2FC0ToY7qoJps5VvGwupYQE+
         l7nQyIhGfcNlbt4q9WEvkixJ0jb3wtWf7Zmfo4fioBguzFYaci1PeluJYnSWQ2Z0okCm
         WbkJAtOUt1L1zXmK7kJa+la5ctoSiNg2euYeyD8KGI5yDkWN/34a31WYsz5sOJds9eGy
         /+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060743; x=1775665543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LScsGFwS6nIpkAboe0X19u7lqZkR6eLlyKmDNKTD1Lk=;
        b=aiz97u3d5AgBl6M6ymsrQyg9KOOP+nicutDXrMKWXdr22JV08P0VtHEVNUxJXgCtRb
         gxW5rkwZo0VkkKgs/5uj/FfVtfWFtXcJDjWIAWRlXRgsGj1Lgwi3XKML5GIB54eseJpf
         JG16K2quy3kQAv/D3ewqnnzPeEpxdopJB+6VS1RJrp4Cxa5NG3n97mXHzQYdguoFOaDc
         yS1Lr2y0eeUS2yxNYvB4PFCNdCizEpds9klbrXWk36auLa4H+L7DWzNaTcA/CJf3U8hF
         24LTEPCuvzEMoNB5ED9TBNO0tygYieM/Srj3O0QC3aGNgHtzCEz8E49oIB4oQ/yEbLId
         kN6w==
X-Forwarded-Encrypted: i=1; AJvYcCXeVV5vyzxa7El2OLtrayM50f+GP3d0vvGCbDVzwSpRG6X5j6E648ETXL8p4G0E68DzHWzy9dQpxBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYJVKiBHfxf7Lo7vwppFkcDtJBaxRCgyiFGcaPlLwCwuTVF6u
	WINexSiu35QLabc2BmNnqZzskx3k8uKT0gVJCOegbMEqGntBKJj8KlSiZKcSLqTbgNLD
X-Gm-Gg: ATEYQzz6woOtojFa1xksXJVqYzYau6ebkW5Govx8Tdgkm4x1DoAoe4aYmV/adMTauvD
	V7Gur1EItsgq0SCukAdXRpt5oXzJLZh2sIukBWs+iH61NDPONVSTaMbI3/bgGw2veM0nykbPHFi
	nCKIyB11DCeqVY8kSZ+zfn7wXI1IDDoxuF96odR1euNYfBqogH0z7pNf94uZkHq/Ehbr4VfeOZX
	Ot6eRWQm+49FxCY9cAtALX+LkmHEsQBZKHXbiscUCk55s0w8Buld6qOYs34usLyVqAXcY67byYP
	ctJs2Gd6A4Y21KiFP3z8S19dkQVUADeOsJ4E4cw4SPj6JDVWpy4vEzL9fQ7OF1SZFxn9d+z+Xxx
	YOf7F4VucHKkx8uDT+DGy6nCESbAdoSz3evH+Kkt5Ny02yUgr6p1xTxu1k4Em06kg0iZld9WmjD
	w4ncBFQbGFp6oVEMKhFxi4PmMdt37IebyH412/sTy4mjzUE7ZS1/VJoNZkx4h5SpKZtsxNFq3j/
	9Hy+AtShjTcs0CijWnBPb6B8Y138M6pc1fvgK7rQg==
X-Received: by 2002:a17:90a:e710:b0:35d:a87b:ef69 with SMTP id 98e67ed59e1d1-35dc7070b31mr3944977a91.28.1775060742902;
        Wed, 01 Apr 2026 09:25:42 -0700 (PDT)
Received: from ip-172-26-8-186.ap-northeast-1.compute.internal ([2406:da14:e8:bc00:e546:17ee:7142:6d05])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35e34eesm281813a91.2.2026.04.01.09.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:25:42 -0700 (PDT)
From: Sheng Kun Chang <nothingchang@mirrorstack.ai>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sheng Kun Chang <nothingchang@mirrorstack.ai>
Subject: [PATCH 1/3] dt-bindings: iio: accel: add binding for adi,adis16203
Date: Wed,  1 Apr 2026 16:24:55 +0000
Message-ID: <20260401162458.88110-2-nothingchang@mirrorstack.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
References: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding documentation for the Analog Devices
ADIS16203 Programmable 360 Degrees Inclinometer, in preparation
for moving the driver out of staging.

Signed-off-by: Sheng Kun Chang <nothingchang@mirrorstack.ai>
---
 .../bindings/iio/accel/adi,adis16203.yaml     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
new file mode 100644
index 000000000..6c5e2833c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adis16203.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADIS16203 Programmable 360 Degrees Inclinometer
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description: |
+  Programmable 360 degrees inclinometer with SPI interface.
+    https://www.analog.com/en/products/adis16203.html
+
+properties:
+  compatible:
+    const: adi,adis16203
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        inclinometer@0 {
+            compatible = "adi,adis16203";
+            reg = <0>;
+            spi-max-frequency = <2500000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.43.0

