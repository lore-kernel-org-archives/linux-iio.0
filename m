Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813AB3C552B
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102881; cv=none; b=Lv1pXBmp6EOUvxm1nJbrjsm5EN5/nMgt03g4Cnjrcf4vzOEL3eZvNMq86yTVuSu9WTDRpFNc3zmzebJF+zCeFm9AN/qqUP1uP/2e8ckpqm2AmK658VNSPwVrCeCibDTnvxWCXKHqwExz5MufCOeCkIA8P/eKjx7rCAxS+oWAM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102881; c=relaxed/simple;
	bh=3wQ39MVMhwv+sIan9nmt82Njg/lpuBoBHDNh3zcHydQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2hgdE92ru4zoKOe4lYrkQQKytDKomNV6Gz4XzgIB+sr0Y7Qx+pTxuf/L3CSsyyLZyzqrp8OaTZWZZEjeZp87d/fz9igMXnNPm6v7j5/slsNC+iPDvLBjCi6J7XYLQdhWOgzodDXkmPahQHiIiV088gMp45vsF3HfvVYxYr194Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=WQa5rs3z; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="WQa5rs3z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784102868; x=1784362068;
	bh=BS1MUbZtDgZZJKhSMPDLCd+i5OY758wRtoFm/U7AmUg=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WQa5rs3zrulBuoUhIN2c5XHPQpNYRDLmyAyRMteHX8Pa0MRObLUz8QNS7PMxCQtT7
	 abzXD02v7I74IBz/KxxVrZwVIgDKBQd7LxpiCiYeVcmZ/kxwEQygLsIhVkOHAsQlDL
	 nEkBcyqU1V5hPVQF/Ln4HnJy0eyunmF2/9x8iaV1j7dU+NmlSZAi6XzmpUll2LXGMQ
	 XR+lujozuK95rbr4/FQKOKHyTEnScvvHjIYReY3R4EBr4zERt0DXUFmsSOXveEJ/W0
	 PQTb3YMqddKqpHAb3Ha4TvM7DHhYdq3K7YJH4v/pr4wk31DqqAfHPOBEn6PqZZWisG
	 qGwHmAQDNPGDA==
X-Pm-Submission-Id: 4h0TLT68BMz2Sd2n
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 15 Jul 2026 10:07:38 +0200
Subject: [PATCH 1/2] dt-bindings: iio: accel: mma8452: Add drive-open-drain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-mma8452-open-drain-v1-1-b1dd2a440c60@geanix.com>
References: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com>
In-Reply-To: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784102863; l=990;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=3wQ39MVMhwv+sIan9nmt82Njg/lpuBoBHDNh3zcHydQ=;
 b=GcqG96YuFrM+bINLYZZI2AXddzNmKEtsfLBfOrhbY+n4EDbY9dyC/ElRN0nGX72fnHY0TjmB5
 LcAIzBvq1mFCqWn90R7XjQZxwGe1gbZEVdSt3vxY7cYhsFPU5GdWF75
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Add new boolean to configure selected interrupt pin to open drain instead
of the default push-pull mode.

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

