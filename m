Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795560440;
	b=Gq7Z850JLkSPt+SINR55U+NARv98HJJHtZOONANBhQEI+3vErxnmyvwUhgeamCKIg5xe
	 OJm0aQoZ9WWGEqKPZRNGKby1bRmDwxV6ECm+h27yu7cNIqiGjYKcCq+ttrkm4YbGPkrzV
	 kMwWNZR3s630EtSrTPx10yrUrN4YZR/7bL2RGM87VHkISSCGrlIqJ9bZaL/tV8e7wMYA7
	 OtgnM61nAp7Z80ZOG1K/xX8041Z0E8oSDu3F0AR29VsZ73Dw9QXVoFy5VgsadoblPLP4K
	 fOzy3RXpfa//5NtR2k/mOhFTw62BITEk2BxeYGCIG/K9eqGaCirJtgw5IpqsI6cgIFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560440;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Y54nt4+fq24f4YIB9TGXc8UsmwWcLEu74poV5qjZyIk=;
	b=a5iplGJip07HEeygWWMIZi4EDAj7DQLtocc7iOp/CwRrbh+X17kpyTyJoqRPcreV2PYY
	 wb4aW4cCB0LyQ7sNG8Dlh28lJoY/HB73HX42Os7bdUZl87cNJHIdgylOO03m1x15hU3KJ
	 8wKP8/1jUI5ThsrFnOeTVbGzTEipFqpHvmvoMKg15jC/sgap72TAnb6wei+6Q3JobHX9z
	 JfPlj6qqo24z7xHZexEGAX/s31K4fyw3fzSyPIUWxLIZNZlEiDE+P8MH3ROSlFS7TGOaV
	 oz8VtEEGc8EY4jnfRau0jz9m3F1c+vE6NGhdIQ0R77x3srrCRtOZGuJyU+10H4RhhQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJr2hUe+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85293606A338;
	Tue, 24 Nov 2026 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJr2hUe+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795560440;
	b=zqv0Xo9C9A3CV+Pye2nkXwm79FF4DpPxH5l0rJTgp5TLuBrXi75YVLGHArduR3jnB7r2
	 1uDlY8VWbFfcAjF2XSZ7OqJG/5NVF6oVaQz28CO2Gh1+Emud+d8FERt7eb0ismvbgycca
	 M0DcrNMx4pDkiJ9sZp0W2KBb9wko8jDBtnuCTEj2isaolJu4CJv3SVZ184tsNAL0IQ6RR
	 Yf4mLPY/lXm5VaTuGwiBrwkm9YaYwDZqBlKxB1tdfrSA4JlIVkbIdjFa3gTytRwOMtHKk
	 2FD6CV1QyGbQXRQESTQ1yHHxKM1agHXj662TEVk0tyq4ADXwWMRudlJkhra1ZGApHEw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795560440;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Y54nt4+fq24f4YIB9TGXc8UsmwWcLEu74poV5qjZyIk=;
	b=pQU6PmLA86UToxCiltm/2obg+Qwl9I04hU5NrsHd5Vd0gvwg+T6XZrnw+9XfrGn93RPL
	 LTtfqrV63XWpmJvIGBTI1yZzqjCBH8FFAXM843681Y+/PdKxg3o8qQDgn7G/xPASyUCn9
	 Y6EAVg68xJbQZ6Wc70JWuVWYhWHD50wAK/RZTmsg2zECBgXOSij/ymWN53SlZx7XK/xVF
	 N6R20nPkvjd7aghQ1H1mYngSE1DVCqOcrjIA713QY7riIWzFSjjWolF3sQp7ZprRtYvdD
	 UWHrYP4BA4nz6dHSvwpJoIZEao/Nca75yFocSFTboS0bVPA/WKh62NtAJeEV4zb1yLQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3141B1F000C4;
	Tue, 24 Nov 2026 22:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795560440;
	bh=Y54nt4+fq24f4YIB9TGXc8UsmwWcLEu74poV5qjZyIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=AJr2hUe+J6SBcQF3C5KVPaqfAYAPMd6N9gYtsCP+w05xmWp/4AtLt6V6s8Jy2tPtG
	 0cPm/gc7xin0tDqAN2v3blcuouFerLqo5TgxjQQChrTjx7jGZf9CiclsRnMKAY5fzp
	 OIvK/8HC46WJTiTifwht27gBEHlUfct7oUy1molx6t5sQb63rAqwZTmMc4rHRWMQt2
	 X6KmfPYga/QYs+mawZAUFVs9yuOoMJPGHv7uanjlIySMRClUVvXLykggSFvD4LISHL
	 CHMcmt5mtqH60N4rXFi28gp3/xFmtkVbhgd9mr8oBfiUivQRdMCAJ9kgPCwM5W16dn
	 OB5nAURHYM84A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BA6D14CC0D;
	Tue, 24 Nov 2026 22:46:59 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Date: Tue, 24 Nov 2026 23:46:57 +0100
Subject: [PATCH 1/2] dt-bindings: iio: light: add ams OSRAM TCS3430
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
Message-Id: <20261124-iio-tcs3430-v1-1-0f2a38a6a4c1@gmail.com>
References: <20261124-iio-tcs3430-v1-0-0f2a38a6a4c1@gmail.com>
In-Reply-To: <20261124-iio-tcs3430-v1-0-0f2a38a6a4c1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Robert Ijtsma <robertijtsma@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795560419; l=2397;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=6g3jbEADq4dZ3mSEGwYLMwabsTUEtLyGK4g51b8S51k=;
 b=8Nwd+wcxYr8+gQfY89SoZNiJ/L0j2Xe4BohEDYG4fTvdYpPs8l4HEaf068d6gyPQjVYWOcXQg
 0Kv0bXEEHNFA7LhdXUb7SakqBVaiDtsarKOLqdzdMEP5VyyZtD7I53n
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

Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
---
 .../devicetree/bindings/iio/light/ams,tcs3430.yaml | 52 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml b/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml
new file mode 100644
index 0000000..085a70e
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
index 44540a1..b1cebc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1489,6 +1489,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
 F:	drivers/iio/light/as73211.c
 
+AMS TCS3430 DRIVER
+M:	Robert Ijtsma <robertijtsma@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml
+
 AMT (Automatic Multicast Tunneling)
 M:	Taehee Yoo <ap420073@gmail.com>
 L:	netdev@vger.kernel.org

-- 
2.56.0


