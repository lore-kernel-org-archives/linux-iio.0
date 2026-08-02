Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8806616A956;
	Sun,  2 Aug 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686922; cv=none; b=F5iv9DmxHTXMKSlji+oBfiEf+I/CD77qm2PyUkdcjkdg5NrTwM4yl0D8IEMaDr1XsspVv0alkIoLMZwk2Lwyq6HHtMRYbOh+NkCcgDT7o3qZJCIRV4P2DTdg2V2l8k7/WUzPz94IQUiu8/YgsDbcuV5o14EtXfpJSGmPkJUShgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686922; c=relaxed/simple;
	bh=6SjpWDvx1FlXMPkojOuWSFNuIhudsvhPMI68rwyTktI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M63G+YNpSGE4gJRHI+0AYWYODyQLdW2quCFaQQUop2q/xjEW6/Es/rcMXFfiszeENc4e2IJno4w6tetmFhgrae4h+DzzztNzmZpnPjl1J8vZDzyl9YiCuaCyS7/BEVplJqVkqK8dJaw9M6zWJJaIevy3dkjYRX7Ypqa3lK+uJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=NMf5T+Ok; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="NMf5T+Ok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1785686907; x=1786291707; i=lukas.metz@gmx.net;
	bh=Gt9ezKxWmebtvz5aVS5tCMnHReCPUJWzdgehzj9ArZw=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NMf5T+OkJCFt5Nux4hDAYyfpY11yX+VD2UJm0AYUUw95OYa6Fo+RmwfibRRB4Tct
	 T8sVUOulwORuXjOseyRQBEPsCmiYw2dniqWGnjhdmv4Z+WthjxALlVDR9W52FRysQ
	 mM6wE305Oj2O8X+c39ibnIIEltOTqFSM82gDtz4WHhuxKhR4+yoWAFnsQsvuTdiMG
	 pNqG4PaMUC9+IojYTnm/dEqlFub+up9m9ADbaP2F3TAlb6DHJYjsIBLxd0c8O5zcT
	 5WaD/d7b69YZiXgGreTDwUO9xc2OPGAXdLw5iqkrBGnmF8t3OT0zGzpz7vSlCGVPN
	 /o9qWXel/ZDK7JczYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQv8x-1wbNtd3fmh-00Pg5E; Sun, 02
 Aug 2026 18:08:26 +0200
From: Lukas Metz <lukas.metz@gmx.net>
Date: Sun, 02 Aug 2026 18:07:22 +0200
Subject: [PATCH v3 1/2] dt-bindings: iio: dac: Add DAC8163
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260802-dac8163-work-v3-1-3ecc7bc66d0d@gmx.net>
References: <20260802-dac8163-work-v3-0-3ecc7bc66d0d@gmx.net>
In-Reply-To: <20260802-dac8163-work-v3-0-3ecc7bc66d0d@gmx.net>
To: Jonathan Cameron <jic23@kernel.org>, 
 Siratul Islam <siratul.islam@linux.dev>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Lukas Metz <lukas.metz@gmx.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785686905; l=3423;
 i=lukas.metz@gmx.net; s=20260616; h=from:subject:message-id;
 bh=G6JfY79iWazxMnPiNOaUL3rc+Z6kP2/2iGTp5aIKWVM=;
 b=lJKGgwYRiePdoMX2PoTlP0chAfvAGo5OFxq2G2L7k2XmWOSmvpveEVLfJXny+RCWTWoh1ZtoW
 sLiHf+Qpqv1AKRb8HAgu5PPpwrh74QR0CthV6XwgKfcwUIDJRKs/tES
X-Developer-Key: i=lukas.metz@gmx.net; a=ed25519;
 pk=ljkIqYPVyHd9CYN4/koqGKt7Mym5FTTB+ZzvvlfD4yM=
X-Provags-ID: V03:K1:Ct10Cu/ufBY1zib+VvIWUjIeJ+ang4WkVtCzpWXMRIFpwhzmEuR
 Mpjk/BUSW2GCR1b4uVDYKcdPKxxkJ04tPb5RWZKNAwpP9cLmouW34DQNaDhPBG6g+y9mDVY
 f/Oi9LM0URGarObzpxjnIGgwnrNWYomk75CQi6P4KVbMKxcNjJYYUF3G3/6XIUuOGe5Tk8D
 CaSRk1rFyl+qAqUANj9lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ivh52tecxlQ=;DUzayVzF2hGkWxeqNN7iza1njxU
 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

Add device tree binding for the Texas Instruments DAC8163 family
including the DAC7562, DAC7563, DAC8162, DAC8163, DAC8562 and DAC8563.

Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
=2D--
 .../devicetree/bindings/iio/dac/ti,dac8163.yaml    | 87 +++++++++++++++++=
+++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml b/D=
ocumentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
new file mode 100644
index 000000000000..ba4099c78e06
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/ti,dac8163.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments DAC8163 family of DACs
+
+description:
+  The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-output=
,
+  dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
+  respectively. These devices include a 2.5-V, 4-ppm/=C2=B0C internal
+  reference, giving a full-scale output voltage range of 2.5 V or 5 V.
+  None of these devices are fallback compatible because they differ in ei=
ther
+  resolution or output register values after reset. The sync pin on the d=
evice
+  acts as chip-select pin.
+
+maintainers:
+  - Lukas Metz <lukas.metz@gmx.net>
+
+properties:
+  compatible:
+    enum:
+      - ti,dac7562
+      - ti,dac7563
+      - ti,dac8162
+      - ti,dac8163
+      - ti,dac8562
+      - ti,dac8563
+
+  spi-rx-bus-width:
+    items:
+      - const: 0
+
+  spi-max-frequency:
+    maximum: 50000000
+
+  spi-cpha: true
+
+  reg:
+    maxItems: 1
+
+  avdd-supply: true
+
+  clear-gpios:
+    description:
+      When asserted, the device output registers are reset to their defau=
lt
+      values (zero for dacxxx2 and mid-scale for dacxxx3 devices).
+    maxItems: 1
+
+  ldac-gpios:
+    description:
+      Pin needs to be asserted permanently when updating the DAC synchron=
ously.
+    maxItems: 1
+
+  vrefin-supply:
+    description:
+      External reference voltage supply for scaling. When no vrefin-suppl=
y
+      is present the internal voltage reference is used.
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - avdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        dac@1 {
+            compatible =3D "ti,dac8163";
+            reg =3D <0x1>; /* CS1 */
+            spi-cpha;
+            ldac-gpios =3D <&gpiog 8 GPIO_ACTIVE_LOW>;
+            avdd-supply =3D <&avdd_3v3>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d238590a31f2..314f235332f5 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26394,6 +26394,12 @@ S:	Odd Fixes
 F:	drivers/clk/ti/
 F:	include/linux/clk/ti.h
=20
+TI DAC8163 DAC DRIVER
+M:	Lukas Metz <lukas.metz@gmx.net>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
+
 TI DATA TRANSFORM AND HASHING ENGINE (DTHE) V2 CRYPTO DRIVER
 M:	T Pratham <t-pratham@ti.com>
 L:	linux-crypto@vger.kernel.org

=2D-=20
2.43.0

