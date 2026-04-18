Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F34391505
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776523669; cv=none; b=OF0mjdGPDbmLoXNLhJ7S2I4xNFCTRpblGsGfHnhvCbk95VI1MHqR7wkepZgmKFtL8iUdxczBT7UbTPeM9vApuyEbZ9yQccKIUVJVvgYXZanZtrE82KCdJQ5CuZqPdy+NnfbHUyHXL7caCteG7oMFJKenBK0pN0KmNsl8P64Usms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776523669; c=relaxed/simple;
	bh=Wxb9PwFATd17PDPb2rUk06CPpwp/tCyfuCX8k/OSLuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElLg+nbU22AwRLxw25mUWi6jgnqQtgDa+ZuzOlM/tVqh3iCbgwfkzb8vcW+MOOm3NyGv5TpA0iGUQFfBMxSYx//4ZWJ2ef0C9ZA/S3AQiyLr4TX7WmlmB4jvHRd0pZ28uWbC4/Via+PSX+CJ4yNHeQ/fkM4epBzTa9ESMC1velA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUUw2TB5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUUw2TB5"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38e7b0903cdso15099521fa.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776523666; x=1777128466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNGi9+tIDznq2/odkG3FnpQo5XY+nW6Im4pa9lH4ZmA=;
        b=dUUw2TB5DO60Dp+VSmLmon0yQjxrrUlpv8UXD2++STW6LR6xUqlTcv36HsIrd0G4Rz
         JdX7gdHoEESzmzh0k3wCJS04MV1oH/zelvLpVvXU0xzTlp+YcdY/0MGg5a6QC10DMorW
         6FUq/6/B9BFf5wACoGZmh9g+XK6KMHyE/sARMV6tFM4uf+dq8ndEsoAnrlZwTbeTEaHx
         0QYzKHPEDc46ngnoMwRKMjgelFIgV9IctnIr0+7MlPDId2wpRgqgVM0aVPqhuA35PqkF
         1vFe1dHH8YDadB+7bgLLf7c1O4tYh1cDdON4Tjw+fFlYmR90FHzhA1XE4SO9gimhl+n5
         sstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776523666; x=1777128466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNGi9+tIDznq2/odkG3FnpQo5XY+nW6Im4pa9lH4ZmA=;
        b=B9sYsRuUyXyGKqw5/xbqdug2KN9gNufgGAS87gA4zWaxGfsW/H1XQHm1BkeGnR2Q4z
         CyUfutZGu8PpLR5dcfDs8wFE++0feoRaOvAW4pgaWDb6au3qsh8ZtnxADkuv9IaSBbAJ
         fsBCn0uhMkF2MZw8N2GpSkrzDc3+Eh6u/yxs3FwwgMkDqyE0007PH1fMuVq8wU0PuV53
         SieIBMxZiKoQ7fX0RUfTblmK5kH9ork85uwvxF7Caq1jSwkCIVg7AxqPVjiasW8IAOIz
         h+wdsCY+BTiwx86xTQgIFMGb9OkbYMtc8Mtb7UOmxqOtb1vtmWi4bgvBU1lMfQkkuNWQ
         SJuw==
X-Gm-Message-State: AOJu0YxTusoZtaO5Ashdu8cZd4T4Cr/Y5E86XYaydc8JFBlQo3iTYhRf
	cSJNUV8i7oIaDq4Mo/EV3Nfrm2VyRSjDDXh/ayvSi/Zyh1Yi2sKbMeKY
X-Gm-Gg: AeBDies3cOFxyUBcEj9hnwU5Vvc8ytUy54kJzpqWe9XjJ7KtJM7yLudmxuAro9D3bsP
	VL4q6yma1CV7iHla1PK6R+waW5EuQ2np+Z7279tZmpv//G8S9usSvnmrcbUiCYpmJywV/ZxeCD+
	GMcVM+fggz3tbyZXQMNPHvDHhohaBHojM8LuXlBK6MSU+UbQyHI/s3yU7kaGpie2tq59U5smX5i
	occdeG3Kg3UZTPAOXZOiF6Ul6xGlHKEX4T+uubM2UVg1Dxtj9zDJ9fYKR+LjpbFuCEnT0h6P6Rz
	2LRy244jecGXmTEhIuohfxEp5pIx0WMneEE6lzlUAAfWQ0zNAHA3ukKbcHXm7Hji0I9Z6R5lydB
	G8YWWP25E7zLNtHY5waBkFqzEkSauP7b39oCVXtFQfCdboY4LOlc5dZ8jGenjQeySU66yqj+usN
	dlZsscOJ34Cb8ec6b7Biabc8CQyXrEgMyzVQ==
X-Received: by 2002:a2e:a549:0:b0:38e:1ebe:95f6 with SMTP id 38308e7fff4ca-38ec7b2a3camr23980721fa.28.1776523666347;
        Sat, 18 Apr 2026 07:47:46 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb4f51easm10901001fa.6.2026.04.18.07.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:47:45 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] dt-bindings: iio: light: Document Avago APDS9900/9901 ALS/Proximity sensor
Date: Sat, 18 Apr 2026 17:47:12 +0300
Message-ID: <20260418144716.132936-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260418144716.132936-1-clamor95@gmail.com>
References: <20260418144716.132936-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Avago APDS-9900/9901 combined ALS/IR-LED/Proximity sensor.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/iio/light/avago,apds9900.yaml    | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9900.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9900.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9900.yaml
new file mode 100644
index 000000000000..f5fb79439e56
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9900.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/avago,apds9900.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Avago APDS-9900/9901 combined ALS/IR-LED/Proximity sensor
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description: |
+  The APDS-9900/9901 provides digital ambient light sensing (ALS),
+  IR LED and a complete proximity detection system in a single
+  8 pin package over I2C interface.
+  Datasheet at https://docs.broadcom.com/doc/AV02-2867EN
+
+properties:
+  compatible:
+    enum:
+      - avago,apds9900
+      - avago,apds9901
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+  avago,pdrive-microamp:
+    description:
+      The LED drive current is controlled by a regulated current
+      sink on the LDR pin. This feature eliminates the need to use
+      a current limiting resistor to control LED current. The LED
+      drive current can be configured for 12.5 mA, 25 mA, 50 mA
+      or 100 mA. For higher LED drive requirements, an external
+      P type transistor can be used to control the LED current.
+    enum: [12500, 25000, 50000, 100000]
+    default: 100000
+
+  avago,ppcount:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The number of LED pulses can be programmed to a value of 1 to
+      255 pulses as needed. Increasing the number of LED pulses at a
+      given current will increase the sensor sensitivity. Sensitivity
+      grows by the square root of the number of pulses. Each pulse
+      has a 16 mS period.
+    minimum: 1
+    maximum: 255
+    default: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@39 {
+            compatible = "avago,apds9900";
+            reg = <0x39>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <82 IRQ_TYPE_EDGE_RISING>;
+
+            vdd-supply = <&vdd_2v85_als>;
+
+            avago,pdrive-microamp = <100000>;
+            avago,ppcount = <3>;
+        };
+    };
+...
-- 
2.51.0

