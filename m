Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC0325492
	for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769355623; cv=none; b=LPusQRtwt9o1VuxddagGBFwAKLs/HMc8neUVYXm8oo6YfJVN1pvGq9cNByhjO/J68V2b5mwYhV/wtxiCQr8rtmSy40Gje8BVfh1ZwUuEOgejxTq1cfuxSWsu4ks9R3JD1mtTT6D6rq/SJXOBCXJcT0TagEw1yRPTwAlHsG5wm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769355623; c=relaxed/simple;
	bh=E7A9c27yUqkUqACBSnmKRI2cuBoHgawSFZnfB30gBd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe+HxcMsz/DJalOOrbxdi89J+ZjqXhUuS+j+04iYuAZp/B6ezMZI6Rs16DORY6j/EQOVY/WCAR569QGSjvxGOX4dy8QfNAOdeSDoAP33ijlmAKi43rJWJSrV2qpBkcqgjzE93RsZx1oJ6wU/RZ+NAedxSuEu5vrgMtoRxKUzV2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYTaenmA; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYTaenmA"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-65378ba2ff7so5709095a12.2
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 07:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769355620; x=1769960420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opwAzXZXGpL/t9kjdWql8KWUaKqEP4kujq0iT4W20S8=;
        b=AYTaenmAqz9E8AV43AgMQ4bN9xuJYoWkVssL7AUvz2q/rgtp/CVusBJu7rD2oWVETj
         6nQYpcIysbVZxg7v2fR5VT/RCOIjrnxCnKd01o91M84yKKf9v6NY7iTSQ+cg9pN5BsZ6
         L7oc4qb019GVkhitINJtxZsKI9gKExV1/gpK6xUm3GL94aRWCh7jH0g3vPaAKHOCE1Hm
         YT68YIIL7DzklZWOKpKJ7KBd8w/zmQVweW4+xovO9EekZOHMkbNsmxi/aRIm41LPSHpw
         W85lIwYFQYDdbUN3p5A6nYiZZBo7HGzuWcsBOxOE7nM3dvyyCwyqWMHaOI6zc7aoi+UP
         0rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769355620; x=1769960420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opwAzXZXGpL/t9kjdWql8KWUaKqEP4kujq0iT4W20S8=;
        b=gZuaCodHFxsuGlAH+RxBTR33ctbFL1FwE44QC73xu5Feasl0ELUfewcV9bjk21YxsY
         7FTJsc08panvX4ZNuVYBh+hdztrd2jJW7wi08kNm7AVGBHpZ+Bs5PVybBM7ibW7UpHUL
         DLX/3KNKeuy3EC4oB8mGhjIJgUIcFxJqnd6Fuq29/7hos2Ra46CzElCsrlAiAyi2y+ST
         GtfFJ8Z1TYfUzqKif6AwGj6IWZmW9G/jSDKnMSc9YXQd2jcOdQROrQGyxPQmi8wuSof6
         3JNffv6V7XIdLuLrE68RmX5IbRGwIizRYAuA4O3PpoxNq4ttrs5wRPqlxWu3Z7tH5nd3
         4MWw==
X-Gm-Message-State: AOJu0YzsikK1hXPNILZT/A1jiCHfm4q/gdXGCRahi4CRqP/OKEyWG9Bh
	MkQ2+qSa0d7WSWHk5Ax8D/scERXeA/UZQw9nOUVnaRMKRBDflpuzSL5s
X-Gm-Gg: AZuq6aKYd/PQhT/KQuES6+Ej8JW7nfHdJQ5DhbPp3nMtn/G64/f3PZK+NFxBNr9ouv2
	nftmJz1cToirPJhT4FqtGRhW3iml7hyGc5GE+2z0EbPFtWUmIgl+AM2X+Ro0jvZtxpyNI4vaipa
	AqEis6IXGqQP9UBKHwPG8JZezjKG8gnmNb+4E7v6/c3UDaGds7s3D6nn/qnZ6Po1pF1QyUT1I6p
	DCRTLeE6z2bO2YOe6C9VLK3URfncoSZSikLghPrLyB1Fw6NEUnD+ZnNtZ2mOUR2ZeBietw5qsgK
	Vh3pcQUwjsD4mzTjDbLAhsgIVcM8i44oQtwrJM1TkaWK/vNlofGVuYJz1UUZ3D/KMCiD8tnjRtP
	Cv0cgo4vBNTit92/ZnRYXbMOHkKVdDxGX2N5jWq7LuZ3zuQXx8c9LlJj8xxL9mNfUD3QXDtRiPB
	izc15Sdk4qmtQ=
X-Received: by 2002:a05:6000:2483:b0:435:bdc0:48e9 with SMTP id ffacd0b85a97d-435ca1ab666mr2383866f8f.55.1769348600123;
        Sun, 25 Jan 2026 05:43:20 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm22459688f8f.10.2026.01.25.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 05:43:19 -0800 (PST)
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
Subject: [PATCH v1 07/10] dt-bindings: input: cpcap-pwrbutton: convert to schema
Date: Sun, 25 Jan 2026 15:42:59 +0200
Message-ID: <20260125134302.45958-8-clamor95@gmail.com>
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

Convert power button devicetree bindings for the Motorola CPCAP MFD from
TXT to YAML format. This patch does not change any functionality; the
bindings remain the same.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
 .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++++++
 2 files changed, 32 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml

diff --git a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt b/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
deleted file mode 100644
index 0dd0076daf71..000000000000
--- a/Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Motorola CPCAP on key
-
-This module is part of the CPCAP. For more details about the whole
-chip see Documentation/devicetree/bindings/mfd/motorola-cpcap.txt.
-
-This module provides a simple power button event via an Interrupt.
-
-Required properties:
-- compatible: should be one of the following
-   - "motorola,cpcap-pwrbutton"
-- interrupts: irq specifier for CPCAP's ON IRQ
-
-Example:
-
-&cpcap {
-	cpcap_pwrbutton: pwrbutton {
-		compatible = "motorola,cpcap-pwrbutton";
-		interrupts = <23 IRQ_TYPE_NONE>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
new file mode 100644
index 000000000000..643f6b2b1f13
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/motorola,cpcap-pwrbutton.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC power key
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  This module is part of the Motorola CPCAP MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml. The
+  power key is represented as a sub-node of the PMIC node on the device
+  tree.
+
+properties:
+  compatible:
+    const: motorola,cpcap-pwrbutton
+
+  interrupts:
+    minItems: 1
+    description: CPCAP's ON interrupt
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

