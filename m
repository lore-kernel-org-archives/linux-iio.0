Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06733090C2
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230165; cv=none; b=BqeLIw0YY1foHKdEnh/WcDiZltkbFjLSCzmfFoPDrWaqcdUqpKpqO8xn+0VIKzv7xrUSq+n3IopZ/LswXvkHXviDFpxjjYlJ0KPO358EFL6Srd/zTqSzI7qkBHZKLv4kyXapOPzR83byGFfC9O6x8JGJMJzBfoZ+PxsyocjgWJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230165; c=relaxed/simple;
	bh=CbuV97VjT/KMon1hV6OEo+IcDzROYPl4T+hyY6k0nlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQqIiyRLpzgA0z3H02SMRQwNyFHtoOqVyf41/0ol7yESHXW7USn+lPa4cD3X0Z3vCvEeeg81JtSZUUj5mxFYR1NS4sMtt704suTheEnyhhrNBphcy+uYtdNz6CGRfKqgeF81O6b5FZo05AN4FmnP3nMKdr8cYHxLQANsCbZkf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCqM29e4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCqM29e4"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ad4d262fc1so4686127e87.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782230161; x=1782834961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMN+DlPVMO7XwEUIB8KB3Q5KPG4C/k7irSNWdefCI4g=;
        b=fCqM29e4FdND0ZlG+m4rRbr5bbJiDvJI3meB9zXDSwJQfi0Gue5R5IJ3hM+TY2mSJJ
         ywYaOpRpR41IYnANzEV0pWHZCQXfFY6nqUqJlp0iVBOiIP3BD7XT/3/glMI2TkUJ/cRj
         sdweupoYS9vbqqua+roM9YUshkRzsI8/WRulJAmWdK7rAn8sO1SMmxBdvWgLnlosSQkc
         v3clBTX3ogAh3Njz6zPiezZXhgKnfTiELDe1h+TRzGBJZ8RGi9lxJvf86/w6MU3RBIy4
         YMgGiniprXTo3rqO2fbeG07QkUEMPiVf8ocvw/plA6xm3XLe5B5J7pABVp05URJUQWN/
         sbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230161; x=1782834961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QMN+DlPVMO7XwEUIB8KB3Q5KPG4C/k7irSNWdefCI4g=;
        b=gPCiuKuFc37q6+XMODz6b+iz0I/1mRJHYY+xTmU7jhsoxNF32/AEYBRgwsjPqxChqH
         XKS5Wqowa/bZANsl4H7bYoeuhGPyI8s3CNH8gf6nc3VyFFeC9eiO65z529sVfdn3GIGr
         SjjrWyTyw5n82dCYMoaW4OT75p/AaF0d+M4+ByXXgBQcagi3agjbbUay0k+aZXZ0zv7f
         TvhgcuDMv0oe8NifIKseL+m/wJdDRc62xmApsR+s/H47Kk0ybiaxdc2nx72IAjdMdPTo
         BXpGzBGpGKakqC8zUX6EpXbFbNesmubQrGP9psJW4t7FtucaFMdxY2l/LqE7g3L1SiGC
         SA7Q==
X-Gm-Message-State: AOJu0YyPb1ChJo7dWumZ33YERCOHninx2TjX6hxp/2VRWYVK5iAJhJfC
	gbWvtajGSjxfJnQj0eM23x0e82KIx7A7mizONNT8vksUCRZBy9e5DqOBxLu7lH7wwbeI3A==
X-Gm-Gg: AfdE7cnIhkMlgtH80T/juPa737Igp5c/4p1meVEE5rSuI08XAmPlzjRZSfD8FyoN9b6
	XwGZAwI3qz/4PMIfMtbTHYYtn/gd+nM3L7BPaWDcDqoCn31xpjmgRWaqPhoGohKsewiam4AE+k9
	K8TjCUvHPDfWOEj9rul5AOWvXS3kqE4xl6VlfqV98Uj3MP6GtHAw5Pbu/Uqqj0pxinSrVfZIs3c
	Yp8aLrFuVfIsHW3ahpJOr9ett0yzVKdj63wIxFXrTY8TzE9u9RnnXZTuqjbl6HmtlRUEe6C+8C4
	Hef4peZsaamzk966wn0PnQ1drYmPw1mFzOlN2T0mhgTbKsD2LoGm7dzKn5BbNix2sR2HqRyGVY+
	vyJdSvIDGyye6rYJEyi+O/nm1V2gQjJeuyscax9l/r7ZURQ5rpdF6MmOJnC3yJK4LnjMbv8IgF6
	PtnftUMs4ZTwDvPY3ujH1aZiik4AoWlYI7+ifECPDV602ZpQ==
X-Received: by 2002:a05:6512:2446:b0:5aa:100a:8315 with SMTP id 2adb3069b0e04-5ad5be78be9mr4935223e87.45.1782230160859;
        Tue, 23 Jun 2026 08:56:00 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a6a2sm908946e87.46.2026.06.23.08.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:55:59 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: iio: health: add maxim,max86150
Date: Tue, 23 Jun 2026 18:55:54 +0300
Message-ID: <20260623155556.13701-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623155556.13701-1-shofiqtest@gmail.com>
References: <20260623140113.12574-1-shofiqtest@gmail.com>
 <20260623155556.13701-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add YAML schema binding for the Maxim MAX86150 combined ECG and PPG
biosensor.  The device communicates over I2C at up to 400 kHz and
exposes an active-low interrupt when the 32-entry hardware FIFO
reaches its configurable almost-full threshold.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 .../bindings/iio/health/maxim,max86150.yaml   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml

diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
new file mode 100755
index 000000000000..1bf10fd1a3d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/health/maxim,max86150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX86150 ECG and PPG Biosensor
+
+maintainers:
+  - Md Shofiqul Islam <shofiqtest@gmail.com>
+
+description: |
+  The MAX86150 is an integrated biosensor SoC that combines:
+    - Two PPG (photoplethysmography) channels: Red LED and IR LED,
+      for heart rate and blood-oxygen saturation (SpO2) measurement.
+    - One ECG (electrocardiogram) channel for biopotential recording.
+
+  The device communicates over I2C at up to 400 kHz and raises an
+  active-low interrupt when the 32-entry hardware FIFO reaches its
+  configurable almost-full threshold.
+
+  Datasheet:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/MAX86150.pdf
+
+properties:
+  compatible:
+    const: maxim,max86150
+
+  reg:
+    maxItems: 1
+    description: I2C device address, always 0x5E.
+
+  interrupts:
+    maxItems: 1
+    description: |
+      Active-low interrupt line.  Asserted when the FIFO almost-full
+      threshold is reached or when a new PPG sample is ready.
+
+  vdd-supply:
+    description: Digital core supply, 1.71 V to 1.89 V.
+
+  leds-supply:
+    description: LED anode supply, 3.0 V to 5.5 V.
+
+required:
+  - compatible
+  - reg
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
+        biosensor@5e {
+            compatible = "maxim,max86150";
+            reg = <0x5e>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&vdd_1v8>;
+            leds-supply = <&vdd_3v3>;
+        };
+    };
-- 
2.51.1

