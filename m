Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936818;
	b=SFOTXP4XUKuCyg4QVarxHO9J2TKp3U2ZPcgJXPESCIbYlkFt0Pg9ov1vV+PauJQoCwXy
	 DcDZxW+KpF0WelX5V5c/7CoDAMxDZFLwCE134QIEyl31IThRfo19RNWkg15t2m7VYdBS+
	 QGhKS1S6r5kjI9RSFUVQ7+Ngv1pyzkGj58i0iNlz1tmNNwTL+3hLeEqU8aZ1xRf+cOchc
	 nANdaDesyUIkpg8fYvFycwhw3pQ0L/Qdj+uHauNpO1TUOV680/IsuyaaF+BFQIKgzVEia
	 wJ9v4lWbwmoIOSU+sT7e9cbG2noVQnkG9PXssf/j5O2AFloNAkVHAfINBDoVYvyqV/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2jL5YnKAVfbEeVw+3LXIU76AD7FXA69elwf9ngK60tI=;
	b=oE13DShLrI04J5hz5wK5j6HlzNVsR8Mwqn3dPw8jXn6mt8RuO4bVKbGVsItNBX6Y8pGq
	 NQ2P0khW+twWtmumeiTMEaggFhTqwOAuvcdVhpU1I8i3FpJ+LrLlrpWPvs+Qw1Y0ip6wc
	 HIzp+hYejR3G6gTI+QZwxQVZclQwGTwGWZBJX7Yfg1w34zilkf7eF6LwNkMS2xxPI71hR
	 kOfJ6LjHExQuQ+ibDErTg2JbOq3zCHTrjYSpNHYWn7X2oStSOgQPbHuwRTq2CgyVOcw+S
	 PKGQLBU37zQIbZkfFUbMnFlVfMEcnBLyTsxy1qlx1peajufUnuy13cxFqCuWIbNTKWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LmkcjQUf;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC7606A337
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 17:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79FC7606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LmkcjQUf
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b467581b98so1696715e9.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 09:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936817; x=1795541617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2jL5YnKAVfbEeVw+3LXIU76AD7FXA69elwf9ngK60tI=;
        b=LmkcjQUfAHAMAiD+xUKnR0eQqfUvZabFBG1Enc9Hbz40FA0mImCIjOxNXlMesC6lpU
         9obmFyCzDpMFN7kBkkuFXfsRT15Ooch6Ay9fROWpQJfd+mmd1+Ff2PAsVUuVYZV6cdNW
         jdwuN8Ci5t1QwsTOoz5TtsvxVMsbCMUe6SIRQQZZaWPcH5aOxMw4Jy3Mdhoo6pgQdI/i
         tGYnmIig3iN7ZtSqUohNc6T6OMtxcwVz7cFY8pDJVZ2kLe69L2qDyWqzKMQgLAGB2+Ul
         PLJ2IbljOqXG2XF87Xj7a0dRGBFTWHaSRsA4EeLAu8M6mDnq5H0ODMx2IMAviQDJ50Ri
         UXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936817; x=1795541617;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2jL5YnKAVfbEeVw+3LXIU76AD7FXA69elwf9ngK60tI=;
        b=FpQ1987TiAeDpXRIg69EmJA0AiwLFu1OL5lk5yxHOoYdvp6eMtZ4uLAiQSptXX6RcK
         xFFp8sgLpUf41wNS+XBBl8qzt/KFzmQkVazPyvObZpoXBo7oVOOKsXiCJaz/cX+aa5/H
         JsWkvkOjYmmSzm7VDZB5H2M5nFmncD11TN1c20Q5tPEVXzYX2fL2rGgOdyjKL3fzIIIA
         E/L/3RgGrWyONMV9B7BY6xYQCOO5uS4aj/ZGAbmv4vAXU+3h7Ufm79K0czEBaSC3LDXH
         x0rCJZspGpPBy5VmMT/7lWi5jlIGWQw+GzjN9BwczE35sR5+nmdrPl0qLdKTvXgJLzmD
         uZcg==
X-Forwarded-Encrypted: i=1; AL+hErHmNfVmbkB2GWvg1TYu5QRi+zx1zm/DYGEuw4QK1DhKSWGZF2A5GacXngxb9eb9d6pQPHYCDV6F7O8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+l1VKkP+vtuweBWerDY+ki21wpQeoEx1t2eks7LMEjglT72AgP
	lAnooCKwoPgakvs9cWKAKWnQCzR5STtKJFX8HtW56+JXW/NYnfWY1DCm9im1NctxL4H9Fw==
X-Gm-Gg: AYBFou2A3EDm7FemtdkFvcgBvk+U3KIMcUm5xrMkgQY8Fhdz1HOw6whO4AnvKGVV35o
	gpcIgAkU1IoiBYqMUOnMukY2J0u5vUzrveNPdvqtocH7C9h906hO/1l55yO2mxjo+cqi6OZDm38
	gkxQhdNLdjLV201+rqEjyhgYPApPtXjFC0OVzgoK8l6Tdw0U7DyC3e3j2nRjXtROmqLEhz10Aer
	zs5XaywUKwClccd3tM9sCYERMOXahaIhclvtNd2gM7XiD+MTV7wQaXSdJUIlj3IRqrKPNOcHYhb
	Xud+mURsGIQw+K/ad1khaFi2WNAbxfp8pSS30TjwhiYEeogqCB4ZH3JZsY8yoSOLOkgm9REYmZm
	GYM0/qnMQcdliP0jLmUKiDBFOWAABDxZIBrczHXW87oivzuPEYfB4s3FibpfOExNSDRlWBveWvv
	eOiKhFfsztPJuZQkBXNbgEU5F9WV4bj63viX3XTPnRvORw474xs/W5KlrgYGelfP39Kg5Yuzjfh
	6d3FXoArKpbMlP0/jAX7Ae2A04/9YI74DsoFt5V+J2MCku+mKT/1Kv0HMFbiss0hgiLLQPnwZkJ
	FfKDQl5dLKLkDKccELdRVmeIYo0xhECPbw==
X-Received: by 2002:a05:600c:638e:b0:4bb:5bf3:8ee9 with SMTP id 5b1f17b1804b1-4bb5bf390e3mr287460505e9.31.1794936816714;
        Tue, 17 Nov 2026 09:33:36 -0800 (PST)
Received: from dl360p ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a2e6c765dfsm8165024f8f.33.2026.11.17.09.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:33:36 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: proximity: add Imagis ISG5320A
Date: Tue, 17 Nov 2026 20:33:32 +0300
Message-ID: <20261117173333.1853986-2-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117173333.1853986-1-tadilhusrev@gmail.com>
References: <20261116074013.355363-1-tadilhusrev@gmail.com>
 <20261117173333.1853986-1-tadilhusrev@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a binding for the Imagis ISG5320A capacitive SAR/grip proximity
sensor (I2C), as fitted on the Samsung Galaxy XCover5.

Signed-off-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>
---
v2 -> v3 (addressing Sashiko AI's review of v2,
https://sashiko.dev/#/patchset/20261117104414.1182364-1-tadilhusrev@gmail.com?part=1):
- Drop int-gpios entirely instead of just documenting it. The pin is
  already described by the required "interrupts" property; polling it
  as a second GPIO duplicates that and risks pinmux/GPIO-IRQ lock
  conflicts on platforms where the interrupt parent is a GPIO
  controller (such as Exynos pinctrl), and a binding should describe
  hardware, not a driver's internal reset-polling implementation. The
  driver's matching change is in "iio: proximity: add Imagis ISG5320A
  SAR sensor driver".
- Move this changelog below the "---" line instead of leaving it in
  the commit message body (also flagged by Sashiko AI on v2).

v1 -> v2 (addressing Sashiko AI's review of v1,
https://sashiko.dev/#/patchset/20261116074013.355363-1-tadilhusrev@gmail.com?part=1):
- Document int-gpios: the driver optionally reads it during the reset
  sequence; it was undocumented in v1.
- Reword the description to the chip's own characteristics instead of
  how the Linux IIO channel is exposed.
- Simplify vdd-supply to "vdd-supply: true" (left optional: the
  XCover5's own grip sensor has no vdd-supply node at all, an
  always-on LDO not modeled in DT, which the driver's
  devm_regulator_get_enable_optional() already tolerates).
- Rename the example node to "proximity@28", drop the unused gpio.h
  include, and add the blank line dt-check-style wants before the
  child node.
---
 .../iio/proximity/imagis,isg5320a.yaml        | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml b/Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml
new file mode 100644
index 000000000..22259e341
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/imagis,isg5320a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagis ISG5320A SAR proximity (grip) sensor
+
+maintainers:
+  - Adil Hüsrev Tepe <tadilhusrev@gmail.com>
+
+description:
+  Imagis ISG5320A capacitive SAR/grip proximity sensor, connected over I2C.
+  As fitted on the Samsung Galaxy XCover5.
+
+properties:
+  compatible:
+    const: imagis,isg5320a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: active-low data-ready / proximity interrupt
+
+  vdd-supply: true
+
+  wakeup-source: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
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
+        proximity@28 {
+            compatible = "imagis,isg5320a";
+            reg = <0x28>;
+            interrupt-parent = <&gpa2>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+            vdd-supply = <&grip_vdd>;
+            wakeup-source;
+        };
+    };
+...
--
2.53.0
