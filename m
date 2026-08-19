Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E5239792C;
	Wed, 19 Aug 2026 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127369; cv=none; b=sxYTJAFbXVKNg7Y63g3AdMI4tZidKZhhwfYU6R6UCwbA09vV1TS/KQ+vD9eoKnBaQp1b9wb4GZumqLl7StuSN2EMzLbR4hZOKOXkGAAmTGeqy1PP9/6g/V6cDTgeVAJ3E1Nl2ka9hTR7EMNyboDiIl8c3PrhByLBFE0KcKVAdtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127369; c=relaxed/simple;
	bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SPneYcuYFu0iC4MVyds9vRgxjKjTXESzGneZwdhPT0JOLmXOQmujh6MBZEzz3GMNdDVoIvxR3EumvOlO5oqk3HBNzf0cMnJR9C1sjFJyXh4I5aaLszxC5D7qj/2tQIQG4LqnLXDUOsh2h672Pnsf3jf0k65Mhwx0wKl+4X7r4zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=6grltua2; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="6grltua2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787127346; x=1787386546;
	bh=sNcmNScEhpmF/4cOJIi/n2ntDi0iE/3WYicZo1sq86I=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=6grltua2VaNOoOvZHjyYhEXdSojfpY9QogKpu/0DHu6g3PWcBx4xPLZDPKwSvdqxX
	 e1qR+rQMHXFh+BQnqH61uym9C1XQjZMOZ2BBhEWy91aXOSzBeNoshbgsZn9IKVlY53
	 OveiFsIfUj0pb4mZw4MyOps7IbIK5IGsgb9pGQ1hobTJkEdazZO/NATQ8KlD5oki/t
	 Y6oLolwOZQjgnsOYiCdO98fpecXRA7kLStCN+1KVgM1bhvETuwSp6XM/pzbHwwZYfy
	 HCOgSAUCe+6Er7G63yaD7o0ij804hZgDe2PsK8UI2YhS1e6qUoBaF0Zrm6xbQbGW4V
	 2+nTnZ8EONgKw==
X-Pm-Submission-Id: 4hPzsY31DQz2Sd3L
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 19 Aug 2026 10:15:28 +0200
Subject: [PATCH RESEND v5 1/6] dt-bindings: iio: accel: mma8452: Add
 drive-open-drain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-mma8452-open-drain-v5-1-d8aa590d7c36@geanix.com>
References: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
In-Reply-To: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787127340; l=1037;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=Vy2kFGWf40LZZu/OrRKxOp27EqZPY3iYxkaZKLnSAbQ=;
 b=Gy0zaNMyPDxrgLMRdLT/GkkvUbfVO4dK7CNbSTnBEQWpYRqGNiua8eGzqVWXmmts9P62jy/2L
 4qcfjPc3BdhATmflgtmB3iou1bZtLKvfcNI3RrnUv49n5ohY+EkU/H9
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

