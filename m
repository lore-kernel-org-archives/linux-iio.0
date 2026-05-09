Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5482C21F7
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778293659; cv=none; b=IWPVOf3qNyB+kS6a8Pc6l+OznzL9/j0FRnLxFil+JNrcOiNx6ivTZtY9sK357N/NqR10CdU/zYbFLK5BHTP1Ynxng5ENCwww8xZLZ2/if2FPlmxWm3GX3Em+BblN5BZ7miJ3Sx2PGgkaNag4N12Skq/Jki4huo8yhnjiQuVFss8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778293659; c=relaxed/simple;
	bh=FsdW0xSERWjE0FiMpistTS4WOSSmY49coVvgl6iWZcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3yWX6U0ya1hco2MVSNWYY6Dg2xYFcPXHT+u/+MbfwoyArWA0/zVFI7up85uzvyoO7QZ5WjAxVUa6ri9aHA9WWy9zeaAj4G68tA3CyXLdR/2yUVQZ0zQpm8xmWXs5aoUIPjAf2bImZyKqVPzfgmWVBJf9ynSasti3VPOksZoetQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1SKj7Pg; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1SKj7Pg"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so6800070eec.1
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 19:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778293657; x=1778898457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddCrhD3GWsw1VzVrN+dsBIb0LRaCdnO2vYmJAaK5Vn8=;
        b=O1SKj7PghhCNiCXjQ8pNgU3WsI2DaKbejDEHgqfEIHVcHgSvVdfZOJP2hg9Oqv+rsK
         8/eH+9BYWlGIdCdsFWmtEOvox5CS+B2UNP5EyVfUx3yOdTDLKcZWuq1GrwY9nGZGmeJc
         O4+x99aXBu0pzYy4nW9P9r0pwVxJLxEvCkDRGioxiNBSnpnuk3AhgKQqgBGEUFnP3ORZ
         4reT+eDOuvuNXFCl//g4R0nRkeS5RytDBMUG49w+5IBiJTqYQfR5mcVr6iVCkmFwb16m
         IhCDoHLNNRoFCCiqq/LBwbrqQQvCIHQF5mlxcDaulzZXGxJ87spFkZxWu/VK7SUsJ7bj
         Yz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293657; x=1778898457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ddCrhD3GWsw1VzVrN+dsBIb0LRaCdnO2vYmJAaK5Vn8=;
        b=gmFDq/J046OPM5tp2rVvwbvaBTCUX/8MsCrz9AXUMv0X/hmdhtcGX7Z/oNsEFGKJTQ
         Ja20wYFttkjdH2k4VQZNRscGrgLOs8rWUemZuuhxxcDlPr4lihZDPv3njVUyXnnUsfD7
         n1z0JaqNGisKmSLt2/EEKyJNwJIN6teVrh1UgmN0BMHoVY6x+93Gsb/Cu1KtHZvn5TCy
         e3ftgEfsXQF03Sx5lyLmUmU8JhWGxF/R2krRKg39Da/YZKR7AQbZFo4VbRISfKeKZ+Uh
         B7s8CNbnTu5Qu77ydQbJz7DCWMwUgmq7FVFau2jw0RdHesaryQYVdTBIqEorTpQWeOaJ
         7Ywg==
X-Forwarded-Encrypted: i=1; AFNElJ9cV0z/62RvET/ahThLF79N1LWox18jWZNdnOjx4LtpIXO4L+ZOw3APTGojbbCYpW3y2e9JSIyo3bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZuo3x6FFBQgbtSwix8FyPeSHyC4334clxOgASr8nkDvxcWh5Q
	Zb2J2rr2NqRQef5zhQsMtcWf9ugSf6oh0lcZSus9yVq0jHx7jILSYyAi
X-Gm-Gg: Acq92OE46KtCJT8oyM/RCRb5vxVa0IHj/wmTR+zV8sCer2V3RL9rY9KUI+0pG0B/ZzH
	S+d1dWNjFVpqwi8Nx51sKNQM7KHrAnPFuH2RjuxR06UUr1quImg/f9gNPfcyLLqd52E4zh15+dC
	t22gCGWmvoNy+Dc7DhBbwUeF1wotrSUHMlyT0prdyWtQL3t1O0XFwivZS90EQfK3rvEzHOIMbjN
	mb3uoYBHkGLX0ZYlxxPROEocRjaYpJ3cvcDZ/++PZ8F2H2Td9DtGskkdb3d7GjmdQwr3MI+b4+9
	PkhB7KbPuArhgKaj854nGdaRcEmzj3RQipbZ62otAe5WsSYixygrjQ0qeqczj37VFNRUNKkVAyg
	XX4DMI323bPRQxDc9nxaRMF0KC32D9KedPSEooc9JsBV12TaYmIVG4LyTvEWEbjJ+i+d9LohBxk
	9dVBafLGCiLi9OCAy5hRAP86I7Fnl5PO/h0rojhi+PQwUwtr1vdp+Zrl8=
X-Received: by 2002:a05:693c:2c14:b0:2dd:6937:79c8 with SMTP id 5a478bee46e88-2f54ad730a3mr7739721eec.5.1778293657154;
        Fri, 08 May 2026 19:27:37 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88924af95sm4689640eec.30.2026.05.08.19.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:27:36 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v3 1/1] dt-bindings: iio: adc: add AD7816/AD7817/AD7818 binding
Date: Sat,  9 May 2026 02:27:18 +0000
Message-Id: <20260509022718.82957-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509022718.82957-1-dennylin0707@gmail.com>
References: <20260509022718.82957-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Device Tree binding documentation for the Analog Devices
AD7816, AD7817 and AD7818 SPI ADC devices.

The AD7816 provides temperature monitoring only, while the
AD7817 and AD7818 provide analog input channels with an
on-chip temperature sensor.

The devices use control GPIOs for RD/WR and CONVST. BUSY is required for
AD7816 and AD7817 variants.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v3:
- Fix commit message to match binding requirements
- Fix commit message based on input from Sanjay Chitroda
---
 .../bindings/iio/adc/adi,ad7816.yaml          | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
new file mode 100644
index 000000000000..490e5338d7b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7816.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7816/AD7817/AD7818 ADC
+
+maintainers:
+  - Hungyu Lin <dennylin0707@gmail.com>
+
+description: |
+  Binding for Analog Devices AD7816, AD7817 and AD7818 SPI ADCs
+  with on-chip temperature sensor.
+
+  The AD7816 provides temperature monitoring only.
+  The AD7817 provides up to 4 analog input channels.
+  The AD7818 provides a single analog input channel.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7816
+      - adi,ad7817
+      - adi,ad7818
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      Optional interrupt line used by the device.
+
+  rdwr-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the RD/WR pin used to control read/write cycles.
+
+  convert-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the CONVST pin used to trigger conversions.
+
+  busy-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the BUSY pin indicating conversion status.
+
+required:
+  - compatible
+  - reg
+  - rdwr-gpios
+  - convert-gpios
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7816
+              - adi,ad7817
+    then:
+      required:
+        - busy-gpios
+    else:
+      properties:
+        busy-gpios: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gpio0: gpio {
+      gpio-controller;
+      #gpio-cells = <2>;
+    };
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        compatible = "adi,ad7816";
+        reg = <0>;
+        spi-max-frequency = <5000000>;
+        rdwr-gpios = <&gpio0 1 0>;
+        convert-gpios = <&gpio0 2 0>;
+        busy-gpios = <&gpio0 3 0>;
+      };
+    };
-- 
2.34.1

