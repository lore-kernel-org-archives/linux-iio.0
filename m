Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792682351;
	b=I3W1fTemq+9aCBsUtJXVvy1outmHpi7h69gSPiEQ44BLjJZLXyrmG1qifxGUV5T/WXLa
	 zhi5c2G4d/4kLQF4gXMTxRkjCXVze+cFkJi75GM6Ho4rwAQFJkNVZM7yG2amcp960wn8y
	 KAeQEpkWeUfcHoWe/bQlk4KY92lsETw5xWMI5vP4olZuBQ8vPLyxqRFxulf8N26OgYmao
	 RpzkSy6JfEhU/i0wiWjVn7Z4zaG0G1ejs58iuv5lhJmwj2WScllKkNUkJo1DFlvMNtU8O
	 0oqDhhIA/SQ4ZXMsj7JyhZ3LfrOSeaf1ne3tyXQg1jyw2OByzn82gigmzyLQe0nc+jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682351;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mgr3ZBUadswlY0m18RoK45iupDXQ8OR9+gCMQmzuBbo=;
	b=UvSG34QLNqsxgOoQ74y+xZQoVEoJ3tmgCrNWhYEz1P0D7qd3nNHdItnlqiH3Owc5dwOy
	 ErGcrbNkV4Lz1TGqzbcqEm02i34FLyhcKTRKd/h+PzFWsdt2QsfTCph5EkagL13JrddkA
	 0oZAmROhncXIaCGu1FwEOwl07miR1tT1EpO0jx95ir0uD1tBSgDLQUDEWGRtRComdqJCz
	 TUyoMglDngSiCdXnDqiGqevRIMgJbit+mnIAk6U418RMMn8iwssK2HoiG9Mg+jL/OMLAw
	 7uto8XFW3bbx8BQWgn9nZhXPEGz08M9auEto8WiuapbH2H+QR0v+pOm53J/DQvazsew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEFt0zHa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB4606CC5A;
	Thu, 22 Oct 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEFt0zHa
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792682350;
	b=tAHIoPT4yQYa5WD5VzurJM3c2a31QKk+fxh3JrxlIInJiLQtWsjlQdZt96/Yp0dW9pDk
	 WFKuSkwgXSYm8W9oTRWFH2JxtHqMA7lHDT4cVWla83CMD+blHQncKaRQMsnfPJf3lJe1F
	 zH9nHN4t0PHUc0rGHm05n2oIEQmFOMBrpQSerFfvv8ka3MowseYumloDzttjO5XW5F0t8
	 sid21JgR+i7WZ0yuiMVGyZ8qq4530tPD01ZApgO1P3zbCl5eG6SHAzGBvYJG4YuRdAWPr
	 MW5NEI0pTqt48pAmnctyThQZxLzkwQ0Ns1qOHXRhxc4d2O7Wxw2rDPetldxK6yBCmQA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792682350;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mgr3ZBUadswlY0m18RoK45iupDXQ8OR9+gCMQmzuBbo=;
	b=1e1a3N96K8qD2LQAMSXQhDigwpOGHakkxOg5ZdEsysbw24x4Flp5adNINH3HOkPqA9YC
	 x5Qz/eoXIL+BJSAStpNrNnyDOuI4lDcJcLMQ62CFzV3nJUGgADFVvGm+ivFzttbhAgjID
	 FncvtU8mEl31dWOXdVS/51ghT6XRHb9gmDgpExIqFNv24PP5tGjGlBxnlKp6/Gm7Po9Uk
	 d1jJSjKEnoYyS2VXcnGiVSXt5pACwh7i2hss+aP8hfwFzooyh0M+x2SwAb15kaGOVTQKG
	 T1yus0oWWGrfo86obBBlWiNCpeiX38V/TIGR0UcoamwUGaFC6iytYvWUR33IL3qq8hQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 00A701F031E0;
	Thu, 22 Oct 2026 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682350;
	bh=mgr3ZBUadswlY0m18RoK45iupDXQ8OR9+gCMQmzuBbo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IEFt0zHaSNUWl/E5sitxQcOI6HRlusm66q/3D22+EwobWGHwkBg3CW/PitV8DKqsz
	 DRkBhKTQvllN4fwzSuMtreGs7LiCaEBeSdih5RS+SRcorjxrHuPqhRWTDRjnBwb3JX
	 DBWyzZSfx9sZ49crCLGzKQY1HEPkSIB1YqhF1i6muC9S3mEOMsMwqv6DVBFy62g7PQ
	 RQGMVpNV6//xtwN1vnd7lJVYlo6T5VnBaP8NCEEuotbk8KapnbueIwDwBjTLnJ9qqL
	 dh+kxo5JxPw3iIxAq65xKDuba2+OCEltjeqGqiOVOjouYlckoh7mSIXtAx92H0DN7w
	 +zNcjGd6tWa0A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7E68441E52;
	Thu, 22 Oct 2026 15:19:08 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 22 Oct 2026 12:19:01 -0300
Subject: [PATCH v2 03/10] dt-bindings: iio: frequency: add
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
Message-Id: <20261022-ad9910-backend-support-v2-3-0ff7f0bff326@analog.com>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
In-Reply-To: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792682347; l=3683;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=CY1SqfatwESZkmEigRY0fdqsP8jg+f3FT7aQydkMpu0=;
 b=oI+lu8LbTOa5A6uaf9OYIuX4y81mOUXtMN/wKCdcC1YNfsNQkrOSbWCPrVI6U8OWrnOPgJPKy
 9F4hXqVq0vZAMv7vRARXh22XzTJpNGwoCWVbyO2/DO/H8ETPZ4TtVbZ
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
index 000000000000..20c45fbaf945
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


