Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E761F3FED
	for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769355864; cv=none; b=Ns+1DaHIrNKIt957Du9hTd5hEFYm1vrHgLbvAi/FWu+S5StIg8T9flbtOYZZY0fs2GAsLuPseEOUEJFEsCy4TG+BsRTx8UcN9PAkfekBRtfXSvZ5VR8Po8U92nITkXNKvHT1RbtlotEBOkbTR2nVZoJafNgsIF7qIZqHavmTjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769355864; c=relaxed/simple;
	bh=SNf2NU+hs+ZIS4XXchD9gc1LEk0khnpy5wXM0ouJBNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VISa/6fNlzwNQ6eNmf5l5xKvS20iZwO9nXPbMj30JbXV73D41BXztgTLLVBZl0doXSCwgxbTgen2ABN7l200zUHsx5RnZDECS09FRQL3uz2p/cJI3ZAnoBqrJlRXF2SIQ6KJFT8OpDLlKCeaCmXRUUXTZ0BPHFq0O7j08F1IKyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiw0dCM/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiw0dCM/"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b6c89d302so3674178e87.1
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 07:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769355861; x=1769960661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXpwpGUeOVZ6gd5Z9uZtu+VcPr504HYG8KCye/qyxZo=;
        b=hiw0dCM/o3BSyBoYWch5fD9QRXr/JQFwp6eOCm6a20Cg4/IDX2YK4DTNUcfTYN743J
         YfAk/gh5gt1XYjRBtUN+bh/1DoxsluMTkGDVb8fxILZ5l6wwZ7EGBFiVC4MGWdTr2t3N
         mYlRL6dpLfli4ihMTqIw4Gg0/BS4H4U5iJKkqmP/6wVIxhp7wIuqrYZxw9RvSR1M2WWA
         GFHil67B7IWQfxR7YmKMm0XMopxsogbkMd0BSeDVENJBpqoMhQhXd8i1BL8h/QnfxZf4
         tmTZXv5mPStcTc2SH1c4QScVEtCBOYLdreW0rKy2TrYI5Eukgo4q2yupMlwtbwkef4Ds
         pW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769355861; x=1769960661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXpwpGUeOVZ6gd5Z9uZtu+VcPr504HYG8KCye/qyxZo=;
        b=dse+1Dea9h22O9S4X2/JGSp78YqgK513skmI7dQN0AjbU0MB24Wof/1Vzj9ExrYjfl
         vcKHvf7tLJmwcj2AZehFBRUgOwm0xk88V/Uqpkr1f/cpoNYWx39yTNuv+2gtfX44mWbA
         WvJ4tXKgNQetFUFgTKSSqOAzkjEbUU2yhQt7yvhqBiDHSMETAzm2Wri0abYwRD3cbEYZ
         BRuncm/tnra7ugMNPz9HLdOz0cyykt5XzpTWs8FHJNGzKfddV7JF069nzOrfW9xXTgCt
         pWF6OVVSP9lFKVQz1V4iBki4G4jY2hDuAk6rdRctwRa4Q45f4rFhzt5Pq+xiO9YqX2hq
         6nLA==
X-Gm-Message-State: AOJu0Yz3HLKlKNUjUoSXzGWpvT4YKYqjlIrBxr3NHN5JeEfF4/zKYvS1
	jvMo5xEdLHJ004EzV5o5vLt7f8LcpRd1j3jJlmfUs0iPVOfrUXmIVVZR
X-Gm-Gg: AZuq6aKNl9ckAieWOSI1WgndljXUCJwWQIQ4RbR3fn4rTJCK1rkmplkm0UZTz69SUUS
	iyGOqndaWODK/S1w3MeyFhZyc7pigeJaczV+Ck7Hgx/4i40zwygavh5Dh2d+zpCtGJth4JmfSgq
	y+fAgEgMOUv/CIRaJaFK0INwjuOJL1ntdwgK1ou7+Lw1nacGv+oxdgsfgwhgIYQIfpeC29rwdOr
	/Fg2aUyFCVRXtMWClQCdyO3I07IoKqe5nHb5K7G/eYfKCsGffElTnSTIlHlTowqcbyz8HT98qaU
	yNfkcFkH5U94KfWJAbc1aLrAoNzeDuU0jBF21Pzn7U3RgRP83ZdCvLYNJU1Ie2Sp94bs+LNHVZU
	3I10WHIx79XB/DwI5FsrgdypHwCYsLxq3P7b63DOtbRXEB6rZsXxiK2cyYrhry4XUtx5G2Goxd0
	qBk5hbBvoQwV8=
X-Received: by 2002:a05:6000:2403:b0:430:f97a:6f42 with SMTP id ffacd0b85a97d-435ca39c59bmr3398601f8f.54.1769348598831;
        Sun, 25 Jan 2026 05:43:18 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:18 -0800 (PST)
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
Subject: [PATCH v1 06/10] dt-bindings: rtc: cpcap-rtc: convert to schema
Date: Sun, 25 Jan 2026 15:42:58 +0200
Message-ID: <20260125134302.45958-7-clamor95@gmail.com>
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

Convert RTC devicetree bindings for the Motorola CPCAP MFD from TXT to
YAML format. This patch does not change any functionality; the bindings
remain the same.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/rtc/cpcap-rtc.txt     | 18 -----------
 .../bindings/rtc/motorola,cpcap-rtc.yaml      | 32 +++++++++++++++++++
 2 files changed, 32 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/cpcap-rtc.txt b/Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
deleted file mode 100644
index 45750ff3112d..000000000000
--- a/Documentation/devicetree/bindings/rtc/cpcap-rtc.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Motorola CPCAP PMIC RTC
------------------------
-
-This module is part of the CPCAP. For more details about the whole
-chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
-
-Requires node properties:
-- compatible: should contain "motorola,cpcap-rtc"
-- interrupts: An interrupt specifier for alarm and 1 Hz irq
-
-Example:
-
-&cpcap {
-	cpcap_rtc: rtc {
-		compatible = "motorola,cpcap-rtc";
-		interrupts = <39 IRQ_TYPE_NONE>, <26 IRQ_TYPE_NONE>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml b/Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml
new file mode 100644
index 000000000000..bf2efd432a23
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/motorola,cpcap-rtc.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/motorola,cpcap-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC RTC
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  This module is part of the Motorola CPCAP MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
+  RTC is represented as a sub-node of the PMIC node on the device tree.
+
+properties:
+  compatible:
+    const: motorola,cpcap-rtc
+
+  interrupts:
+    items:
+      - description: alarm interrupt
+      - description: 1 Hz interrupt
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+...
-- 
2.51.0

