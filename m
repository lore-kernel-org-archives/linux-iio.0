Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05E330C14B
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779651545; cv=none; b=FRPXitymOBnRMyujG+Gi3RgMIOg1LpN4AAxFsIt0rdg57jVPxuJkLJ2M/mRoBByOp107VP/JW+JJHZRRHDlF/CwAS4pVygjzaey53/4NS3Tds2hoWkOwQTjIp8ZYFR7jzDYOvFT4W6AlupuEDOKdJ5xkC4oH5pRHu1RyMko1tJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779651545; c=relaxed/simple;
	bh=Ka0lpy76ovZVEz7hWNGwKbfns3W5Bp+Q3vY0KlvxXyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLF/lDWVU9jjhfGHK/LCmlb8cIV6QoadqMv56QMKPRB6xvdixBK0syKeKGLf5MNj3RzrOCj1vW/w4VM9feflxMFrRV29w6M+R1lvCzVLutqEWU+Y/bLmbTnGJ1NLv1E8WsBFroQb6AXIstQXhBto1Y8PV89gocCF0LQ5Qx/Uh6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvHIzUvh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvHIzUvh"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso14081405e9.0
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779651542; x=1780256342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYXve+OwpS7I6tcSPMQLO5NJg/fMFA3PAPuTx/rEeus=;
        b=qvHIzUvhmacY3aN/SNjCWNDzmTVLm2jR8DG0TXCIEjOq0ZbsK28dp36KsPk/lxTuG+
         BEgNM1LlaVWCYlVpjjjRJjeAaJbMM1hHASt99HiEBwn8rkdrkNK3WVFSVJNt8BLjcweV
         hosSp58KSd/1b7YatHLndSRiCkMo2YxHVOAA0hUdCq5XUwhUsavdc6cLb21czZNP0Uds
         MOgAB72MAjJLD1SKMThx9L+tUsfwvmrRHC5Yw6bx4DZyR1JuN5CskFXoL3jvEZG1nLD1
         s+Mt8YMChaMQa79y//naQYd+kiH0rj12+sy9VFd049rr0I/MtQZL/QOyxyt9qmRTjkFw
         ePQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779651542; x=1780256342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UYXve+OwpS7I6tcSPMQLO5NJg/fMFA3PAPuTx/rEeus=;
        b=Y8aw3uzolNm59dlFRaGkf2/Ie0w9Am5COfVdrxXDWljYcGQhNp7HqLgjDG6AQRY915
         Xm6MlPwDCCVWghHOi3hR9rBGJ52txFNxVAhxGCvRQeGa1m+TqtDV0Ay5n9ShpNl+gNus
         HRvxTFEKSEHWfx+ZgONyKUATvBGPLvBPlsLRbGB8USouTB7YC1tmxVhFcQ+nMBL2Sqfd
         hiTP9pzU21/f5K4em8q023Qm4GHi7wObJIKuJltqWe78Kn53wCF6PuKG0Qfb4p7mhM2n
         g2KXTh75mqj6RelkT7Ny4twB+qT226u22vuuzSHBs50+xHJqi9diT4+cUdC4dvw+7IcW
         mDrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/M9CQ08TvR0kiFNauI+rR9e/biZHlOwx+UcMt5OFibXf7K8doqFrV1hQEAvvCPkfHlmuAH314Utto=@vger.kernel.org
X-Gm-Message-State: AOJu0YziSykTaN/Xg2kCoGD2P8P1WAANQJD8TZb3YIgSbas3qoun5OVv
	M3o98NgeVztkKKpL9Tkt0nOtNhx0IjO8F0vWL0tY75ZDtiLJnWBi2Nk6
X-Gm-Gg: Acq92OEb+8eOKEk7xpYs3hVzlL+EnlrDvmTYX1chjeRfwuMScMIuCwcYytlcGdzOh8E
	YSZvwknDLxM6TZPsfdq0Gm0yWeqg+DWE/DXRkQgHIfzERfybnqe86EH0pqHNjSjkFdIhCRVY8vZ
	e9yWOMiKSfktCy7LTyYuhnwi3hLkIs47bLR1Gx21PeH7GS8leJ4duofsjJsd83/iDKseiaiMS6J
	UpbYzE9iGGaHHj9FZ7TVGTXGSAVIYXOJYTg6MVbGVoDZf4vEndgoBi/PfYSHYx2xf2JUmHup+/j
	i1Q7Eqf7zxMgXPYR55JCkM7/VtFmKSy2O5pM/btPAkEWFyfFOrH/aDW8wcoY9jjz8MFSOd1noiw
	cQ7v0sNq0RbRbZ+wofEPimBo9k7LUmbpLS0og/8diqxULoaO/XEeabzOxudwZp6jKoJx287qd68
	xktDgO
X-Received: by 2002:a05:6000:986:b0:455:7d77:1d25 with SMTP id ffacd0b85a97d-45eb38af97dmr20907828f8f.27.1779651542090;
        Sun, 24 May 2026 12:39:02 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9ba2esm22339674f8f.8.2026.05.24.12.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:39:00 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: wbg@kernel.org
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wadim Mueller <wafgo01@gmail.com>
Subject: [PATCH v5 1/3] dt-bindings: counter: add gpio-counter binding
Date: Sun, 24 May 2026 21:38:44 +0200
Message-ID: <20260524193846.19216-2-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260524193846.19216-1-wafgo01@gmail.com>
References: <20260515153616.157605-1-wafgo01@gmail.com>
 <20260524193846.19216-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a binding for a generic GPIO-based counter.  Two GPIOs (signal-a,
signal-b) drive the counter; an optional index GPIO loads a preset.
The counter function (quadrature, pulse-direction, increase/decrease)
is choosen at runtime through the counter sysfs interface.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 .../bindings/counter/gpio-counter.yaml        | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/gpio-counter.yaml

diff --git a/Documentation/devicetree/bindings/counter/gpio-counter.yaml b/Documentation/devicetree/bindings/counter/gpio-counter.yaml
new file mode 100644
index 000000000..4bd972b61
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/gpio-counter.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/gpio-counter.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO-based Counter
+
+maintainers:
+  - Wadim Mueller <wadim.mueller@cmblu.de>
+
+description:
+  GPIO-based software counter.  Decodes up to two primary signals (A
+  and B) and an optional index pulse via edge-triggered GPIO interrupts
+  into a count.  Supports quadrature X1/X2/X4, pulse-direction, and
+  pure increase/decrease modes; the mode is selected at runtime via
+  the counter sysfs ABI.
+
+properties:
+  compatible:
+    const: gpio-counter
+
+  signal-a-gpios:
+    maxItems: 1
+    description:
+      Signal A input (encoder phase A in quadrature modes; pulse
+      input in pulse-direction and increase/decrease modes).
+
+  signal-b-gpios:
+    maxItems: 1
+    description:
+      Signal B input (encoder phase B in quadrature modes; direction
+      input in pulse-direction mode; unused in increase/decrease).
+
+  index-gpios:
+    maxItems: 1
+    description:
+      Optional index (Z) input.  When pulsed, loads the configured
+      preset into the count.
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
+        index-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+    };
+
+...
-- 
2.52.0

