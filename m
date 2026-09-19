Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3809D3451CD
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789861917; cv=none; b=tTT5jtlP9TdUOclomKDFst7efgEvWT+kQwH5h3s8/sZknL7wYrCSkQvinYOX53S6/+ItM/AuIIPdsy0HZob+ix4ldyDY3UnmCl90sYKcgWjFbP97XQpj/iJ2OJuSSQB5IsNOAbme26cpDoPr4F1u9I95xRWwxfS5JKgLJFx0D3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789861917; c=relaxed/simple;
	bh=FqxWjOmDX/kecaW/RuI/kHrAGN9fCpwYa5Nb9b5Sa8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0Fx6o9b0T3nTbUiNgMg9MQ4wuUtpiLg6F+h5FVLygRfZjo/flkSeC+2b2zhJniBFieJJ8lhoyvdX2CU/2PhOi2KN/Mw16jQi+Somn1akYO3psHQwHTtV81So8viGqgJ60ayDB51xPq0wYTDjFcsfg3m0VLaL31P0kYk598OObQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRhfsCNr; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRhfsCNr"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8961cca9193so22963927b3.3
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 16:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789861915; x=1790466715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9QHpm7c1V8gHiee3hWq0zuvysKzJj4/MeFKMRUANhqo=;
        b=PRhfsCNrlg+IYy/PZml0fSQvjfc8HepLnyYYTUiWvq6bIym6/0bHklgcqc44Yw+fPZ
         6maCS24sdO2UpwB3sC2wWp50wflW7lBrUz1ZqVMttLFHv6NLBqQha2MBQSYe+LBkCC8a
         C6aDhwln02e/xgmbD1Zy7OkTl3w5N4zD0D1vupIS95ZKWh4+D9LgB9JpZEEeNRyg/Q+S
         TrIyY7bEZz2sZ/Wx+wloBOO736I1uF1JOo1hQmHpKUryn5y7KleVl3CyX4ceyY+63T2e
         mCAA7ApPEBUsEfSVaznaNsr1INkRZYOoPhyiAU50prTK8p+Hlqa2yEY8qPuin5GNjEI6
         3Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789861915; x=1790466715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9QHpm7c1V8gHiee3hWq0zuvysKzJj4/MeFKMRUANhqo=;
        b=2DAd7RhE9GjCWSS0JLSPmdgsKQtBOH+6tMcCovw3s+fZ8zF23xqkq/iZjDvS6XZ83H
         pnjs9+L4VfNEap8z5aG2Drv62nqnvDk8pqBADRfW1GUL5F8tmM9oMaN2tGmKO6cAJ8Np
         OUR/98w//34/POLcLiYQ8TCYdvbC30xHbR4twanIGL0yTb5G+Ugv0CzfiWdAylBKOOL7
         RL2aaKSZQ29cMUTXZzzkzTk3GQIJNs7QQFO2R9yKfA71TwWxWcgiChmGaKMyBHeRWtKi
         3+Dc9nfAJQPhUwuB0ubJmiIbv4XdzDLR4qkvDx/UT5eZHqYLSYsBY47LHq9mEYw18eId
         a3tQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3Z4tBVApdNZDJMnds6sWDuyVXAg0rvEqG5pkIXCekECG6xLuhORpNAIQlzEIUo5yItPABFg9fTxE=@vger.kernel.org
X-Gm-Message-State: AFuF++mNpqTgjeTClQwTyk1jVeSBRXS/55QWk4XSUmP9G4ym6FWw1POS
	vmvjr+KJS36i3inCXo9uwVg7Kp7xGUiOp7l5QwJaFr7vFilrAKWKCJJ1
X-Gm-Gg: AYBFou2QfbB2+sksqApd6tG9ydLg3nkH8Hpie0R9KTe2PWlkEXRLTNwEvFAIXmn+8Sl
	iH8CJuMrgsB9DIk2qxsqUBYk43f7wb/zjs6uNsX4eN1hP2TDXbi3lcDNUWVAC3mNw1Iv04gGl05
	PhcGhZunqAbJ0Zyl4pIiOGvqwRgk1zvNWztF9LuzdeptIwXtqNQ9LmChZb1whdCCpkH5DfewK/f
	ARwi7FJZcEYbzsDk6Y0XAfjl6IDgaOnWaG5sHk/VA7Lq5sW7JrJy0FWrCEU4yG2aJBtig+PJeFf
	FFv/db7eOeFfqykhKmQvOMPNSCg1S7zJAEgzS+FVD4pyY8kgohDRG0PtTLsHdyt2783v2NitwVD
	25O3Uw8bDRf5VuQohMfgQmwSpimBHemQD5n7YO4JdRcZLjH4f3JUtR+Ro2rIm6maQPAL9fd8Rf4
	XSsDNTyIoi+Z9nRMkakWa9Qu+cMoJJj8S0IeHCSQoon7pkHf2hbAID7g==
X-Received: by 2002:a05:690c:d86:b0:89b:689d:3a6d with SMTP id 00721157ae682-89b689d3c27mr7212887b3.36.1789861915186;
        Sat, 19 Sep 2026 16:51:55 -0700 (PDT)
Received: from localhost ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a45d8f216sm12915647b3.14.2026.09.19.16.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 16:51:54 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: iio: light: add as7343
Date: Sat, 19 Sep 2026 16:51:44 -0700
Message-ID: <20260919235145.48273-2-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919235145.48273-1-marcus.yu.56@gmail.com>
References: <20260919235145.48273-1-marcus.yu.56@gmail.com>
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

 .../bindings/iio/light/ams,as7343.yaml        | 63 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
new file mode 100644
index 000000000000..cfb15fc551bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
@@ -0,0 +1,63 @@
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
2.55.0

