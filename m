Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D13F321F5E;
	Fri, 16 Oct 2026 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138544; cv=none; b=URA4i9Bqrqn1vpKw50BPAWED1AU9Qn/7U+ff6ac5Jwx4y/mUuVMwb8VL28k85huJ63Nvt21hjfGo9b8R+jKicVqPgHDwhQ5nAR47uIII5tQLK084/028mMNE1m1GMZjI4Ijo9UfhGI5OGHp2j0USG5txPIA2c7cUXyFF0x5Ik/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138544; c=relaxed/simple;
	bh=sYcOpjMMCBGwFOuj+OEqshBcNoWownBFOm0UmIx2nyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5m4hnThjJUUpdum8WU28My4WVlBDCTkAU+eWZ7dX3Rzt9sh4VkRK3Z3Lfa0wrXAlUmTr49EQZkUhj2DLT7u8SLVOtkTfqM0vaC025j0QZjNojsTqucu0mRqz+BUh2DKXcCk3vByyr8Fnp6fcMcIfcmsoRBkEmgWlc75U8/VTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUpiP9f4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUpiP9f4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52352C2BCFB;
	Fri, 16 Oct 2026 08:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792138544;
	bh=sYcOpjMMCBGwFOuj+OEqshBcNoWownBFOm0UmIx2nyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oUpiP9f4hJlWRrcZqiZnUxz/O9F+X2B8/ntzD7UhJ8azlzADm1ydxi40mQlebCqvP
	 ML9kDvHqY8vpxac2g8Vb4zD42+Fe1mXz10bsCdBxtfBry6rJ3jVFpKYSRa0Gw0CCuX
	 yOoyaqWRX4b6GPnuauIRVOo0bbEqsFgQED/kkvQDC4K7MRKkHYOvGFrruaet2gAPut
	 zT27WrQJItUOdfuO0W/3YXHYhEMygR8UWAHEQnh0YGRvM1n1U81ZqhxDhr8VThuy9J
	 K9Q7wILRxcZDI5UV5HMGZcMca8PpwEL26uX3A8Wl4o6hwuNIGWwQBQUMIhbg9LnPGg
	 L6sPqPmOZw7yw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4097BCC6B38;
	Fri, 16 Oct 2026 08:15:44 +0000 (UTC)
From: HuskerMinion via B4 Relay <devnull+mocker-mug-unwoven.duck.com@kernel.org>
Date: Fri, 16 Oct 2026 02:15:41 -0600
Subject: [PATCH 1/2] dt-bindings: iio: light: Add AMS TCS3472 and TCS3400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-tcs3400-v1-1-3d79d2a7f449@duck.com>
References: <20261016-tcs3400-v1-0-3d79d2a7f449@duck.com>
In-Reply-To: <20261016-tcs3400-v1-0-3d79d2a7f449@duck.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, 
 Arka Mondal <arka@arkamondal.net>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 HuskerMinion <mocker-mug-unwoven@duck.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792138543; l=2144;
 i=mocker-mug-unwoven@duck.com; s=20261016; h=from:subject:message-id;
 bh=BWUWnSBFMvBC1r9mYPrAA1SsYL8ZdWWn+kvzusAboq4=;
 b=Xa7RxEdTpTYbQjdRPfeW64AeQcjC4GWpcsjfCs0yzdJ9p8RqqV4uSAy/nF2G3SRkRkjPCO0sQ
 GIunnEDKx3cBozCdJLU/Jz2YP4Xou4aer9APbYMhg8fw5Q3hAdzGXEL
X-Developer-Key: i=mocker-mug-unwoven@duck.com; a=ed25519;
 pk=Q7l9BnP4XnFimCK28K+NVowcECqTaJNXicdBAInot0k=
X-Endpoint-Received: by B4 Relay for mocker-mug-unwoven@duck.com/20261016
 with auth_id=1206
X-Original-From: HuskerMinion <mocker-mug-unwoven@duck.com>
Reply-To: mocker-mug-unwoven@duck.com

From: HuskerMinion <mocker-mug-unwoven@duck.com>

The tcs3472 driver has no binding yet. It matches DT nodes only through
its I2C device ID.

Document the TCS3472 family and the AMS TCS3400 family, which the next
patch adds to the driver. Both are I2C color sensors with one threshold
interrupt and a VDD supply.

Signed-off-by: HuskerMinion <mocker-mug-unwoven@duck.com>
---
 .../devicetree/bindings/iio/light/ams,tcs3472.yaml | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/ams,tcs3472.yaml b/Documentation/devicetree/bindings/iio/light/ams,tcs3472.yaml
new file mode 100644
index 000000000..cd4a0516e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ams,tcs3472.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/ams,tcs3472.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS TCS3472 and TCS3400 color light-to-digital converters
+
+maintainers:
+  - HuskerMinion <mocker-mug-unwoven@duck.com>
+
+description: |
+  Color light sensors with 16-bit clear, red, green and blue channels, an
+  I2C interface and a threshold interrupt.
+
+  The TCS3472 family covers the TCS34721, TCS34723, TCS34725 and TCS34727.
+  The TCS3400 family covers the TCS34001, TCS34003, TCS34005 and TCS34007.
+  The variants differ in I2C address and interface voltage.
+
+properties:
+  compatible:
+    enum:
+      - ams,tcs3400
+      - ams,tcs3472
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
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
+        light-sensor@29 {
+            compatible = "ams,tcs3400";
+            reg = <0x29>;
+            interrupt-parent = <&pio>;
+            interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&reg_3v3>;
+        };
+    };
+...

-- 
2.43.0


