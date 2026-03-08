Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F57D330324
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772969997; cv=none; b=m1gJue1b9eqTKGBCaj770xMysxm/00h10eqFC9Ofpl3agS6osZIUndWPwPADY3dGdRhUBXsplZSOqhjjQMc2d38PH0kbyMiJ3+Tl1EFbzDGQm+uUrssrcNn+9YtpeeLpj7q9cn2EieP9EcmHW9wCMtBTKCx7DkPPh0SSFEQdL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772969997; c=relaxed/simple;
	bh=xkjvnBfEWzXCeVXpajuv8PkZ3Fco7O1UlnT6iVuPIBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l40Ff2Kx3x5tpO+txtbGEpbqZ42NdJeEkfDzwQxz48ugGXIk8RHCz1cyQRaoFk++UGBbPBTrYP1al4REJ7bo+cMpAy/RQ0SwfiptZg1uBrw3DbSFWjFDV+C8MIowGuKFdYv6uGHYw1TPVdMgXD8oC1JwFThN0FQdd7SyuNyYpU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c7393536e53so1223244a12.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 04:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772969996; x=1773574796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQ0NQXAScTkrINYzywR9cEThj+C+gXRntuK61/et010=;
        b=hl2hZqlUZyrYQISYP2GXnyZo7m34EU8o7/nIW2ba87HyksXOtA1wUyAiZjO8I+oo6h
         wW2oCnvEzi/SflqUhG0tpwGkIcUsz9vn9osuPomvsy/UZep92FVN8fBEPtewixbVhNHw
         Hjc7Ui/qCRFFybsEfQi5fwLFd9meJQLrc/lhkofvDcTqhDg7sPPalyuDbGK7nryhWOhd
         xfdAPOOjPOI/JjcuGbaFMmlHSKEqX6f2ceqUpa/D7bFQPQq0fUMlmDYsFba7Tl01kiqI
         g254xA+2nUudqXq0Wxi3+Z7PNlGBg1epyJiwD7FOjyhskxgAQKlEJlwejp+j1FcVzMkZ
         Ymgw==
X-Gm-Message-State: AOJu0Yxhlq3hVCJlI7gXcNkU3X1lEt5UAHpt81OdOKVrdbkprOjT0KGj
	ISpBDBwsfkuMLG85DHzwPgViDs15+QlgZC0Zzz7+xBzqXc9bb9gxUi6MubX2ttZBLxo0jw==
X-Gm-Gg: ATEYQzz/+nxfTHcjsEo4caWbT2bsorNmnDiqTIamRLx+twnlCM1HDMIKvRfzRJ7IY26
	RygXb9saSxOZtpiUWmBY0me2Kil1zfQsZJCKzSvYmujsDh1LWgZXAzaHeaZOQDxA01RLO6jlcod
	z2ZoFar5A0Lz8PYICt2pWMnf3bVkTvDHPgmMTcCaDkYGLBenxrXrdgP6+BeAqVj0/7ElgpFRZFN
	EgMjzOuJXpgmTtbBWzqJ9JozyiNS+yTZxrHAqwe4xhcNhGscdD096+l0qdEW7SI2gXytCs2FgHI
	GpGkhFCCHjY70Gwd/XFKH/GC/yV1vbeYL23cKgNrSgHfWHunHJELZPkM7tX1tx66UCmC1J1d6m1
	yaK2JwWspLQc1NRl2Lj4yYjMZxvsMYBE92nkEqCIyeyz1qLanEPCvcrL1QQ+AQdR7B10uNDv+im
	JfwdsFJHI7KBX05jwCAy95tG+mzxs=
X-Received: by 2002:a05:6a20:729a:b0:395:4dbb:7e69 with SMTP id adf61e73a8af0-3985908729emr7663067637.45.1772969995684;
        Sun, 08 Mar 2026 04:39:55 -0700 (PDT)
Received: from archlinux ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48d372esm7063721b3a.61.2026.03.08.04.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 04:39:55 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>
Subject: [PATCH v2 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
Date: Sun,  8 Mar 2026 17:37:27 +0600
Message-ID: <20260308113728.40860-2-email@sirat.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308113728.40860-1-email@sirat.me>
References: <20260308113728.40860-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding documentation for the STMicroelectronics
VL53L1X Time-of-Flight ranging sensor connected via I2C.

Signed-off-by: Siratul Islam <email@sirat.me>
---
 .../bindings/iio/proximity/st,vl53l1x.yaml    | 50 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
new file mode 100644
index 000000000000..c4ae96293f27
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/st,vl53l1x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST VL53L1X ToF ranging sensor
+
+maintainers:
+  - Siratul Islam <email@sirat.me>
+
+properties:
+  compatible:
+    const: st,vl53l1x
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  xshut-gpios:
+    maxItems: 1
+
+  vdd-supply: true
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        proximity@29 {
+            compatible = "st,vl53l1x";
+            reg = <0x29>;
+            interrupt-parent = <&gpio>;
+            interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+            xshut-gpios = <&gpio 5 1>;
+            vdd-supply = <&vdd_3v3>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 61bf550fd37c..01c8e6bac322 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25093,6 +25093,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
 F:	drivers/iio/proximity/vl53l0x-i2c.c
 
+ST VL53L1X ToF RANGER(I2C) IIO DRIVER
+M:	Siratul Islam <email@sirat.me>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
+
 STABLE BRANCH
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Sasha Levin <sashal@kernel.org>
-- 
2.53.0

