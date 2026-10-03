Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88793C09EC
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 05:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791003946; cv=none; b=UzF0RI4CiOhxlVCabfuZN/M4XVyNLQI8UNN0WMjcXuOAIHdH7nS6Mp7gjpVwuPOAeA1kKjmrk37lrPYhLYQ7bqZRnAxmxi4NGaLxWoaPaYHONp/s7nmsTKiLDgy00F0iuskyHmkODRC8ByvcrV+9W0YSbZM0GMULLnwvo9EVWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791003946; c=relaxed/simple;
	bh=IwCtURbrr+SWD9gPB7I289RiCtbN/TLUhieNLgnc2cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU0L2jgF1dG5rtT1xWssIawEkWEP7q9xK6hnbyirMbYQ++bAAbGMVOkwXby6GqRDYBYRalc81hsTNfGg6B32hMcKAFcV4gxiMNhCQqaQr8XcbEJW0/DoUkNt3UsmjwKo8aC911sbesbh307nbkBwks7/QGucdmxFIxp0CaEP8a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrvYP9FI; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrvYP9FI"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e36so21738a12.3
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 22:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791003944; x=1791608744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Mzyt9MubLLBQ/ccdXz9zxpmDHfG5rpeLJMT8DRWbQM=;
        b=VrvYP9FIIyeAexgVd9xZ3oJuW+sHt4xrKvurQtztr8as9ovA4xd9X5tyvzT4wOTyCC
         UJFql9amSo7mceIdb9Rjr2yKiVTUozCIV7dhEfKm/wrIwIerCpat+E8ZWyl1kce5ZTlE
         TqeW80zh3d+RwMRBvbUFD8y6JXUGJpCNIaIylA8OjiVtwAfiT3htJInmf+npP4d+KMrU
         ZS5B/NrPFP5ahLb+svajGdNcmw3oC/YGyd90O69rc4u0SZMErrnzjrSa+e1A6sf7vikz
         Yn7u5OqMQPSNRUEV7BEfevKzns71CKQm4y/P2FnSTQpAjNDhjqKp1F6vUsQAlZ737K4q
         n2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791003944; x=1791608744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Mzyt9MubLLBQ/ccdXz9zxpmDHfG5rpeLJMT8DRWbQM=;
        b=lO6W3GClFiH7lOOIXcXq6x78C1xobdJBrUC01imPyOtAs6CK5nAAaqzpLQgQMlb6HN
         zuC4OQsioVxK+P2LyNDsTEuDVWcbeE5tQz+0KMjDPEIqYIw0r6Aen6j+YUnWnopy3AWV
         qSpow3RABFn/ljKTD6QtI8WDgLsDtvVyYIt2X0Lyk8wwr29UV0rfoaiyVeZqjsneDwo3
         96a5wCqpV3//cxof0CVgiB3YhbG5Njl1Y9V4JXphXHwdNBzqmM8SdBya+dIyqvr6Vfjs
         baAm0DH5/kWkV3iMksKscXZannfUP7SVcs81obTvB7wh3BZhTYwJwd1j5OSsxwdTNtGF
         TlLA==
X-Forwarded-Encrypted: i=1; AKwUvBzL27Rl1/VheUhQWnehm2LaKNz0accuCbkwH6bUQkviIg82YqKAkHArgTWV7ruKyzk5UTXG1zdvY14=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8DH69rOwAxwIZp7Ap7Ew+74Sa+qa952J+zJONLWQRVOfdEJxU
	sJD9q8lN85L40oUl5lZ2bw9/I+t7+fV1DHDH6NkpoAXmYiBLDNpsJ21g
X-Gm-Gg: AYBFou1mwO0QgoGAewv4BKELemvxjMDGdBi/sR83vtHBLXAUWaDMwDOfnAWpavCeLQ+
	iyD9jaWXdcU+YHgXcXP4OBvxVp9QMmCrRyh0MBVOBtvvt5LZTZiE4kmxmO5aTY72zngT0G5jCke
	3Kc6Qh8EARU2Ip4c7r/wjm+0hOHUpGLq4DYUiCMMPxZtg2G7wfVq8+/QYWF7tdDAWEdM2YDjqPe
	Nh1jQlM4W467ap9e1etI12LmPgP1k03K5nB2B2mtJDtgRwWEcdcQgZ4FksTONNoozKmzyW7/K5O
	imfOXVCrdAfRsHWreexlgBD+nvZ5g2XFlnxv7t/MXABeGR295gBBglfsJMOT0xmpj7udNO2FXnb
	z06Q95Vo7eIM4r4yJtOWSHpd83M3LwF2SpaUzdiurEtOvh93Dn5wRXeI2Hjg86dX1uUugxW24nK
	Opb9ArDgIg0ciDkYtiQLekn1uriVMIA+VWFAN0B7uVtoMl2ITc0KMH+55O0mAA/AdAJTkovqbNw
	HBamTs9zQe8fepxDCwDEg==
X-Received: by 2002:a17:90a:d2d0:b0:3a4:dbda:9934 with SMTP id 98e67ed59e1d1-3a6ce983199mr1774430a91.63.1791003943915;
        Fri, 02 Oct 2026 22:05:43 -0700 (PDT)
Received: from l (ec2-13-230-214-216.ap-northeast-1.compute.amazonaws.com. [13.230.214.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d4a869esm1650442a91.2.2026.10.02.22.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 22:05:43 -0700 (PDT)
From: Liu Yufei <lyf98405@gmail.com>
X-Google-Original-From: Liu Yufei <lyf98405@gmail.com
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Yufei <lyf98405@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: proximity: Add Vishay VCNL36829
Date: Sat,  3 Oct 2026 13:04:52 +0800
Message-ID: <20261003050453.413700-2-lyf98405@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003050453.413700-1-lyf98405@gmail.com>
References: <20261003050453.413700-1-lyf98405@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Yufei <lyf98405@gmail.com>

Add devicetree binding for the Vishay VCNL36829 proximity sensor.

The VCNL36829 is a proximity sensor with an integrated VCSEL emitter
in a small package. It is controlled over I2C and has an interrupt
output. It is powered by two supplies, vdd and vddio.

Signed-off-by: Liu Yufei <lyf98405@gmail.com>
---
 .../iio/proximity/vishay,vcnl36829.yaml       | 55 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml
new file mode 100644
index 000000000..6f20537ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/vishay,vcnl36829.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VISHAY VCNL36829 Proximity Sensor
+
+maintainers:
+  - Liu Yufei <lyf98405@gmail.com>
+
+description: |
+  Proximity sensor with VCSEL in an ultra thin small package with I2C
+  interface.
+  Datasheet: https://www.vishay.com/docs/80580/vcnl36829um.pdf
+
+properties:
+  compatible:
+    const: vishay,vcnl36829
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  vddio-supply: true
+
+  interrupts:
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        proximity@60 {
+            compatible = "vishay,vcnl36829";
+            reg = <0x60>;
+            vdd-supply = <&vdd_reg>;
+            vddio-supply = <&vddio_reg>;
+            interrupt-parent = <&gpio>;
+            interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f82..e6ef84b49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28754,6 +28754,11 @@ S:	Maintained
 F:	drivers/input/serio/userio.c
 F:	include/uapi/linux/userio.h
 
+VISHAY VCNL36829 PROXIMITY SENSOR DRIVER
+M:	Liu Yufei <lyf98405@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/vishay,vcnl36829.yaml
+
 VISHAY VEML3235 AMBIENT LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
-- 
2.53.0

