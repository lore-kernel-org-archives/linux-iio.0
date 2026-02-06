Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C08425CFF
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398961; cv=none; b=Yel38AOhUHoULwbfwxRib4I3iRNaf1Dvgkm4OWBLE5BWJE7gkjTAUbD8mbpZkpLqDIVLl5rmqdKOiETrnaUoXeIuNcPKGO8YvlyWohcuK7yjll/HAXAm3FTbz4X0w46Z2Q5KSLXBABUuAMxhz6OG+rZTyjTJNcTK8d8HuN3QB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398961; c=relaxed/simple;
	bh=+xCYYkFGQ4JgB4ICZr6PyE2V+kBr+3lOCPplqVBjWes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgA89MlELskVqzCeu7f99KAr6b7Jd6WFyBfQf/9RpsRaN73SH3yhBZXJcGSzJAuMyOKzpbwuLAxfx58989/7Yo4kBS7a0y1xt6Ad+YoefY0I40cwVRaO7wAsEFG+bFDYKYaH+MzLriHDgKaXEx6JHA8Fd/emePd4DDUPkH3AzvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Riy2l0yL; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Riy2l0yL"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4362e77d7fbso506752f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 09:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398959; x=1771003759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLyVcjdxnN/By9KBCrGjy5x8Jg9Sn7LCgXxWdazKspA=;
        b=Riy2l0yLjmRwP1ulNGS9BVzMh/hEKtZqCbooYDKNdtnbQ0VQ8bRBTwHK8CxnJztbsv
         Lz/FJ+5gnMO9shXOrrKes9P2eIhryTUzzZ7NzJ24Se2FXx/PBSf9UM2M+6nJM1E5hrP7
         BOiXfz8edzIXP/HcRJr94XLm6TwjXLYOHezwKCd+njpvWA7z3DSsvDdmwpKZAcKUhn9L
         a2QbnJ9jvpvWV+YP7d4DxAIypNovWMP/qJvwnqNJ3N0yVhEoBRlZ+A+BVZTJz1U0uFdJ
         V9MUcmcERsmMnpY0jWr4XSQTUYRVdHJGsFh1JeE/hIhKGJp397+U6jDkoMSeGTJEodZS
         l/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398959; x=1771003759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MLyVcjdxnN/By9KBCrGjy5x8Jg9Sn7LCgXxWdazKspA=;
        b=DiLx2H6DuXQpSE2kCXxQ3cAlxzVLQZ/L7EIJFHlLBHy/w4RfAgBKxt1L0Q7YakQCie
         YRt4oLEqM7d1mVCZfgjR4ZmAvq+bAIBJqvRq7vi+Y1A1PbpU1ygTqCNFYTK5LB0AZXg0
         F5GmOXbREwlNlTBrtoafCaCDLlGHXh6qtgZSsadzOHtGCmRgU61PYNgQSxvanKJsXIeF
         mr+PN/Qq1fpKouyAbd66nvtdeUaQpoI3x4xSM3w4pjrP/YixLjfRCelmXBHkkSAN7tjU
         fe/qZBOEmSltaVuY2IVZkElIl3U00kAgb+rXSsGxvxm5pJ1VHjsz5e+WR4kaO+pMFKE1
         jItg==
X-Gm-Message-State: AOJu0Yyva27mP+LJl2gwJyhnpu6qqff5rjsguut0pS2zpP1MMEhTcnWo
	UOw05NuX8ALXwUF6n1D0Vm/1VJB8Jzpf2qJ7xlu/cNVqitJ55sIKGGSM
X-Gm-Gg: AZuq6aL2obdpH0LZShMiazmWjkfJzRCj2s/F+XQmvrly1HxXRuyZP3DydWbx0dcjmAJ
	qErgDI2jsDHAYttFPTkUr60cQ2vnXxcDtagIR4tILuL+ABwoy/BYusEDkRRJfZczjRVgeAZWV02
	rAe4yNJM4XzkzHZD/TeYUbNNJTHSBn80/vDIJLdIQHESfgRdCY/7x4OT2+dXd0HXsq7ZwH5Glvq
	7hFPnyOvaqROBHryKM9lbCus0bIwXec+ftBL1Phlq7fhvAEKuVYd4q+WNaTQXTyas1LclrZFQlU
	WTZH0IE1Waa6twwyDH45IipaVUV681ec/UINTG4qCg6Tu5EYY8ZaLCWggoxumnwayHvpSyrF2IK
	pDi3TRcEBUbCoF1mMo9rzJQXy2qmt0ZFogdgha0fW38Ft8bZhAV/uGR/xUaxHtjMTy4GIQINnU5
	/z
X-Received: by 2002:a05:6000:2485:b0:435:9ee1:f91a with SMTP id ffacd0b85a97d-4362938b450mr5960628f8f.53.1770398959002;
        Fri, 06 Feb 2026 09:29:19 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:18 -0800 (PST)
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
Subject: [PATCH v2 07/11] dt-bindings: input: cpcap-pwrbutton: convert to DT schema
Date: Fri,  6 Feb 2026 19:28:41 +0200
Message-ID: <20260206172845.145407-8-clamor95@gmail.com>
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
index 000000000000..77a3e5a47d1a
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
+    items:
+      - description: CPCAP's ON interrupt
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

