Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FBF30CDAE;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869184; cv=none; b=XbXDkz5ZB79FD41e/pAKwYMEB2sBHkiBIVpLTLrqmDBUVx37uL7Rr7EXx+uBQNxXPPlYbEl1J5kOz5UtoEUSHcoiwfcy441sP0G6xjBTpq0DNQ+gOPLRtlqOAx8PKRz+sZM8DJvUF98pfxIxbjalM3v8Yj5oByAkUJd06sXWR70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869184; c=relaxed/simple;
	bh=DzIZnucRYUqqamp1ggNd1WrAaNj54va5kduJMehc5ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlteKhS2loYvS3Oqf487ua+0G1r+shdHQglin6EcnNqwy1TGsBPGD89LL04+3St4BtHYHCHLTsK16YUFcmYjOpAEL+LaxwZ4JholYKny58nvFOse5gyH5Yr8U255iZR25dRzOY3Ha2EqIfb37Ma5gutUx/7SH/BsDSTVjDqbDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNxQtq3P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNxQtq3P"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A36FC2BCC4;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869184;
	bh=DzIZnucRYUqqamp1ggNd1WrAaNj54va5kduJMehc5ps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FNxQtq3PZadoEV09tdAaNUUp+S7PABEoZiP3AtgXD+QjfoR6lk4XHHgcxojC8B+r6
	 M4r3ppVNhasJlpfh6FvkkiZ/CPkiDgtlm3iFpbRk5+YqOX+KaEu+JEme6rIeyqqSvS
	 Hw91A2bALLB3Cwy/OJxTjfA49gz6M+/FcIabPcnx9RprZmZGgaYbxChWqRTOMO4oPK
	 w3Koh/ScH2d5HPHbTWVSc6uYBNC3aJcLk9IsrtH65V4vUIe2Quikok5B03ZfZm/htG
	 08fSKb7JpgX/98zRWacFQY7N1NzrMyGKEMNMpRqCg1Ob8/zIammuhgyD9mUaFGqMt+
	 sUEVINONQseuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ABDF9EDF1;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:40 +0100
Subject: [PATCH 06/22] dt-bindings: iio: dac: ad5686: rework on power
 supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-6-ed7dca001d1b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=1922;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=9yk2gkX45ghKrgYSGht1grG7IvZtcYAKJWf3zLMMNP4=;
 b=dcBqGtLLVkbxf4wEq7VPlN9iVaG0HiLPdYiiUkS9NeZGHpveLr/vt4Lbdz7p1ltswxjyeDR3G
 nAN4LC5D/vfCmOzorRCWQNWxC15iFdmcs6icw4r37pUpeBeCcHf1FLk
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
 .../devicetree/bindings/iio/dac/adi,ad5686.yaml      | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
index 543ee181f7b3..3292d5190b70 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
@@ -40,8 +40,22 @@ properties:
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
-    description: If not supplied the internal reference is used.
+    deprecated: true
+    description: Use vref-supply instead.
 
   reset-gpios:
     description: Active-low RESET pin to reset the device.
@@ -89,7 +103,9 @@ examples:
         dac@0 {
             reg = <0>;
             compatible = "adi,ad5310r";
-            vcc-supply = <&dac_vref0>;
+            vdd-supply = <&dac_vdd>;
+            vlogic-supply = <&dac_vlogic>;
+            vref-supply = <&dac_vref>;
             reset-gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
             ldac-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
         };

-- 
2.43.0


