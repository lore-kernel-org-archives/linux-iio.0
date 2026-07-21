Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664246A61C
	for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658286; cv=none; b=SVclvSkTm9nZR3sqe33SNKW6jCjc4eolPhblfHrVAzdqYVpVk0NFTb0p4GFxfAfaXbNH20hcfhTQpgjwH58AA/5FNVR6/fJaeQO1Y+hdQT9FXufulaeu+BtulmCzvxOf4u/dzReEf2I3AoPa0eLEp5zUi+zbdTe00AwVu4s6doM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658286; c=relaxed/simple;
	bh=PZeTCn4vfiOzIxtzUP6Cg4NPmVD+ay72/JvaXAZ39eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8ZRHXc/VzOT0g4/BvMPmL/gRK8OtR/G3pZA769Fkc1QgyOK0vdvmtvc7uvcMn0dK0wkjx2XHwvyO1wAZ+21i8BTg2K47fVoXK5hRArLX3LwOibRp25R43aDEmJ1FMHf9fFoJYlyE9cRQoi/q9o42UQI84CyFrejhO3D0stg3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cypSOEBn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cypSOEBn"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f707e5d75so1911543f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Jul 2026 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784658282; x=1785263082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ohyabsYXUEeH9CZfps7B4outocJBDW/m1cd73oaWqh0=;
        b=cypSOEBnqyUusLKG8Cu+jJsX6jfpCnEI/MSsrG5PNqJUvrAQH6r467FS34jZ71sZ7W
         p0hoV+fYwYkGcTPe/svbcBVU9pmCXBHS3MmQ7GFCp83E/eo7QWwWwt0sCdmTU5WUcp7p
         KMLjwDVY/j5sgCuxL2EFVXw0rgbjqEVqAEPPiSfTOU/k0p6n3lheo58kh4iAtTg4kF9h
         JHyToCmlFUInA80kLqsWKOhj4QPEvYd88ZC0Tyh3LTBHJw0CwWpW3/9qKo5em/kEVe5t
         1tPJTfvELrfsPvGIyZYBT2RQ2gGEJhimaOBZo+wJFoz8GoZj6jN5nf2Olas9gNNyo/rH
         jIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784658282; x=1785263082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohyabsYXUEeH9CZfps7B4outocJBDW/m1cd73oaWqh0=;
        b=SSFp5qXpmROUpOZ/kds45+FhtZQXIdXnx9EE9jtrM5jSZBhjpHhpf8n+9NgMlAYXnW
         N8uKoLhj8dNIn5UmkFg3orLrr4jnQhtbNz6fFXB+7kBXmpyXBJB2ZOlovEEZQWn2W1uP
         KxkfExfi//V8OBDdaI/ntiE2Q0YD/D0GR9uxvKjR+TIYOLa1//LJbETgbHyDLSF0Ugjm
         JRwLgOvNLdybElgKGLH81PnzpYgCmKLvaqyOp5Z04mVAkiJwCMMH1kGtCWCKnBrrl1fC
         leBNHjbYRyVQFXKWIVSnK9rKj+7S9TpqYDwcOUipCjsnORJCN7aD73UIK/RT10dnNIQA
         S0eg==
X-Gm-Message-State: AOJu0Yx6/6g3AyVLrr+qxwIQMPm61KWLqv6ywSMLyDU4ZH4EvM1NxabD
	LjawrBod9vi6JpHKJX5U/urrpBYCb3sKonM2zgZkHClzZZVTC5j8AoELD0XwkA==
X-Gm-Gg: AR+sD11yALqcNE2L8wNbSMHoHwaJPkov3KZ0WvK5934czZM9xsufck5voMDA8teY5p+
	CnhAe0Am4ffq7NtINn6SzcsllT3P4z5sNAJmmHyafRt1at0VK6a8RXgf+o4Qf53CKJcbXMM+wPt
	J04/I//XjeYpYgMC3yGDoHNEj6DsDdRMBfOF+l86aR+ar+lTMthz+5Sou4i4zervy3A0nwno1cf
	8G6xa/syxql0KIk9aprQ/f29IqHOe6sQShbgxaaC8jHNymi+jTDT6h443IK3gvz4b4YMt9FB7z/
	DRkSSz07YXlZHFpbkF4Epio0cDo5Kgen9u0bUABQsL59PMj2v928clGrAfKMDu/B5MQg+e4fqV0
	drzKWGz7XTx9rC4O3E6IusP2nHxpB3T0okKElKHH6UxXf26mRPv4xOFkpElYTV5wvrSEXUjeN4Y
	NUnrWgW82HDDnSF05Lz4DIS7q2F1uuZZTx1EFwBV4xqL9CjRrg7pjp90+AbLnx6516yHa2JsUvP
	p9KjAIwfpTRNPohfDzoH9vwvWuVnTQXQLyLjdXeCYsUoyDuHcMiWHelMXKT3HpQTb1Nja5vC43A
	54z0WyajzuMHV9z9oNi6S7INrVSc24vf/DycUWO0RnMqGvTmn+hmcy5TQk5GS0B8+p6WJVR8cv4
	CK1Yf3Sk5GnxAT6Y=
X-Received: by 2002:a05:6000:400f:b0:47f:8152:e568 with SMTP id ffacd0b85a97d-47f8152e595mr4627922f8f.60.1784658281871;
        Tue, 21 Jul 2026 11:24:41 -0700 (PDT)
Received: from [192.168.1.187] (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd1csm40835081f8f.29.2026.07.21.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 11:24:41 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Tue, 21 Jul 2026 20:24:38 +0200
Subject: [PATCH 1/2] dt-bindings: iio: dac: add support for mcp47a1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-mcp47a1-add-support-v1-1-da045a2567e3@gmail.com>
References: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
In-Reply-To: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784658280; l=2591;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=PZeTCn4vfiOzIxtzUP6Cg4NPmVD+ay72/JvaXAZ39eY=;
 b=GoXVBBA3rVZtCkVT6C+MiAV66zcR6c4ebeSsV4XVESuW14/ifqraymiESHNCA5hYmoaVvmSFG
 PQSowwYCwf7DG1J/qFpP0e+ZhEJNsqMSahq7Q9WzRzvIbxbG8KhEuKC
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converted
which communicates via I2C.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 .../bindings/iio/dac/microchip,mcp47a1.yaml        | 56 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
new file mode 100644
index 000000000000..3322fca03b3a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/iio/dac/microchip,mcp47a1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP47A1 DAC
+
+maintainers:
+  - Joshua Crofts <joshua.crofts1@gmail.com>
+
+description: |
+  The Microchip MCP47A1 is a 6-bit single output volatile DAC.
+  This device can have different IDs (0x2e and 0x3e).
+  https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/25154A.pdf
+
+properties:
+  compatible:
+    const: microchip,mcp47a1
+
+  reg:
+    maxItems: 1
+
+  vref-supply: true
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          dac@2e {
+              compatible = "microchip,mcp47a1";
+              reg = <0x2e>;
+              vref-supply = <&vref_regulator>;
+              vdd-supply = <&vdd_regulator>;
+          };
+
+          dac@3e {
+              compatible = "microchip,mcp47a1";
+              reg = <0x3e>;
+              vref-supply = <&vref_regulator>;
+              vdd-supply = <&vdd_regulator>;
+          };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2b1ec46c5919..b44693593b94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17699,6 +17699,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
 F:	drivers/iio/adc/mcp3911.c
 
+MICROCHIP MCP47A1 DAC DRIVER
+M:	Joshua Crofts <joshua.crofts1@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
+
 MICROCHIP MCP9982 TEMPERATURE DRIVER
 M:	Victor Duicu <victor.duicu@microchip.com>
 L:	linux-hwmon@vger.kernel.org

-- 
2.55.0

