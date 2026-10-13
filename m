Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4DD4F6477
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892625; cv=none; b=E7qDfhvwlz9FIXFkuTkibqIILOjgjUOjOVr5lvz4PPAxBwa7a0N7QEqszOLZIrXzve8uQdbgVo71vogf66I1Lf+K7S9CAk4erZeGSPE8eMPY54iLGj0Zpj2I/PvceelVHS9eQygcuiVJmQ2RpNXV/DmzAhhPvlVmKDbAskxpGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892625; c=relaxed/simple;
	bh=X5ZU7JNnypfrB8yv3CiSgtsjeTv0kMCAa5OOfmHUqfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xf8y9Sh4PpxmCqU0wA3vZ0KbVQdcRSVa+Ld6PQCABL6cGcBq9GpofpDtz2GE35jNihCfEKbzSqqQW/jftZOXTzTrSFkwL3DLnBzdUPwzZhc7LNWY9Vhmc5lUWWQARR1unRBBDMBUB04b/XyVCy534pom/l4FnneqUx9Rjp6vbzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYKfOAWy; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYKfOAWy"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-17bc533fda3so259799c88.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791892623; x=1792497423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4kunHk2WNZFU02yT2wiYv/FHONgL2+rn9vP7+0p544w=;
        b=fYKfOAWyyndwCTkjHI1Rh7MDthkgkkZCFkETE6GE0C8FfLwwcI3q034NJO0tst2DnY
         e2uyywnpH6R2/+EcH0kDCgo8QRHGAJNHzUeGyodK3d82HjzRQPfWN/qjpscJGDpIDO97
         kjpasT7l+FtMqD0hUuOB/axfDcVbpNv8ZQEImJRFHKP3OADxXdnMcMDCOv9dD+5DdoqV
         TS+SPbZGR1PajpIDPn8hII8nOwk6cVIR7mct8fHzmV2C/r3Aj9n7NEDvYijdOy/eMDat
         EZWrFdfBGm8vPXAst5YOlOv5fuiaumc0BeKo5ZAVnGOFjdwslKr6e1pqXqwXmVigShZb
         pzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791892623; x=1792497423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4kunHk2WNZFU02yT2wiYv/FHONgL2+rn9vP7+0p544w=;
        b=eKzDlwguHMiLpEDluLMCfCFsaGsVxOIrWzD5PsoA6tmRsq47VoMKVy77dFOdM94pme
         rbJVxXdvu+ZW/bZpDxgx1pTc+/+bZZXeR+Nn9f90A9Cim/TU9sSjc4FIfbba3/aNNnZB
         ANwm7tBo8LlZgLfNJRTgJE9//O7O7NCL+5HHuQ3M+HUfaK9DIKo61Hb60jHhALgmHQ/o
         Z4fxXuskqTDkvKC4jt/STcNDD667aoMLJ9cACFPzV8z8Lz+sNIyaXZOt4+ginUs4zZ4n
         3CGlDCorbH5KrjPC2eQuaaVrpkHGaEfv7R5/1PacZXPMbOIfz7p/YOidTdTTTnclhexp
         EqQw==
X-Forwarded-Encrypted: i=1; AKwUvBwELDo44sZwG36x2UB2GKuW0jlG3+l8kWmikyc14L60hpT9EwM7VPHlivcc6FY/0JNpi2LJfk1PtqM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI8Ys5700k6UlMmogTAdDqDA14wPglHbHg2jk4asCaXq4AEaOu2
	5pAVLnHb/doUOyjkHlumdRjm18LZp0l4FM+DubUX03nlZUxWYBtfGwSDWP2IoxarHpc=
X-Gm-Gg: AYBFou2zL8i82oewKs/+OJ490a8cNdMFUNBqu/E/KxhqvFJzP7SB+QrjhkzBssAN8YL
	UF6LickdX8d441D1AvnQgmx+dnsRMA8ebzQ6D9YpDpjyJ2mIQ97OKiz8/XaXwfriUmYFEzwqpaB
	0c7L8/YGedMI1Rmt0CFPdkCkq3GM2qHFovHXbaX7efq0ZY+jCqSS7bkfrbqsHOr64dcoBXWbZBb
	EIqB+BdH+MTzIseOkGaguOBDpy93W9dRmKxW/RqaaV8cSDjxxTwzK5Vcd4Md+UpMCC2RBApGD+h
	YB6Mum4u1U3smx5FEl5r5QfeBAVKxylNZ8ZzhtnWir+OiK2Biqfqiv3HWsBfpaX9w//Ydgku477
	AV9c+6bHanDgamgLkyF59e9RByd/KLQG66nUNC3UPucKwbt2eiUnfjDD4d2mz9NSAHnJSWAhL5t
	hNDAa37amEMQ2Ja7GaP3G1SIvvQin2mSKcKTRWcn2MwL8o3Wt0DVA7pKQDVp9U/CwuVRn9c62F
X-Received: by 2002:a05:701b:205c:10b0:149:49c:233 with SMTP id a92af1059eb24-16a60811394mr17959201c88.27.1791892623397;
        Tue, 13 Oct 2026 04:57:03 -0700 (PDT)
Received: from localhost ([104.156.230.40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3595e0858c6sm30250575eec.22.2026.10.13.04.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:57:02 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: iio: light: add as7343
Date: Tue, 13 Oct 2026 19:56:38 +0800
Message-ID: <20261013115639.167433-2-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013115639.167433-1-marcus.yu.56@gmail.com>
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
with i2c address of 0x39.

The GPIO pin is not described because the datasheet does not document
how to use it for hardware synchronization at all. The GPIO register
also has no mode-select bit to isolate the pin from the chip's
internal control logic. Exposing it as a generic GPIO could result
in kernel writes being overwritten by internal logic.

Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
Changes in v6:
 - Add a ref to leds/common.yaml for the LDR pin.

Changes in v5:
 - Remove the GPIO pin.

Changes in v4:
 - Fix led-max-microamp property name.

Changes in v3:
 - Add missing include for gpio.
 - Expand GPIO descrption to include hardware synchronization.
 - Use led-max-microamp instead of led-current-microamp for the LDR pin.

Changes in v2:
 - Add the LDR, the interrupt pin, and the GPIO pin to the bindings.
 - Fix node name and unit address mismatch.
 - Include MAINTAINERS changes.

 .../bindings/iio/light/ams,as7343.yaml        | 66 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
new file mode 100644
index 000000000000..7fb10b0d4843
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/ams,as7343.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS AS7343 14-Channel Multi-Spectral Sensor
+
+maintainers:
+  - Chang Yu <marcus.yu.56@gmail.com>
+
+description: |
+  The AMS AS7343 is a 14-channel multi-spectral sensor with i2c address of 0x39.
+  https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
+
+properties:
+  compatible:
+    enum:
+      - ams,as7343
+
+  reg:
+    description:
+      I2C address of the device (0x39).
+    maxItems: 1
+
+  interrupts:
+    description:
+      Open drain output active low interrupt pin.
+    maxItems: 1
+
+  vdd-supply: true
+
+  led-max-microamp:
+    description:
+      The driver current for the external LED connected to the LDR pin.
+    minimum: 4000
+    maximum: 258000
+    multipleOf: 2000
+    default: 12000
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+allOf:
+  - $ref: /schemas/leds/common.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        multispectral-sensor@39 {
+            compatible = "ams,as7343";
+            reg = <0x39>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+            vdd-supply = <&vdd_regulator>;
+            led-max-microamp = <14000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 04fa5322d9f7..8cf4e1635053 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1430,6 +1430,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
 F:	drivers/iio/light/as73211.c
 
+AMS AS7343 DRIVER
+M:	Chang Yu <marcus.yu.56@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
+
 AMT (Automatic Multicast Tunneling)
 M:	Taehee Yoo <ap420073@gmail.com>
 L:	netdev@vger.kernel.org
-- 
2.56.0

