Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6343C076
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610615; cv=none; b=KnwYvymcuR/uC3lqZaWEU4Jsle9cAao9AGnHUyotvCGq0iuTXcFOYKp9Y3N6NB20NtXauspK2ICfahK6acLwt7Dmda8ezIG4blgpbynFcPcpWjOBvr4GTuhW1VKyQUAIvHkTUMHFNF0EZvm++1IqWqSms51mH8oaPiIAD1O+35Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610615; c=relaxed/simple;
	bh=sXhs9sIVrV1bJnnaWiX/0/Bg0j9II9XzLpCMNCnXuDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+0VXWuxeZ+/okG4XfFHmI1NxI2ByohU2gwalH7M79rZh3IwiHgNUJjZQDTzBT4gAmlb2fFdHBxRuJgP9NGw/+7jvlzgzji/udscHWQ1ERd0/HK5QX2sW2DAU0OjAHxvLNj93fROUYo2Tuml2grX+nGM+xdcVK/Qd7sGu17IQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LjhWXWev; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LjhWXWev"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781610612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Va1wbI0GgUL6eB+s6EdSP5KZVywyXLfOSTxFT6wT1mk=;
	b=LjhWXWevkQ31iwpi1HdMZDJRr8BbiP6l36sRxueeq9O+zzCBhs2sGVasFM47ZH/ZR7MTw9
	Z63FO9EG/q3FPNA/bv024PgRoot3mG6fk7O8YbpAUiVJGtPtQzCE0dB5SDp5kqFnkJqvLJ
	t/oRgIb2Jcu+yWGc0HiQnYnNnL4geqw=
From: Siratul Islam <siratul.islam@linux.dev>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: siratul.islam@linux.dev,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: iio: magnetometer: add QST QMC5883L Sensor
Date: Tue, 16 Jun 2026 17:49:38 +0600
Message-ID: <20260616114942.37241-3-siratul.islam@linux.dev>
In-Reply-To: <20260616114942.37241-1-siratul.islam@linux.dev>
References: <20260616114942.37241-1-siratul.islam@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add devicetree binding for the QST QMC5883L 3-Axis Magnetic Sensor
connected via I2C.
Used enum so that more devices could use this binding

Signed-off-by: Siratul Islam <siratul.islam@linux.dev>
---
 .../iio/magnetometer/qstcorp,qmc5883l.yaml    | 52 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml
new file mode 100644
index 000000000000..38abd083a4fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/qstcorp,qmc5883l.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QST QMC5883L 3-Axis Magnetic Sensor
+
+maintainers:
+  - Siratul Islam <siratul.islam@linux.dev>
+
+description: |
+  QST QMC5883L 3-Axis Magnetic Sensor on I2C bus.
+  https://www.qstcorp.com/upload/pdf/202512/13-52-04%20QMC5883L%20Datasheet%20Rev.%20B.pdf
+
+properties:
+  compatible:
+    enum:
+      - qstcorp,qmc5883l
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+  vddio-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@d {
+            compatible = "qstcorp,qmc5883l";
+            reg = <0x0d>;
+            vdd-supply = <&vdd_3v3_reg>;
+            vddio-supply = <&vdd_3v3_reg>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e035a3be797c..1127403c579b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21787,6 +21787,12 @@ F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
 F:	drivers/bus/fsl-mc/
 F:	include/uapi/linux/fsl_mc.h
 
+QST QMC5883L 3-Axis Magnetic Sensor
+M:	Siratul Islam <siratul.islam@linux.dev>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml
+
 QT1010 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.54.0

