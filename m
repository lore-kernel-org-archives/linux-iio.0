Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED521329E7B
	for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2026 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494189; cv=none; b=R10UaMvB8MYUORx/Q80Y50utrf21EEtbUXGoM5UuUJkvlliJ8Cjf4nekMNqU7HTBM7XsAvRiRmSt5jfBdv3JCZ6GdmomM0KDcv5xA/YCGFxtumqG46cje4sVZxnwz0TnjjfKdJiC6hUIZ8GwZfgdrp4MAfJ3PVt2ZD8NlelXPXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494189; c=relaxed/simple;
	bh=tlOEm1BPNblfpRZaqxme09QCM+gvLrWtWYFzJqX7T/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSZZ/Savw0Dz2OqU0ZWqNRtHpRPC0phXbHuq20uA3NvIYyGAeJg7ZJ+EcbOdSdVUaN5OOCs2AMPRoou55kHkczvHmxNvDsLxwjbJQztPdd3qJq7xD/SSxHV1bfXS+8EoLNIDyuw1x+6EnpwVGK6gcev3Wqmoq04xPs+6i8Mla0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGk-0003pZ-0D; Tue, 27 Jan 2026 07:09:42 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGj-002hiJ-2s;
	Tue, 27 Jan 2026 07:09:41 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vkcGj-0000000GQEt-0aHo;
	Tue, 27 Jan 2026 07:09:41 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: [PATCH v2 2/8] dt-bindings: iio: dac: maxim,ds4424: add maxim,rfs-ohms property
Date: Tue, 27 Jan 2026 07:09:33 +0100
Message-ID: <20260127060939.3914006-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127060939.3914006-1-o.rempel@pengutronix.de>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
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
---
changes v2:
- make maxim,rfs-ohms a required property as the hardware range is undefined
  without external resistors.
- add allOf constraints to enforce 2 vs 4 items in maxim,rfs-ohms based on
  compatible string.
- drop explicit $ref for maxim,rfs-ohms to fix dt_binding_check warning.
- update example in binding to include the new required property.
---
 .../bindings/iio/dac/maxim,ds4424.yaml        | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
index efe63e6cb55d..400afd8771aa 100644
--- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
@@ -27,9 +27,44 @@ properties:
 
   vcc-supply: true
 
+  maxim,rfs-ohms:
+    description: |
+      Array of resistance values in Ohms for the external Rfs resistors
+      connected to the FS pins.
+      - For DS44x2 (2 channels): 2 values required.
+      - For DS44x4 (4 channels): 4 values required.
+      Typical values range from 40000 (40 kOhm) to 160000 (160 kOhm).
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
+          minItems: 2
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
+          maxItems: 4
 
 additionalProperties: false
 
@@ -43,6 +78,7 @@ examples:
             compatible = "maxim,ds4424";
             reg = <0x10>; /* When A0, A1 pins are ground */
             vcc-supply = <&vcc_3v3>;
+            maxim,rfs-ohms = <5100>, <5100>, <5100>, <5100>;
         };
     };
 ...
-- 
2.47.3

