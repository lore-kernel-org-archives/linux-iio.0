Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84D1AF0BB
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778286510; cv=none; b=LunBvmUWCulDL357jZpZmnXzTwmD66aeBZcEb8Gmb29I/XOXn/g+zSca1tYqjTHd1bt6hLrIm5/F9j6PihOiNRcORKRh3smuzUTnxmvr32IImK/z3Cu7skSSfmFGPH1zkuioyuaE5iOhuWUVOLaOMV5C8tS+LKBPST6Op4+yXvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778286510; c=relaxed/simple;
	bh=krKCyrAKFIC5EL9Q1YnrE+uzJ56qyD1S2ilkMbdCeMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eB5s8TWLh7I5oDYg9AC0UZhlHN5j+k4cHhyKEADBMt3aheGf7Vp2hXGiVkjY7du/Ry0teuBXGXG8M10EuUCqDOx1IJ8JguP8nqNIUSfrCXCZUYomk9abFkjQY5TjS6Y+K0UxSK9FezhhlIaW8KlLm+c5XbOe4Iyr0Vr2YTp7XlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMYsCbeK; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMYsCbeK"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-130b2295ed0so7490017c88.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 17:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778286508; x=1778891308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDwIE60W0mXeu2WpR+wEI1Y9fvjpyHov5WakopHMXbo=;
        b=ZMYsCbeKRhZg/k39oSZxqV1AKMtlb0/aY4Vspe2tDI1Y2smIGydCO0ulGHr1t29d5b
         p5kmsRLvIFsOPk3pqbkUNpFfJ+2CC0aWxx2lqufoboUrQGYaeYFvysj6L3+jwZC9mtg1
         56uaYeWgOOi7WYjrftoTeQxu/cAvF/sRIwjINpX1Hb7StzacKL7RZYSdGM5HDku5OGLu
         etPuhdtC91r/4J5zsbOb8hmhT192zgpPJdZNHFVGJuA/dv9gBNb8MtgEihTMfOymjW0u
         sQYAIB/XFe4eHhHuTj4BzoKsD7QpoBpEKT58q+yqdK7Zz9+UYVFH7oMWwAoScYViVwl9
         296w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778286508; x=1778891308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qDwIE60W0mXeu2WpR+wEI1Y9fvjpyHov5WakopHMXbo=;
        b=LE7fpzzrlHUzcvd2cMN0sajq0BHyzL3RaCf1oxDXZTwi+QKgvoG3570YEnxpUGiyn4
         Qmd/+Sm4hmOufY0g9HKVpENf5qxbxWMrKwoznYOT8cNJScq9K2HgkXvMjeOozPG9ILzO
         V7hHrdDBfDd8fvs6Zta1TBcgpx1b9YUHgVd/Z/aTmJKduNsmFvCkaOoMuhrkyaQA3R+f
         /eUdY1S/sJOkwVuj0+3eOOkK6k1aOx6DQbzd5sb9kx+y6EXC9BUMMmEWcD7Dc+2KefMI
         ooKNFrxQ08HK+q4MoLn/HjthyyHXOQf/dylvbnHyu1w3xAR1Y0zEILWJD4K1B7+BRPsx
         VwEw==
X-Forwarded-Encrypted: i=1; AFNElJ/c+mJ9qV+braa6Gv6CvUkONXutVO92gSzcKm3xLUFp8i3+VGNfXGGXKwMVn+e1NrSInpwGAYaVEis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL2aFRJFSsUXcqglvZyZWmSyBcDwE+Eu28DWeUWDQ1we6nAYvW
	uFxKiNN5B6YxOoT+PdKFVxp+Di+M5/FqrAVD8U+Q5Esc5oz+x9a7OjUZ
X-Gm-Gg: AeBDietBSqO4cnHtvLCnAqeyWzbRUW+mCBKkoU/PN6Sxy0dCu2FJdEZJBQkP0fktrvg
	j5eqnKwVNUiSpu9OXbzsk6C9Ru5r4twHIUPJbgzS65Q7gZWvfun95nbAaCSkOqZUHDZLLeryOJa
	edjXvi/7Fj9I9VY4foPgEZCDm4MUQ2QszTJ7+sDkRdvApz67woY3hGgnrPRIGtMYpcWiYfdvuLB
	/Dzy0yfnd1yYg5adsQlPddJaEWnhmDt5X7Zf15uV7IAUD2rAl2jLSUf/pq3YdMuQIfP/3BBrVsl
	UMslLlyVGpCxz4CRQWGVzOpvFDJQ+KLn7pZE2sTMEfYA6+c87zgy40FcuUpfVuIolaM7ng5+uA3
	u0Tyrtf6jJK755X6Rdn80hFEuSh+rlt/jh8goi8DO/3Lr9dHMOqSAei4bosyJFIUdhEnFLH5YB+
	x7cB11zX8rBcMC34s7ulda1hvZUpUPXt/2lunQnrG1k8b8Ug36SPuUmzM=
X-Received: by 2002:a05:7022:1b0e:b0:12c:44a5:fb54 with SMTP id a92af1059eb24-131852d2fbfmr7892176c88.7.1778286508407;
        Fri, 08 May 2026 17:28:28 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327810ffb9sm5979234c88.2.2026.05.08.17.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 17:28:27 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2 1/1] dt-bindings: iio: dds: Add AD9832/AD9835 binding
Date: Sat,  9 May 2026 00:28:10 +0000
Message-Id: <20260509002810.78372-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509002810.78372-1-dennylin0707@gmail.com>
References: <20260509002810.78372-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding documentation for AD9832 and AD9835 DDS devices.

These devices are SPI-controlled direct digital synthesizers
requiring AVDD, DVDD supplies and an external master clock.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 .../bindings/iio/dds/adi,ad9832.yaml          | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml

diff --git a/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml b/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
new file mode 100644
index 000000000000..95b20ed4f9c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dds/adi,ad9832.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD9832 / AD9835 DDS
+
+maintainers:
+  - Hungyu Lin <dennylin0707@gmail.com>
+
+description: |
+  Binding for Analog Devices AD9832 and AD9835 SPI-controlled direct
+  digital synthesizers (DDS). The devices use an external master clock
+  and are controlled over a serial SPI-compatible interface.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad9832
+      - adi,ad9835
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  clocks:
+    maxItems: 1
+    description:
+      External master clock input.
+
+  clock-names:
+    const: mclk
+
+  avdd-supply:
+    description:
+      Analog power supply.
+
+  dvdd-supply:
+    description:
+      Digital power supply.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - avdd-supply
+  - dvdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mclk: clock {
+      compatible = "fixed-clock";
+      #clock-cells = <0>;
+      clock-frequency = <25000000>;
+    };
+
+    vdd_3v3: regulator {
+      compatible = "regulator-fixed";
+      regulator-name = "vdd_3v3";
+      regulator-min-microvolt = <3300000>;
+      regulator-max-microvolt = <3300000>;
+      regulator-always-on;
+    };
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ad9832@0 {
+        compatible = "adi,ad9832";
+        reg = <0>;
+        spi-max-frequency = <20000000>;
+        clocks = <&mclk>;
+        clock-names = "mclk";
+        avdd-supply = <&vdd_3v3>;
+        dvdd-supply = <&vdd_3v3>;
+      };
+    };
-- 
2.34.1

