Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19127425CC7
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398959; cv=none; b=mx6Y/rGl4mGeloXYO4FeOxy1etMLo174cm+nC975R/71fpWkbC+uRPHJZe5TtEzlz8tu6iP2fqDBfXzK8v0hyWo4TJWoVWX9Dp9hHZN1ACFto3H5bPbZfoFL5VC3djrvPdyKOf5b/fNjXvcW7yx1iUBYn1bCpFIJDqlAG6Zas0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398959; c=relaxed/simple;
	bh=DrNGeBlRxTjZoXBtwt3WHPiWKByZ7OZ+6oYAQENqEx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtTfNd/sbrWJZSBUyUQS/2Sx5XBDwyRsdySdHwaKjuSq2qJLFx3u3gLNRZakKm8E1JbcL7/rnA3BWz+VkLETz9Iw0hqZ0Y3j+6Q93hLTzDWDL0H3zaiUjX3A32uJP/EEsZxU4MJg1NBTOajtvteuoLFmFkYP2Cjg1OAmhuNbaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCwh3bIb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCwh3bIb"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4362507f0bcso1336248f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 09:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398957; x=1771003757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFT7mMG9k0k/BXen8CQg8hnB8vdYe60xOPZB+uYBrVs=;
        b=KCwh3bIb//zvZ6x8Eeqi5oW96xjKRphn+S3INdExR7uEdNzwn+8MXX0oKYd/fWC+Pc
         Ldsig3m7gudUyEkHw/2hQrq7aolu3ph++Fcx+xFeoZHvft9Bddbe5vvl1hjB34G2jX+G
         nOBWK99hiO7EnOwJykvohpC30hcGmKqDtw9U41A+F6R/PaRQ/KfxIPzwagY7a0NZgOlj
         vzC/Kx1+VeBHwD41lAklcBc9vHqkMFZDk1Cv5kqy0Esrs5Y93r1ZZ3g9bXcEMVR9jocA
         VUww/ntgzXmlpM9hUn/DmzwDApcI5b/FRRJfalYKZyHVzOv5n9qQ3FpZKEmGWhYXgcSQ
         UbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398957; x=1771003757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFT7mMG9k0k/BXen8CQg8hnB8vdYe60xOPZB+uYBrVs=;
        b=Uisz0VJTIWf/RHAUmk6DDgCnCL+FwSefEhsvJ3bI2OMWYBVSgxwZKS93IZ+Pk3X+yS
         HQ8zo5tk2iUDfky/L58Onvcc83r5LJMsz9a/5YDApsQV1iCytA2OUAIkODFbYPoWXpO7
         w6Op/hT0JGuhOLsj33Caj7Vnqd+KKPoBrJTkqYNFaD+Wack/l1PdmzNna3ufrOKrdLIN
         EpcotsodwMHa5flBOOL0XSJZZuzjtBlla5YLxvU5ETAIfVDhKZq4R8Xa1KbrtJOdYyWP
         SUZYPZA20FAC/tqd7j5oV8IXQDoDeYPUVvaG/dew0zJKig8ic7Gvs4Gpox4YfIgILw1B
         Gcow==
X-Gm-Message-State: AOJu0YyKDm7cgNakMK32M/HV3MeNOLvl7iz1Z9cf50tkDuA9suVl3tq6
	vd3v5xHHSCSP6iCumiuHqqqbZJhhGv+GJsGqup6jAAvU9R02qlN3x1D4
X-Gm-Gg: AZuq6aIfQiRRc4dsqBBvJkAjEBJ9U9oP2FeIWXh/jeJFh5962uImPg6eGRTLw5oqoPJ
	SNN2sPPbcVtoUvA8o1NEWdg2HMcSKMgfnL0697dqhfp8fAAOOWErGhM4mZU97zd1w20vityyq09
	eVsffRYrKadJh/ih8A4hQfum1ykQun11d+ajKszSbYFF13dvDAfexrJwOkPUxF3/0qXQszy6nEI
	moxi2pLwGZ5sDA5KDOcqyuSUalEcfO7TKfhH28vOstP1YSyeTsz9LK5glqWaoArbUNl2jpQ0kwo
	/5O3HZbSDCuLA2xtMvz273hjRGLOs3F9fCb0XCvnCQwx8/uqEHL8OAklVkY/R+i6/yD4tG7iAHQ
	5gafogK8eGo+iVW+AS5iIY2CHVxYyKbJiByr7qhN5fu+H58rKZSk0NN7BwZHv3KV9hRWyR7DoXs
	yg
X-Received: by 2002:a05:6000:288b:b0:430:fd0e:a502 with SMTP id ffacd0b85a97d-436209c9865mr10673215f8f.22.1770398957349;
        Fri, 06 Feb 2026 09:29:17 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:16 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 06/11] dt-bindings: leds: leds-cpcap: convert to DT schema
Date: Fri,  6 Feb 2026 19:28:40 +0200
Message-ID: <20260206172845.145407-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172845.145407-1-clamor95@gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert LEDs devicetree bindings for the Motorola CPCAP MFD from TXT to
YAML format. This patch does not change any functionality; the bindings
remain the same.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/leds/leds-cpcap.txt   | 29 -------------
 .../bindings/leds/motorola,cpcap-leds.yaml    | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
 create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-cpcap.txt b/Documentation/devicetree/bindings/leds/leds-cpcap.txt
deleted file mode 100644
index ebf7cdc7f70c..000000000000
--- a/Documentation/devicetree/bindings/leds/leds-cpcap.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Motorola CPCAP PMIC LEDs
-------------------------
-
-This module is part of the CPCAP. For more details about the whole
-chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
-
-Requires node properties:
-- compatible: should be one of
-   * "motorola,cpcap-led-mdl"		(Main Display Lighting)
-   * "motorola,cpcap-led-kl"		(Keyboard Lighting)
-   * "motorola,cpcap-led-adl"		(Aux Display Lighting)
-   * "motorola,cpcap-led-red"		(Red Triode)
-   * "motorola,cpcap-led-green"		(Green Triode)
-   * "motorola,cpcap-led-blue"		(Blue Triode)
-   * "motorola,cpcap-led-cf"		(Camera Flash)
-   * "motorola,cpcap-led-bt"		(Bluetooth)
-   * "motorola,cpcap-led-cp"		(Camera Privacy LED)
-- label: see Documentation/devicetree/bindings/leds/common.txt
-- vdd-supply: A phandle to the regulator powering the LED
-
-Example:
-
-&cpcap {
-	cpcap_led_red: red-led {
-		compatible = "motorola,cpcap-led-red";
-		label = "cpcap:red";
-		vdd-supply = <&sw5>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml b/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
new file mode 100644
index 000000000000..c8e7b88a05cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/motorola,cpcap-leds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC LEDs
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  This module is part of the Motorola CPCAP MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. LEDs are
+  represented as sub-nodes of the PMIC node on the device tree.
+
+allOf:
+  - $ref: /schemas/leds/common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - motorola,cpcap-led-adl # Display Lighting
+      - motorola,cpcap-led-blue # Blue Triode
+      - motorola,cpcap-led-bt # Bluetooth
+      - motorola,cpcap-led-cf # Camera Flash
+      - motorola,cpcap-led-cp # Camera Privacy LED
+      - motorola,cpcap-led-green # Green Triode
+      - motorola,cpcap-led-kl # Keyboard Lighting
+      - motorola,cpcap-led-mdl # Main Display Lighting
+      - motorola,cpcap-led-red # Red Triode
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - label
+  - vdd-supply
+
+unevaluatedProperties: false
+
+...
-- 
2.51.0

