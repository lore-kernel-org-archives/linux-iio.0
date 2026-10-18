Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DCE3E6DD9;
	Sun, 18 Oct 2026 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320304; cv=none; b=h5iT4HnySEPPNRQ6Dh9tInvOOvpAJfhR3xPBn3+7SDn34W+a5bINI9U8Og1ce5Nk2hePMHOnMdd/mvoslNm5LwTCjLB+XpQ6juoeAc45BMjKux8i7qGS8Skmb7H28H9KN+sMtuI0EhugqUIPf8HfPAA69FDCFjMOJunNex07kso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320304; c=relaxed/simple;
	bh=vNqaHCrfSA0b4VKqfRdlPpjbXdDNlSf9M0McDU4t62Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K04lg6QpRzxKY8PHS4cchkhAbsDR5ghi5pmlB9WLhZv6hru1AZtHnSDQqZy8hUnsG2YxIkXHzEEbgXlcUTMP/XW6LzohdQf8+zg/kLDfrFKsLirLNSxe/T15xjJEiilgnhAxfUokNp2PmDj4tZU1jDzzc4o09wl0uJyf18Zg414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VOudf8Te; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VOudf8Te"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mi
	MF4+nj09eXhJ0U/z9DFw9etlGUXEWdhhThFMF/aeg=; b=VOudf8TedwmBasyZWK
	rsKszhheksu2/hC5d1xV3g3xuqrkI7tFBbsKW9AFnS1gXSP4fEpgq7I9Oy8r+s0e
	k3Lyt2auVvxT/fdasyEYVM9DZS5Qquk32oqWsPj9d9AzwDZTz+YEAmd7kAczr8tJ
	JLYWWREYZU49Z0igAkm2/I7vk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAX5pnxotRqUthIAg--.5987S2;
	Sun, 18 Oct 2026 18:44:11 +0800 (CST)
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
	Tenglong Guo <admin@micronull.cn>,
	Sashiko AI <sashiko-bot@kernel.org>
Subject: [PATCH v2] dt-bindings: iio: adc: add documentation for adi,ad7816
Date: Sun, 18 Oct 2026 18:43:58 +0800
Message-Id: <20261018104358.38255-1-wrmfwv@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAX5pnxotRqUthIAg--.5987S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF13AryxuF4rAFyfGr45KFg_yoW8Kw4UpF
	4DCF93K3yfK3W3Ka1fKa40kFW5ZF1UCw1rK3WDWr1UGrZ0gF1jyw43KF13Xw1UWFyDtF9r
	WFy5Cr15tw10vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UkCzNUUUUU=
X-CM-SenderInfo: xzupw4ry6rljoofrz/xtbC5hy3o2rUovxDxgAA3L

From: Tenglong Guo <admin@micronull.cn>

Add a YAML binding document for the AD7816 family of ADCs.
This fixes the checkpatch.pl warning about un-documented
DT compatible strings in the staging driver.

Reviewed-by: Sashiko AI <sashiko-bot@kernel.org>
Signed-off-by: Tenglong Guo <admin@micronull.cn>
---
 .../bindings/iio/adc/adi,ad7816.yaml          | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
new file mode 100644
index 000000000000..d23ef9163e61
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7816.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7816/AD7817/AD7818 ADC
+
+maintainers:
+  - Tenglong Guo <admin@micronull.cn>
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
+  rdwr-gpios:
+    description: GPIO connected to the RD/WR pin.
+
+  convert-gpios:
+    description: GPIO connected to the CONVST pin.
+
+  busy-gpios:
+    description: GPIO connected to the BUSY pin. Required for AD7816 and AD7817.
+
+  interrupts:
+    maxItems: 1
+    description: Optional interrupt for over-temperature indication.
+
+required:
+  - compatible
+  - reg
+  - rdwr-gpios
+  - convert-gpios
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7816
+              - adi,ad7817
+    then:
+      required:
+        - busy-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7816";
+            reg = <0>;
+            rdwr-gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+            convert-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
+            busy-gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
+            interrupts-extended = <&gpio0 4 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
+...
-- 
2.25.1

