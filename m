Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA8396D3D
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111283; cv=none; b=U5W9f1N55Gqfuzj0ZWxOxsQ1uGPF1RAEHewLFIcZmzGsFWBtiAid2FQLgmbKDm3OiNGbpiPpAJz0IOe5/N77v+a5aMM6eoe2QmIFHnDIByKcqL86eyvDnXU4MZtU5aYq1Dq1U71WDeyyzHiyj0otIzGK0acetuJHndXBhzC/3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111283; c=relaxed/simple;
	bh=I+KR3587GayMS9LYDAZmsoHVX1w+4QoBrKCV62DQFF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGxAmIp3cw3vsEnj56SprTii15jwvlbnp4B7islfPniljx+0quFoBOttAiW53m2gyHXeN+tEXh2Pk3jMWS2bRD0zHURLBHt1Kg563V5Ko+vo6PklscrCUw9iOCt3DCp6Oqqw2UNRg/5MZDjE7ezFJxXK2QvSESkkUSMN+4Ut9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-0003lg-SL; Tue, 03 Feb 2026 10:34:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCns-003slh-0J;
	Tue, 03 Feb 2026 10:34:35 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vnCnr-0000000AhAe-1DHG;
	Tue, 03 Feb 2026 10:34:35 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v4 12/13] dt-bindings: iio: dac: maxim,ds4424: add maxim,rfs-ohms property
Date: Tue,  3 Feb 2026 10:34:32 +0100
Message-ID: <20260203093434.2548978-13-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203093434.2548978-1-o.rempel@pengutronix.de>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

The Maxim DS4422/DS4424 and DS4402/DS4404 current DACs determine their
full-scale output current via external resistors (Rfs) connected to the
FSx pins. Without knowing these values, the full-scale range of the
hardware is undefined.

Add the 'maxim,rfs-ohms' property to describe these physical components.
This property is required to provide a complete description of the
hardware configuration.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
changes v3:
- Moved minItems and maxItems to the main property definition
- Refined property description to state that values depend on chip
  variant and hardware requirements, deliberately avoiding specific
  "typical" ranges to prevent unnecessary hard-limit enforcement.
- Corrected the rfs-ohms example to use a plausible value within
  datasheet typical range.
- Removed redundant constraint definitions from the allOf logic.
changes v2:
- make maxim,rfs-ohms a required property as the hardware range is undefined
  without external resistors.
- add allOf constraints to enforce 2 vs 4 items in maxim,rfs-ohms based on
  compatible string.
- drop explicit $ref for maxim,rfs-ohms to fix dt_binding_check warning.
- update example in binding to include the new required property.
---
 .../bindings/iio/dac/maxim,ds4424.yaml        | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
index efe63e6cb55d..4323df2036ac 100644
--- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
@@ -27,9 +27,43 @@ properties:
 
   vcc-supply: true
 
+  maxim,rfs-ohms:
+    description: |
+      Array of resistance values in Ohms for the external Rfs resistors
+      connected to the FS pins. These values determine the full-scale
+      output current. The actual resistance depends on the chip variant
+      and specific hardware design requirements.
+    minItems: 2
+    maxItems: 4
+
 required:
   - compatible
   - reg
+  - maxim,rfs-ohms
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,ds4402
+              - maxim,ds4422
+    then:
+      properties:
+        maxim,rfs-ohms:
+          maxItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,ds4404
+              - maxim,ds4424
+    then:
+      properties:
+        maxim,rfs-ohms:
+          minItems: 4
 
 additionalProperties: false
 
@@ -43,6 +77,7 @@ examples:
             compatible = "maxim,ds4424";
             reg = <0x10>; /* When A0, A1 pins are ground */
             vcc-supply = <&vcc_3v3>;
+            maxim,rfs-ohms = <40000>, <40000>, <40000>, <40000>;
         };
     };
 ...
-- 
2.47.3

