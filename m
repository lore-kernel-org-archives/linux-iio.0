Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5D4756CC
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 21:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275390; cv=none; b=pGG4+XOE+KTyPSRKkUBLJOS+aCoo0jxw96iM99PMmGOP5j+Reagn5eSmOID4Nl8pYvISV9mIj9fBXC56xsb5UF5FUnXUEt0kMgp/yxgiwqKiahsXTOn5ysgLBqFOZ7iTlPMN5wrFLgc7bOm4gEEtc2N/mbiyeWlgJi5iPUVkWU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275390; c=relaxed/simple;
	bh=4hfTn+xfU2Xm4P8U99/VCET8B1ZAjdDFbNV+hP87ynQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdiI52uxf8POcyMSl1YQ7zZxX8z8Q51KYR4Hpt3O4AMCO7rGnujZcbbAF/o3hMRRDuQR3SIYEInK6SQnWCFdkqTiHfX+w7d66OsEkzTJnFK/C87n4jCTQ/VKSBPqqWxvenZwenaQcffkuu9tePR+GfDW/YQgeV8AO0KQVPEYrZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=opgTK2yO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opgTK2yO"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f707e5d75so231504f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785275387; x=1785880187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=thorgqwrdljHsSG2fybZOjOPvwxMgHZOcqTTpLPCNMQ=;
        b=opgTK2yOaDayjTmVY40NJzMJhlNft9voqlLR67oQO23N0n7g4bXgNnMBj9H4EkR/w5
         aLPKIsrgHdip/XX7XasaYLN79S9DNrCStVoXfd7l84X44kQaxOHX+UnxAx00PSEh+02p
         C9Zt2BshY5nYrEqf+OjvotC/EFFuyYKKFyPnORA1Cf7XmBv5rwAUMcZ8piXPyk6ZbfSg
         KZkBQ0XrWaaM6igWuybj7dsadYdtdAAK6UzTMAtKorLafwCttvQVH0sGEaDviqjbeBEJ
         PtT+5aCYzNoAEnmzjAE9Yu8YFaRZ+yy5o6cc9Xeyw3DpBAGeek6yM1rfmTWJJ1JEBYBS
         5hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785275387; x=1785880187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=thorgqwrdljHsSG2fybZOjOPvwxMgHZOcqTTpLPCNMQ=;
        b=k8PI3DzUTzb0J0+kShlAJrmL7Lo+5Xo/nHCtcXAMtnFy8rIFm0tEcCM2h7UXMbBiy3
         UgBLmELAGUtjes+lZFvUUdYdz9Tf2zIjwhKXAOcD93KZtkUmTNTxBUpDEF3ItYw2lPJF
         qG+DDnFOig9/8UWI++H4NIn/53Q54jV9EOTCoHuvSdg8YewlTMq0Z0PF1XYv1iyW+9Gh
         Mpj2Jlr3aA77u8rVHFhKOlTUR0MPfgObMDDw3fBFAxK+Zs90T/3OoWMsMR47hnv1dxaE
         p5bTdRE2s9sN59in8CuCdR9nI5kwBmBQdLxG4R0DgWW2bWXi8bFGt3N7m71O+7FototQ
         92sA==
X-Gm-Message-State: AOJu0YyrEtrz93WOR+p0v4fChwsMh1kze8KzCTP5qbdZ7tr5CVZN5asz
	bzLP4molJBkLA70kLLBw+08zNPlprzpgGYHvWXW7FpZS4Y6w5+69SSxy
X-Gm-Gg: AR+sD11/zxwFiiQSNN0BTb7FSMQVukho848nJUjEoieMZepfkzLpKiy9F1BlfUEdwe6
	uKs+q5PlcaFIHJs0M6/PzcPvAfVtHH8A4rWzy+fOStv24WgkUZWQKHb8NSJIzKc+Q1XKk1leVbQ
	daSJjha+wJr4vjE9XisByQ3uN3OjRJrP9OWkDssMMIG68HievqmF2wyuwufn+b8vOwPBjDG4Xui
	uvWM1I4oSsQ7UkiNf58y89XYMM3CpO8fXiTc3mhbdd5MM39VTZWCUW8tII5FEJMgT8dT+4UBTSy
	JhEiCoAdhape81qf72x2bdAUMUU12wpxx2CTB2MGB40RAtw1dy42ugium0hx3kyegVwzMdYzAfT
	O46XAHZ3b7M+BWvHkqvoeBZkSPqwqJwp9OzhNQhN8jlvxq3DXXmTH4ri+6KLXGEdaoJzzgQ==
X-Received: by 2002:a05:6000:2408:b0:47f:93a1:115f with SMTP id ffacd0b85a97d-47fb1ec2a47mr4497611f8f.60.1785275386924;
        Tue, 28 Jul 2026 14:49:46 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ef25sm2353042f8f.24.2026.07.28.14.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:49:46 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: jonathan.cameron@oss.qualcomm.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	maxwell@maxwelld.cc
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	455.rodrigo.alencar@gmail.com
Subject: [PATCH v6 2/4] dt-bindings: iio: flow: add Sensirion SLF3S liquid flow sensor
Date: Tue, 28 Jul 2026 23:49:41 +0200
Message-ID: <20260728214943.29820-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260728214943.29820-1-wafgo01@gmail.com>
References: <20260728214943.29820-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the bindings for the Sensirion SLF3S family of digital
liquid-flow sensors on I2C.  The family currently covers the
SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.

All variants share the same register map and differ only in the flow
scale factor and the calibrated measurement range, which the driver
reads back from the product-information register.  Since that lookup
is needed in any case, a fallback compatible would buy nothing, so
each variant gets its own compatible without a fallback.  A future
drop-in compatible part can then claim one of these compatibles and
work on kernels that do not know its product ID yet.

The active calibration medium (water / IPA) is runtime-switchable
via the in_volumeflow_medium sysfs attribute and therefore not a
DT property.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 .../bindings/iio/flow/sensirion,slf3s.yaml    | 55 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml

diff --git a/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
new file mode 100644
index 000000000000..79718f4f98bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/flow/sensirion,slf3s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SLF3S liquid flow sensor
+
+maintainers:
+  - Wadim Mueller <wafgo01@gmail.com>
+
+description:
+  Family of digital liquid-flow sensors from Sensirion with I2C interface. All
+  family members share the same register map; sub-types differ only in the flow
+  scale factor and the calibrated measurement range. The sub-type can be
+  identified from the product-information register.
+
+properties:
+  compatible:
+    enum:
+      - sensirion,slf3s-0600f
+      - sensirion,slf3s-1300f
+      - sensirion,slf3s-4000b
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  interrupts:
+    maxItems: 1
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
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flow-sensor@8 {
+            compatible = "sensirion,slf3s-0600f";
+            reg = <0x08>;
+            vdd-supply = <&reg_3v3>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ce020ded5fd3..497492825f70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24583,6 +24583,13 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
 F:	drivers/iio/chemical/sgp40.c
 
+SENSIRION SLF3S LIQUID FLOW SENSOR DRIVER
+M:	Wadim Mueller <wafgo01@gmail.com>
+R:	Maxwell Doose <maxwell@maxwelld.cc>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
+
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
-- 
2.52.0

