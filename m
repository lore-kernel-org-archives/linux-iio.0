Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch [79.135.106.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E4299927
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776637966; cv=none; b=ZsrvLsQM1a8ZYQtZOsF8qX7nVWCRhm7NZJV1tvdTEQgeww6fC82VeuT91D/0dpCpa8ianawGw8UJqYqB/P8Gg1TZrGefwIibT8gS3jIemS6p/wKi5A2u/LmBeWj/fK1vn7VFs81pBkY43yS5YWXJqdcoiMdCO1O+vXqObIt4H7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776637966; c=relaxed/simple;
	bh=h4m4u0qkmJAER5pKaCfe8t7x9hCuAS05rfldDLVor6A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1376OSiC+V3K8eNRLAU8OYpgnruE1crKnSZbfF0tThJBbveIXv6zrM+lvhXdTpq+mpJaKGRlzF0XUNc5gSm2+bqCKjx3tPdtSPmrtR6ATj6Xjk0/t+rnyEy2DUMoKI0xs560AeTNfHg23/nHua/7i8d65vJZA/UQbXl/pLPblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=dZYC5gCp; arc=none smtp.client-ip=79.135.106.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="dZYC5gCp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1776637957; x=1776897157;
	bh=yvoexbK0dmENpV9aFI3G1FiFeiAaZWAdXU+Z85ZXwl4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dZYC5gCpz7XagwRQ+epVGiUMV+0q3SE4SSgkSIXsmIQ8GdUeOyFivfKVjP/qx+OAK
	 Y/Hqc2FKK17BBFM+7nD1YHw7BGCPdDINt8ITXhPN1irmNa3lfI2VnJOY1J/N3CbZXX
	 YiqMBeeiA/Mi9eEPTisvmGqGZjHUc6DW9mG9ldkqd0veNI/3hl5rd0w7hX/Hikbt2l
	 Xt/7GIZNTGnnP1w4O9pRbV82sfcl3QbrR9zrWUIfs9pfKOhmIiiESXOn0hdOVVoyO9
	 3Y5w4TASzk7Fr3EX9jZAfsg72pdTAuCEUgkCl8ywoTBwOQsWgb4q2XiSl0wv2vPZft
	 ADUj/7o7Y3LKg==
Date: Sun, 19 Apr 2026 22:32:32 +0000
To: gregkh@linuxfoundation.org, jic23@kernel.org
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com, krzk+dt@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, me@brighamcampbell.com, nuno.sa@analog.com, robh@kernel.org, skhan@linuxfoundation.org, Hardik Phalet <hardik.phalet@gmail.com>, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH v3 2/5] dt-bindings: iio: magnetometer: QSTCORP QMC5883P
Message-ID: <20260420-qmc5883p-driver-v3-2-da1e97088f8b@pm.me>
In-Reply-To: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 0c087ad38cf9953db3d14364c90a411258dbab38
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add the device tree binding document for the QST QMC5883P, a 3-axis
anisotropic magneto-resistive (AMR) sensor with a 16-bit ADC that
communicates over I2C.

Add a MAINTAINERS entry for the QSTCORP QMC5883P devicetree binding.

Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
---
 .../iio/magnetometer/qstcorp,qmc5883p.yaml         | 48 ++++++++++++++++++=
++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc=
5883p.yaml b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc=
5883p.yaml
new file mode 100644
index 000000000000..72cc3fef2226
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883p.y=
aml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/qstcorp,qmc5883p.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QSTCORP QMC5883P 3-axis magnetometer
+
+maintainers:
+  - Hardik Phalet <hardik.phalet@pm.me>
+
+description:
+  The QMC5883P is a 3-axis anisotropic magneto-resistive (AMR) sensor with=
 a
+  16-bit ADC. It communicates over I2C (standard and fast modes) and is
+  targeted at compass, navigation, and industrial applications.
+
+properties:
+  compatible:
+    const: qstcorp,qmc5883p
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device; the default address is 0x2c
+
+  vdd-supply:
+    description:
+      VDD power supply (2.5 V to 3.6 V). Powers all internal analog and
+      digital functional blocks.
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
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        magnetometer@2c {
+            compatible =3D "qstcorp,qmc5883p";
+            reg =3D <0x2c>;
+            vdd-supply =3D <&vdd_3v3>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 48fda1f8332e..d41f6b33d0e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21554,6 +21554,12 @@ F:=09Documentation/networking/device_drivers/ether=
net/freescale/dpaa2/overview.rst
 F:=09drivers/bus/fsl-mc/
 F:=09include/uapi/linux/fsl_mc.h
=20
+QSTCORP QMC5883P MAGNETOMETER DRIVER
+M:=09Hardik Phalet <hardik.phalet@pm.me>
+L:=09linux-iio@vger.kernel.org
+S:=09Maintained
+F:=09Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883p.y=
aml
+
 QT1010 MEDIA DRIVER
 L:=09linux-media@vger.kernel.org
 S:=09Orphan

--=20
2.53.0

