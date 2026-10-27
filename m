Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105176;
	b=EXqVLPFAMIb7uvUl4WiijURxNHruFzEPEIg3CzqtY6tjWQwSjfEgwk23WoM/1/OvDEa8
	 hLs64CRjqG6Wm3z/nJ4FgYEw8jiS3QXnDJ4+BtxAT6xSXq0BxgOFcJlHfDV6SWGPnbqWw
	 N53hoRPe1KIib4gnj70zfzynM+csogAC56S/l5+tDd5o/hg4eSesKZ74D/yGWaQUUK+7H
	 wX1p69yiv2JYYBokGVX7dzffk4Gn3bA/TD849uPM3+LW3aGLnnH5ovd1Mj3Eg4e/IS6rp
	 TBuQZgHf79OV7ta4ciemzyC364Fr7n175FnF54kfi/2ZqGX0f5KMnyi0uaUgZc+UWpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105176;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZuPnGPtXOcWmhVu7JksGY/6MPU+imQRyhrYYsrvJoEY=;
	b=cdoD4oitatdBrOGNUgQMC/JjvZAAZ5A+rILwSFQn0Go1nXSQCBc0FdF2OQ/bdyyQEkFx
	 keaqz0fcoaQ0wBicd52TXye93i1+9/3dtvpKASwNdNucpzONV28lMCzGWcfO2Ec6n6A7I
	 K8l4zyUT6GVxB8tx8CLraIMQHirYksIO4rPT4j93UXLYHxrJQyY/oBoZdsy6Oxhq6TfYr
	 7+yugq5qgJnmxP+tPW34MQUBTx6/fz8kfXa6FZd+wTyXZ780oJIFK7ydj/h4nqMubuQzE
	 KtLL5kJMttuVNn/jIyHKMvM8le2FHaTPJx2r9GFEMrf4ECxS9B6oOb/ZYkz/j6mWKvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vhbm56jr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE42606A31E;
	Tue, 27 Oct 2026 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vhbm56jr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAFF1F01825;
	Tue, 27 Oct 2026 12:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793105176;
	bh=ZuPnGPtXOcWmhVu7JksGY/6MPU+imQRyhrYYsrvJoEY=;
	h=From:To:Cc:Subject:Date;
	b=Vhbm56jrteQjTTsDguHLxGkwy0uhl30h+TeiYpBkTKwcKnWtgi5eXu6cJGSAGtVHN
	 qnmYKadM/iQjZaXm5kN86nrNVfajeEwlKXp7XBhUAohzubxKZl88nJWvNZlkvibmUd
	 pKvIXlhYJrDNj/NMg/dm6HOuw4npnMPGCjnrELNpq8Kx7YtCfLLDI0iXDagBpQxhAV
	 1eFuMjWTWyQLfFoEQdftXK1zpkblWAD+MFmNPCfyiexQzfPQ6XABH3NcjvezNsmvAS
	 CSzG0RIj2q8T89kJfzmx+n61e2E7BZ6BbwvvhQM5puqgznU2rZEuPeRUIJ0Mpt8T60
	 ydBT7FGwORYLg==
From: Joshua Crofts <crofts@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] iio: update email for Joshua Crofts
Date: Tue, 27 Oct 2026 12:46:02 +0000
Message-ID: <20261027124602.1533-1-crofts@kernel.org>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'd like to use my kernel.org email going forward.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
 .mailmap                                                      | 1 +
 .../devicetree/bindings/iio/dac/microchip,mcp47a1.yaml        | 2 +-
 MAINTAINERS                                                   | 4 ++--
 drivers/iio/dac/mcp47a1.c                                     | 4 ++--
 drivers/iio/light/veml3328.c                                  | 4 ++--
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/.mailmap b/.mailmap
index 1f5540bc33f1..07df296885ba 100644
--- a/.mailmap
+++ b/.mailmap
@@ -475,6 +475,7 @@ Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com> <jorge.ramirez-ortiz@linaro
 <josh@joshtriplett.org> <josht@vnet.ibm.com>
 Josh Poimboeuf <jpoimboe@kernel.org> <jpoimboe@redhat.com>
 Josh Poimboeuf <jpoimboe@kernel.org> <jpoimboe@us.ibm.com>
+Joshua Crofts <crofts@kernel.org> <joshua.crofts1@gmail.com>
 Jouni Malinen <quic_jouni@quicinc.com> <jouni@codeaurora.org>
 JP Kobryn <jp.kobryn@linux.dev> <inwardvessel@gmail.com>
 Juha Yrjola <at solidboot.com>
diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
index b181fe73dce8..e8a8c7c88716 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Microchip MCP47A1 DAC
 
 maintainers:
-  - Joshua Crofts <joshua.crofts1@gmail.com>
+  - Joshua Crofts <crofts@kernel.org>
 
 description: |
   The Microchip MCP47A1 is a 6-bit single output volatile DAC.
diff --git a/MAINTAINERS b/MAINTAINERS
index ecc22d1149d1..78a21782e153 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17912,7 +17912,7 @@ F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
 F:	drivers/iio/adc/mcp3911.c
 
 MICROCHIP MCP47A1 DAC DRIVER
-M:	Joshua Crofts <joshua.crofts1@gmail.com>
+M:	Joshua Crofts <crofts@kernel.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
 F:	drivers/iio/dac/mcp47a1.c
@@ -29151,7 +29151,7 @@ F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
 F:	drivers/iio/light/veml3235.c
 
 VISHAY VEML3328 RGB IR LIGHT SENSOR DRIVER
-M:	Joshua Crofts <joshua.crofts1@gmail.com>
+M:	Joshua Crofts <crofts@kernel.org>
 S:	Maintained
 F:	drivers/iio/light/veml3328.c
 
diff --git a/drivers/iio/dac/mcp47a1.c b/drivers/iio/dac/mcp47a1.c
index 0bf994aa0e4f..2e2cf8f645fa 100644
--- a/drivers/iio/dac/mcp47a1.c
+++ b/drivers/iio/dac/mcp47a1.c
@@ -2,7 +2,7 @@
 /*
  * Microchip MCP47A1 DAC driver
  *
- * Copyright (c) 2026 Joshua Crofts <joshua.crofts1@gmail.com>
+ * Copyright (c) 2026 Joshua Crofts <crofts@kernel.org>
  *
  * Datasheet: https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/25154A.pdf
  */
@@ -161,6 +161,6 @@ static struct i2c_driver mcp47a1_driver = {
 };
 module_i2c_driver(mcp47a1_driver);
 
-MODULE_AUTHOR("Joshua Crofts <joshua.crofts1@gmail.com>");
+MODULE_AUTHOR("Joshua Crofts <crofts@kernel.org>");
 MODULE_DESCRIPTION("Microchip MCP47A1 DAC Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
index df36c48204be..c49dd3ff432d 100644
--- a/drivers/iio/light/veml3328.c
+++ b/drivers/iio/light/veml3328.c
@@ -2,7 +2,7 @@
 /*
  * Vishay VEML3328 RGBCIR light sensor driver
  *
- * Copyright (c) 2026 Joshua Crofts <joshua.crofts1@gmail.com>
+ * Copyright (c) 2026 Joshua Crofts <crofts@kernel.org>
  *
  * Datasheet: https://www.vishay.com/docs/84968/veml3328.pdf
  */
@@ -440,6 +440,6 @@ static struct i2c_driver veml3328_driver = {
 };
 module_i2c_driver(veml3328_driver);
 
-MODULE_AUTHOR("Joshua Crofts <joshua.crofts1@gmail.com>");
+MODULE_AUTHOR("Joshua Crofts <crofts@kernel.org>");
 MODULE_DESCRIPTION("VEML3328 RGBCIR Light Sensor");
 MODULE_LICENSE("GPL");

base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.47.3

