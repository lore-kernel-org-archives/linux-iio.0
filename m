Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297003EDE6E
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420962; cv=none; b=Y2ULaz5b/TeRuMa47EkpK9F/oeKXULgSYYtekfHeII+yK3TIR21bnFLbNsOFSqj99XhhihjzNv6tzIKi7NtU/6WamPZZXvjdcYkj10i3hwjdzLscO0CeSjhbfaM9tCC56hnO9c5MxfkCY7JQNJejPpk753HaLsF3+xoWZ0o/N7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420962; c=relaxed/simple;
	bh=t/lScOB7CpFSN+BBpWau0Y34mVwtawmhNWrHgcJiZHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPEGSLs95IU8bqwqqYGxhPp8AtjzAKt8ehLZegRwR2ARN4HRkotPeyjkeFelfbg2cQIWcqsQJEs7FaqU4DePCWihTnNomN2ijGikIp5wcEJg4r+8CQf8vvnDvlC/X9BMhM0OJ8qoWonXm2cLoDpi19KGD88QnwHJ74f3YQmPKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlLDQKAj; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlLDQKAj"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb78090edso3035348e87.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jul 2026 03:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783420959; x=1784025759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WWfH/GxGUXWLsJ6S744tEAlMTJ0a2RTRBnRY+9o/Ybw=;
        b=NlLDQKAjTV5IyXQaKpBJ0eEpMOlwZmXJ8IMyph2TOuhU5wKh+D1msvjeI3R7UBgJLM
         zKj9+cuyn+9hFq8IeOMObTTvrT0U8hEhClCMaWDIT+mBXXAl/G1jxJvDS1Xk9LNlOvKz
         Rn32RIPVTJh4Z/KBrlaBvvITR2OzTjRkSGGhx2j3XdaB5Il+YI0MCRV07X04PTDnSeQT
         svusWmwylkl7ckIZCd7n0tfo8WlpeFP+3tegwMU9fSPaQgn8eP0R2ULIoZbuSdTGxz9X
         RoiZ6O8+fgDHftgwanFz0P/onIdanqBqmvYCz+7Y98Ji+IZdKBSB8d0PP2I9BNDX6/35
         M66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783420959; x=1784025759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WWfH/GxGUXWLsJ6S744tEAlMTJ0a2RTRBnRY+9o/Ybw=;
        b=czfWSR4C44hNau04Y5Zdsu0iP4MdiOwjZ9rVnSTKJycnT2RzwlUae6qb6nARwe51Wc
         7k+5LVRjcFjIfPhWyOyemi+COElumE4DCOJ/fdDvyQ1x19ZaY/0RP6usidFTi1KrLSpc
         lcIJSL4vghiGv8lpcWeLb9y5ZLm6+qd08dmS3LdMj7E1uyXZv9WqlWBow+k/cg1WQzcq
         8513gi7qHcqTIokuKWHD9/h58mWxmIgiQB07xulCUPwnnEUkjcOHu0KJEHRPleaHx+wv
         zlYtZbL552QUJfiogZkIvbAZIHgJPNxcyZv2MW3/7nesBrIg3Gnt+lo7W5W0T8pSJwza
         SgVg==
X-Gm-Message-State: AOJu0YxAJciJeRywI+uyJS35PXMUFJjHFNbSN2Es9+lZDVy4bLBTmTnR
	N4gZeCLEQNoHu4FzJDn/O/rLcvVRxZkdWFPlzzjL1Tf3cJi9dGncMBaS617+bFQiPiSzug==
X-Gm-Gg: AfdE7cla/Ywwb7qSTsfPcsmuxKk0/bIi3anlyk8ZneykrhcqmrHFrpeVYm5OoS01+1A
	fGhx5fkAMeQTCyZ6JHjMS3UVah1KsRT0/tgHsvLskHn003zepx0VV4zMq5YvSwktp/xOHL9Y7E2
	XRwPK6ME1f0ml/LsZbjJN09nD7nZLDud8SkNd2s2tHMO3PzIqr6RsG95L2+M4bQEnkHsfUX6Jjz
	8gsAVtRGiICLLhLMMx4g2okLEQJI4CJizl89mhUVPCYRA8dLI7F9Z3pd/+pHpt5FTcTvF4DAIaU
	6swLG3TuNucQ/lx1J1DKise9sxjqW920af4RXzTLZoVKgnqUzam6WW7EXpcrEAU2J3bAJlS0QzU
	k3t9bCJSiy6YDOf+vv+wMP48xPlTr2/QiQz++ho5EDn2PBc/ZqTIuJzB4plo9vV/Z/OJ6oh+zy2
	igZsdWoo0S1RmA9MijsiycBsVEHl+MfEgJymPrcaYwae6duQ==
X-Received: by 2002:ac2:4c35:0:b0:5ae:9c19:165c with SMTP id 2adb3069b0e04-5b007c089cbmr641197e87.7.1783420957925;
        Tue, 07 Jul 2026 03:42:37 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c8c1asm3533227e87.81.2026.07.07.03.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 03:42:37 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v8 1/2] dt-bindings: iio: health: add adi,max86150
Date: Tue,  7 Jul 2026 13:42:33 +0300
Message-ID: <20260707104234.1957104-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Device Tree binding schema for the Analog Devices MAX86150
integrated ECG and PPG biosensor.

The device exposes two PPG channels (Red LED and IR LED) and one ECG
channel over I2C, with a 32-entry hardware FIFO and an active-low
interrupt.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 .../bindings/iio/health/adi,max86150.yaml     | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml

diff --git a/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
new file mode 100644
index 0000000000000..b0ae7d2ecfcec
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/health/adi,max86150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX86150 ECG and PPG Biosensor
+
+maintainers:
+  - Md Shofiqul Islam <shofiqtest@gmail.com>
+
+description: |
+  The MAX86150 is an integrated biosensor that combines two
+  photoplethysmography (PPG) channels (Red LED and IR LED) and one
+  electrocardiogram (ECG) channel for biopotential recording. Samples
+  are buffered in a 32-entry hardware FIFO with a configurable
+  almost-full interrupt.
+
+  Datasheet:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/MAX86150.pdf
+
+properties:
+  compatible:
+    const: adi,max86150
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt line, asserted when the FIFO almost-full threshold is
+      reached.
+
+  vdd-supply:
+    description: VDD power supply (1.8 V).
+
+  vled-supply:
+    description: VLED LED anode supply (3.3 V to 5 V).
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vled-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        heart-rate@5e {
+            compatible = "adi,max86150";
+            reg = <0x5e>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+            vdd-supply = <&vdd_1v8>;
+            vled-supply = <&vdd_3v3>;
+        };
+    };
-- 
2.51.1

