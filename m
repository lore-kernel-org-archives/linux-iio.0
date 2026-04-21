Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6247C1F5821
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776751369; cv=none; b=e6+S/xEgSST6a1UJd7bkCDlsnR7I7txvgkJDYMWrYyJ+3kF+uljI+kkHK0BtfnKW2LKOk9qNNJlft/T7Z524ojxuJWNlT9uyyRwyasf2C3OLozvXwqbs69iGTng0cc5sXOKvs1MlJELtLSdqrrkJPKdqP3a+oUPUJCL3y3/K55Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776751369; c=relaxed/simple;
	bh=o4s7RQJVLaKWZyqTCtdrIQ4el0b9XV5xDQP4/7MQ2uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hh/tyGiV0MPWrkK28g/6dBJWUSHU10a4GhM6j9yjUX445dh0Sgtp26Fnr40A3SLNJLWJ6qqbAVW0BL/d7KgASmyAnns9Xy1ujIlizDrGx8lIfsoO8c/gamexONcLjRGvadsBW+76Hpcc39G4aTmco3Hw2x/1hx299IpBEAKyRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=roSS+Vz8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roSS+Vz8"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b0afa0210bso17848625ad.2
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 23:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776751368; x=1777356168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2GTU1uONrWcOgiwwOslB4zHcwSXJATu+7xJPkzbInQ=;
        b=roSS+Vz8PcYuqAc5WkION7RZEZ3XJrismwcwDLzaHNF5/w8H8y/WL566R/gvy4KzJW
         bOqhLK3QBMtBUJxrvgiEmwgl7gxovAmxSE6dqLX+VDeIVtG1dF4GxTI7FgTHqgFS/udd
         UvVXbgy8YwCfP2cXV469baQInv3Y6MmifI9raZgQl7F61K9W9iRonYE6BVACdgH4zKKS
         ErCdplY7inoy5EV79IIk1ZO0ZG2Yxe0Im+PZ7MNfsdz8GoSB/BZpWIMS1NYFI8Ba9ovs
         U37px9AWy7eSgcQropG9l/a8hZ8z3SOcuIWODm0YDyEqhMfX8Y4VNRO7494TqlKWWLzB
         EvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776751368; x=1777356168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2GTU1uONrWcOgiwwOslB4zHcwSXJATu+7xJPkzbInQ=;
        b=XJlHJ3FSy7ucb1c4F8YkuMLJyRkQWAwAPm7kVw7TOU/C5RCkM3TLebHsT0xH1PNJQw
         WW5M+3xepZ+HO8H6TGFiJXV3pE11OpxRS/OKAo2rBh7nE3WKihhz6EPO4IlX2OS0xLep
         nRoU6rpiSnS6bTnjaVtmcPPcuUXuwEbEpWMq2Jm412gAVERtZgZSCid+kPJ48e/Ifm8R
         AmF7jZlXdYc5RKYw07D/eJWABauFdBVX9/XuVaVKHXnkTFJWVQgDnT9F+jUQGH/7fRaL
         E0twpyIqr5PSPqTpjmStBFlrfy6U/It4w89e8TUCR9qNgnaQ+Zziv1IVnodn1Ls2BrSZ
         ce5A==
X-Forwarded-Encrypted: i=1; AFNElJ8RP541Xx2ftUJSFZFWRxPyohGgIeGeE0pbLCjKayE99FXyjI6hd/JIddU5jgBD4Ccp4ih1+ozUPl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFCGFMsT/c6UcFacoJCgqo1rXdlsY4WYhXqIM7rXIBZmDFEKLH
	ob9OkY0kLl8jBMEZqXFmDIqSJWzT7JZ+JAvxcPNanm3s1VQI0NxX4xoQ
X-Gm-Gg: AeBDieu59GbTC2UcaM7nHRoLoz0Oy9ZofsrjR0AHmjlVwUPNpQFxwb0SrlDwOuRBUfX
	J8sO8WrACIQU8pZrbpeXGYVBXZrBru5s2H7YSZW4uG7QeWj7YU3Ff2/DBAotROQzRXpxvX1qnFU
	Cw9fg5gknFSHVOwWi1WIuBw4Nby0BAAt/Muo18E+b8vj+D4OuNS3RM/eGmPH3K8ZVNOzyIO9aDx
	sxPdkv7buFWRTgsNKtNVSBRFycfaeimPLp4hncRsE19/UGCq9doVoiUBIz7hZsfweWCMGAZ8T3O
	ZAfUDIyKDYL0Ghhya3shyXD/IY4C44xPrqSjOXOnassSU4X0bA22+OuDGlZbmDC9OYKpQ02UCzJ
	341/nwsQTwLMUSseXrBow9LWDP3WbUToWORV8NbaHYnAAR0VGuoF+Y9Yt3lt4Ii9lDCPASBLV3J
	lNqiJstUvvyGxmmnM9AoaOLdvvtZh43wQNTkFv1z0POD/JJSccGZTjYvldHEmdlFQpBwKxDnsGM
	Kfp/3G5TxB1GJAs7I9qQ0bIbn20XUkvxhDpgSOafTcI9iG6w47UfSmz/dgnxGQH8TBfMaOM22GL
	hXsf7/E=
X-Received: by 2002:a17:902:868f:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2b5f9f3ca68mr127077205ad.25.1776751367609;
        Mon, 20 Apr 2026 23:02:47 -0700 (PDT)
Received: from PhantomX4 ([2402:3a80:51:767:3618:c13a:2d9b:d51a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9fedf0sm144516425ad.6.2026.04.20.23.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 23:02:47 -0700 (PDT)
From: Sudharshan <sudharsanam346@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	Sudharshan <sudharsanam346@gmail.com>
Subject: [PATCH v2] dt-bindings: iio: adc: adi,ad7816: add binding for AD7816/7/8
Date: Tue, 21 Apr 2026 11:30:11 +0530
Message-ID: <20260421060011.12917-1-sudharsanam346@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for Analog Devices AD7816,
AD7817 and AD7818 10-bit ADC with on-chip temperature sensor.

The devices communicate over SPI and expose:
  - up to 4 analog input channels (AD7817)
  - on-chip temperature sensor
  - a busy GPIO to signal ongoing conversion

Signed-off-by: Sudharshan <sudharsanam346@gmail.com>
---
 .../bindings/iio/adc/adi,ad7816.yaml          | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
new file mode 100644
index 000000000000..6780510aaeb9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7816.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7816/AD7817/AD7818 temperature sensor and ADC
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  The AD7816/AD7817/AD7818 are 10-bit analog to digital converters
+  with an on-chip temperature sensor. They communicate over SPI bus
+  and are commonly used in robotics and industrial applications for
+  temperature monitoring and analog signal conversion.
+
+  Specifications on the converters can be found at:
+    AD7816:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7816.pdf
+    AD7817:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7817.pdf
+    AD7818:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7818.pdf
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
+  spi-max-frequency:
+    maximum: 1000000
+
+  busy-gpios:
+    description:
+      GPIO connected to the busy pin of the AD7816/7/8.
+      The line is active high and indicates the chip is
+      performing a conversion.
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
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@0 {
+            compatible = "adi,ad7816";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            busy-gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.53.0

