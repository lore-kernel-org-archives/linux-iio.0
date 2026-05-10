Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC032D5925;
	Sun, 10 May 2026 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778436592; cv=none; b=rphKMjuZWttKoiUU9IHSwbH7XtF7QHhzZi/C1IoCQ/swzXnq9fy66jMlwos4O7YFdZR6j04O+Xlxk/W+LbPYrMblJ3bqkbZuIootUeK6klpcAnBoB5Sy0KvJm3qnZX03yvnO7bHyiUPJVwqNWdjj6/AGNGJsPtrXt8qimHMM3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778436592; c=relaxed/simple;
	bh=p918NNAfKESHUaESEupz7gVBnaccniWtXudL4dFa/Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWmLZWpTrE4FxwSeWoV9TyrvlVPUMICFjWlaDAe4OWbsrg4y30hVc/qxtKsVEIWObthbBoRWsVTbaNtavCjgHu3CA5Fiuz4SccJRqJkZoh42T7ax62aNeuxEX4EZoG0z7Wr1zRvmB6Pr8sloNuXNiELRscoSnS3PYHXRTgdYao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWB0QG/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWB0QG/r"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0FF5C2BCF7;
	Sun, 10 May 2026 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778436591;
	bh=p918NNAfKESHUaESEupz7gVBnaccniWtXudL4dFa/Bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uWB0QG/rOz9wOPr9DIP/Jm3hs0ZzgvpNcAlOGm3rStwBdIYQKWndScS66XW1HP/Mj
	 38IzKjxx2SRd0uhTcdMFVrdSx3aiymhgwAJm6TKs1jREbKOtpixvQtTLhG8m4AX5Kg
	 fptGoKkNzD+R1Zn2GIe+fEnj+INRSFp5xN6niixobWBPABjAHhjY3ZTyu75a9SbAYG
	 m2m75t6+whiHfqjQLU2o6ViaJz+mGtVhxMbQJU0Sn7L74APzhr/zsCJG19JtJezGjK
	 P8U2dvCqMsTY4NyUH2Rlso4C3/6/15yX3Sx8xspOnEqUwVl0ZnlpeGFGsfLmblJOjE
	 Xg09UHYPqP+4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E05CD3427;
	Sun, 10 May 2026 18:09:51 +0000 (UTC)
From: Alexandre Hamamdjian via B4 Relay <devnull+azkali.limited.gmail.com@kernel.org>
Date: Mon, 11 May 2026 01:09:49 +0700
Subject: [PATCH 1/2] dt-bindings: iio: light: Add ROHM BH1730FVC binding
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-bh1730-v1-1-e0df1f499135@gmail.com>
References: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
In-Reply-To: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, CTCaer <ctcaer@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexandre Hamamdjian <azkali.limited@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778436589; l=3793;
 i=azkali.limited@gmail.com; s=20260510; h=from:subject:message-id;
 bh=jQHKR47Y8URKhOfFc/PxeUwRtzxZuqi9u6qUMfwgT9g=;
 b=ObpFPEaz1gMJZrJKNnAZL+40c304k1+WO2lqMgrq91nU3A5nKTrMr0nYckD7+iHo7qyNij7ZN
 Y5dEaGJwKdxDczrGylqUt+yNwxh5kvsPLKgpW7qXwFETXJPQ9AlRB3T
X-Developer-Key: i=azkali.limited@gmail.com; a=ed25519;
 pk=I0Z0IdCdQJqNGX+FQUnXhrHg950u3cM6Xzz3YT6JOyQ=
X-Endpoint-Received: by B4 Relay for azkali.limited@gmail.com/20260510 with
 auth_id=774
X-Original-From: Alexandre Hamamdjian <azkali.limited@gmail.com>
Reply-To: azkali.limited@gmail.com

From: CTCaer <ctcaer@gmail.com>

Add a YAML binding for the ROHM BH1730FVC ambient light sensor.
Documents the required compatible string, the als-vdd/als-vid
regulators, and the rohm,integration-cycle, rohm,lux-multiplier,
rohm,opt-win-coeff and rohm,gain-coeff calibration properties
consumed by the driver.

Signed-off-by: CTCaer <ctcaer@gmail.com>
Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
---
 .../bindings/iio/light/rohm,bh1730fvc.yaml         | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bh1730fvc.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bh1730fvc.yaml
new file mode 100644
index 000000000000..6273b69e82ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/rohm,bh1730fvc.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/rohm,bh1730fvc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BH1730FVC ambient light sensor
+
+maintainers:
+  - CTCaer <ctcaer@gmail.com>
+
+description:
+  Digital 16-bit ambient light sensor with an I2C interface. The device has
+  two photodiodes (visible and infrared) and supports four gain settings and
+  programmable integration time.
+
+properties:
+  compatible:
+    const: rohm,bh1730fvc
+
+  reg:
+    maxItems: 1
+
+  als-vdd-supply:
+    description: Regulator for the analog/digital supply (VDD).
+
+  als-vid-supply:
+    description: Regulator for the LED indicator supply (VID).
+
+  rohm,integration-cycle:
+    description:
+      Number of internal clock cycles used for the ADC integration time.
+      Used together with rohm,lux-multiplier to calibrate the lux output.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  rohm,lux-multiplier:
+    description:
+      Lux scaling multiplier applied after integration. Used together with
+      rohm,integration-cycle to calibrate the lux output.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  rohm,opt-win-coeff:
+    description:
+      Optical-window calibration coefficients. Specified as a flat list of
+      triplets <rc cv ci>, one triplet per window region, where rc is the
+      visible/IR ratio cutoff and cv/ci are the visible and IR weighting
+      factors used in that region.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      minItems: 3
+      maxItems: 3
+
+  rohm,gain-coeff:
+    description:
+      Per-gain sensitivity coefficients. Eight u32 values arranged as four
+      <cl fl> pairs, one pair for each supported gain (1x, 2x, 64x, 128x).
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 8
+    maxItems: 8
+
+required:
+  - compatible
+  - reg
+
+dependencies:
+  rohm,integration-cycle: ['rohm,lux-multiplier']
+  rohm,lux-multiplier: ['rohm,integration-cycle']
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@29 {
+            compatible = "rohm,bh1730fvc";
+            reg = <0x29>;
+            als-vdd-supply = <&vdd_als>;
+            als-vid-supply = <&vid_als>;
+            rohm,integration-cycle = <38>;
+            rohm,lux-multiplier = <1000>;
+            rohm,opt-win-coeff = <260 1290 2733>,
+                                 <550 795 859>,
+                                 <1090 510 345>,
+                                 <2130 276 130>;
+            rohm,gain-coeff = <3000 0xffffffff
+                               2000 9800
+                               15 60000
+                               0 1300>;
+        };
+    };
+
+...

-- 
2.54.0


