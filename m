Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01B13E0C57
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646488; cv=none; b=tbMrkQGwGuilUWtkauAq//XC7efKSzki0aObBBbId8ZnyMtgQfUHpi7R4SMVnj7wfZ5OeNfOOzWZeRgONOpDvstynTTz8ogSbaKWSP1Q7Ea6YrAKz3QYZqFTTgQhnRimuUwhbXHmD5HM+2dVNcO7dACkP0e00C2ZZ4eG6Bo48+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646488; c=relaxed/simple;
	bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EcAvmg5kRkLMOsyoSBRaB+GlC0Mp+rLcFuR1cqGxBLabvS0Dlu6t3kfoA7/QTYyInm2kL5ePmj7ifQUgY5p+e2OGNkU/emw2casiPomAMUfFHYXBuQjJOM7x5KC0Z7zlXMIBGFI7FypTON9c5BXv7Ruaohiyw5B/QFq8rRzsFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=zKSEyeMZ; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="zKSEyeMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787646476; x=1787905676;
	bh=sNcmNScEhpmF/4cOJIi/n2ntDi0iE/3WYicZo1sq86I=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=zKSEyeMZC9ALIqcj+oNJ7WEDEIFwZ57dLI2pz7DlKjeDyg5cMDiPbnll0i5VOuwx0
	 SgmeskI7Txdt/o8FvscFGd8eG7+IvYzZ0yyQLXCSNkeAAa9V/z8pZGwmV6jN4H2+I+
	 ww1bAPCdyXB+lNv9+M8VBH+yb0+kpryO+z2DjGujCX7INfRZL0Hz/NatFHwsntONGo
	 8QtR7w5ArweRWBQBa2nCl/TWf0dE8fBh91fSQ8wpz8r+la8HjfHtFPKm3lnMFPzaZV
	 Azi1FUaq5moWerNT+00olHOWGJLSizgsjhOFwGzXBgYf79A+m/SuG4SmD7yN1dOW1I
	 P12UuIG4/JsjA==
X-Pm-Submission-Id: 4hTgrq1gvwz2Sd57
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 25 Aug 2026 10:27:39 +0200
Subject: [PATCH v6 1/9] dt-bindings: iio: accel: mma8452: Add
 drive-open-drain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-mma8452-open-drain-v6-1-9b252804ee80@geanix.com>
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
In-Reply-To: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787646470; l=1037;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
 b=IzU8EMotoIYwcAYrT69KS1JNYlR4P5lOx3HMAa25p7BK6i8vvrqFcjJ6yP3Je3/az9jxNEOAO
 4FIMFc3IiZ1BacypX57zwYv9k3KzXJV7d7DR+AItoUfF7KI7dPbbVTH
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Add new boolean to configure selected interrupt pin to open drain instead
of the default push-pull mode.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
index b0dd2b4e116a..20701aa725d0 100644
--- a/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/fsl,mma8452.yaml
@@ -39,6 +39,12 @@ properties:
     minItems: 1
     maxItems: 2
 
+  drive-open-drain:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: the interrupt line will be configured as open drain, which is
+      useful if several sensors share the same interrupt line. (This binding is
+      taken from pinctrl.)
+
   vdd-supply: true
   vddio-supply: true
 

-- 
2.55.0

