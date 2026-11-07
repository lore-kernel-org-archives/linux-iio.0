Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794094302;
	b=Ub4I8XL3f3eQtbOUbFWJ74179ksrqHXFh8dFOeBJVugMRCmBev3WQtKILcxgj/71/hm3
	 4qorciV7TUyiJxhVwS71pD9M90g2kmLKyAI51+DZbsdRrIqf1m6H01PCZoABx4rsBZoWt
	 hqu/DQmvGPm/PyBnZ9uxi6mhFhWw69qpH+7q1IP11GW//8rJT41ZrAWGESJZ58dZ3lxT8
	 UhkW3EPTrxFkX8C8SHOMVw3ldOKPgJVF/EtPC9mX+o7mT+DxwdmTD7C/fNHgBqFkKZwPn
	 cZfll1DfSuimRoPB2XeotGY2+26YgqqDO3V81n9pD8A6xgmCKEx2q/y5lvZICtTMs+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794094302;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=myoH/GQJWTtL0DMiL0KOTSUWHospqFoTMbzac0eaW+Y=;
	b=hu8j1MvUB9fXqHNOK6YbpZtEtMjFyQ26oO7bVDgNeqJJoFwOwbfjHgZOAFexeJf280O6
	 gKOCb6Ts3hoMU6BX0J+tZ8k5ygx6VmUfII8TAtdAU86+dJ7DTDJD3wSNiZH6kzfcZ9LlG
	 qLQiuAsZGDwkrYV8IzD/P/bEwAI7OST0Q7T8T7/FB3bh2U5hCIXehTDRiqbvjLsQJ8ZS/
	 YZrTycQxRpuVZXjyV7njjhfFyntyAXyniRUDwbxWcCFQ9KEnwob3e1YlyHNB8ijejnXKM
	 oOQX17MGSWozlU+hxCZqBixuuthnoIn001bpzH8b6FyOzi/K9N63fCD+8cKsdigAW/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PT+mx3Tq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A69606A336;
	Sat,  7 Nov 2026 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PT+mx3Tq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F411F0089F;
	Sat,  7 Nov 2026 23:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794094302;
	bh=myoH/GQJWTtL0DMiL0KOTSUWHospqFoTMbzac0eaW+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PT+mx3Tqh8c7M/R5VL1eRXeRx1vaWTwG6TZl1nRZ5D0IBuloxgeEPGmJeCK3zrBAm
	 B53kvhWQdg0C+r3+xDkuYpKSd8SmHzSFZUTUznIo+Qs2likoHKin7NwbrRUe1y55Kh
	 UfxYUSJKMAHy0dIouY50oXNqUpvitc2tmmfIJ4pZXcRZtPzwxibP1/BGzSs4+33NMm
	 MrgVDz4S3iI32REg3tPRKIT9TNyMUo2ZJ2AnMzzylUbiSO/4wuhTawK373S5msdHbe
	 YlAAfjapUvr3IG5KvmT9qf18iy8OcehNncIajWHubZ6UHqNQ01FcwIq8lPeXNUwSs+
	 2EqdPWSVX0N0A==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 08 Nov 2026 00:31:34 +0100
Subject: [PATCH 2/4] dt-bindings: iio: light: sharp,gp2ap020a00f: Add
 GP2AP030A00F
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-gp2ap030-v1-2-55314eb7055b@kernel.org>
References: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
In-Reply-To: <20261108-gp2ap030-v1-0-55314eb7055b@kernel.org>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The GP2AP030A00F uses the same register address layout and interrupt
interface as the GP2AP020A00F, but returns raw clear and infrared counts
instead of providing automatic illuminance calculation. Describe it in
the existing binding with its own compatible.

Keep the core and I/O pull-up supplies optional so boards with hardwired
power do not have to describe them.

Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2ap030a00f_e.pdf
Datasheet: https://jp.sharp/products/device/doc/opto/gp2ap030a00f_appl_e.pdf
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml  | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
index d4bcca0f2d0a..45f1b53d6d7b 100644
--- a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
+++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
@@ -4,17 +4,22 @@
 $id: http://devicetree.org/schemas/iio/light/sharp,gp2ap020a00f.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Sharp GP2AP020A00F I2C Proximity/ALS sensor
+title: Sharp GP2AP020A00F and GP2AP030A00F proximity and ambient light sensors
 
 maintainers:
   - Kyungmin Park <kyungmin.park@samsung.com>
 
 description: |
-  The proximity detector sensor requires power supply for its built-in led.
+  The sensors provide digital clear, infrared and proximity measurements.
+  The GP2AP020A00F can also calculate illuminance internally, while the
+  GP2AP030A00F exposes raw clear and infrared photodiode counts.
+  The proximity detector requires a power supply for its built-in LED.
 
 properties:
   compatible:
-    const: sharp,gp2ap020a00f
+    enum:
+      - sharp,gp2ap020a00f
+      - sharp,gp2ap030a00f
 
   reg:
     maxItems: 1
@@ -28,7 +33,8 @@ properties:
   vio-supply:
     description: Supply for the I2C and interrupt pull-up resistors.
 
-  vled-supply: true
+  vled-supply:
+    description: Infrared LED anode power supply (LEDA).
 
 additionalProperties: false
 

-- 
2.56.0

