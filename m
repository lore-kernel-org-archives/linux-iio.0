Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F285324B1E
	for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769348601; cv=none; b=rUpL6b2OQGV46XLK81Zkez9M3F4xSHG8pV74GC5fmmjGIJKjcHjd/J6iLWwLNMjOnKzMriCRVwYimm0tFALlTW4cctcAkQ07Rzuy/cAFrpj8aI2sV6MXUsS5hsHZZdzwp5fmDsLMu1QuW/kjCOaYTKrZLfQljfo9XOZpbGFk9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769348601; c=relaxed/simple;
	bh=TtbHp+Kk6wUwswvK+4rO/i/ox+3QmSKSyODoCuFnZ/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uovibs17bw0a85Lf3O6qmxbjn08L2Sx7i7sd+cZU00myDJQ9zIHWEWSRNrELxd0kLlmB8AVOTllEAX0xLkDJ42lu/f9DmvHQOST/aM5QUVu87L7rJHyEIYmpBN3UdIs+8LaTs+qTdIseUzcJ/oukE9q5cdX3se+PWrTfIaitOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh0FJUmg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh0FJUmg"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4327790c4e9so2348235f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 05:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769348598; x=1769953398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KLM9Lln2ain+djx3Mr18eCyDfPocMjE7ubO1KrNHRg=;
        b=Qh0FJUmglEgpfra3T58ldRh1nZEdspecD2ob10GcHuy9Ub7TknwEOjSTbJVMxI03Hz
         dy6wTVRH36kJLJ54XvdvcbU1H1J+PFmCVEGUmXH4t7WxwppmjzyvA6eGkYVrFxcrF0/t
         c1PhWHm2vR2/j3KFTN4V66QIM7wEjJHjjiiqWfma7CAkR9jAcU8bMgAEahOvi3vqmWvC
         Ild/nI+ADWVWbuevYmCLkaRLTvPnrPLioKSthI9O/iwpWC3N78fSRnGxd/Q9eSIDN6X4
         MLPwB2DNHBfNecohoycyb265znFzAn5BX75RS2QQCgfldXR/maqeAu22MvL/r3jE8teN
         jBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769348598; x=1769953398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3KLM9Lln2ain+djx3Mr18eCyDfPocMjE7ubO1KrNHRg=;
        b=ZX9r6qHhILvkpWyqlgYfH+mQP1SX0c6xp6OpRKKcIwH2s/WB7s9FqK7FrCaKlRdP8T
         m7Buv3Om85ZRKZgVqlcPydFUOl6n/DS951AEiS36wpYSXoGIQMZoQKUqrpBBhbSZSAvS
         5FUeM1wh31oLojtiw7AQdEAfuCl6x4DbXM4LIaJbC59tlzFxkhwE6G23fCnhtB3N89Vv
         zCV1crVR0MhwqV8powdSB64iknwx0rX9a52JuGCPEZaxB92O7KZhXKP7YMvobccyxGGP
         PemhWLfMn+zuc5SR3o1GGmlX/CdZZAePudtq2YJR5B3mJ7YywkKvtgidec6oPd1BOFrU
         A0WQ==
X-Gm-Message-State: AOJu0YxRpNlgRgaDsYdz0jw4wHcUzq34no/2vVpS0cU3YqpRLwbTTkrY
	eCNwx4OPYPmzoeMzbhIBpA4APC/56xhyzflTeREqJgNzopOVR9BuVO1G
X-Gm-Gg: AZuq6aJJIH1z2QE9sRX1bT0+nVTqypqT+Cxt0anwEPeQ1/e3LDtDTKBfiyKAYKFsBsY
	km0v8z5NooHRsclnIBVx6j/3HoT3HS/2m8Ey/lX8IYtsJxHDw4t6S+hxfaUrxalxsA9yFm08BMX
	aeYJyJ8FC/pdqBmbd7wT+ui48vObA4cEZrKAqtA8pazltp9e73rTU/dtBy+3xmTW52eo6Dc1qNL
	ct5qpHJfuK0KhDtfykS0+bFhjZazQ9EkTc2kl41ssue6HccGrPcKV4FVwTEVWyHGeDdFcAi4CM7
	rRAzO+eZuryZRx0p22lQ8Lzww4yVvaLiZyMSIT/GOMb2Ljr3rVUNEQ8Bh56Bfn7KRhUII3zVM1S
	xiOe/qnLkKfnxLasPTsReM8/LVDdQi5Nul72XFFeLJf2WxD0ZbbylXOUR41O1KVReiJOqSGgZrj
	vX
X-Received: by 2002:a5d:5f92:0:b0:431:488:b9b4 with SMTP id ffacd0b85a97d-435ca0f9ca6mr2049590f8f.17.1769348597520;
        Sun, 25 Jan 2026 05:43:17 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:17 -0800 (PST)
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
Subject: [PATCH v1 05/10] dt-bindings: leds: leds-cpcap: convert to schema
Date: Sun, 25 Jan 2026 15:42:57 +0200
Message-ID: <20260125134302.45958-6-clamor95@gmail.com>
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

Convert leds devicetree bindings for the Motorola CPCAP MFD from TXT to
YAML format. This patch does not change any functionality; the bindings
remain the same.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
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
index 000000000000..8dfc98a1ef99
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/motorola,cpcap-leds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC leds
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  This module is part of the Motorola CPCAP MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. Leds are
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

