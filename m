Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463388;
	b=4x3osnYU5jpAX5BShesXvaXTgW2jJZ9xPxLMr5XDzJM6KswwURD/LCSwvmBHAnuuJaDj
	 tNjHn6UVRjR1Y5cljc2d4kn+ye1q5GdHzpjOCSplzBoGPjB5KsuRrBLNrYtuKd0Sp+k3C
	 NQgQlTovKAPUZdmMNJVqwyLyVI1afsY4+bHjuiqpR/d6a/Ux67T4fMRhGulKzdHztoXyW
	 Ks5cyejy4yJQKfLGmdc2tCLcLFPU8tuU2A367N/3chJ+4C8QxSQo126lBEJHZHrUpojXw
	 3MIqnxLLDQtSHF7xsoBgQcbmM3RaPgHsnWMPWgmM3BTapxvhmfO5kU65jnnZpgaZCLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tBF+matHGBGE6Nr1Fd/2Ogm4SDKpAbX6dyL5PCX4Igk=;
	b=Rh1YlgF1JZSZXPla0AIhllk8ZndXcsl8SDo0LLkCYS2nvkyIXGBaaN7FjYHdK+I66KhC
	 oRttsAdUeyDOurfeGFT/xgChI4VVUaWntsaRV6isH08xQjyp4VOlsPWqiB40dzy7bCeit
	 UpFNH572j5Gt+VMpzAbh7zysfM0T5uz8gTrX8VbilY84HJwP5++/x7i9UTLYADaM/lc5h
	 rQZl6u2BfWU+r8wzDn1gEN7xE5UrrJYy47L89/zyZ3IoDs3Eb9dGXAdNgacRz/Kp84AQ4
	 j2sTol9QorZk85c9oE22aKrqqmTbBz8CCYlIYMo3i6kurBqKjVoaFyc4U2W4oQ6Otmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Qaq3PXtD;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E79606A685
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 19:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1E79606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Qaq3PXtD
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so31815955e9.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 11:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795463386; x=1796068186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tBF+matHGBGE6Nr1Fd/2Ogm4SDKpAbX6dyL5PCX4Igk=;
        b=Qaq3PXtDYHyqoyMov8LwW7piMp5iLht+BnmiGSoPfj3M5yjv1DrYnD12Kze2+dkBzH
         Y+dWv9wBLUCpbFJhBRd7k5Yb72AhZrbaZSiO/KKhp/apSosa3cmFAyzfw+Ud4tqfUAUt
         UiXCexOyoidQjRJga3S2YLrhh5//y8Dze1gfcgPObp2+MhW62zzniloiHqvHDbN8qEbV
         rrx4A8QGYD0vlO2vq1n2HhW7mSDHPRpCBIKY/7dD0NU8MO+GriTygNcY7jf54h1tQIow
         ti7xvN067tpOOrSIcA3Iga+1oTPEb1zRHjLZXmujqMyoUeeP6+VJnOaDRdNqNUaB2KY4
         20vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463386; x=1796068186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tBF+matHGBGE6Nr1Fd/2Ogm4SDKpAbX6dyL5PCX4Igk=;
        b=ISIi/Cvie+5wcLC0EWfFeNH9ViyGG+oO2OY/Ubx5xq/q8zItZFrFdsVFU4tvqxkqkD
         UKJw1DaV7H4y5wwpNU5xyk/JiPTS9dxB7OHgtYjwPGFbcD4hjc/SZJ7ivVWcoMm78umC
         B6lZ2iNsRBc603+2wFAurrMnp00xq84zm9e8Wopa9WkKL7PJ9oJt50EJ750EeC123OjN
         Xoo/9hCijB4cdGMHTiVT7INbP++OYYNpZqwdFOJzvSO7ncEhy1+LV2R36jfUVoniPTg6
         KsImEkwIunp123qU39gXjZKAwI+RoTr/OZSVGy1QzRnSe0kA6GOFkEUQqrajBkhS54g0
         HgEA==
X-Forwarded-Encrypted: i=1; AL+hErHWr32/fmL6gVhlopA2XuCSfyEAYU4C8Y6L04Be8h6vZLkJ4W0YGaEIipk2Sjqg8SA7ZHDxGf8u444=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uFjugVuGkYPehC7tYrAzJ2IRMuIOXzxZfilP2sSF18vSmxFzu
	CDjcXnwobSCyjpzMI2ivnLb22k/1q82xZlYIxcAsCEUnXkRpk/MMFYRCWSuv4kKUL+s=
X-Gm-Gg: AZFdTZeh8aYl0h6Awl4sXDMp2913zbHqlTJFKFXyqwEdirBJFE5YSVQNaR6InFl+jag
	yI7pmrRwrTHS9u4AS/z+mGnUQFRw6P8PLHtBVqHwi33Ss+gfG7OtsjmZGU4d8xExmJeDomRlnfm
	Z+Y144pnJg7HA1IKxK3K96Z1dkBVeW46FgxtdakyJidipnewRbZS+OKJv2ztw4CCH7UKc3YNzrL
	m16pmRN/Uo30np6MP4XumjesIqPYAf02YZYUqAqmPfTyVsUwEbSrCtttdVJXm/I2+x7gKgvQxGa
	lmYW0uMFH3zBcc1C2Q1KRxu7mQyYLZFZ2BDaeEv3rBME3Ov+PKynBxxqhpgIyQvX8eDM+lRazKF
	7Gga/jTltqaHgrinP101sSl8fSH+yMVybHAaTiHuXI1xbG1friZ1hHot6VYVt0JhBqmnckIQipi
	JJ6fpRQ6hqez7TennhwXaSNGLQoLqt2hEDreYykEMyBSndqmQHCjWOvHA3CNZ/M6+fkr3kNO02Q
	5aI7JYSUwVU79Ap8FI78c33oYITRjWF70nHy9T5IUmq3HmC1vx8KH7ce8ezDD5LeX/BxAdNVQWK
	3V71rJ0yAlihQsSYv4GSbS95idh3KG/MMkgu6Vz/9PBsAWFet+BIDiBT1KUPah+gsT2bROTebJF
	pY+YyT1JoRFo=
X-Received: by 2002:a05:600c:a086:b0:4a7:6425:c274 with SMTP id 5b1f17b1804b1-4bb887c34bcmr263324385e9.2.1795463386327;
        Mon, 23 Nov 2026 11:49:46 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm300924125e9.2.2026.11.23.11.49.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 11:49:46 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: iio: magnetometer: Add MEMSIC MMC5603 and MMC5633
Date: Mon, 23 Nov 2026 20:49:40 +0100
Message-ID: <20261123194943.57601-2-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261123194943.57601-1-gerard@teslabs.com>
References: <20261123194943.57601-1-gerard@teslabs.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MMC5603NJ and MMC5633NJL are listed in trivial-devices.yaml, which
allows no properties besides the register address and interrupts.
Boards need to describe how the sensor is oriented, and the supply it
runs from, which is often switched on wearables.

Give them a binding of their own, covering both the I2C and I3C
connections of the MMC5633NJL.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 .../iio/magnetometer/memsic,mmc5633.yaml      | 61 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  4 --
 2 files changed, 61 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml
new file mode 100644
index 000000000000..423b8ecbb9e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/memsic,mmc5633.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MEMSIC MMC5603 and MMC5633 3-axis magnetic sensors
+
+maintainers:
+  - Gerard Marull-Paretas <gerard@teslabs.com>
+
+description:
+  The MMC5603NJ is connected over I2C, the MMC5633NJL over I2C or I3C.
+
+properties:
+  compatible:
+    enum:
+      - memsic,mmc5603
+      - memsic,mmc5633
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  mount-matrix:
+    description: An optional 3x3 mounting rotation matrix.
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
+
+        magnetometer@30 {
+            compatible = "memsic,mmc5603";
+            reg = <0x30>;
+            vdd-supply = <&vdd_1v8>;
+            mount-matrix = "-1", "0", "0",
+                           "0", "1", "0",
+                           "0", "0", "-1";
+        };
+    };
+
+  - |
+    i3c {
+        #address-cells = <3>;
+        #size-cells = <0>;
+
+        magnetometer@30,4a20000f000 {
+            compatible = "memsic,mmc5633";
+            reg = <0x30 0x4a2 0xf000>;
+            vdd-supply = <&vdd_1v8>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index a8b2b9deade4..523c205c0880 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -261,10 +261,6 @@ properties:
           - meas,tsys01
             # MEMSIC magnetometer
           - memsic,mmc35240
-            # MEMSIC 3-axis magnetometer
-          - memsic,mmc5603
-            # MEMSIC 3-axis magnetometer (Support I3C HDR)
-          - memsic,mmc5633
             # MEMSIC 3-axis accelerometer
           - memsic,mxc4005
             # MEMSIC 2-axis 8-bit digital accelerometer
-- 
2.45.2

