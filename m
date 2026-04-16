Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A6349B02
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372533; cv=none; b=BfgJH0Ic2+8JvVSHVvmFvyf65rAAV0dW93fdHtX7/ZNft7rrpew+Ps7mycbKVDOMoV6eXbvvHcijT115LFUfBzFJd/JFv367WCwHXojIJU3toMj4eO+j5qHQ7ppGz24b5Jn1nGxAZ/hX3lyrF8vQD4/QKcV+BfAYqbSdtr6ALMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372533; c=relaxed/simple;
	bh=v1vfoqnG7mr3y+oTV1y9cm3RZIb9k31IsXz4+V/BCFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0Wteh2xDodPFUNq36GjSjicvq0p9OdSZrHRJkNl6cgwZRLg89+YcVFLC+2MFuGshaa/HzxTi2Z019c7VMCuxro+KFfH4HIddHDqy2nA6gfiL08RgJoMUyPqXvWMgP//v333kAXFheWYAtEeo5vbqLVrGcvSEY/7WKAyVmdIIRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh9vYMR9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh9vYMR9"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so10824140a12.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776372530; x=1776977330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhNecU+tmFElmowxJNTJwmYaqHoa2Fb9XKIuMgIj0n4=;
        b=bh9vYMR9pjvLIFcNxYrcj01P7qICcSCaMeF7xiDJO3/helVPlXEJsPyodTf1x07Cu5
         ULZrMOPeuXEYvRdhQf7Myhdx+WslZvKIhV+6owAI7qi0ADgECSGcuQWQM1skxD6Dr/6J
         g5q0Ej6BkD3xFAUwt5i6vN8FPv+o5m1ar6fnnfgVjrFqLAbvRznrgKJtqKYMeqQWGxM2
         Y2NRcJ9curNmPq0CEsNtiP2qBDy37FtkX9TB7DKBL5CQUECxUQ86VDMVQOcs8FP9+68m
         28VbK7uN6oiyzHxbYSWwAZycp9l1olFEX47FGK/Xg4YQV0RVgOQ+SOgQDcrBjHScA0M5
         OZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776372530; x=1776977330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhNecU+tmFElmowxJNTJwmYaqHoa2Fb9XKIuMgIj0n4=;
        b=M8R2+3/09voGO1agNzNeeAoKfDVucgcx6vmWox9DrDr7NN034L1+G3tLh1CJ+XNl6z
         jk4fRpQ6fA/ialNJeJ8Ly94JM+7/BdLQmAOnddJdNIUKdfFIyf797PrsqFMdRzkm6bf+
         +Oq6GjPQONbyulqptfP4JYiiQaRbDw9K+FoBL78zElFRfLUil91uDBxfbd7Vp4ZMayj6
         I+5nZR335zlJp/XxxqOM3QoGjhFOJ/pHGBknTEYTYso1wMFwutjAU9FFW9hf/kRkT7ir
         fMAy+G7LTCS4JwARr7DGKLR299NDtMzri1n1/M/4mrtlw6Xoa1RK2/pj3cro4dNvCvXc
         5GSA==
X-Forwarded-Encrypted: i=1; AFNElJ9UpsHjlCr1owWaRD/lBc/+hN4V+g1xhvTd7lUsYCRUWQvjuv96bX7vVgbnfbmCrW7jydUDlY3mfBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwkzVdJ7sT+fQH5S5sFmdWZyJHDHs+lGMlqcybsR9YCsmceUov
	6adP0K36069vXe6DZ0FzFI56O8mr+21f25uWDXpjCZrU+XKcbpgYAdhHwXzU1JbE
X-Gm-Gg: AeBDieteWfMuVthcm/x9xyduD+JboSf5HaXpAb2v/SisYTfC1lRFAQh2VwrdNoxKEyH
	VLjX8mhaSSTOtlrKYJmHsszs1OQI59q23pDlCE0gXVtigs8vtpwU7yD7I1UgdMLCs2NsXguJw0L
	m7tkBZx9DBxGpfGlXXMtXXEHiAZYJgdmniM6BcLyWjjK9b0IDqPMPpIs+IYnyJ8puKu6zFgBxn/
	2G9t+0x0NVZvdue0FMFz92H3B/wjaOrdt12ge5MVEOC6br2MVIbMeSX1Rg2SarJOP+xKAUhUY9M
	yujwi4W7tSLZ3u5pQ6pXEmbmjYASWmnOEDoT4cqo284i1W6v6fothmzOWfAM+fn12Godn8aLHE1
	W8xp8KiSWxWVw8kDJDQvtnWhsM8klRLe3nKFG/bOvW0slFmMRLGEFLwecbBj9Wu0QHdZKV8C0K6
	dX9MvrFIM8
X-Received: by 2002:a05:6402:3048:10b0:670:8d21:dcb with SMTP id 4fb4d7f45d1cf-672bfdd8356mr78643a12.19.1776372530217;
        Thu, 16 Apr 2026 13:48:50 -0700 (PDT)
Received: from fedora ([2a02:8071:50c5:5c0::d908])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6723800b6f1sm1437962a12.26.2026.04.16.13.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:48:49 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: wbg@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wadim Mueller <wafgo01@gmail.com>
Subject: [PATCH 1/3] dt-bindings: counter: add gpio-quadrature-encoder binding
Date: Thu, 16 Apr 2026 22:48:17 +0200
Message-ID: <1663eb2f4bf4c826cd190fa9974fb55c321e7073.1776372319.git.wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1776372319.git.wafgo01@gmail.com>
References: <cover.1776372319.git.wafgo01@gmail.com>
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
---
 .../counter/gpio-quadrature-encoder.yaml      | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/gpio-quadrature-encoder.yaml

diff --git a/Documentation/devicetree/bindings/counter/gpio-quadrature-encoder.yaml b/Documentation/devicetree/bindings/counter/gpio-quadrature-encoder.yaml
new file mode 100644
index 000000000..a52deaab6
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/gpio-quadrature-encoder.yaml
@@ -0,0 +1,69 @@
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
+  This driver is useful on SoCs that lack a dedicated hardware quadrature
+  decoder (eQEP, QEI, etc.) or where the encoder is wired to generic GPIO
+  pins rather than to a dedicated peripheral.
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
+      When the index input is enabled via sysfs, the count resets
+      to zero on each index pulse.
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
+    quadrature-encoder-0 {
+        compatible = "gpio-quadrature-encoder";
+        encoder-a-gpios = <&gpio0 10 GPIO_ACTIVE_HIGH>;
+        encoder-b-gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    quadrature-encoder-1 {
+        compatible = "gpio-quadrature-encoder";
+        encoder-a-gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
+        encoder-b-gpios = <&gpio0 11 GPIO_ACTIVE_LOW>;
+        encoder-index-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+    };
+
+...
-- 
2.52.0

