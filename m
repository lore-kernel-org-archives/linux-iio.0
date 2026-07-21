Received: from MTA-10-3.privateemail.com (mta-10-3.privateemail.com [198.54.127.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE70372686;
	Tue, 21 Jul 2026 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641777; cv=none; b=T8gdzbASs7/KjTXaFO8JaxZIFlFbtS9BGAcRsrCuQ2ShggGcwzNtWmxHijaYDGobgk2BIO9sUcu88n99MgxxmND6uZOaAV3aZrxNliCL69bvzFPL32gU86Qm4NU/AEqVHvVaiAHs3N5IxXt5IkHWifUWoU3VKu93GZcjBw/kVmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641777; c=relaxed/simple;
	bh=IA6tu8VvKBsU9nA56PvhKSyDoPFqlr1Ovuo0Ms6wSEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PloXauC8I6L1vGWFNPU4/tg+hPS/87bm028G2po9KI/yhrnDQ5y/kAe89KTkJah+heKkAvZn2QlJABb71OUdgWfHjXBEgYVYRRCE+WOtZXmpks6+0a+b4VnSEIBKTbmFjdvL4kiE48laiDELTYMJkd+CjI6EHjjeDHZpxUmAqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-13 [87.215.145.39])
	by mta-10.privateemail.com (Postfix) with ESMTPA id 4h4Jdp4M9Sz3hhTq;
	Tue, 21 Jul 2026 09:49:17 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Siratul Islam <siratul.islam@linux.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: magnetometer: add QST QMC6308
Date: Tue, 21 Jul 2026 15:48:42 +0200
Message-ID: <20260721134843.7484-2-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721134843.7484-1-jorijnvdgraaf@catcrafts.net>
References: <20260721134843.7484-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the QST QMC6308, a 3-axis anisotropic
magnetoresistive (AMR) magnetometer. It is an I2C device with a single
supply and no interrupt pin, at I2C address 0x2c.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
v2:
- Spell out AMR (anisotropic magnetoresistive) (Jonathan).
- Drop the package mentions from the description and commit message
  (Jonathan).
- compatible: enum -> const (Jonathan).
- Use the current GPL-2.0-only form in the SPDX identifier.
- Kept as a separate file rather than folded into
  qstcorp,qmc5883l.yaml - the two schemas share only
  compatible/reg/vdd-supply; see the cover letter.

v1: https://lore.kernel.org/20260714202842.340293-2-jorijnvdgraaf@catcrafts.net

 .../iio/magnetometer/qstcorp,qmc6308.yaml     | 47 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml
new file mode 100644
index 000000000000..6201a44cfe38
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/qstcorp,qmc6308.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QST QMC6308 3-Axis Magnetic Sensor
+
+maintainers:
+  - Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
+
+description: |
+  QST QMC6308 3-axis anisotropic magnetoresistive (AMR) magnetic sensor
+  on I2C bus, with a single supply and no interrupt pin.
+  https://qstcorp.com/upload/pdf/202202/13-52-15%20QMC6308%20Datasheet%20Rev.%20F(1).pdf
+
+properties:
+  compatible:
+    const: qstcorp,qmc6308
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  mount-matrix: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@2c {
+            compatible = "qstcorp,qmc6308";
+            reg = <0x2c>;
+            vdd-supply = <&vdd_1v8_reg>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2b1ec46c5919..2315c94ad0e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22061,6 +22061,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml
 F:	drivers/iio/magnetometer/qmc5883l.c
 
+QST QMC6308 3-AXIS MAGNETIC SENSOR
+M:	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc6308.yaml
+
 QT1010 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.55.0

