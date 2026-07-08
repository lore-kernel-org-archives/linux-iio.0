Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C581991CB;
	Wed,  8 Jul 2026 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504391; cv=none; b=Cg7tf7dlo7wkkpr+HIRovhVgFDRs0/RA+Z6fEYeTrWAHBn0zPLKy/KktE9pMDAKg6rlvgSvCQ7NUCStZsXrqNCp2YIxv/pONXO74Mv0ZHFjLDC1SWgLcBNgWU+casJsXBzWpVOfB5I0fuXqqCsKr0bXS9hh3XtwzWoR7tEdmZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504391; c=relaxed/simple;
	bh=dXRXQbwZCN7hSFnczZa91tVae1Lx96jLs0UZZRMJYEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JS8fM8YdVbBbYRlZ1FtA+/pbclB0k+D1+Qq4P5PUuhqhH33YlmHqkkIV1UvYZ8jGvUCtmbpepa/9kAcQ4zoRLcgTG7sc+FFDza5tU5EeDtZSszGCzNqbKrz+gxmqWxQGbAlCj4Nw/xyNBdcnMIIPi59zyyLB01WSJodp0QNOwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=Zv1Y/hzy; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="Zv1Y/hzy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1783504387; x=1784109187; i=lukas.metz@gmx.net;
	bh=E7lvMvc0gcCo4Ii4kk+RBfqf2Z39k4xchsmp7X13678=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zv1Y/hzyZS4lbvtjrxqNLZTmoeuFbB9OuOUHCU6kXuPbvmFf27qtIUeLpyobtRSh
	 qg39ddbQORZ+x5ms+mdX70E8i1MCgTB21+xe8XtL4nuYHsn4AfiJQDsEVez/wE2Vs
	 LMp9gL0GoHq5YP4RUf3K8+Fitt/BOUJ3ObH6gFqQvK16NENvx8vEipMzNiBOHeEzg
	 HHrY0KhN9bY27Q1brbvvmRKUeJG+BadZcwIhifn7f7Kvrr7QNYvt6tDVs2gschTAO
	 NOzPmTXSfXFItn9GMoNkHgEQhChzAiV+MDlntWjeStO3v98JIrQKgr2+lcy2Cd7jH
	 ZD2EUKwnsBvIjqZoPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Ue3-1wjqsU1btx-00AX8W; Wed, 08
 Jul 2026 11:53:07 +0200
From: Lukas Metz <lukas.metz@gmx.net>
Date: Wed, 08 Jul 2026 11:52:43 +0200
Subject: [PATCH v2 1/2] dt-bindings: iio: dac: Add DAC8163
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260708-dac8163-work-v2-1-3acd1bf20182@gmx.net>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
In-Reply-To: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Lukas Metz <lukas.metz@gmx.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783504386; l=3284;
 i=lukas.metz@gmx.net; s=20260616; h=from:subject:message-id;
 bh=NIBxnmA4CoRSyvC0HNjI1ITXhMA9w3nVE2U946bcSik=;
 b=pyN63UDs6w2IlGEKGSa24DWJFZqkFfaQn57bUknU+I3MewgRqKUphkt/5qNj5FmcaFhlBtHay
 ilBHS6lzH5pDXwP+nF8jHDYOA5d5kAoYBJSkBrIdyqpoTBtiqRqliwX
X-Developer-Key: i=lukas.metz@gmx.net; a=ed25519;
 pk=ljkIqYPVyHd9CYN4/koqGKt7Mym5FTTB+ZzvvlfD4yM=
X-Provags-ID: V03:K1:wRgBukvRCQPfBMWWiIeE7LmLxfxeVSfeGkdXgFvcpjjwR0LloW7
 B1Xhsc9GZvPo3MwmLcKcQMFGfDZMaI8wFxKrcnyqnXUlp21KbGVFMFPAgozqmMpxZ4RYAWp
 cI6O53U+tZB88F2BXZR0WpWR9WbKLXAY3Ll78XJG21GeAUrqvb3n2LDMg0bvN1AOZA+yt4j
 DNokKk7MTVKZUMYJWKBAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f8djs2F09n0=;A5DKqYGWpIFhtnrn3At1DH6mQWW
 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
 BHYvuRKmPTx2fkxfq1lAABuc/M6Pvzl9bd5j07l

Add device tree binding for the Texas Instruments DAC8163 family
including the DAC7562, DAC7563, DAC8162, DAC8163, DAC8562 and DAC8563.

Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
=2D--
 .../devicetree/bindings/iio/dac/ti,dac8163.yaml    | 85 +++++++++++++++++=
+++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml b/D=
ocumentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
new file mode 100644
index 000000000000..533cc7327c2b
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
@@ -0,0 +1,85 @@
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
+  The sync pin on the device acts as chip-select pin.
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
+  clr-gpios:
+    description:
+      The device registers are reset when this pin is asserted. The outpu=
t is
+      set to zero (xxx2 devices) or mid-scale (xxx3 devices).
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

