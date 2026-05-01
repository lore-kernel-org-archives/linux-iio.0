Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7141B375
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777666076; cv=none; b=RqCQEYjT/DxSgneg4elP7kIgjOR4ZLmc0EXCeNcbpmIopo281Fy8OSsA5Hj1pQN3y1pQ2g3P9A5P4nX9N4J7qjj84G12P9xQ/+RETJSi4ZMAYtX+LdwymqvA8ng/6vilOWeKjPQMhUmgWExxN080Zl3HqpuMYuuD0ehalHkm0cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777666076; c=relaxed/simple;
	bh=899m7Zy7xurIUVRNpX/tx4JxhXfB8AQU+XOgGIIb6Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcZtC+yMWYiBgjd/TYJa8UpckYDc8JJXPPlxY83zi9DM6XUXfI+c0Uhb2azCYOEBAIcA4K5eeyDRcHLOZm9IAEqoVJgTbCiwisKYqQXk2qXoCud1631PO+pJphFJbKghjtKVerDJykgMOA6rh6WJSupSvc9afYuG4Uab3ppKJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6y4F31+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6y4F31+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso16374075e9.0
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 13:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777666073; x=1778270873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uK18dh7POxzr+9hxadaHOszS8KbryfPOypweUkfevYs=;
        b=r6y4F31+sZjPntSP2s1Jt7Jhd2XoLUiGVVseGn0wakxco5FoE40kSwngMUlijQ9kce
         DtVaT0rGIkBaPg1hx8dcqSYRrHtDd98WjdbW2m8CUAKTM4eiOSvcWPGdS5GyZEX5PZOE
         RJ46+04K4RWRZrqo8ci3r6doGLngWwzRYjLzDbnztHdrrGZdUsi2sFpf4fMP/3Yq+IjT
         9GPC+NpyamNzbRvGcZjL0rsoI/KF9k8ZO94k28+XpOrvs9K0cw26sODfFmz+A2s9JYoc
         XW6mzQSDefj+4Sq0oZNPJwNf2zoctuVBSdlbkQPzVGsLc/Mh8RgZacFMnThAK0bMQGIC
         HbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777666073; x=1778270873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uK18dh7POxzr+9hxadaHOszS8KbryfPOypweUkfevYs=;
        b=SV8OEDFTdXSYEPEdUJGf5VA7X4ylQt0J81PbwjzDuMnFEba3szxde/gYRhi4Q6jRDW
         hcOAK8RAEGwx+dtRq0kHcVUq+Im0ZLV8XxzP5mpHyTmNCkiIZNnJsI3gTvLFTLAca9ze
         VbA+42HSUXNAbnIUxtNOxC8oZ8XKwAAIfN+lqWuO3wJbi9xX9bxQ5KUmTiq89sr5VWfR
         vT10mQgrUndHfMNnxMMkIEkNwoD8mpAF4/k+vxQ5MU6V+d+bMQUeBss4F0wwKNLZTVDr
         yDMfvEQLR+0gyX72v3MbgGD8Bz6w2QzJ99hOBJUa7ACrVVdgFPvRrJslxwhlA5mwwZwa
         oShg==
X-Forwarded-Encrypted: i=1; AFNElJ+3KV5rjncObghQuOe2Hcirewpu+qBGLrNJE45mjiT77TGi3onvrIsRFAW5oSbOcqAdE8DG2ku2C4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0XMa0dh14iG8s4pd9sIKW32eLOqJecMVDQdzbxaasKyH6E5P5
	/w4UrPcyGxZM5jWRrCn+irN76vPXqzfxz7VCpDwYTB5QLdVEMAI9buuwCVOqKkOWf3Q=
X-Gm-Gg: AeBDieuoP6wz6OhVarvCuVMQD4Ht/llE4Si8iEKdryHPdTwGSZg1ILMpQyCQWU19tgx
	mhZhY37YY/YHcQkUfPzNk5M3LBzJAzmnCXr6elsllYNpN+C/S5RWvXfo5XpotX2A8VIio2x/EXg
	s6dHgpVhZPJmF5oMsYAV1BL+mPkVwT7l9mLSdxCLKVZSMTU1cgioq9UbrW8RtBb/idbZd48pj+M
	n23jkO1/JhPHo+Yumilu92Ke90XCBsdALtaEU9hEGkLF9gMTMKkIRuwtJJSnCxESDksW1w4ibEX
	tq7zzNiVUwglYBkcMFrRZ/gO3Ujgg2VSVW4Dxymg04Z9NbGsVM1386/9p8wkVr6qYKvGvFIui8h
	kJ2/hybsttbVrLdsbsp3F0o8EDcixROUF9E5C2MN5i+K4zaOj9yfL1ZtAhozuzp2kpodYj0BBVD
	yokTzHPYU8
X-Received: by 2002:a05:600c:45c5:b0:488:a916:14a8 with SMTP id 5b1f17b1804b1-48a98871959mr6885675e9.10.1777666073401;
        Fri, 01 May 2026 13:07:53 -0700 (PDT)
Received: from fedora ([2a02:8071:50c5:5c0::3323])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fe953besm26829325e9.2.2026.05.01.13.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 13:07:52 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: wbg@kernel.org
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor.dooley@microchip.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: counter: add gpio-quadrature-encoder binding
Date: Fri,  1 May 2026 22:07:47 +0200
Message-ID: <20260501200749.20029-2-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501200749.20029-1-wafgo01@gmail.com>
References: <20260501200749.20029-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding documentation for the GPIO-based quadrature
encoder counter driver. The driver reads A/B quadrature signals and
an optional index pulse via edge-triggered GPIO interrupts, supporting
X1, X2, X4 quadrature decoding and pulse-direction mode.

This is useful on SoCs that lack a dedicated hardware quadrature
decoder or where the encoder is wired to generic GPIO pins.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../counter/gpio-quadrature-encoder.yaml      | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/gpio-quadrature-encoder.yaml

diff --git a/Documentation/devicetree/bindings/counter/gpio-quadrature-encoder.yaml b/Documentation/devicetree/bindings/counter/gpio-quadrature-encoder.yaml
new file mode 100644
index 000000000..741396b29
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/gpio-quadrature-encoder.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/gpio-quadrature-encoder.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO-based Quadrature Encoder
+
+maintainers:
+  - Wadim Mueller <wadim.mueller@cmblu.de>
+
+description: |
+  A generic GPIO-based quadrature encoder counter.  Reads A/B quadrature
+  signals and an optional index pulse via edge-triggered GPIO interrupts.
+  Supports X1, X2, X4 quadrature decoding and pulse-direction mode.
+
+  This is useful on SoCs that lack a dedicated hardware quadrature
+  decoder (eQEP, QEI, etc.) or where the encoder is wired to generic
+  GPIO pins rather than to a dedicated peripheral.
+
+properties:
+  compatible:
+    const: gpio-quadrature-encoder
+
+  encoder-a-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the encoder's A (phase A) output.
+
+  encoder-b-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the encoder's B (phase B) output.
+
+  encoder-index-gpios:
+    maxItems: 1
+    description:
+      Optional GPIO connected to the encoder's index (Z) output.
+      The index signal pulses once per revolution and can be used
+      as a reference point for absolute position tracking.
+
+required:
+  - compatible
+  - encoder-a-gpios
+  - encoder-b-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    quadrature-encoder {
+        compatible = "gpio-quadrature-encoder";
+        encoder-a-gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
+        encoder-b-gpios = <&gpio0 11 GPIO_ACTIVE_LOW>;
+        encoder-index-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+    };
+
+...
-- 
2.52.0

