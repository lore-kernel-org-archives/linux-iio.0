Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717585;
	b=HebqF2zXLXtMsnCKi8Bs3zrr0d6h3v6eguKC5u/f72QkniM65b07pOrQm934kBchXVMp
	 W90PXD0tCUG6Tj2/QaBlxGpqiJMRMa3HD+v8FmUwvrE8q7gduvH7+Z+73DhRTz7OWC4Zn
	 NSvwXMRF9CQuuaUjeoUXWMOqnzC3+yJjFFmxy7RE5R1sCQ6Wh56ehHmjYnsd02m/Oqe78
	 qiQhyuRayM72yLZ/AoheyHKHBXUrO2+Lyj/blpNw6e4l8FPpRINK5SB8iWgz5SRXRIAwI
	 AOr6vXSg6i+YQnRHJF7/hGnuiRV3+2GRH/leOGWtxqvQQ/O8rj4jObaHIHV4VXAQvww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717585;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yectdAgmzmhui0t4D3DsYWeLZdeAhuDJLH7WeB96IZc=;
	b=1OTz2z9ttYaQsChUvHz606uf2MXZouSrutyegUuiKVL8r+MChb8zDqq1RxycgaQZA5a0
	 SXl+7cqFt+QpZkTeNv4+NA6MzWER0vUYSYPraD0e1Vck9XM5mPgbrhS5RmJ2vfZx31FvF
	 CDZzPk+RFG/GBqdSLOoHECBxbMcYBe1N8OJuG7N3bybf6keQYciXqjxvB5E+Zm2n5ljKB
	 GocfQdL0CNEIgG3KPhlVRG7Dy5Am5J1AFee+unwKl24GCoyPBFFzFdzrnaMMKS2XLLzhh
	 AvrAE+18mTj+GxeoIsR/+f/kw92FD41XIdh3li+FTh6IB1ZEwGY9NnHNlFkrLXx0lhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mH/58RPo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFAF60A5BE8;
	Tue,  3 Nov 2026 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mH/58RPo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793717584;
	b=Bs1qzPV4fHFnx4Q4qOYuvC9VTDSPqN9cBogqHRgRiUS0/6n8JY22FdY1gRjE/ETnMnO4
	 lwaKi0YI1ntxYRAJyhnCghHxGlLGiQEAi7M1k9BYd7Vn8f6qe7Wrv4alu30ha1Y/MZe4r
	 +r5RBWXrOBTLoj2zXvtj0mK1oYuC3+RAiuCALxVPtuMqq5LPqdhFK1TgGIASvujuosG3W
	 577tZSEpl/9wAzooh7BinD81xq4zkXZU53c5tP5QGzDWl5qA8TQEnZd9zr3dROV44u7fS
	 2zjLFnmOpIGtS1oXmwZQUmFYxeUHhGpuc8PLHk7V/Doi1bY5Qv7J6iv4eIi8H0iwkRg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717584;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yectdAgmzmhui0t4D3DsYWeLZdeAhuDJLH7WeB96IZc=;
	b=2VZxQMTFK5YDpt6LtBoALEGzyVPTdo5nhVMNwN4ML4vfNs8xoXP/VqXbcbDJSwNMCDtR
	 czXXi7QT7/XtcjIGJ3ycGwzOirJLSVNBYsIZop+Wrw17JP4k8U/ZUYuHP5yleHd9eU46r
	 F9/KMmefBccS+2RTNgzHxAhoR2NcPSxYQSiQnN9rVA0IrIGJSLJR9TPolyM1L0LEA20R0
	 ZAWmvzdXyuFLVqaEBn0A265PTCgAMv0lkCNRloTrIyKjhl5E97ve4Y9rTON3MTk/J9nIn
	 su+PvkThgBtDKC+6HetJcrbk2sxN8BZUlGJclD9zwM6xsP2PlgRm3rtPY+BeX8Zlo2w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E6D071F00A02;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717584;
	bh=yectdAgmzmhui0t4D3DsYWeLZdeAhuDJLH7WeB96IZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mH/58RPoLQUfB2UsOjEPE8j0yFz8hsNsRxNT0jdwyZSVj+9ObIxcbh5LSNFeAMV28
	 c8XTtHO1XJKzy1Utj5zBW3/VBLvM0GRHg1r1IbBLi9rmwJJ8eRNHm6N79X16gC+zBc
	 IgeMp036GAlLW6fPc45pPh5Kd7ZLcuD3JYXX6rcH9UqXJ1QP1kgMETWWXQie7aDbn3
	 EWN76U3sgcrxjqSruQ+K6EZsQjoswxVtT0G7qzjvsJUlLGOrTrZnt9UHwhIP0XxcsI
	 WUy/H35BIvxAMFlL+LiB39KBRD4S+z6lJ8QQhrXwkOs1EAveFX1VdQvnYOozFqQ52y
	 CQI5HvxSuwOTg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 77718469A6;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Nov 2026 11:52:59 -0300
Subject: [PATCH v3 03/10] dt-bindings: iio: frequency: add
 adi,ad9910-axi-backend
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-ad9910-backend-support-v3-3-0e9224ddf7b7@analog.com>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
In-Reply-To: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793717581; l=3687;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Vpt8ByHRtr5TDXwqxoYNl6Ot/aTCRU3OJEu+Iz3CjUQ=;
 b=EjBsUN03kU5K4F/VlwvjNh80dr8t5tshT9uZic/yz5iwotKYp8imIyszafaWJET7pQ5BrErD5
 kz5kxc/XeypB4iJ8BgtyxxQbb5j12O2dqOV8en1BUhev2QxgjPNzzXd
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

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
index 000000000000..0015a92aeaea
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
+  https://developer.analog.com/docs/hdl/latest/library/axi_ad9910/index.html
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
+      The first cell is the PWM channel index, which must be 0 (DRCTL output).
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
index 52024397dc78..351ec0bca477 100644
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


