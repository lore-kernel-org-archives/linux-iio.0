Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F2833EAEC
	for <linux-iio@vger.kernel.org>; Sat, 12 Sep 2026 01:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789177166; cv=none; b=M4AMt8BrEBQnLuXC8IsowtxhBu5qwOPAbCgBcbLCF08Q0NkUpsf6OmIvGXdEKeWI0nCj9zItX3aELD9nP8w5MCTSIPFoKr1Yg1q3wNtw6h+8yhcv2nYNN241TVlTqY4nU7ivkjVBb4nvDqY5f2eV7pfJDBjUTYY/wqULQfh4x7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789177166; c=relaxed/simple;
	bh=JLLXSvZCKraVQIIXIuTkcWyIgBFVni2Obqjb6K0W0u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxBDmU1oMDuzCIYwRtCWhQSK/X87i6ImhwSCbN433w+O/Y9xHbhJBq8AURSBstcvND9RTNFGsIpOluemqkpupELn2dbxF+IXnpe2ErOWrfURrXmrshQBE4DEAXmeZ5CzKcrAul6e86R3wrggWh5ICcioMGaQFHUeZx4NJC5+2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpaGvR+U; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpaGvR+U"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43da99e9so5249137b3.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 18:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789177163; x=1789781963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j5UQFfztvZOCjQN7oLrmWgKlycY6XtxKRBgU4jQ0rVk=;
        b=JpaGvR+UwdxB+HKQA0zujuigXoLPPmIQqQiU57zZwUygEQwY5NxnSBcKby7hocV6ga
         mlb9AsM/WaVS+2ryBUBjxBys54Zm0Jh9BG7bMenDza0j8aE5kaWpxoBxB/2rJsR5+lMA
         IOwxiklQqDmh2pGdVNtmxF3MAJqBPb7/MOqAEGPIyxoEvRtB6bhGWdgoFlPl0jMloVjG
         Mx6osrz9dyq43a67+15l2L4DhL1ARDCWB5ra55Q5zE2LTsQlwUH+HR/TdJIa2D6nV5Cd
         0siYRHM5J1C7b+9BgD8t70f2HXgOdcml5TzuYneQL/gWM7R/lQwnPGdDjpx8fA99GggW
         ht8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789177163; x=1789781963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j5UQFfztvZOCjQN7oLrmWgKlycY6XtxKRBgU4jQ0rVk=;
        b=q6m1G30nXZMQPCcJ77H4IF6iAJnXoJ7tHrwZ5UUfvivQGt+Lrr6B61GpJGRucEUeqK
         xtuV1I8VAwnh4HT5PjgHwDw/MWZmpDVOWsvXSY/QTFVtleeHxff99Z8LmuekV7KCY2C/
         bvW3rpY+O7xxaiX57NOipi1TNO2jJKJwNvdafWNVuWWlJQ/D09Nn+ei1FNCvrclVC4fa
         yc2mSJVYiHGAroEO76ycqle+gg7uP5mvXMYNq6TSaZXMqmwVeEr/MxxAQVcRbvorDpNC
         a26SQKcmJoA0XNf0NL6wYP/I5SjhcaAquG6no0it/a88xJL7nRO0vDSXnXt5ahUWKFrh
         USXg==
X-Forwarded-Encrypted: i=1; AKwUvByC6jniigzgeCZF3EFaj579DgXqy2F82CHL1zDbODR4hD1gSUHGXss8IgvKQB4O0lZnV1efSLe9GOU=@vger.kernel.org
X-Gm-Message-State: AFuF++kb6NIRQKlWvp9Lv5rUh3V42PvOAxHeIksBM3xor0dR/+5gniFL
	wyQt1ayvHT/cEuEHysy+RJWT3WJXNYO/ovmUF/wbygo4bpxthw2aMCKr
X-Gm-Gg: AYBFou1tbyJ7DGzHXmlJYzJ5RhglaoL/h3ftuEfClNYuzD1JcduGpfM5v9R33zF337S
	wHRLvPmPRgh8yqeJkDH99D51awyYgSO5mZeoJnVdRpiBSbgRDePU5jhFxkv1cKkl48+bbsUciJ8
	fri0sMUvmtWRldxU8YzsIy6cRY+YSu+3SBBmGJ0rIkQ7aN+ZLDHMNAB/OfQcq+iCiGKcFmfcRmH
	4ZINf8riT2PjvgY8ppQ8NEm/nZUic+dgvSYN+5zOHrCLLgYll+vfJyv98Z2jO0e20HfvGPHf5eK
	43AcHlmKWxGeamQ3yDUyKYgZe9jKr9IIWfjPGkQjBFmzOfiKcoXHVcILpk7eSVoPwOv0MEO7z/+
	yBv0Kr4pot3jPjH59fBvw3tz4kGHgoDt45adWLyhJs4RIALsxtBRUXEiOh91lTJgrrolJBMX3xM
	3u2ZafTRxtFCxUJAGxUIf/LNryh8e/DfRTd0+m6KpigqdoTyFVAcBzIw==
X-Received: by 2002:a05:690c:319:b0:887:1704:be8a with SMTP id 00721157ae682-8871704c8e3mr9286207b3.8.1789177163260;
        Fri, 11 Sep 2026 18:39:23 -0700 (PDT)
Received: from localhost ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-884894fd624sm17098387b3.46.2026.09.11.18.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 18:39:22 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: iio: light: add as7343
Date: Fri, 11 Sep 2026 18:39:11 -0700
Message-ID: <20260912013912.51887-2-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912013912.51887-1-marcus.yu.56@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
with i2c address of 0x39.

Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
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

 .../bindings/iio/light/ams,as7343.yaml        | 72 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
new file mode 100644
index 000000000000..d963832fb413
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
@@ -0,0 +1,72 @@
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
+  sync-gpios:
+    description: |
+      Optional GPIO pin that can be used either as a synchronization input to
+      start/stop measurement or as an external start/stop signal for
+      synchronizing with the connected LED.
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
+    #include <dt-bindings/gpio/gpio.h>
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
+            sync-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
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
2.55.0

