Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E03FF1A3
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811608; cv=none; b=N0XwCtw3JgS8oW6DhruSBK6BfThVIIeOyoAPAOn+BM7bK4i7wJYasoWDKsIAgG6gJarQFWjLgKN60Fijr0oJIArQ+89g9jsGniwvgCQ2wiZIP9A+au17FVjcb8v6/l7RRDfSuV0Y/X97Sk3yoBybfg5txJ1lMjlA3dDFsYlxhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811608; c=relaxed/simple;
	bh=JHBphShF7jV8KWhQLnrjSOppbpAv9Vu+X6/V9F520k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlyJsGWrPsuSB3ypqjgtWURsbkLlSvgVJKb3cR36kIxnIwuIIxQKk4hcXd6kyaefg0obfp25k81Mc6bPovXfxsP+YdylBkJBlNLDJuHmHSjmhQgIrUWAJkZY4DiUkZyb9H+2AGE2xsZxkrXgIqMmu59kXhxMF421ZRn0JFB1EUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CcEMGUQ+; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CcEMGUQ+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 295D0C51474;
	Tue, 30 Jun 2026 09:26:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC39960233;
	Tue, 30 Jun 2026 09:26:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7B39106F1D14;
	Tue, 30 Jun 2026 11:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782811604; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=o4VwmGHX+O1eNtL/TGDqwiWsVNqp3EO9QAN+rimq5hk=;
	b=CcEMGUQ+YAKTzQKXxaAV6cI6nIS0dMaBsm3p7cJaq/Qz0rkJ4nKneUB2vYHzbpdd1HPITz
	gnMclh8Pq/p0vwtdUM9/lUyBm3GRMrmcpI5BFGIR/L+rMAGn5/yhjDBT2IRJR8IYlawm7h
	QCwmf5CWTwVxsjyXbXwOOo63NoAyLK9OM7iXjnh5NCXsX8Zq3kzy2OzwB4cGew8rYfZwKJ
	vQVcKNLVL9QXoxJJCynAEb3F7/Mr+ORfj0ejXoAdvkgcgCiNLaM+L9wF89rWwpsImo9zOt
	3TzIZP6WVw2rX6jndvu0EJsSiLFfD9ZZ2InkkN3STXbaPbhEaX/gM3xP+5A+LQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 30 Jun 2026 11:26:34 +0200
Subject: [PATCH v3 1/2] dt-bindings: iio: ti,tmp117: add binding for the
 TMP119
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-tmp119-v3-1-cfdb50e2e99f@bootlin.com>
References: <20260630-tmp119-v3-0-cfdb50e2e99f@bootlin.com>
In-Reply-To: <20260630-tmp119-v3-0-cfdb50e2e99f@bootlin.com>
To: Puranjay Mohan <puranjay@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Wil Stark <wil_stark@keysight.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

The TMP119 has the same register layout as the TMP117, and a better local
sensor accuracy. Add a compatible for it.

Use ti,tmp117 as a fallback compatible for ti,tmp119.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../devicetree/bindings/iio/temperature/ti,tmp117.yaml   | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
index fbba5e934861c..7fb3e68207919 100644
--- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
@@ -7,19 +7,25 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: TI TMP117 - Digital temperature sensor with integrated NV memory
 
 description: |
-    TI TMP116/117 - Digital temperature sensor with integrated NV memory that
-    supports I2C interface.
+    TI TMP116/117/119 - Digital temperature sensor with integrated NV memory
+    that supports I2C interface.
       https://www.ti.com/lit/gpn/tmp116
       https://www.ti.com/lit/gpn/tmp117
+      https://www.ti.com/lit/gpn/tmp119
 
 maintainers:
   - Puranjay Mohan <puranjay12@gmail.com>
 
 properties:
   compatible:
-    enum:
-      - ti,tmp116
-      - ti,tmp117
+    oneOf:
+      - enum:
+          - ti,tmp116
+          - ti,tmp117
+      - items:
+          - enum:
+              - ti,tmp119
+          - const: ti,tmp117
 
   reg:
     maxItems: 1

-- 
2.54.0

