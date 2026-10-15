Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75635541E65;
	Thu, 15 Oct 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082995; cv=none; b=OQF+4DCXXYze7PZWR96q4WJJBncJI6uxaI0R0QyfhQSUO5F8Gp7fQMA3z2FsQ/eV9AC1AP837gyXDJgp0Ly290i3N/LcoHYe7SFhUbh+CNu2spgiXDIuENKPGdNzRdsI5n42ngqXzaUnfB8G1iARnfdsf2f6iPTMgrbeJnqPEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082995; c=relaxed/simple;
	bh=Jw7pUBGadwcJoxIiCw8ndleKgT/t2mQTcH88UX2z24A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dm7+A/WF4Oq7WjwTKpOtnI+y3JPJ3MHK++q26rCGf4RcYNsZHg6fhOkOvi8H559pXpBEycQZGpaKg1I6P8hCxADAZ9GGhFRcMoytSi3GAU4fCn9J6OV98pvmESZnxayXirdAo0luI1iieP1sEJELS7KXPeDdIcOIiK0JDVzK4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTn4uyCz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTn4uyCz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 046A3C32781;
	Thu, 15 Oct 2026 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792082995;
	bh=Jw7pUBGadwcJoxIiCw8ndleKgT/t2mQTcH88UX2z24A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RTn4uyCzTKsE8gqyWBZB1lbcMh16WWBd4T7tTmnEPcPJtCMGyMiAWNNONwoKuzlMd
	 Ifqv+9ZT6VzGBJFA6xqLJYYj+XZb9mHxBH6msLnWauacjtF4zePrKUG80ITyx6JpY1
	 PA+nIdcNcTphzPgvY/CrjLwknEE0YYEjsfUKRVU2z73R1V0n/4hCdoXRxwlOq0uxRl
	 AtU6y1y7UunBxbc0fpAPW1Nr2Txf6amDwmfE0TntLf++sVgiREz/kiJynOeAvAa2zT
	 kGe6aBgDt8zcpPHABLJvod1mArhuy1tyzRXy2f3sOPoaMOZNMOfMKc1DT420v2re7a
	 xQFDn1ZdUDBeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED3ECC6B38;
	Thu, 15 Oct 2026 16:49:54 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 15 Oct 2026 13:49:43 -0300
Subject: [PATCH 03/10] dt-bindings: iio: frequency: add
 adi,ad9910-axi-backend
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-ad9910-backend-support-v1-3-3c21648c8e26@analog.com>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
In-Reply-To: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792082993; l=3655;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=3NhlsAOFJ1QmxON82V1Y+ILA5J9HSbaSpVlBemiZfX8=;
 b=W13EWuyVYCatrPm+Z0YoDTHgCS+/s7VyN4aHRv7FFp/9rVp2CbyDkl5Qfyd4lLfKdZsC/QU1a
 OSmt4rxCx8kBCDCmZqcWIkTOVjManPBMmQfOcbxujpFCzxlkFjXEjuR
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add bindings for the AD9910 AXI backend IP core. The FPGA IP core
interfaces with the data and control pins of the AD9910 DDS, streaming
data from memory via DMA into the 18-bit parallel data port (F[1:0] and
D[15:0] pins), which is clocked by the PDCLK output of the device. It
also drives the PROFILE[2:0] pins and the DRCTL pin, which controls the
slope direction of the digital ramp generator (DRG). The DRCTL pin is
driven by a PWM generator, so the IP core is described both as an IIO
backend and as a PWM provider.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../iio/frequency/adi,ad9910-axi-backend.yaml      | 74 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ad9910-axi-backend.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910-axi-backend.yaml
new file mode 100644
index 000000000000..20b884e8eb10
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910-axi-backend.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,ad9910-axi-backend.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD9910 AXI Backend IP core
+
+maintainers:
+  - Rodrigo Alencar <rodrigo.alencar@analog.com>
+
+description:
+  FPGA IP core that interfaces with the data and control pins of the AD9910
+  Direct Digital Synthesizer. The SPI bus is used as the control interface
+  of the AD9910 device, while this IP core streams data from memory via DMA
+  into the 18-bit parallel data port (F[1:0] and D[15:0] pins), which is
+  clocked by the PDCLK output of the AD9910. The IP core also drives the
+  PROFILE[2:0] pins for profile selection and provides a PWM generator that
+  drives the DRCTL pin, controlling the digital ramp generator (DRG) slope
+  direction.
+
+  https://www.analog.com/en/products/ad9910.html
+
+properties:
+  compatible:
+    const: adi,ad9910-axi-backend
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: AXI bus clock (s_axi_aclk).
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: tx
+
+  '#io-backend-cells':
+    const: 0
+
+  '#pwm-cells':
+    const: 3
+    description:
+      The first cell must be 0, as only the DRCTL PWM output is available.
+      The second cell is the PWM period in nanoseconds and the third cell
+      holds the PWM flags.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - dmas
+  - dma-names
+  - '#io-backend-cells'
+  - '#pwm-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    ad9910_backend: dds-backend@44a00000 {
+        compatible = "adi,ad9910-axi-backend";
+        reg = <0x44a00000 0x10000>;
+        clocks = <&clkc 15>;
+        dmas = <&tx_dma 0>;
+        dma-names = "tx";
+        #io-backend-cells = <0>;
+        #pwm-cells = <3>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a2dfd1a4fd8..93ad6a829cb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1731,6 +1731,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/ABI/testing/debugfs-iio-ad9910
 F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
+F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910-axi-backend.yaml
 F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
 F:	Documentation/iio/ad9910.rst
 F:	drivers/iio/frequency/ad9910.c

-- 
2.43.0


