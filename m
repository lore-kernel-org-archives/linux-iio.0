Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795767181;
	b=EXoW99Roi6taO8dt7MRdNlKXNDFSg5tRCUqwMoWL83YiKegtUby+idHX/G8VszssQ2+6
	 8zfouopSxZnqIxUkWqAL6/cyOB2DrWGLHkLPMUzBMJ0KyP8Fdqqwm/KiCdMAeTU7qSNew
	 wiW0SSilW0C+E1/YKghm1w2Bn4JClYXtWPo7zrR1HBYdqAfDYDJyj2AmPBjcRWXMymHks
	 YZx+s0kM0gm6ORBkRDzXKXW00QaX7tRNJfk5KCUKdVRiaynEUF4FsjFTD/QF2Ps9RU2ku
	 sxQ/2KppGVaybuEphOLpZHIcncB8dD3MnAjFEQj0vo/DueAon+5NwFrqJvgRJkuAwUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767181;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9/G1Vu6zc8fcopapjdqUOr2ovRpO+znKcwj1cdx0q48=;
	b=AhrsFplWjE7F0UhaYkhMF1x5s8BSvomcnu2whYyt3X4QNvEEfGzbKIDKtu0pMjGGYyXd
	 JS3XsymxON0+HZYjZz9kPL/u3gF5fjN6h5BmSb0TKXAuLL2taes/LJx9+K4uZNHz6gi/n
	 Hf1KEd3Ad2L04brpdyUHByBJSHnTZiwwWxBfkrkSnNpJW8BYr9p+N6+a8zGY2EVPN9lts
	 JvihYst24jdxtnll9uO5yyn4R3kmIHvwvzva6Ur2ekLx49xWuMQpF1aoR3ELsAJOqwBge
	 OPoE25q32Bgmn9q7OYWoLVGL5tAmLfmW92mkXFBeBwDEgFKrhtsLmyE9Pa5ALmzaREw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbsXZpLx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B5606A32A;
	Fri, 27 Nov 2026 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbsXZpLx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795767180;
	b=B1ZWDHP6Ra17U+5N8rXArpz9GGPSpm9jX9hQ9kZ4y23fnf+gHvcUjVNGVctUNOrPa9dE
	 FVe5R3cUh+gdt1h1VlUXUIMaD9FAYU7BleOMqJXGONUM16F2sIu8iXa7AEJCaRLvK93iK
	 vrmWyI2TzVgtuhl+61LDVIT4ZlxA0TCOnIw4xU+kUsebVbH3skenEzqsxLftvIu99UhOd
	 X99IRibt89j7nmR7O17JOEAn+1xwlWUyDuDdo4q7P+Q56sWLf3SjI9TlHJP2gDz7WqNfC
	 m9vJtfx2pF7qJfqRl01rvV6yt4dXAGbljj/eF0UUnI6hWV8F8YaYCx6mAMMVGTvlPUg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795767180;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9/G1Vu6zc8fcopapjdqUOr2ovRpO+znKcwj1cdx0q48=;
	b=qA7EcqYymy3bboIT/W9lizWjbQE5qZCndjGjKG0XiDOwC6D6LSk9V9iKByYjUfs3k9+y
	 h1psZxu3F7wbaTnYBTQ4K804uF2PXb6JM0MdvVbm7KwBwZ8GSY+SjbYCpIJUGa++RwZ05
	 GdVAjmcU6M/BfwWDFLZHU6XJpgiHiLRh1Vb/ttseJ1maJALbQUbDCOK8jvxDxu1d9Rtdy
	 zFf0cfkn2YRa6Jx5UuMbC2fOjZixlWzhV5/p8Pm0iJARAZ4gynOGquhpH/ZlsjhswwkBE
	 8V1y1/C6BptEs984QF+EMOSlwwEAlO88BqsnwNBxNIk2ASMO7C5/nbX3+OwSGPz9yWQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 07AD41F00924;
	Fri, 27 Nov 2026 08:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795767180;
	bh=9/G1Vu6zc8fcopapjdqUOr2ovRpO+znKcwj1cdx0q48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mbsXZpLxW9R7YHUMcyrX9ZukLFYTOjEiHrs76AbqmYau09L+SP+aC0d9y7K9jbfDW
	 U4RFGRvXIA111izHXniGMkD+AJJC8v4RwbURgFzbMmt9D+5M0prL8BjhEr8/bw75Qb
	 PO87+dQjXg7clRWRm2Hba2HGn8vSOCqyGQKQJFmEYq5B9WMVnE8OLUjzoar3cCs/zD
	 5rBfckFGN/sDdSAGoGXUcyPaAjqn97g/Dq5MuEMiVOxq2w5bQcQ3DqCI5AR8MP3oV6
	 TcaCb/rw7ERaE6fhE4D8ld4IlntRnXXcH14EhBWY/Ks3ghKabwnv2aNB9vDrhY1NYJ
	 ImbLRP+q9naaA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8F5984B621;
	Fri, 27 Nov 2026 08:12:49 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 09:12:49 +0100
Subject: [PATCH v3 1/2] dt-bindings: iio: light: add ams OSRAM TCS3430
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
Message-Id: <20261127-iio-tcs3430-v3-1-e191a40a4ae9@gmail.com>
References: <20261127-iio-tcs3430-v3-0-e191a40a4ae9@gmail.com>
In-Reply-To: <20261127-iio-tcs3430-v3-0-e191a40a4ae9@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Robert Ijtsma <robertijtsma@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795767168; l=2571;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=oT2YcBwRHJlAGiUMywD1VuA9hLwSIhrT+EC9d5oP2Lw=;
 b=lJhAPvXVEYPKV37e7n9QxeCFHjPF/8HBZfjLq+xoS72yW/gV+FT+W9cOtK4HmHtDAQeG8Lzg6
 8ISBreLNTKJCgtQBebBcMlr0YAHJQVnxcHGszcGpCVJRdSmwOHlFTsI
X-Developer-Key: i=robertijtsma@gmail.com; a=ed25519;
 pk=qiDyKVqFicxFIR5sB5m+p9SWPKL2/+mMoiQnUx0C9P0=
X-Endpoint-Received: by B4 Relay for robertijtsma@gmail.com/20261122 with
 auth_id=1604
X-Original-From: Robert Ijtsma <robertijtsma@gmail.com>
Reply-To: robertijtsma@gmail.com
Content-Transfer-Encoding: 7bit

From: Robert Ijtsma <robertijtsma@gmail.com>

Add Devicetree binding schema for the ams OSRAM TCS3430 ambient light
and CIE 1931 XYZ tristimulus color sensor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
---
 .../devicetree/bindings/iio/light/ams,tcs3430.yaml | 52 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml b/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..085a70e5557b1b5201bdd11e00736af065e002de
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/ams,tcs3430.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ams OSRAM TCS3430 XYZ Tristimulus Color and Ambient Light Sensor
+
+maintainers:
+  - Robert Ijtsma <robertijtsma@gmail.com>
+
+description: |
+  The ams OSRAM TCS3430 is an I2C ambient light and CIE 1931 XYZ tristimulus
+  color sensor with photopic Y, Z, X, and IR channels.
+
+  Datasheet: https://look.ams-osram.com/m/43d518b4cd81e3f2/original/TCS3430-DS000539.pdf
+
+properties:
+  compatible:
+    const: ams,tcs3430
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  interrupts:
+    maxItems: 1
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@39 {
+            compatible = "ams,tcs3430";
+            reg = <0x39>;
+            vdd-supply = <&vdd_reg>;
+            interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 44540a1eb2b8088f9da95a9b6f83b4bf05188ee1..ea8ebd8ccd849702e82bf6aaeb4d8d60c2255628 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1489,6 +1489,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
 F:	drivers/iio/light/as73211.c
 
+AMS TCS3430 DRIVER
+M:	Robert Ijtsma <robertijtsma@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml
+
 AMT (Automatic Multicast Tunneling)
 M:	Taehee Yoo <ap420073@gmail.com>
 L:	netdev@vger.kernel.org

-- 
2.47.3


