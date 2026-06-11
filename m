Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456F54028D7
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184427; cv=none; b=gB/vArY9GZXvnxHyqj5HOUEhzM9ieu39d8tyC9TvGkWjUlKk+olunMBIttzvGwr7h/r/kxpVcIup1um6mJf0I8Ml7UHW4tANS1MenEHDAC2swns9JkuXOyYBJR6ZwRNI3kt8JUza5nau+HPCJxrcOxikb2jvuRPWQJYwaewLgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184427; c=relaxed/simple;
	bh=R8VBiD+QXC251qgkXFGljnCBmfK+Jfx8IbBGreOEHZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXuA/gwdpnqrYn5gMkzSdooq+C/WNwFtjow0xh+t2fXhTKTmkTO7gsVuCNS5oPatH7v2vSwzck2zBP6rdkTCNkk7CHut3SvPxdfQLeLuNk18R+9nC7iNGq+j+5lD0R9n+iKEXFqeg0lUI1lvdoKSsiQIr/FuZY//2QAtsRfNqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvzCOYsJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvzCOYsJ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bebc80100efso855420466b.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781184425; x=1781789225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6oEo+zVW0utqGa0HgsB8AO2WeB1C1W2F+2/mB2GeSE=;
        b=dvzCOYsJ5BcQnQ2ITm0wkP8sf1v6slWMwjxwCrYImZMKZq3N2VzXJVtWdwXkP0L27D
         kAUiu1xej6nFuorgG4cUrJi1rZ+MpmuaAZ4aHZknMnOkKyPFzTGS7uRnaeetMNhY0P4/
         nYI0HCtd6GBWpq9Ra347TINVPFgtW9a7tp5uPYD23T3B8MiQzjEoJlw+LmkSf0PJImNI
         s2CuSHydufl8thlfgFOVP6TVe6vpGZQMwXHQzXq9ABKn3pyxkMkjyjxZJTbXtqYxMgsn
         /5IPylPAvKlwgq7WLNVmjdM77095aBX1pcDdFAi2SY1z3iFnsh6BukjQ5liH1gYfcjPy
         2RwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781184425; x=1781789225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T6oEo+zVW0utqGa0HgsB8AO2WeB1C1W2F+2/mB2GeSE=;
        b=VBr335nV8UX9EvY3KVHrq3RvCyfBTD1XJ6tWvL/sNQgcC7oo32Qdfa1uH/VMbAx6+j
         RbmtwKj3vDEkOTx9QQGy3zNPtuQHjwAqxeOmA8qLCSdnk+LJntq9BXHLlJSg8Tm39cWg
         76VL13WC1HheEVVVXd6tg3YOahT9Mfewqb4b/ZSOIPtkGX043NqHLSc/0A9izFi7F4Gj
         FaW6KUurNCFgaoO0XwaOn3CuYgCWUJ9ektlkd26qxKYj1HjAviknI97FJX/nq5M0SBhx
         uJYMPZR5nR1dRF3LWHO0r18mHFx+CH1uwavjxJkjD+uj1JNU7z3HftMI6hnFtrK4N31Z
         xIPA==
X-Gm-Message-State: AOJu0YwwqpEG1tsSupytf4vHArnFcmwiarT+FNcPVQuXpd/9Bpica9/e
	9eKAHCjIhUKwLkTyczIu6oKqgZT/8A1GPItPRoACBEh8s6upAd6rcyIe
X-Gm-Gg: Acq92OGZOI3UfFKMonbCut1jN9C/bl3L4zNt4E+pne4dCynuh1ri8DL3JwTKYE+BnHz
	b+Hps3YLgobHarr9bL5fmQKhZutJvxsJcCivRUqqnUK7IAV/UV7ZfDtkDpnkxhJdxBkAGw6vv54
	+bgjg4huBBpb4WVxtdKw9wsplN61B886sRFkYtVdB6XsXR4P4MML7usfYFL0N88m5Rk3h2+oDEA
	ojH4zXMdWGqAmLMja8k3/BQJ1wrblz/jGGBWz0CLUH8IIqTphbAAZgEj2BBrLFdek26OedSJyOW
	Es57nsEiny4qP9JjTM9qaET0havMnK6NCvI5PdYa4HNY3tsgcZ4FV+u8T/DHnLAyiQhJff4Aiy9
	3Tyiy6m2rz2+XA1wGw1DHVefLY6Ki2U692BLVfVEQTSQcMGfeouSKGlTwhU/MsXzXNQ2fSoFHMD
	NfOMpsopVEneBYGvKLiGPN947Jbnu9PK8zPu/9ZAQJb3s4MbLZUbFTVxiMQ0U3VG1kX5Sz46a3S
	VA0
X-Received: by 2002:a17:906:c10c:b0:bde:a3cf:d268 with SMTP id a640c23a62f3a-bfc85c7f9acmr150749166b.13.1781184424344;
        Thu, 11 Jun 2026 06:27:04 -0700 (PDT)
Received: from fedora.clients.cmblu.de (p5df027fc.dip0.t-ipconnect.de. [93.240.39.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfcb1cf077asm65719566b.26.2026.06.11.06.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:27:03 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	Wadim Mueller <wafgo01@gmail.com>
Subject: [PATCH v4 2/4] dt-bindings: iio: flow: add Sensirion SLF3S liquid flow sensor
Date: Thu, 11 Jun 2026 15:26:58 +0200
Message-ID: <20260611132700.671322-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611132700.671322-1-wafgo01@gmail.com>
References: <20260611132700.671322-1-wafgo01@gmail.com>
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
---
 .../bindings/iio/flow/sensirion,slf3s.yaml    | 58 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml

diff --git a/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
new file mode 100644
index 000000000..c054a505b
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
index 06a8c7457..cdc18a601 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24187,6 +24187,13 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
 F:	drivers/iio/chemical/sgp40.c
 
+SENSIRION SLF3S LIQUID FLOW SENSOR DRIVER
+M:	Wadim Mueller <wafgo01@gmail.com>
+R:	Maxwell Doose <m32285159@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
+
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
-- 
2.52.0

