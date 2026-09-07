Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F04156FB
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814854; cv=none; b=F3vHHk/bB7zpbH0pbyA6IoJfLQzipPdb1YIXupk4bXZanpG9b9mTtqox3bitrqjARPjKF5Xu2dr/9GwmG0kdOyaLlnfw6pgqMHdfJxjKYUDla+jg97Bjt1pHj+YRP7LqfXMX4sO3bsURAAuHqu9Itg6qKem7X6muncHK0A+SwIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814854; c=relaxed/simple;
	bh=CB4IrDCbkQQPKzyE1+JRdP4YHZ3X3MjycoH1v06qadk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlPdyz7g0Cj1z9DWsWluaofAJhO5pM4ooOa4uEznQY9lksQ6b7lh4wZ1fbAqmu7KWXAsVA5jYyy3qn2TMOXPFYB+wUpqXxBGPYjpV3Gjfl9H8nhb61Yn9wSDFBldcszSiuf8grVkiNxK1J20cJMAdvLYTO6rGitZDUTPPNdMrPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEkqr3gP; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEkqr3gP"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66fc2844f0eso3873267d50.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788814852; x=1789419652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQ3j3AcjNNd2Kd8M1yKbKABbzsBbCoNm0E5xFE2ml5k=;
        b=AEkqr3gPSiI5CYkvlQx0vdsqje89KMGCcVa/ZbGLM/26zPrlFNRKXGHPp7yDNqeZCT
         DYNV2b2AUF/JCiJggWDXbGI0H9OkYQy7jIX9nWDCdjFccsTzYqGjx/Dg9IaMkVdZUONM
         14lpbrkIgsTA9liNwvhI256ZZCh7jjmObwMlgEwl7eKV6nOTQ0ztrOlx5NxEg7ysvWjp
         yaehUXPUl9eQsgSpJdqwxi0ntNwanVTiaf4+P2noMpLHgfKV1kR79NtyEmmEOoqdXxqX
         v+WGo9O2K12NJdHru6Bk/yr5nRLp2YuROA3yUgfM9sIBJPByYUQMwlq+WENdyDWDpQKT
         7HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814852; x=1789419652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQ3j3AcjNNd2Kd8M1yKbKABbzsBbCoNm0E5xFE2ml5k=;
        b=fFIUfbUX9HH+JWLjIzifoVQLKXF7e9J0nYk+K5eQpG1mdbiUT1X93pNp6ZpZAvFZpC
         F5Xc4W/35hM2NuJ4jXBIvQ8e+GlP0o9dFxbVXwjZzF+GVF7HytkoQ8J4U662EJo/XWxf
         XhUyJGTizt7FUvbwzeek6ErIU06ykTvlqTkw4hNpSUj8pv0DjkytTW8i2wIAkhvjbm3L
         EWLPGGtnpyY1GJ7pyx1+9ri9Msk4/+845xxmrBG37vsps2Hf2soJ7nXt6ZPrvo10ufdN
         ThPs5/BcCRfhXXoe8+esfkVfgi9ZHk0x8iq07PtOG4OKaXsmlr2vmUCfN2emtlmxg3Qw
         Xn1g==
X-Forwarded-Encrypted: i=1; AKwUvByjwjyvu+flvrbmEYF9dIbVAMSyKFOkb/ebkmhm1h+35LwJ0RufBJIwpWsy8dLqazrThs7pJAX2om4=@vger.kernel.org
X-Gm-Message-State: AFuF++lf5e24jzlo2XUaMT/5jwnMI79SLPJvonns3bdtzhDMGi5PrMeO
	dpfhLt1t66jyIyo5XmDQCuLG7mQ1bGjCGc/n6WD4yDbvAKvas8bHAgxk
X-Gm-Gg: AYBFou1aS9yK/7A8rqHRGc4Xsd6gSuMcow5YuNTe0nZBVc81NfkDsskhYNdSrAVCsf1
	lfBCOSZbJ2iGnbmAJcniZ0DhHTsxb7KZtqKe96DeMnH7EITCgSpOCfKutvQqs20qeDZgahtGxQJ
	Yr/6eo5lhatFU06LLXHTnyHhETABj6pKDhnsL7e7Pc+iAVvEcIKCU8/jTDjZgaSZSo3zTHg90Fa
	oUu16iEzY19nzQW3d51zyqC0quCPwof/olR5bnN1zMkJaBNfpqqERa7KTCFE4nYFBUtFgdigfa7
	E/YjK0Q6KvWgVWw9yY9TDdlEDDQ/vPpJEMoELv2jdbwG+uY4hyIa/OKqs7xq4geDoD8emzgsB/9
	p4LIdU3K51WFtRcHh2GA/jXlxjuQuq0fGvJxzbppKdn0DXupW/k2wyGPKGZhPQ/o7nO5rB2qPRY
	0L8cD3dK3I9ad+RdaeOqPVVFp/7G7Ubr9v/UplgXTXjXE=
X-Received: by 2002:a05:690e:2101:b0:66f:c1be:84d9 with SMTP id 956f58d0204a3-66fc1be8732mr3943603d50.71.1788814852166;
        Mon, 07 Sep 2026 14:00:52 -0700 (PDT)
Received: from localhost ([2600:1700:5431:250::1e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48fb6d5sm8644500d50.11.2026.09.07.14.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:00:51 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Yu <marcus.yu.56@gmail.com>,
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
Subject: [PATCH v2 1/2] dt-bindings: iio: light: add as7343
Date: Mon,  7 Sep 2026 14:00:41 -0700
Message-ID: <20260907210042.32552-2-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907210042.32552-1-marcus.yu.56@gmail.com>
References: <20260907210042.32552-1-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
with i2c address of 0x39.

The GPIO pin is described as a generic GPIO for now. Binding design for the
more advanced measurement/LED synchronization use cases are deferred to
future patches.

Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
Changes in v2:
  - Add the LDR, the interrupt pin, and the GPIO pin to the bindings.
  - Fix node name and unit address mismatch.
  - Include MAINTAINERS changes.

 .../bindings/iio/light/ams,as7343.yaml        | 69 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
new file mode 100644
index 000000000000..b06d445b92b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
@@ -0,0 +1,69 @@
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
+  ams,led-current-microamp:
+    description:
+      The driver current for the external LED connected to the LDR pin.
+    minimum: 4000
+    maximum: 258000
+    multipleOf: 2000
+    default: 12000
+
+  gpios:
+    description:
+      Optional GPIO pin for general I/O.
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
+        multispectral-sensor@39 {
+            compatible = "ams,as7343";
+            reg = <0x39>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+            vdd-supply = <&vdd_regulator>;
+            ams,led-current-microamp = <14000>;
+            gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
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

