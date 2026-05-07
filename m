Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912433368A0
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158072; cv=none; b=VKjthH0yM9+k7YZxeObT20uzMnY+KirWHty5sPSbgI+jBIinr0JG7p2hOqXbqF9e0nbP/Vjd8QHy6bktcRO7UPZBEZapH5/vphjtUzROLu6p9nv/5vcZ5PN+lxKDnIKy0vERma7Ol714ZJlhSKskPyMhxfCa6fnDlAmfOpdpDI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158072; c=relaxed/simple;
	bh=VUBGPXzFgs7rcLq3/V9cERhFMeh3TZOT2bm1Ss+ziR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jI03RMMLWdJranP6ScjcPL1eCMipMgdsYB+/xJ315ZmREMm4IxtmVxsNJQJZyvLkReY24hrFc+/9JsUwpn/tvVKbgh4kx0tSg00TeSqou89sY9Qo4SeqI12LVXRuYhPCEOfDfg1ba2x+TO1UFGJ1FThFUJs5haBC69NINektRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lw4Q1/O2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw4Q1/O2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso5143265e9.3
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 05:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778158064; x=1778762864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1xzKmrAnk4+uOrTkiEWK4P8n1MUdQACoonvGkky13Q=;
        b=Lw4Q1/O2DUPOr59UbGBohnpCVTKEv+pORCPeeibLjPgyzbmBewCXQs7m0MnegFHrtX
         BAGQjkLARe+6PGDskMEw8v2PSJvE487+8uquDjXxFgMVmzn3iXXZRXqkptE21WBmkJQ2
         khwwuFCQDMJM4iIvn3vIui9bJ931uxzCXRwKMy7jd3kZiVl/pU5JMgU4aVsLSUrF8X61
         0T8PD2STEYWz85Ja503mv4zNYXqDTfRho4CTZqfrVlObHt/f5K5ltccAU1psnHSEBpFI
         83VI0gkzkhSzBhoze89LRiJpFKFNhGVy5cqkGxaxNR+tUbOvPyn3aumKdspyUpdTA+pZ
         72wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158064; x=1778762864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n1xzKmrAnk4+uOrTkiEWK4P8n1MUdQACoonvGkky13Q=;
        b=O3iVFOEuVSXQghTXTAqaDg/vCe049AUmvCyGSjcOEdkhGjbOc84Dlkou845olgfW2m
         AZe0vp1GhSOR5bWt3E5nb9WN0WsdMfedoW8PWe8BVlo7eRg/HICpvHIHJGydU46wiPqK
         PIIbIdhNM701IhxumOf0g/WM6WKYXV8JUvxtlwfUYkNE/b7aGvVv/6ybpX8IkzgbmPV2
         N/Yloth/+McU9OeBga0y1ab5BtIFTzwgPe40S83Qrcz5y9v0UBFp52U00FMG+DEYNO/5
         kBLOqo4wll1giw/tkgKFx+FJa0jpD1LzKtJKPskogp/lefBDpdQrwH2kJWYXeFyjJhcO
         sivQ==
X-Gm-Message-State: AOJu0YxhEvxza3rEYXP6waPoeuo5mWPxJGCLb2vVtNHN8hIeK+zln9uR
	miPLvD4hOE5H0n8BtcrKErcwrvAnSsj0B3dhPe1kIgs1hIX+B/Lxyf/H
X-Gm-Gg: AeBDieu9gleJuJGLSpNPsW+t+FzoWEaSivlHd2tODwPKNYp3WGO0k7/elKCbQ26nwXe
	kPm1oljqnF3G4/wY2xU6uTCHoS/vFp91xw8lsHSD/qevDILWJtv7h9s5g1nqr2QoOaI7U5dybb7
	xTtXbz94KJAGyPEZgotOOLR/MQmkXG8p8mDtzEgp5n716TjCe6bnv31meRZa3Z+/mDglWCsvoZI
	QHBI3bxd+axYkAy2kzUJ/nUcG1a3OpdnRdQuh44YtM1Cw4Mjij/Q/RWSO40tver9sJ/UBNVcbFn
	eeRPFGDLs/5k7hcc0sVyJopi3+B9wxwm+orRJgoGa2hlsP3TEppSZeFRbXmnSinqmJUO8m2RzL3
	AmfZ1uxq6Rh/svzRmfZtu7h92VsU6qqf6fx/1j7kuSf8KOYdibWhWbIZVj8OuoKUuful0NUFcN8
	kScEAW83lcQ+Z2UBVD8KkPuPY0KJJ4inAnU8LrmCKNMhRmSpc0ivNFKV00FNl8TndoRyvXbdYU7
	2s3fD6eWaou4ABPrlZd/kDgwfrL3A==
X-Received: by 2002:a05:600c:5304:b0:48e:51f8:eb38 with SMTP id 5b1f17b1804b1-48e51f8eb70mr131729415e9.27.1778158064315;
        Thu, 07 May 2026 05:47:44 -0700 (PDT)
Received: from ai-node.taila4f726.ts.net (89-139-15-25.bb.netvision.net.il. [89.139.15.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538b6e9bsm209228145e9.10.2026.05.07.05.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:47:44 -0700 (PDT)
From: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Subject: [PATCH 1/3] dt-bindings: iio: magnetometer: add MEMSIC MMC5983MA
Date: Thu,  7 May 2026 12:47:22 +0000
Message-ID: <20260507124724.813043-2-vlad.kulikov.c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507124724.813043-1-vlad.kulikov.c@gmail.com>
References: <20260507124724.813043-1-vlad.kulikov.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the MEMSIC MMC5983MA
3-axis magnetometer connected via I2C.

Signed-off-by: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
---
 .../iio/magnetometer/memsic,mmc5983.yaml      | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
new file mode 100644
index 000000000000..bbe2aa597f75
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/memsic,mmc5983.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MEMSIC MMC5983MA 3-axis magnetic sensor
+
+maintainers:
+  - Vladislav Kulikov <vlad.kulikov.c@gmail.com>
+
+properties:
+  compatible:
+    const: memsic,mmc5983
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        magnetometer@30 {
+            compatible = "memsic,mmc5983";
+            reg = <0x30>;
+            vdd-supply = <&vdd_3v3_reg>;
+        };
+    };
-- 
2.43.0

