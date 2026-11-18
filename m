Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009579;
	b=ppfuMe3SQ0fLCGltEG7pq61MjS8ewtxBHCmgkXbt8LsYamEqEremqKZkNxSyU+3Da2oZ
	 BeRIyIr8ieb3ApA45p5QBZrbhd6IwVBAebxMNYHF3GNvyBake8p2SFCQ5BM/2gan4W44W
	 DdfwbW3pYQH0iCEYvUyU/kYtmzEqft/gC09lbbIhyg71QxGXVlxHFRQRW2G+UJLBL22II
	 adCo2ABqnznWLSXhrAU/sFKH8G73Y92azT4xwkNGl25ejQRybcmZKBsLQswUqK6qflPk4
	 yaer6Za9KgaOHdD6CAsuWym0HLZtzviOk6ry8F1ECBzWPahQGQDh/Zktb4f/JygzrDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009579;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=LCXykxBzrI7ON2fhMNoORcDkQfUzgCK++6lvveh+ycw=;
	b=JJGFBxdP0SW3XSyk1aFMq+T1jJ3tL9QzVvSThSLZQCEb/gbFEuZd/aMdDnYvbEgfbupi
	 ga/5ApkgGIWvM050yrD79icBtvszt+VTUpb8CQGqJ+cURBPGPJhmiJ/PiiClpw4GrTA48
	 1CclYGAZkeAsmGqXJZbtxLmnhTXHm1hbhTRgVe240RL5ao4O3Gq9+30G5fLhb9gRiMRut
	 DwzHPznZEuOArhmtfWZBFK+2TF/mS+pELcYW4agcZCQBmEjhs7ZJpbIQxFJlus7h9hrz0
	 hMTN54FG38ZT5O/0osgFY3urCRAIk33uPk3BuSxcGQz661KcPNfCmdTeUaqT6EqwRKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcwOjPI0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1389E60A2604;
	Wed, 18 Nov 2026 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcwOjPI0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617861F000C4;
	Wed, 18 Nov 2026 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795009578;
	bh=LCXykxBzrI7ON2fhMNoORcDkQfUzgCK++6lvveh+ycw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UcwOjPI0q21RBuGN50g6M9P/qK01kStrCW30C3OhBn5Xc7/KTTxrUImmVmQSLSS64
	 1QQ3usD2r6PdBoUmCC6V02RFioWKWqSFsfrreW10PInsbrZdFcWc5Eh2QuXm40DvUr
	 7OzzgMmADWKeVuLmwhW1FODp6djb9gjqJExnHCvjFFEPNK+PPMeqvc2MEcvds0l2VO
	 Z3Qz9mq98itZKp/rG7NRWrmc7feRF5ikfN7nL/DWbLBkItwkyUPne5YawuVZwrUYBo
	 FeqsT8UmsFU2V6tJ6Z0I8mwj3r7QRWTqi/B4aV2JgjX3nOdqYmPi05fBr/1gBUaDDM
	 yDPlPVKQSFXAA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 18 Nov 2026 14:46:09 +0100
Subject: [PATCH v3 2/5] dt-bindings: iio: light: sharp,gp2ap020a00f: Add
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
Message-Id: <20261118-gp2ap030-v3-2-c8df93460110@kernel.org>
References: <20261118-gp2ap030-v3-0-c8df93460110@kernel.org>
In-Reply-To: <20261118-gp2ap030-v3-0-c8df93460110@kernel.org>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0

The GP2AP030A00F uses the same register address layout and interrupt
interface as the GP2AP020A00F, but returns raw clear and infrared counts
instead of providing automatic illuminance calculation. Describe it in
the existing binding with its own compatible.

Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2ap030a00f_e.pdf
Datasheet: https://jp.sharp/products/device/doc/opto/gp2ap030a00f_appl_e.pdf
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml     | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
index afba0b005b34..f4a262dbc956 100644
--- a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
+++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml
@@ -4,17 +4,22 @@
 $id: http://devicetree.org/schemas/iio/light/sharp,gp2ap020a00f.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Sharp GP2AP020A00F I2C Proximity/ALS sensor
+title: Sharp GP2AP020A00F and similar proximity and ambient light sensors
 
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

-- 
2.56.0

