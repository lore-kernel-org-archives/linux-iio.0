Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EB7146D5A
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782521939; cv=none; b=tGE+ti5Yx8VLau6gaP5blimGsC4zKAMgiFsDZYj1tdQ3cm+aPgGeyAvfR5nEszEI4h54gAMoFtqDhfgyLBKM9uAD9mlr1Jo/CLxdMxf2+yoo8hYD2y6EWwg/VacrOIK2cmsJ1gjSX4w4iMCY6Tmrta67GROtkZ4QoX70GOacIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782521939; c=relaxed/simple;
	bh=y3S1KvtNosafy48tcj/3xMktfz9snr7y2zlr/HxBb4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NrFXwO7fOs6bon/7DL/gOcJ3cCuEWL16+6il5RAi8SgDg/FtwwF+c3hU1SCY2kKjxrhSJHPFNX7NgwGAaijS4/pbhNGfx4iEAlS+AH2lribun3HrH4QycYWavUTWB0DqpPULGnTo1aBXD/irUBiIaRxxORv2R0WVBkWmTiPCcww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibzftLa9; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibzftLa9"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-139b914bab6so2196259c88.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 17:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782521936; x=1783126736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywpGJ5fE+ty8rvwH5Kr4yHLvcNd7p6MPefLn/FkUlLU=;
        b=ibzftLa9DBxBS3I5j65YwTJ43Ony0V7ErMrn4zZwFHYh475LcEUqhu+kMh3nFnIdcM
         bkXKDmLIXmqpo+fqDxQCKdYkJdiLpWqbnn2K76NN9230ASaf4qdg7nCunPBTq9xO5aPd
         l9Chdva7M0Ufai+rUg+lq9sm5lHI2O1+l450IoPe9laE0nbf9fsVr6S0fOCpJYhFu+kZ
         gch/rXujlsRQBBZddZIj3GWIvBc5Aegf2G//rNWreLqU2tHYdcIgR8Op/8fAq0rddmal
         4jY5h0qe8Ja76n7qqhDrVWJzl6GU2shFOkcrV9SeDYZQ9ibUSG/qiatBWeo05lJvkinQ
         TOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782521936; x=1783126736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ywpGJ5fE+ty8rvwH5Kr4yHLvcNd7p6MPefLn/FkUlLU=;
        b=OE73Nal3yRNlEBdQpyXb1ujOuNdOnq/d8byVBXdhsenMTZl8e9qjM81NJbVoSP5MOu
         36LbpA7B5jMtF7QMO6qXc5EG4mGCkrBDZAc0nk8P5dJdl2NW5EkBIHvvTJNevHjcJXCj
         88CdUkD8zzF1jZkfnStxyACawh6QcpzM23DX50cgTM0fUtwslEZeiXePZCZwpOkJU0yf
         MmYXa4ry4kxNYd5UK80LtfWedP7TDB45TQr1CY9qbyi9WsP5yg5cdxTIEsqk9+SrjuI5
         C3wKo7ZKoX1hYXv+2irpvlNK3h4sGALHTAYXI4gQsbnvDEuqgsJnfpzxkZDCCzs13MEa
         zf3A==
X-Gm-Message-State: AOJu0Yx7vHs8RqNFDovXFJWlC4zS6zUjlrpzBuW/jxHPGNB3HjzQajQB
	mByyJokeNYld0w+5hXMEG7AjLHuLu/3vkoeTL7M66JJtfASl/nbCp9a+GPDUA6Y=
X-Gm-Gg: AfdE7cnGu3JKbXLyUKP0IdvFcBWHNbYuBmXARwAVGnYzzQE0WC+z/mNanT+stDiCm9Q
	8ti7h+bg4qM8g0l5I/bBBNCNPKlIyb7Otd9+bNuwK8JcRbTMAu5JsLigThGO16S6dRrVIOyN5At
	oVEOA8UiVtXB3ZoVq+lrf0m5uzSvkYWJZKJxdIrG1d65RetkA8duFY5CCsj0g84k3yeaqHmGpc8
	ZTOG5rgwbgctgMGhSCuuf8KYaiGHRZfqxYtZTCyJGwi1SxkAuD/ELQo0CXUyldp2y3CNFxkMYhz
	y47VGUZi4qOG1GQttEbXqvAE93z/q/4iuqfmxEr9mLRUsB145cRZNh4XL9WvlWesxjMpKoF29zb
	VGTInDw+ajFH88w9WXzcN3K8P64OP/Ms47T1KUFVZp0NZm4sIpZzeYi53+RBBgrenW5uChkREhT
	A59vO91p8THN//XC+ECaeWvc4ud+LEKoHc0vExYS9Ur7afA7erTkgZ
X-Received: by 2002:a05:7022:ff47:b0:138:4067:e44b with SMTP id a92af1059eb24-139dbb2b4femr7178834c88.12.1782521936031;
        Fri, 26 Jun 2026 17:58:56 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f6d2e4sm22387112c88.7.2026.06.26.17.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 17:58:55 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	u.kleine-koenig@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: magnetometer: add Melexis MLX90393
Date: Sat, 27 Jun 2026 06:28:42 +0530
Message-Id: <20260627005843.7786-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260627005843.7786-1-nikhilgtr@gmail.com>
References: <20260627005843.7786-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree bindings for the Melexis MLX90393
3-axis magnetometer and temperature sensor.

The device supports magnetic field and temperature
measurements over I2C and SPI interfaces.

This initial binding documents the I2C interface.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 .../iio/magnetometer/melexis,mlx90393.yaml    | 54 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml b/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
new file mode 100644
index 000000000000..33ab0be66345
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/melexis,mlx90393.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Melexis MLX90393 magnetometer sensor
+
+maintainers:
+  - Nikhil Gautam <nikhilgtr@gmail.com>
+
+description:
+  Melexis MLX90393 3-axis magnetometer and temperature sensor.
+
+properties:
+  compatible:
+    const: melexis,mlx90393
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  trigger-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
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
+        magnetometer@c {
+            compatible = "melexis,mlx90393";
+            reg = <0x0c>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <17 IRQ_TYPE_EDGE_RISING>;
+
+            trigger-gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..469ae3f9aa0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15501,6 +15501,12 @@ F:	Documentation/scsi/megaraid.rst
 F:	drivers/scsi/megaraid.*
 F:	drivers/scsi/megaraid/
 
+MELEXIS MLX90393 MAGNETOMETER DRIVER
+M:	Nikhil Gautam <nikhilgtr@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
+
 MELEXIS MLX90614 DRIVER
 M:	Crt Mori <cmo@melexis.com>
 L:	linux-iio@vger.kernel.org
-- 
2.39.5

