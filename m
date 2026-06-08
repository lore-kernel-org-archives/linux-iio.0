Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200C3246E8;
	Mon,  8 Jun 2026 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934438; cv=none; b=RtxCv1QY1sFaS1lFr8XCV9wqhQs6avGsWRWH+YiJSKKuFWjVocrLbRJhg/+H007pzIFpXIKpSKIXh1NYpV4na2qk/0pHP+HOZaxaiksHzxZgEGNvdrh2RxY3t7QEFIyVYjdtMBcH+2UBPgvYjIfbKqx0ir87yaDkYfXgYmhf8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934438; c=relaxed/simple;
	bh=sdpDayMX61YvBZXacSyRdkvxSAoP6fxbVWk/8cunNLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H22Iy13D2k8HUvV9os1sAlykcQz0GugxlGYiY6lO/D2Z9CJWyN1/Z75NbnvsCiP82dshuI659mOgCTUisvE+1VbdJDcgdY3S+tj5bcVwbjYOLlqkR9eonlOfy/cqW6GqkaUp12OtGibydze10KCI+VgBv3dJg/YuhEF7zhP2wOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zHQlZzT1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zHQlZzT1"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 84ADB1A37D8;
	Mon,  8 Jun 2026 16:00:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5645D5FFB7;
	Mon,  8 Jun 2026 16:00:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD2E2106A19CE;
	Mon,  8 Jun 2026 18:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780934434; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5L85lN+YIg76FDHGEipMOXZM+5GQVFMUjSQ04DJ98rM=;
	b=zHQlZzT1V5ImsmIMOHoEQc5nXpwKftecEKLCklUZBRcQ5/1zp6gBeCk8i+NxWqbKaEuX8x
	oTenWSrzJ2UEA5cvtAJaXGn812qHi5J10bC/vTtceqHA9hN7T0e1lii5R8VDTN+f4DAgSD
	/qkJ9UjksMeat/OC40WFvnflpSgPPgaqIizww9XQj6dsKxiiyAp6/daJJogYSuVgSVUceH
	EgbCNNymiaVeQmYBKspklGx//zvQNqS1GP0lKP0FVbKos0fV5ETHfsE0Ow7fhLeMm6NPC1
	JqrJCbBSnNiziaB6VIrSqaLn/PKC6YZvJl9f1WZulb/vVLsjzG1qU7J+FLFRDw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 08 Jun 2026 18:00:24 +0200
Subject: [PATCH v2 1/2] dt-bindings: iio: ti,tmp117: add binding for the
 TMP119
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-tmp119-v2-1-30c3537d5097@bootlin.com>
References: <20260608-tmp119-v2-0-30c3537d5097@bootlin.com>
In-Reply-To: <20260608-tmp119-v2-0-30c3537d5097@bootlin.com>
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
index fbba5e934861c..d12dfef315b6c 100644
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
+        - ti,tmp116
+        - ti,tmp117
+      - items:
+        - enum:
+          - ti,tmp119
+        - const: ti,tmp117
 
   reg:
     maxItems: 1

-- 
2.54.0

