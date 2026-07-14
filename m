Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFC3FAE15
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017045; cv=none; b=EguaJEwU1nU2ieCqJSefvxkqFmIoMy2melGv4Y7/jmOutbF/2sFD8ML2J/1EgvpUEpuVIpHg58xDZYi7NisryQ5fG/WgaNAuY6OugUQe9qQHAJ57xld5o42lfLCSlRpXO3Z31RESI38nAEb+7gbkLBkjXOtuscKxdFnoLmu/Fqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017045; c=relaxed/simple;
	bh=xEEGwX2WirNbeBAzB5AL0aELp4pmQKWtE6Dq3wSUlo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQtYqvoa/tHPIpRH3ydDK3Zx7CRu0oFgMmsevD/i05lcF67vBYcL5J9VTJ570xzD5Xl3kH5gTycwE/nFt7TIC11WG0KpT2+Z1qYbZyY2HtpKjoVlscGNC6KQQOcHCoz2xrqcMxqsjX8BgQescWo+ja1HHPL/AT7VoJLWuQdIoLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4SIuYA1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4SIuYA1"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1614804757so398653266b.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 01:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784017031; x=1784621831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CoQnMOKpiJRr1uZ4EPacW9ACutARLVYGOVPpLwGEQDc=;
        b=N4SIuYA1YpE+X4zPakS58ufaufjsMyKuKHkF0PzSROVKnTh0UWN3POFbKuusvr38Zx
         xnXfb1JzX+PHLjWy/dT8/VxeEQkwrPqubXlkr5EXFVbi4qF3VLMMSi5Fw0u5qIjpg/tD
         7ywUjcxKcLJrXaS786DpipEDrdYWlCuPAbVD6+TRR2XV5u8QZCrue7m5w9KlBbyz8L00
         Uremnl/3UGhEsK2a6QwdxQucu/tVUASNfoAsgwykO7FDuqtLpvYLr2eXIaRX7rmZqKoy
         TOEkVcZz0E4xaturFGmYW493ntFpOYl5sURYUQMTLXC0PSzk8Zye+HaKELHQEkU1V/Q/
         yfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784017031; x=1784621831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CoQnMOKpiJRr1uZ4EPacW9ACutARLVYGOVPpLwGEQDc=;
        b=CuOT5KYvegpwmYI5dlMFZR0ysDCQkdWAqrFm4oiNA+Hlgh0RPmoOQkh1fe0jz9sTGa
         r0ejF1nKFHrRoyjXEQuq/9TAtUoIYZStYEDN5FeY0r/11Osl4mWxAgvrxHA6uJ1PLXJx
         4yIadCdJ0xz+xo4O1pVWjsNuhsDPPmzdcNZJsBdVIIBbmMG2z3ExMxEUzfVq2+7Vjgmg
         SeoV0aF6Coj9+xM7VUEKTiXqYkg1h22pKDG5dG9wiH/Uh2T2H9/4e4W3lAFrYuwzJhWc
         zwOQfX3IW2acNEZ/f+hwdj82jIoG5LFOJ4VZZB7ir0iWK/ld36qBBWgOm7O1t0n0ubEY
         XvJw==
X-Forwarded-Encrypted: i=1; AHgh+RrrQ5kk9NBiyZbU/lXpIwPCiRWXEL+g4uWW/eREY+zIxyVtiV/kwQrrx4qbc7SsjmJ2lCef5a70q9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy4L9LZ0MC4bfNzzLKfzVg5cGaBwXxBteajlWu4AVdzJDYlHtZ
	hfDVCo0qEcYk4Kv9jdNyHRRxspuefJ4a4Tw2YESlO/j5Y+h54EH2QcCl
X-Gm-Gg: AfdE7ckejabydshYv402+boyI9c3VBk17lYn7Y5MumSNstLUasI5L6pR7MdlJuKVoj4
	UUxUfbGLWdxp4EH3XVs2dXB70d+cgMBJNLKPdB1y94debiRnxR4PCaKcUt+6hzJu4LA9gejYoyL
	ss3n+NRQQAWXYGVFnLdeyjH8IHRgFML5y5suxJg/hL2nLBb1aRkQakBsbzuN2/SdERarKz/JvKy
	fmvA+GOrCzIpt9AgcjPvJyivOSv8h8cKxtSKtkxd0XmDTeWr96tN4ltyZeNN53pOwFUM+Rbo3U5
	C1PFNczwEvEkbK2OYOWhzvnppAU8FlqOfAaffmtWVR/EsMWH7lZ7YaNRGm/YWlZnQsacDlbCzJ3
	eTb9jLe+/qiMg8NLfW+9CZmiIYQrllE2WzvpzBiivW3iivuV7W94Rp0OSZSBawE0oNe1ccWu5/7
	1zhohym2ljIz3uPj/49AML4Uii/f+0fdZDR+I=
X-Received: by 2002:a17:906:7304:b0:c16:12b6:243c with SMTP id a640c23a62f3a-c161e973a85mr554612966b.14.1784017030626;
        Tue, 14 Jul 2026 01:17:10 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15e353d2f8sm723085166b.34.2026.07.14.01.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:17:10 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/3] dt-bindings: counter: add gpio-counter binding
Date: Tue, 14 Jul 2026 10:17:07 +0200
Message-ID: <20260714081709.17846-2-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714081709.17846-1-wafgo01@gmail.com>
References: <20260714081709.17846-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a binding for a generic GPIO-based counter. Two GPIOs (signal-a,
signal-b) drive two Counts; optional index GPIOs load a preset. The
counter function (quadrature, pulse-direction, increase/decrease) is
selected at runtime via the counter sysfs interface.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
v7:
  - index-gpios split into seperate index1-gpios/index2-gpios, so
    Count 2 can have an index line without a dummy entry for Count 1
  - dropped Conors Ack since the binding changed
---
 .../bindings/counter/gpio-counter.yaml        | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/gpio-counter.yaml

diff --git a/Documentation/devicetree/bindings/counter/gpio-counter.yaml b/Documentation/devicetree/bindings/counter/gpio-counter.yaml
new file mode 100644
index 000000000000..782cb177ed0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/gpio-counter.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/gpio-counter.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO-based Counter
+
+maintainers:
+  - Wadim Mueller <wafgo01@gmail.com>
+
+description: |
+  GPIO-based software counter with two Counts:
+    * Count 1: A + B. Quadrature X1/X2/X4, pulse-direction, inc/dec.
+    * Count 2: B. Inc / dec.
+  The function is selected at runtime via the counter sysfs ABI. Each
+  Count has an optional Index (Z) that loads its preset on rising edge.
+
+properties:
+  compatible:
+    const: gpio-counter
+
+  signal-a-gpios:
+    maxItems: 1
+    description: Signal A (phase A; pulse input in pulse-direction/inc/dec).
+
+  signal-b-gpios:
+    maxItems: 1
+    description:
+      Signal B (phase B; direction in pulse-direction; pulse input for
+      Count 2).
+
+  index1-gpios:
+    maxItems: 1
+    description: Optional Index (Z) input for Count 1.
+
+  index2-gpios:
+    maxItems: 1
+    description: Optional Index (Z) input for Count 2.
+
+required:
+  - compatible
+  - signal-a-gpios
+  - signal-b-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    counter {
+        compatible = "gpio-counter";
+        signal-a-gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
+        signal-b-gpios = <&gpio0 11 GPIO_ACTIVE_LOW>;
+        index1-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+        index2-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+    };
+
+...
-- 
2.43.0

