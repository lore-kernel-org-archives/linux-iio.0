Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174249;
	b=kCKw/yED7m9xtb4heX3mvg24tGUZNfP45/8bha0yAf3v6TOli5qdQvWTzmwlMtRZFU75
	 a9vJ5Sq7vwX+K1Rqau/L8A+KBb0CWjJgKl5BBQWC+eB79EgqsFjlYbZ4jZwSzH37KhVHI
	 lcRj3vrtuE2EeLzcGIuj9RxcupSMQhQ74YxnBWnyeG7QDzFosInBCyYpiyPi4S4jbCLp9
	 1r3oVb72R6+DImGh67k9HzXXcALBxDET4tQL10hhGD0ZSZH+MTwmA+6XguuMNz3dn3lK7
	 3w4ITT5BvelcBG7HbjgOlUJyhqWHn/W+Ji96gFsWuqVEGRMx2QfTYC6rfvvxr6KALMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174249;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=GiQf8J1mxKPhKnR2sI/CKk3x2cIlkp42oHh9MXFfHIY=;
	b=3MkphdGpg08C+y7wcafsDbrs7zB1uiXNasbuKPgz0TW1ip9HdOxkhJP4E2wgA8gdHoMH
	 Hghu/3hi1sm3xjwj6KwryrairNu0wQU8H6C9c4bhohRp3JN7R/fpfeFMDdIMfI+BeDsMG
	 93ky/EgPszgcmoBGCidWs2+HRpQAHX8mNWjQfGtqauZQKt68bYufWFR+/fxektWpRSc0J
	 Px3dxcT2KykcddGU7rI5/QbbZ+34xb5fyfExLqHwdHedShnoIftXJICNu+3CCQHpbwKy1
	 QkilDJLyRCawi8Fcohgu7CwH81PHjMkTTYfuta7N3AmVKxwF5c95O7GOrLReClSGhBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOATcZW6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B75606A321;
	Sun,  8 Nov 2026 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOATcZW6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AE71F008A3;
	Sun,  8 Nov 2026 21:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794174248;
	bh=GiQf8J1mxKPhKnR2sI/CKk3x2cIlkp42oHh9MXFfHIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VOATcZW6dRywSad3fFxjxD7EkTI8WQrAD8yGGF6GKtx3HNLPOR8eFuF2Ofb3rONNr
	 9VGIKVu3EWcC2vuTsX5/IQk2bgOHe/E6MZqSCTsU2qbigBTdjOjVszKfUb4FW+W5aD
	 MuYWDK3U1KQs3F2sGuqhKBLSFE6H1s2H6RW4+GO3ND3z9fnoG0fwS/59LGaHSh/KFD
	 lDjXbJPHBTy7SFdOeRzPRkDqoQ+cAvIn8xKz7TwUc+x6wDOXYBHn58kEXKeK7fjxRf
	 6SjaWt72m74i2U7yYAfb7YbMi4A3fw+OwRu8h9rZ3Xa8aZcd1U4mRUFqOp+8wmjvmb
	 FybDWm/nKK/qQ==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 08 Nov 2026 22:44:00 +0100
Subject: [PATCH v2 2/5] dt-bindings: iio: light: sharp,gp2ap020a00f: Add
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
Message-Id: <20261108-gp2ap030-v2-2-24eaa1b9fe59@kernel.org>
References: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
In-Reply-To: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
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

Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2ap030a00f_e.pdf
Datasheet: https://jp.sharp/products/device/doc/opto/gp2ap030a00f_appl_e.pdf
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

