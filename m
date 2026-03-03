Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0774389DE6
	for <linux-iio@vger.kernel.org>; Tue,  3 Mar 2026 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528665; cv=none; b=r9uLKfvoio0Ryt3xdZVzY7G8E64NTW7FJhLmek6+2BpTZvcagtYHNPW6HkYJMSs7SJIUJImPfJWLhfl+VdETytbkPuALe+1jF2KIeoslH4K4jrJqBF/rKwbGiKskqGzjebfuXpu+QMkgb/9XX7HK4hqofxGaDzjZG1HS2ZQIKzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528665; c=relaxed/simple;
	bh=HMWLi5YF4lA0CxQ8/r7Lh7BOhSJi3O7f2hDG4tWEiRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfXsvYdUZlGlBVdrQbnf8ihK5a9ymmvQL4xW3GewVUI91G41zHpcP7sU5qYUJe4pFrutMNRoaj1hTc39KDKUejC+jZ1+zjdiXEg7BvPEHHYs+s48tm/Bh/2Q1SXf8Av6C3VeOvlBp5VBH0HL9sWAfqiNq0nKLeAu4Hf1YuiDA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70c112cb61so3096337a12.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 01:04:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772528663; x=1773133463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=41EUXMaXVnuo7cK8Z5CD58qbq04Mb1iyKiHB70SkViA=;
        b=qyGj3X8uYTAhO/y/V5mkVNqUlaeshkyu6nCeYRWzvZwydWAWGngU660DLkUp2pZLyS
         Cz8vka9bhXKAe703z7eWxPdOU//l/4uWF96uQMkR12aHMDHXom2o83L3NaXkaazlxV3m
         J89MJw+kDmHHgt5RfV8jbDNq+sDGN4jqY4pDxwDYxePJfEV6oJnLepVK6vtkd6OFOGvA
         dplkFEDfyf0KrHQmQ3B4A0485rro+Kiat0MKQM7Oomi+rGVpkGIf6MieY1pfUxr8uS9r
         X4v9/776LXIeNo8vvp6SUySZdvv97IQmhHdwesGARbOktb094RKrPewj1WcRHaHal2oM
         SFrg==
X-Gm-Message-State: AOJu0Yzfhdv34nlscG8v1hUGeYUXWnYi0Gfmnj3nwhOdFajtmxlCf4mp
	8Sl34jig38B2tRMyubNEaLjHSCc6bgo7C23xKXTtdxW7uIC4EfiOB9rCw3A7XfXxjYs=
X-Gm-Gg: ATEYQzyToCisFao4cczEUERk5ONsGnMsHFXkg92gxZ8qRbfc/VCJh2sE6jroETZhNER
	i/5bY2VPbZ6V1sf7wIBgVWIogNuL8met6O8FP8XnoNU5hbqJJcpygYi2Yc/JADQILOHuVuyPg5S
	h9yn5UOhM3+1DaGmWGhhU21omi5gFAPoatTK0uSZlpeUkMUxA7Ywr78M6BukdClQn91m/DfFzJQ
	5XbyG6wbLsqYru9sv6T2gWNtfp8si19aP9t9YjOUusKRj8Uh1KEjuwvzULG8TK62qKBEbRh1QYw
	ckgM+4BqnQTrB8ni9fQEgkZ/pfe4zbIGm934LZ+7te4DtslgIl4M8DMHrSSuHCTdrII4Yo6H1IU
	BsHXNN/dnUY4J26sqCai6YPclkRTPPkrpDlQp21cn7NDuVbA49W2UzmbkKO9NDC18jVLUf/u1jf
	LTLWGm/RvOVrZAK/X6
X-Received: by 2002:a05:6a21:110:b0:38e:676a:f31 with SMTP id adf61e73a8af0-395c3a4a18bmr12885122637.25.1772528662985;
        Tue, 03 Mar 2026 01:04:22 -0800 (PST)
Received: from archlinux ([59.152.111.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0792sm1638259a91.14.2026.03.03.01.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:04:22 -0800 (PST)
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
Subject: [PATCH 1/3] dt-bindings: iio: proximity: add ST VL53L1X ToF sensor
Date: Tue,  3 Mar 2026 15:02:40 +0600
Message-ID: <20260303090253.42076-2-email@sirat.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303090253.42076-1-email@sirat.me>
References: <20260303090253.42076-1-email@sirat.me>
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
 .../bindings/iio/proximity/st,vl53l1x.yaml    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml b/Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
new file mode 100644
index 000000000000..1b14063ba344
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/st,vl53l1x.yaml
@@ -0,0 +1,49 @@
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
+  reset-gpios:
+    maxItems: 1
+
+  vdd-supply: true
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        proximity@29 {
+            compatible = "st,vl53l1x";
+            reg = <0x29>;
+            interrupt-parent = <&gpio>;
+            interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
+            reset-gpios = <&gpio 5 1>;
+            vdd-supply = <&vdd_3v3>;
+        };
+    };
+...
-- 
2.53.0

