Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331C3CC32E
	for <linux-iio@vger.kernel.org>; Thu, 10 Sep 2026 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022309; cv=none; b=rmYwj98C9RzN2wuM6dUHnytre0LR+Wdzq3K7wkkyY2DlTCh++oBaYn27QRKK6labmSr2pqChWo01MN1yhFn1NnX9H3sulxJQzbmB1je+RnvcDwkso+d7xCu68upusVWq3bIBy5zc99n7GiPHRBtMG7nc+fouJf07iOgXcocMAgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022309; c=relaxed/simple;
	bh=i5nr9zlL7n42aeFEwV94X9Ky6UzQbINjUj5sTjC4cII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVsbG/k1IVWcn3MENwn49dnOp/1SAaMqvVj9oDDPVFzdJycVVSjf7pQdwrLdf17jfwyGR/b6O3msMuPdjGvz+ZjTFcLtTxGgw+zA8gu6EuEHxqD7Eb1dURunKkFCFN91jgloqdyW4iv1+1Hl+WxsQ+y1REAzTEoApIf0a4AESj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hec/4zfi; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hec/4zfi"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-87ffa98d4a9so19053087b3.3
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789022307; x=1789627107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sa7WS57WkiG8wdPJazdCMEUZZmALuhoGF9iK21huDkw=;
        b=Hec/4zfi6cl9bABDzFxv8hVQUZvTXKzc3rnVt23NBUG8TVs8O4Guy0gxzTBerBYqkO
         L1WLKe3zO6kGfsOU5KzpgTUVmc7dSE9nAR/Wpj0YKTxtK3nq102iBrpQ69Cke6D1PozK
         R3Evu3J0uRMor/XDR23JBabt6rNSmNB9Ciy2FE8tE5NIKJpz5I2FZ6fLDPhmm7JGbmqD
         7kcKbEHL6IwQ9wTMqidpIfDoiV4Rx0LFDZPA3zM4wAkgrZCElmdVl2q8wRLwUm6DWmwy
         oJ9yGdDDrj2fhaCU4VRih7E/QC+yRwrTidqF/BcST4SRGldnFMhoWnV3EKVWbltjxzJb
         ud9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022307; x=1789627107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sa7WS57WkiG8wdPJazdCMEUZZmALuhoGF9iK21huDkw=;
        b=bQ3GKhHmpaw2TdIaSX611TyP028CShilevtB4T7inwBSTfd66c3movQ+njGzDaBdAG
         m/G7SA+aZO6vxMpobPxWN3wagkJ36lIPEyuyKKsUuX2P3cTB77douvFfxyRtr7/gzMR5
         Y9aCaJGW4z/DbT67Epe46Yy6FLe/OSn0TLS+d/iTE8HwyOp/ke37SJ5IgJ4gaQoh2egp
         E+quBHuI75Jk7MvUdp8HsMk7EUBB1aQ0hTA0tptPlny0/HD6bSGhEqlBDBE8gMfmc3q0
         moMpYoLMl4nHlee0WGwOZYfyD1IiB06KvnO+3KyJXLI4kvdsd3pWXv7MI7bQa0YBB14c
         2SVQ==
X-Forwarded-Encrypted: i=1; AKwUvBweKyfqgSl6UrSyzp3KpcUZTfxVDd/QL9cB+UNpwHQPfQDElO4069HEXBcWAbDByz/DGiTT3J7/Qe4=@vger.kernel.org
X-Gm-Message-State: AFuF++mSeouQblAo+iGrdBob14kmicyxz+I/mob1iwAV1uiSFYprdPfW
	qPU52tr6h+F/oQeswjneAc+9YDRRCRhC51n9g5s8LpnA9yh/7gkbPJq3
X-Gm-Gg: AYBFou3uUMrxrxHtP15DWEL83xUkudMDZteMFwXLoO34XMJvebWShBSVWO8liR27+xW
	Uf+MxD+anjqi3qgRoXA8pqwO9JR17AoTRI8H1YzUqNiOsyI+WeLQ3gxv4pH1qRACrUl0FxorUTQ
	x5djDxvJ+4LI0IlCw4YhkpbpPkh1knD3YbgxFf/FVrEzamcssIdClNIZ7EOz0A4aQM2zAqaTOg4
	p6wieHLsxh369XQ/uy5PQIOXwzl3gFnmfmWfsYUYABDr4xy+e1iYr/+mKyUm0YMCgIIOtSN1wJF
	h07i9NrzUCJ7XNaiqrXJo7WqSQjcFuzqBMbsP+FANQVpPHqJX2Pj3CASl3UWHBuWqp/eg/LB8Nn
	l1un3wf4vchP1tU6FP3OfXFj5zP404FlBIFqRgplt+YXUmtX02/E8Muxrn+iKHfj7U+uw84M1re
	DTLmkz6DqtMqPojJVKB1/m1KBmSsNZVo2X87Mf7bnSSoj+TzScr3GYHrCwVsONwTj9
X-Received: by 2002:a05:690c:7685:b0:873:5bb2:6c09 with SMTP id 00721157ae682-8735bb26f9cmr92220467b3.51.1789022306735;
        Wed, 09 Sep 2026 23:38:26 -0700 (PDT)
Received: from localhost ([2600:1700:5431:250::1e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714af5581bsm119455507b3.36.2026.09.09.23.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:38:24 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: light: add as7343
Date: Wed,  9 Sep 2026 23:38:12 -0700
Message-ID: <20260910063813.56419-2-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910063813.56419-1-marcus.yu.56@gmail.com>
References: <20260910063813.56419-1-marcus.yu.56@gmail.com>
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
index 000000000000..6b8a05be0043
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
+  ams,led-max-microamp:
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
+            ams,led-max-microamp = <14000>;
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

