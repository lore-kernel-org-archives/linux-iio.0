Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39116318EE7;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869184; cv=none; b=pobvrBLo7Rnl/ZboRiJPiibI8wJW/dmis4W6wwdv1VMdLzUAZRhXDjT/qXQRYCUHyDXhCUIsYwZW8C1tj6on0oOWxSUSKV7cogw5/eiBri5JsGij6sQF/gsVS9QA6iniD7nq69EHKE/Og2v4dlVwtXOL9B23K/malCBjPAsDKj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869184; c=relaxed/simple;
	bh=xxutEXxm9rgHXUJpYjoukNdmX7/D20P+XlqLd31i94k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZwzMDYoPlu1SwL0pZWf51fjGHjLnkMmY1pBJLDpGNAhyTEKlnva7L6IUeZ6ONr3Kayg+IWaJlycPixlgr/28UQAOLiqepCaC3cObIwuel21Ggslh1L1rm3qSeOj1AolPK65fwmGyX0fSp5/yXKZ2HdmyBA+7CdmKrc2is5goRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS7ICVYv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS7ICVYv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA1C0C2BCB7;
	Wed, 22 Apr 2026 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869184;
	bh=xxutEXxm9rgHXUJpYjoukNdmX7/D20P+XlqLd31i94k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KS7ICVYv223/Y3P/49WzwpIcP9xt0kLANc8PHrQHxt5TrNaNNPgqBkC6vkdBR/H7a
	 ylPCWbK6N/UawP7TqTwCT2SIXIhg4Hi/kPW+63EiiRHqTiJhox65mOsoM4Z1MIOfph
	 N6WTcGLFc8Bgi3oL8wLwegXOAwgUdiwe5JkY4ouXfyPQ4SDXBSClIxo1vOGf2rmyBB
	 tKNrba6QVhnBQPRazxQ+dQ3DEhbsvSg25qkKCP9BFsK8vnrAhXtRBiAJOy4JjSNDZO
	 AwFn/9mHXkVBsmeABKwCXqH0MgATmeSEWSSseZmytwpg2AHLIYYw91rK1o7a1thB6c
	 w3XlBozi6BDUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26B7F9EDEB;
	Wed, 22 Apr 2026 14:46:23 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:37 +0100
Subject: [PATCH 03/22] dt-bindings: iio: dac: ad5696: rework on power
 supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-3-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
In-Reply-To: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=1859;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=1236hzCkqKqmziCwLICDAiFEWcH70pEVjQM4fWoD3cE=;
 b=KGaW/CCBXk2IGuhChc+a7r9Q3nj3yr2KhBU0eKijuxjA+L0wfzFYJc+djA7P8NGETkdonjbZ6
 EzDN00+ByOBBXSxflMJZMnLaGqwfgI+8OjTA5rYHYD2D0rMqfM3c3fw
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add supplies for VDD, VLOGIC and VREF input voltage pins. The vcc-supply
property is deprecated. Certain devices require vref-supply to be
available once an internal reference voltage is absent. Still, this patch
does not add those as 'required' so that the ABI is not broken.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5696.yaml     | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
index f286e5072abc..21b80fe597d1 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
@@ -38,9 +38,22 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply:
+    description: Input power supply.
+
+  vlogic-supply:
+    description:
+      Digital power supply. If not supplied, it is assumed to be the same as
+      vdd-supply. VLOGIC may be hardwired to VDD in some board designs or
+      internally connected in small packages.
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
@@ -88,7 +101,9 @@ examples:
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


