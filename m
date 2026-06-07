Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8832980A8
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875916; cv=none; b=tJi823y4FKu1zZuMs0P2ql6xsFZPuP5KUfaSNGe4pPjkTsTDpbPcnl355iZeZQtEISiE8Hc0I+McyYO0jK3GdETNrR+M8IVRmKzSBUmxT5/grmZu4pxEcyrdU5+TPetlC82XRvyx68nWfOTDS0InMyYPt9jlNRd5tKl21W+NU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875916; c=relaxed/simple;
	bh=Spsg1lhJOwmJ2qBBDyH8EyO73klzrypmW6Q3Hscl2pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKFSE5dwoqgq5J7nx8TOzX33cT7fzbgzD9Rjr+KOFiim6srK8HjERNYJke74BpaJsw66y1MaI8WKFzaWb9JVlcdBj5gUIlgh6JEBePmcMq5hcf0XndytsA/aL5zhlmzQDCj4bSg/hfA2kXPCTggfle14/neA0sAgrDoNsfxOX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RELLlOtd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RELLlOtd"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-842cd900ee0so411979b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 16:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780875914; x=1781480714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ahs7nLcf9FlQuNK4toxYY0XgtCKzjOPXWCt75LqsX8Q=;
        b=RELLlOtdJeuklN0IPC0N4fELBQGbivMj+u3cRt89hqX1QvJQ8s0tO1w9peG8L7xNPp
         uwIE89aEQazibfTOJ1PBvniK7fyNEqr+FY1S8saUMXOQC7tEfF42nra20UegijpDwiri
         yskHvDY595YC/N5ELX7tDdK2oyByhDOS7tikErE7Q7GBt6zXb3gZy5nQfz3zYSdAmvBt
         BADlyYd0IaIj5g7U/cT4geYK8klz45BFFoNM9zHb5n00BbpKfPMBFZjQGHNgFAlJT4Fu
         +q0txLOGxHDI9gVHOeNH7XeShxY0ZyeEtZOJ0vFQupf7/MFAQFuUInpw8jJLIwAp+nWQ
         eIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780875914; x=1781480714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ahs7nLcf9FlQuNK4toxYY0XgtCKzjOPXWCt75LqsX8Q=;
        b=T/tsAFImwHDKeZAyQcB0m+T7B8namQwkk5+DMYOnPrM8ku+z4GdURT0zJlZ6tLbSPv
         +VzDdBzCNW0JplvE+nL4XJDDUblI8yKNYEvGCShyBGXTYMXsXWi3eGPsWaQckjmMrn0G
         Vn4NDp32vRBKwbR2OfKQVABuDRi5h+aYD3lx7RtAvpk6PqSC9K4Ib2yJEHlL3A4UsvtL
         EsI97ytFtZjz3OckFEa/9ThNMPRn1Ovh8mqOeQAh7crjqgHEwsmNDBot8ku6JA/guAGr
         8XgeOCRdp2JElBX4iJqRU3lTQ6gGcz8mhBSE4CPDBFOdFAvLZdyyMGqLMDUB6s76fGgK
         SfZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/hjDvoTC7WEfDJKfUprQsHaWqM+1/zjk0pe0sP4yvsJjOrxxEdl/xtyxhx8B3OH0J+squWsk0iBgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzziu1wyqj86YjIDJsgPgKeLhxZXbZXbuZhDEJXJXmnLTyv1w3C
	C+ZOmPqwrKVjOlAzjYf5spCp6Eu6Fe93Vc7gcq2qGt8ds9eCF+P92LSp
X-Gm-Gg: Acq92OEMnDynsqfePmEEvliW/n4HnAYKkelIlO3i2OUkjYT4WCi4Mq5Oi06xp33fk6E
	VKttqjuzhznx63Ycqrs5Y4mtgVPpkAccicvOD94pY8Uy5KwJiRybH0ectoUkZhQF66eieApVHTc
	CCGqlbnutiIPDJlOe3Ycj4V/BEotN083PSZw/GQ5+ueKJdscHqKAglg7432p/G7FnAi/MZA5Rgm
	AaoxCQp8cEKGIsF/+IAC/Df1khyDTLrqpgK9iVB9Us+h4Z51Yn/9Z/Qf/BXExHP3aZbqz4ieiiy
	w9qyjtZ0UPoAC77g3wbuuZ9rU1zNln1JJGeoMtIHZckHrNmZAF2zM4re0R2wqfsnYuP/730m3LL
	/iYbktFHjC6QUUNVSs6QzlcuXdCLyOXPjhNPPHpo+aamA2RtPdCieeueP/LHPtv38TB/tJ7h8PZ
	CmVH5P3zg0AimuE1sBG8PPD+0BgBpmFQx3u4hOmHpDFG1jU7AlQQYdvsZ+MB8XEwLRtWoLD9p0J
	0KZlvXcsLcx1JF6ISjYsrmerrTfkGMY7HraLg74tUP5648u
X-Received: by 2002:a05:6a00:4298:b0:83a:4846:90b0 with SMTP id d2e1a72fcca58-842b10980d8mr13046383b3a.46.1780875913704;
        Sun, 07 Jun 2026 16:45:13 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828d6bd1sm19257732b3a.44.2026.06.07.16.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 16:45:13 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH RFC v4 1/6] dt-bindings: iio: add Open Sensor Fusion device
Date: Mon,  8 Jun 2026 08:43:38 +0900
Message-ID: <20260607234343.22109-2-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607234343.22109-1-kimjinseob88@gmail.com>
References: <20260607234343.22109-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the OSF sensor aggregation hub.

Use the generic opensensorfusion,osf compatible.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 .../iio/imu/opensensorfusion,osf-green.yaml   | 43 -------------------
 .../bindings/iio/opensensorfusion,osf.yaml    | 43 +++++++++++++++++++
 MAINTAINERS                                   | 27 ++++++------
 3 files changed, 57 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml b/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
deleted file mode 100644
index 626b41fb0..000000000
--- a/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
+++ /dev/null
@@ -1,43 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/iio/imu/opensensorfusion,osf-green.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: OSF GREEN sensor aggregation board
-
-maintainers:
-  - Jinseob Kim <kimjinseob88@gmail.com>
-
-description: |
-  OSF GREEN is an STM32F405-based sensor aggregation board from the Open
-  Sensor Fusion open hardware project. It sends OSF0 capability, status, and
-  sample frames to a host over a UART link.
-
-  Open Sensor Fusion is not a generic industry standard. Public project and
-  hardware documentation is available at:
-
-    https://github.com/opensensorfusion
-    https://github.com/opensensorfusion/opensensorfusion-hardware
-
-allOf:
-  - $ref: /schemas/serial/serial-peripheral-props.yaml#
-
-properties:
-  compatible:
-    const: opensensorfusion,osf-green
-
-required:
-  - compatible
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    serial {
-        sensor {
-            compatible = "opensensorfusion,osf-green";
-        };
-    };
-
-...
diff --git a/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
new file mode 100644
index 000000000..a4049715a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/opensensorfusion,osf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Open Sensor Fusion Sensor Aggregation Hub
+
+maintainers:
+  - Jinseob Kim <kimjinseob88@gmail.com>
+
+description: |
+  Open Sensor Fusion is a sensor aggregation hub. The hub exposes an OSF
+  protocol data stream over its host interface and may report capabilities and
+  samples for multiple sensor classes. The Linux driver discovers the actual
+  sensor channels from OSF capability reports instead of describing those
+  sensors in Device Tree.
+
+  Open Sensor Fusion is not a generic industry standard. Public project
+  documentation is available at:
+
+    https://github.com/opensensorfusion
+
+allOf:
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: opensensorfusion,osf
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial {
+        sensor {
+            compatible = "opensensorfusion,osf";
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 56181470d..e227b9aff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19977,19 +19977,6 @@ F:	Documentation/networking/oa-tc6-framework.rst
 F:	drivers/net/ethernet/oa_tc6.c
 F:	include/linux/oa_tc6.h
 
-OPEN SENSOR FUSION IIO DRIVER
-M:	Jinseob Kim <kimjinseob88@gmail.com>
-S:	Maintained
-F:	Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
-F:	Documentation/iio/open-sensor-fusion-protocol-v0.rst
-F:	drivers/iio/opensensorfusion/Kconfig
-F:	drivers/iio/opensensorfusion/Makefile
-F:	drivers/iio/opensensorfusion/osf_core.*
-F:	drivers/iio/opensensorfusion/osf_iio.*
-F:	drivers/iio/opensensorfusion/osf_protocol.*
-F:	drivers/iio/opensensorfusion/osf_serdev.c
-F:	drivers/iio/opensensorfusion/osf_stream.*
-
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
 M:	Rob Herring <robh@kernel.org>
 M:	Saravana Kannan <saravanak@kernel.org>
@@ -20024,6 +20011,20 @@ F:	Documentation/devicetree/
 F:	arch/*/boot/dts/
 F:	include/dt-bindings/
 
+OPEN SENSOR FUSION IIO DRIVER
+M:	Jinseob Kim <kimjinseob88@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
+F:	Documentation/iio/open-sensor-fusion-protocol-v0.rst
+F:	drivers/iio/opensensorfusion/Kconfig
+F:	drivers/iio/opensensorfusion/Makefile
+F:	drivers/iio/opensensorfusion/osf_core.*
+F:	drivers/iio/opensensorfusion/osf_iio.*
+F:	drivers/iio/opensensorfusion/osf_protocol.*
+F:	drivers/iio/opensensorfusion/osf_serdev.c
+F:	drivers/iio/opensensorfusion/osf_stream.*
+
+
 OPENCOMPUTE PTP CLOCK DRIVER
 M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
 L:	netdev@vger.kernel.org
-- 
2.43.0

