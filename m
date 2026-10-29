Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260157;
	b=lM9Onac3t4Dl5bMcay1pvsTso2zCgRUsmEq7dN9D+oODI99kktQn6CBOQJUyj+peGRUR
	 EhGyVejpwRJfuqTUEZlH2Fz//SrXfzaJCort5chw6XZ2i7GfL5CP7J3M6sqCyPInfc2ya
	 ulG5EZZd9oepNWCA3Y3b4gkCq9asKEk0YfGewTRHucL6JSJ7sYPeBNj4vH8nRQwroVkjS
	 TdJ57lGXhEDFlZrmRyzNRM27gdUsLdTb7NHIN+5m2bhdMpkLCVJzUmRP+d8zDJJ71E7lZ
	 aoexVRrpqvjXoEV4VaAWfAtgm8ln/0iEjHoq+dYL9XwcPolZ0wtjh0ijoudHTecx96Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7IN2ZZeCgcwCvS2txh5dZSlnQHrz7HH/k4+ry9PPBlM=;
	b=LJmAXtZFtNcvTN3f+Q4rz0zYeGijJD96Xq4jlgSwKSF/x0uE51i1TqzbLhvHSSnT5w/M
	 vPf6RwAxwLnTz0O8F9Aq8rolsuME2w33nXPTIJ2sFBF8DvxOxe9BFQMFqz4yOP4//mLsl
	 wK8KDeRopW2PMCLinb2JVp6R+J/IgIWxxCzDPxqQMlRPFmdk5nZrb2lE5okSYEQsYDC5I
	 FnK8IvWW8I8lY3l+ZceVaudZnTodODF4r9zE6JiQSuaLCDXOf1uK1Wd8nlQul8xGJJxIF
	 IG9QhfSme8Pq8cCOiTr+p08YPUMzy5j3jXNxbjsWq7nURax6gI9uxRHS3q08n2w7wpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ND9YmuvI;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A7606A31D
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 07:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 270A7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ND9YmuvI
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a17a332ecso2644266eec.1
        for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 00:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793260156; x=1793864956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7IN2ZZeCgcwCvS2txh5dZSlnQHrz7HH/k4+ry9PPBlM=;
        b=ND9YmuvI+s5qL4svijWrxXoigMp9/Sd2qGNSXgfwZEIpwpmtXfX1YGpVAsH8C7qLP7
         bgKRrcEkB9aexHpHgPGV/DJXu25Eb7nBymol76uogfwk+S8afgkbJVA6q//pzQtgSVAZ
         HSN31GHY87lEMX4m6ChJBy8qyCRoMd5rxe5o+juHiRktTDW++2HHKZPYmCnuCx9GY7gY
         yrYYjDrD8k7hzk9YOsAdKKgRGmQxa4n/xrc/Uq15TW4Iozgs25i18Ox/uM9pOxEZdEcz
         ILmPMoL+enigdLboeW4VEm33vzE/yFvuEgM0i1VsgMZTxrcPt6x+Wq83tloASR5mfP+t
         R47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793260156; x=1793864956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7IN2ZZeCgcwCvS2txh5dZSlnQHrz7HH/k4+ry9PPBlM=;
        b=Uj3uldm2vaAexkl0OS2uXXOf5KNN7xg6hxO32kFirra+vy7FjshACH8HAh9qFqyV2w
         UnXUY7JYe+i4YhqEo4rdyW17Gvo6rt+mXgebeTSnFvCslGM9a8lPoosby4yBrbyuVlXp
         x2sohi2w5r7ySCN+QuzZshMUlwqjJ6NXtK0v4liWMxlPWNSuXvo3x1g1Dddiy6KWC8LP
         H2PyoTVKczrHa51DI8mb5aRW1YkH4d3WwhM9W/JLKzbcI3igD4kjLi8fIZVpnioyfEee
         9InNYa7Yar9O5Ju5usdtlLXgNRKcTENmuUOYIbIqU69OkC1L4WqCJIar3dTzXOG4Rm4g
         K0hA==
X-Forwarded-Encrypted: i=1; AKwUvBxJMAZAFTnEw5ksrvioTOkqcXAtwrHL90qLWzlWHqGCkje6YeN1Ow02Kpa1OToqLBfobSpU1X6nSnk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKY/M28b4oBpEALnxhTwl/z26bSmMlZLVg3TrnSdpnEEpv/hKaA
	T/s5gDfxTxcYc58IMU9GoQUUqoAwKgKzmulGDQ6qBlPsfUnvTlWFsnRn
X-Gm-Gg: AYBFou0qlANYgdpSVT47r3hN56mx0vvJPZx1UHS8U81JI2irJU7gbiBnvpTUqkz1eBz
	6aaclPRM33Wp6aDFyMHHHMHtIwMMlK7fYvfK1H2cIRJ98Pe+C9br1ctR1jRE5hmK+SkiO+9u9+a
	HAoQqtQSNEQTlq/Zcw5eDMna53kgQavTNBdEm8nqLvdfChU5xG2XvJ/26gcKxA5NfaVOknPPO9g
	unXfjECA5oN1QvETcMwIQucNmAjSpYqReGZ3Cv5rN/Z6v2fWsfSG5gPKEZFaATgxWExCuc999b7
	nJ7U4tBGv7+2eIyAx3w6NutUM2S8nBtn+egsNurJeZao0e1VMt71QQlggGuXg/iNpRT031w9ZK2
	yoDYmlGYbI7IveMPXDk4FegzcjBLLeO0OuGk782YRMjpBhSemWRofxwcM7GB5oH6wZOkuj0RI1t
	SIXV8nJlFYK7cXhIhtZu6JnUjKl3p1Wx+Ps0SAXbGCrsYg2qIWKbSZvTZjBGCX8NfgFIVSkYovZ
	z5EjZrAfZQAaYKRU1bx7dw1MmH5Qha9s+kqy0RGi3UHHCVS0JSE5pxqCNUy7m9YWZgKEbjrZKjx
	LjVij8m00iFSD2RjHQeTiMbKOF3J
X-Received: by 2002:a05:693c:62d2:b0:368:40c6:3a01 with SMTP id 5a478bee46e88-36a1ffc5574mr7347926eec.2.1793260155911;
        Thu, 29 Oct 2026 00:49:15 -0700 (PDT)
Received: from localhost ([149.28.89.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23908449sm15539704eec.11.2026.10.29.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:49:15 -0700 (PDT)
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
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Shi Hao <i.shihao.999@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 1/2] dt-bindings: iio: light: add as7343
Date: Thu, 29 Oct 2026 15:48:50 +0800
Message-ID: <20261029074851.216029-2-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029074851.216029-1-marcus.yu.56@gmail.com>
References: <20261029074851.216029-1-marcus.yu.56@gmail.com>
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

Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
with i2c address of 0x39.

The GPIO pin is not described because the datasheet does not document
how to use it for hardware synchronization at all. The GPIO register
also has no mode-select bit to isolate the pin from the chip's
internal control logic. Exposing it as a generic GPIO could result
in kernel writes being overwritten by internal logic.

Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
Changes in v7:
 - Specify reg as a const.
 - Move additionalProperties after allOf block.

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

 .../bindings/iio/light/ams,as7343.yaml        | 64 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
new file mode 100644
index 000000000000..8379f913138c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
@@ -0,0 +1,64 @@
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
+    const: 0x39
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
+      The maximum current for the external LED connected to the LDR pin.
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
+allOf:
+  - $ref: /schemas/leds/common.yaml#
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

