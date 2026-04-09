Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A723B9D99;
	Thu,  9 Apr 2026 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751860; cv=none; b=KCoJu6t19WlsLwIOCgJBCLdna5NHs3rg2Gbbv4rwpR8inWtBX756vuAyvzJu+exKdsPMHfBt2hb4QN2Hlc4rxau/uSADK/9QlsCEmhuVDzULklN+ZtDg+FdTW+iqbxp2BGD5vtam3vUNmu6Ime717wo9LoyMl1UF5vV4di4/O+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751860; c=relaxed/simple;
	bh=FHqavf4x2LMnpKhwYIAJLhWWLpu5loE7rr7KuHjSJBs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7YjRv+Bwo0NjrfpzwlfMjidheRrUBnDWwVuMItTp/rkt6BYx5k0R29fcttAt1WYtCZVL2JXgAqRDWyeQz38z+dGANZzbT9tf4kEukoXQCTyaTuC1uq2KjIbL6JilyVotGZvKvaXf1lnoblitCqCuAu87StbNrBMfR6VKneIZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=W3WtiRWC; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="W3WtiRWC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1775751851; x=1776011051;
	bh=MyqNqpuNtgV8td1byNhhPh0LwJSSFfPtn7H4KgGMCEY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W3WtiRWCUQMsjfJgajIHTMq2Qmaa8uqUIuw6M7Jj0STqXFJ2Apgtyc34+FDHpGXtQ
	 xgvfJLGuU3w19OUVS1mhYbFBUqA5vSNKqPCYWX0TJKXeGgCDylACcNSe3O09ulN7qs
	 t38hAQmHa44z42R5al+v5JN4JPhW0mjCeUf2LnBFd0m51k/wT4+r3DjyHGeKJZbr3e
	 8ctDfUsxtNsPLsuY/kosLUv2AqbDovsdAFg7vguG1WWlazftTsze5CFTJbsgvFuCNf
	 emKn/vxs6eQqFAcDIqqON6Z1iVa4k0RMeUKWCNOF1eMyoVs5xznCaK/cIuYPjCR1FW
	 Y3ZnfYhiR92rA==
Date: Thu, 09 Apr 2026 16:24:05 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brigham Campbell <me@brighamcampbell.com>, Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH 2/4] dt-bindings: iio: magnetometer: Add binding for QST QMC5883P
Message-ID: <20260409162308.2590385-3-hardik.phalet@pm.me>
In-Reply-To: <20260409162308.2590385-1-hardik.phalet@pm.me>
References: <20260409162308.2590385-1-hardik.phalet@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 56cf74d2e6e82df571b58112540e55c2da1541cd
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
communicates over I2C. The binding exposes the required 'compatible'
and 'reg' properties along with an optional 'vdd-supply' for the
2.5 V=E2=80=933.6 V VDD rail.

Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
---
 .../iio/magnetometer/qst,qmc5883p.yaml        | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qst,=
qmc5883p.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883=
p.yaml b/Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883p.ya=
ml
new file mode 100644
index 000000000000..84fec10d8b9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883p.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/qst,qmc5883p.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QST QMC5883P 3-axis magnetometer
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
+    const: qst,qmc5883p
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device; the default address is 0x2c.
+
+  vdd-supply:
+    description:
+      VDD power supply (2.5 V to 3.6 V). Powers all internal analog and
+      digital functional blocks.
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
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        magnetometer@2c {
+            compatible =3D "qst,qmc5883p";
+            reg =3D <0x2c>;
+            vdd-supply =3D <&vdd_3v3>;
+        };
+    };
+...
--=20
2.53.0


