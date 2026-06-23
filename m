Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA83043B2;
	Tue, 23 Jun 2026 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230914; cv=none; b=KTLoO/dUaLKbJAP1dioOaZ9iAKXdXosUa8xpiROOXvc4keYoXiVBtHcEmx9YXryMP1QkaybCTbMkUpVvcc0KoQVxBgu2ZB2aSmV280vXJ5sQXcIDdYERx7OfJepGPFp570Fl+w5lYmbCjKhoxt4zeVcy2txFnFJa/Go3sUlNOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230914; c=relaxed/simple;
	bh=/d16Sieqk8yeRcOYDHX46mX63dJaYsjHBRnL9CwK+KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ACPRxrgWh6gNeih0qvdH/URKagNI1zG3fN97/6/yMza0v2NO78TncDlDUJAcIPVkflbGPuT4hdCdIpinjup9JlOFKaLZPdZZp2fZTgSuLPZYsG86dIXx3Hi+LsQobvE0Vp9v1GXBvBC2Hl1Rpw/lAxKe62u7UDxHT8/vRGtcUu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b=dv+tVRbH; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=lukas.metz@gmx.net header.b="dv+tVRbH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1782230907; x=1782835707; i=lukas.metz@gmx.net;
	bh=YQaX3VHKdD3WPqIuFdUCd3GK0GLWKKG+sZlaadadLXE=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dv+tVRbHOUoSs8vJLMecQaszXxspcV6SgUS113qoHZpDoZadom6xoGLupGhY1TWr
	 svwquB2riyD0tMO6QfqV6tuLiOtbGz7Pg8D2erJ1pmNZQmIC48sAgFKhZ7RXZdtCE
	 Eyq2pjot+HfaU7A6iPuMd4SWbyaN5N3nHllQSNNLoROdWn6QzTzQfB6IBMIg0BmWl
	 OuJ2JhZjatoZDaWymg8z6T1zYRVGoIW9zJ/3OOXW27tzRdyNEnB70vWrk6yo2etxP
	 t2Kck1gyEUXM1Gvtfvf3MIMUWGrFfmvPqjidLGoaCuDJaWItqySdhauVpvJxO3XWK
	 O9sL47u+U1MEkcYGkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEUzA-1wM55c3dVq-00641c; Tue, 23
 Jun 2026 18:08:26 +0200
From: Lukas Metz <lukas.metz@gmx.net>
Date: Tue, 23 Jun 2026 18:07:28 +0200
Subject: [PATCH 2/2] dt-bindings: iio: dac: Add DAC8163
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260623-dac8163-work-v1-2-5b508158faa0@gmx.net>
References: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
In-Reply-To: <20260623-dac8163-work-v1-0-5b508158faa0@gmx.net>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Lukas Metz <lukas.metz@gmx.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782230905; l=2942;
 i=lukas.metz@gmx.net; s=20260616; h=from:subject:message-id;
 bh=I4z3yDFWiBkP4lYrlkuPuIyQvzLuax7/Rw3MLySZ/6k=;
 b=oAq/Mn2ajNEMtoaBZARgUYWJRZlytAKaPyiT0HQ9WTN/U9+wwzG00NmOKsj1//jVjlZwyKLV5
 rgncBX1UQFvC9Stl7UdkqvxG4lfbFndSscTb9sUI88HLPslkduHDdNS
X-Developer-Key: i=lukas.metz@gmx.net; a=ed25519;
 pk=ljkIqYPVyHd9CYN4/koqGKt7Mym5FTTB+ZzvvlfD4yM=
X-Provags-ID: V03:K1:/uscYcn37XUDxEaqUG7/S0YtZ46q9bGvWZCZ+SkWHaGACQzqR2j
 1bSk+VfYqtCxVjhz+jLVSyz/u/qCgH9adcgx8mK+YI5JnU5udDWGdRexNBIUO72cTI/Adlw
 8uENZA08bI4yWL08rMffRc89bfYII0lpqBsWKpQwQPxmLuE+2rOA9vnHtsb3iLKBzSxNqXh
 c/Q9iQ59xuJ1vLVJcuQVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eRrasztFB/c=;RTKBtdkFRvPo0lnMcNpYrgZ45jE
 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
 bvOnZw==

Add device tree binding for the Texas Instruments DAC8163 family
including the DAC7562, DAC7563, DAC8162, DAC8163, DAC8562 and DAC8563.

Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
=2D--
 .../devicetree/bindings/iio/dac/ti,dac8163.yaml    | 75 +++++++++++++++++=
+++++
 MAINTAINERS                                        |  1 +
 2 files changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml b/D=
ocumentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
new file mode 100644
index 000000000000..bb4bad389323
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
@@ -0,0 +1,75 @@
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
+  reg:
+    maxItems: 1
+
+  ti,loaddacs-gpios:
+    description:
+      Pin needs to be asserted permanently when updating the DAC synchron=
ously.
+    maxItems: 1
+
+  vref-supply:
+    description:
+      Reference voltage for scaling if an external reference is used.
+
+  ti,internal-ref:
+    type: boolean
+    description:
+      Flag if the internal reference is used (external otherwise).
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      not:
+        required:
+          - ti,internal-ref
+    then:
+      required:
+        - vref-supply
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
+            ti,loaddacs-gpios =3D <&gpiog 8 GPIO_ACTIVE_HIGH>;
+            ti,internal-ref; /* internal reference used*/
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e82cc28e1bc3..5512f5eaab44 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26398,6 +26398,7 @@ TI DAC8163 DAC DRIVER
 M:	Lukas Metz <lukas.metz@gmx.net>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
 F:	drivers/iio/dac/ti-dac8163.c
=20
 TI DATA TRANSFORM AND HASHING ENGINE (DTHE) V2 CRYPTO DRIVER

=2D-=20
2.43.0

