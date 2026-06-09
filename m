Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5556C3F23BE;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999991; cv=none; b=pqKhycws5anTnFu2I0E4VeFiYZM/cK61C+0qN4Atf6DXEx/SS+/ezahvCVy6NJQFGL1o+LJC+fRyvDGL6TMwjRU0pU47U5Kjg7YzFcS7cKTo+0ln46ybPsLWAUduh40INZYYs8k8TMGAoaAFZnkFnOqciiKn3s4lXbxP5DFwCVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999991; c=relaxed/simple;
	bh=w7+Obg2ovPOs9oqtkW3i2gIiJgBvqx4L7FEmPgqoV24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z40TtD8jO077Q7pU5zLZ+is/1Q3mlNEWAQNVmMjoJlBfbUkAemamaFib7063DpBFtrN5SW9fyu6mzTKchm1h47W24HzaWmCH9RKp6PUsAZaaikWXB61IPBlx3tTjvSBSxAITIaJiilBMRk6yW1q4TikYUjB0W5Ab70SROnwWHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKVn/Ijo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKVn/Ijo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AD81C2BCB9;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780999991;
	bh=w7+Obg2ovPOs9oqtkW3i2gIiJgBvqx4L7FEmPgqoV24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SKVn/IjoQKW1q+0S8Zrbuyd7WGZHXz9NP/ekLKFnRbdyEooLmREc2Wl3GEHtu1GCf
	 sBoWF+1HN18uhYUlixPG5fmRI/4dnzIfEtH5q+K+rAquUsSvGsaqksky0Hdc4Z3zTE
	 J1roeAwsG05YkLvH6sVM98JRfx63/0gKiJKAJlW915aHoJ4T7Y21Qn1+OUr6gV+LRv
	 A1/i1zzvIxMT8YRJVr3jTBjzzIHDT5JEODZOFdGo/3TJe5pthIzoy1z3KUS9wxQDVt
	 5CskC5Vv4HFcY/NqhXZX0Mj0VADrWPYskir9eXSRreBZDJHgA4oxP+Z0sKKzIYxX3c
	 MQk/77Ku8PjMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05321CD8CA8;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 11:12:57 +0100
Subject: [PATCH v2 02/12] dt-bindings: iio: dac: ad5696: rework on power
 supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ad5686-new-features-v2-2-70b423f5c76d@analog.com>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
In-Reply-To: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780999989; l=2384;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=w6n2S0hkRQCn42MvDFzzdjyI7tPRxsrjN1iZf1cE008=;
 b=hUxstRmk8br4kUQXfwBD8NZ5/92wGDEz8Rm5YyaB/rYzwPnjeXsSHxUHwG/rGAfw5vm91qCkO
 Ah0LnwO3WSYD+2dRhP5XSj/5GZSKT6mNZWO3EL2L35aVIktF3rarxKX
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add supplies for VDD, VLOGIC and VREF input voltage pins. The vcc-supply
property is deprecated, once it does not really exist as none of the
devices describe any power input with that name. VCC is also misleading as
it sounds like the input power supply, but it is being used as an external
voltage reference, which should be called VREF. Certain devices require
vref-supply to be available once an internal reference voltage is absent.
For correct operation vdd and vlogic supplies are required.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5696.yaml    | 31 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
index 2dcc049f30e9..e5fbaec4adf7 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
@@ -33,9 +33,19 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply:
+    description: Input power supply.
+
+  vlogic-supply:
+    description: Digital power supply.
+
+  vref-supply:
+    description:
+      Reference voltage supply. If not supplied the internal reference is used.
+
   vcc-supply:
-    description: |
-      The regulator supply for DAC reference voltage.
+    deprecated: true
+    description: Use vref-supply instead.
 
   reset-gpios:
     description: Active-low RESET pin to reset the device.
@@ -55,8 +65,21 @@ properties:
 required:
   - compatible
   - reg
+  - vdd-supply
+  - vlogic-supply
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            anyOf:
+              - const: adi,ad5693
+              - const: adi,ad5694
+              - const: adi,ad5696
+    then:
+      required:
+        - vref-supply
   - if:
       properties:
         compatible:
@@ -83,7 +106,9 @@ examples:
       ad5696: dac@0 {
         compatible = "adi,ad5696";
         reg = <0>;
-        vcc-supply = <&dac_vref>;
+        vdd-supply = <&dac_vdd>;
+        vlogic-supply = <&dac_vlogic>;
+        vref-supply = <&dac_vref>;
         ldac-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
       };
     };

-- 
2.43.0


