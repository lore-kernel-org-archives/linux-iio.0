Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861BA27B353
	for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769354875; cv=none; b=YLV27UnALoJ+nCCyovIXZAYuLjTmF9Ff9zI4lFsjPU1tcy+MjUdLkAex9wsMKP/A02aQ13O79pwWS/y6g3cDK23GCTJyBp8rJLcccgZfBnD0egogyez5vh0GoUjea9oYuKMMbF5hUCYmsUVAPFtdFrXdpTp2bwmGO4Of9+4QFsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769354875; c=relaxed/simple;
	bh=l9NQa79di/jjOBPV+OqER4b7B0YtHihmaNsEeJfrOXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WE2umM+4vep7BNj69mmES4TQ6QkkQZLmM5v8NweTtOkIGRcIQNGwgKoK8tIUvLKvtWqWRww6BYHTwz8JGb1f16oa11xVTqSl3cDlsX+C3dUWu3QLMJQL4YczqU2jLJWLBa8psj9JDbxXcVdBVfIvwKCoFDs+SksgD2VulIPqzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjvGddzo; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjvGddzo"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432d2670932so3436783f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 07:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769354872; x=1769959672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlJduHNY4/ATTPZTxaM+BbgtP/PXXrqKo+1qMJ4eq2o=;
        b=KjvGddzoEO+Zt4XXfZS24+ZfcLjDGDzBqd2zsgRM6GOmCpIBV8V7gCJ44QhFRQDuVl
         i49avi+so+ie/C/m42gSA+6QVDk41jWgVSgdPmFtDGuuSiFK0Fp9OFAvtTPzNP8Nx45U
         HbO95ZnmEvApeTXDTrH8uQXDghA3+ldPpicgsUFidLhTE0lXi17BlzEvRU3Cj1m5W2NT
         RNv2icQJjLnx0Uc94LSEuGkQgpk/fpfsNUNAOIenx/tT7zwgPdyPiEGyuvwn2f6Um4BX
         tH+3tpJ97Aav94NbQnANbV45EbN6iD0rbir1tjkScyRfYn+8nPUR+1J8C/PRVLtYtNY5
         lOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769354872; x=1769959672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IlJduHNY4/ATTPZTxaM+BbgtP/PXXrqKo+1qMJ4eq2o=;
        b=rAu9Thck9wEMD0f9j9lIxMXFLekbdVroIlV+g1JbiBaqrDSWy5FeFRUBD2wZ9/J9C4
         qclW9zA53nGDIKD0QPxxnK/T4GupeK8KQeRauw6LQjnSE9zp5pLJU7n/7sUM1V0CpA+m
         jHmQYoHucoMpC2/aLnoT2tuSB2rrz/XzJntFc66lbR1KyHfdHh3YFG4qd/sqwUwLlk0X
         ytss3Vxq8Df09We9oDRRPKl26kTz8K5Uhz0Xs8bGIwrTeEa82gikorZp4GcJ7RFR4FF8
         gIlfd4JaY9upzp5tYSmt0mozpxEsMGhscVbHOkMju16bCFal9sli4JZA03+DjQthicUZ
         01Gg==
X-Gm-Message-State: AOJu0YyYRg1BmMxxmcauW8VGszbhe1qqc/4Pbpn9fa7fiXq8WJC5u3rR
	W+ZI6ZUlLm8bcy05iyoHtUAFKXOelrttXZb0MsSOceM5kMzFDGEhk5KBUKrEmQ==
X-Gm-Gg: AZuq6aJzaYZIV9iPWWM4cEsifqv0OC/C4w0Cs8MK5NebtVdswyjGLFRlvCr4VmIxvom
	TEzzyXgp94Oz+msS5PLfvk9g0qCojoCGGJFp9CK12bZPUZ1CEkeAcmSb80VYvil5xf7gLl4Ixv9
	6faNH8ZYg+SMETbV2jo+5X2uofH9/aMd5sxNNWAPjulsWV0Tp9O3nkH5aQ1Ydb4RPPtSI9zC9RE
	BP5/EIzkvV7knCo114t5DH6zs4FjSJ3QxCox04VeMlWZ12I31CyhVRYHvt2pE0ZLMvTm2i+1grM
	83x00DblNWNonyK2Gvc7ZZEAJ05hrZuUw4UzVEEYLRs3ZXww3CYRTvVzMtqAZdMkLETh5eCsPY8
	eC/C6zYDEDV3q4kyQMLW0BQ9jw6HThYEVWaS0qOrPuW/BFs6xtGzOqE9IMf84OHmto/MFwBQLX9
	yM
X-Received: by 2002:a05:600c:4f43:b0:477:a54a:acba with SMTP id 5b1f17b1804b1-4805cf5f2b9mr31969485e9.17.1769348592595;
        Sun, 25 Jan 2026 05:43:12 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:12 -0800 (PST)
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
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH v1 01/10] dt-bindings: regulator: cpcap-regulator: convert to schema
Date: Sun, 25 Jan 2026 15:42:53 +0200
Message-ID: <20260125134302.45958-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125134302.45958-1-clamor95@gmail.com>
References: <20260125134302.45958-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert devicetree bindings for the Motorola CPCAP MFD regulator subnode
from TXT to YAML format. Main functionality preserved and added compatible
for CPCAP regulator set found in the Mot board.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/regulator/cpcap-regulator.txt    | 35 -------------
 .../regulator/motorola,cpcap-regulator.yaml   | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt b/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
deleted file mode 100644
index 36f5e2f5cc0f..000000000000
--- a/Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-Motorola CPCAP PMIC voltage regulators
-------------------------------------
-
-Requires node properties:
-- "compatible" value one of:
-    "motorola,cpcap-regulator"
-    "motorola,mapphone-cpcap-regulator"
-    "motorola,xoom-cpcap-regulator"
-
-Required regulator properties:
-- "regulator-name"
-- "regulator-enable-ramp-delay"
-- "regulator-min-microvolt"
-- "regulator-max-microvolt"
-
-Optional regulator properties:
-- "regulator-boot-on"
-
-See Documentation/devicetree/bindings/regulator/regulator.txt
-for more details about the regulator properties.
-
-Example:
-
-cpcap_regulator: regulator {
-	compatible = "motorola,cpcap-regulator";
-
-	cpcap_regulators: regulators {
-		sw5: SW5 {
-			regulator-min-microvolt = <5050000>;
-			regulator-max-microvolt = <5050000>;
-			regulator-enable-ramp-delay = <50000>;
-			regulator-boot-on;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
new file mode 100644
index 000000000000..b73d32a86904
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/motorola,cpcap-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC regulators
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  This module is part of the Motorola CPCAP MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
+  regulator controller is represented as a sub-node of the PMIC node
+  on the device tree.
+
+properties:
+  compatible:
+    enum:
+      - motorola,cpcap-regulator
+      - motorola,mapphone-cpcap-regulator
+      - motorola,mot-cpcap-regulator
+      - motorola,xoom-cpcap-regulator
+
+  regulators:
+    type: object
+
+    patternProperties:
+      "$[A-Z0-9]+^":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        description:
+          Valid regulator names are SW1, SW2, SW3, SW4, SW5, VCAM, VCSI,
+          VDAC, VDIG, VFUSE, VHVIO, VSDIO, VPLL, VRF1, VRF2, VRFREF, VWLAN1,
+          VWLAN2, VSIM, VSIMCARD, VVIB, VUSB, VAUDIO
+
+        required:
+          - regulator-name
+          - regulator-enable-ramp-delay
+          - regulator-min-microvolt
+          - regulator-max-microvolt
+
+        unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+...
-- 
2.51.0

