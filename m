Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ABE399D0C;
	Sun, 18 Oct 2026 10:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792318884; cv=none; b=D8be5atWPrUPna0TZzQ8WPXG8vPLf+80uZ356EHKgoKFo+5x3cjtGOieix+DWMUhHhvkUBCb5Y3KCmRfTlVP1viJCW/dj3nbbckRcSGAdcJi2dmEEP6ishHxO/eF/RD15MErUdWVQ2RGQqpwxLfk2o90oXA2xbn4965mEOFLIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792318884; c=relaxed/simple;
	bh=rsLtirXT3pM9Ylp/JZyMLrn5/KMeLlhApTxuT2rQ53I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ETyxtbA1I3ALV4r9CgKo1jCjMgKbaQEkoTR39twvwBQxGrEdzrr1jdp41Y7EOOKKQso49ltkNBrToGrND7rAnOhyfvEGN+YVRLFXQw6+6Nd/3ft9fK2r7XPsK+Tfi13tRhcrswbL79Iq/a+E2AR5DspmChN69OwrV9w2Yuq4mNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=je793fjJ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="je793fjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Vt
	8fZLzUBr7kthYDZY5SNrJCUOz4S713r/k1RND8oY0=; b=je793fjJfwh1QfI2ML
	Nei62lqNDiC5gNTiL0f2CnXG+sKLmOePCVvrIJDOvpyyo/j1VzySfrNxTSYquAds
	SnJrAXOoe9evZU1IMWjEizXmlEUiKfkuy+8JDXzda3Qp4B/+qzMUqNmrOqPtuCM7
	UUuG9wUDAIreLnO0iFdM4tzLA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXXyYtndRqtvFKAg--.6901S2;
	Sun, 18 Oct 2026 18:19:37 +0800 (CST)
From: wrmfwv@163.com
To: nuno.sa@analog.com,
	jic23@kernel.org,
	robh@kernel.org
Cc: Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gtl-m <admin@micronull.cn>
Subject: [PATCH] dt-bindings: iio: adc: add documentation for adi,ad7816
Date: Sun, 18 Oct 2026 18:19:21 +0800
Message-Id: <20261018101921.36424-1-wrmfwv@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXXyYtndRqtvFKAg--.6901S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF47tw4DXF18tr18AF1DKFg_yoW8XFWUpr
	4kCr93Kw4S93WxGw4fK3W0kFW5Zr4rC3WYvF9rK3WDKrZ8GF1Yyw4akF13Jr4UXF18KFZr
	uFW7KF15tr10yr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgtxgUUUUU=
X-CM-SenderInfo: xzupw4ry6rljoofrz/xtbDARlFMWrUnTmNywAA3w

From: gtl-m <admin@micronull.cn>

Add a YAML binding document for the AD7816 family of ADCs.
This fixes the checkpatch.pl warning about un-documented
DT compatible strings in the staging driver.

Signed-off-by: gtl-m <admin@micronull.cn>
---
 .../bindings/iio/adc/adi,ad7816.yaml          | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
new file mode 100644
index 000000000000..0bbc52829b77
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7816.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7816/AD7817/AD7818 ADC
+
+maintainers:
+  - gtl-m <admin@micronull.cn>
+
+description: |
+  The AD7816/AD7817/AD7818 are 10-bit ADCs with on-chip temperature sensors.
+  They use a SPI interface for communication.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7816
+      - adi,ad7817
+      - adi,ad7818
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7816";
+            reg = <0>;
+        };
+    };
+...
-- 
2.25.1

