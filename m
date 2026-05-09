Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693E279DB1
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290684; cv=none; b=J6H2fYBsb43HD0/y2U10FxgrKDc15arBjvwKprj381DmYLE0SGnaQa7L/yzDCGZd1gkArGDKWVDAxox8n/h+zhXrG6R+u032qCYY9sJd6gnalkB4sIWC3cJV1+PYUcaZJ1KJ2GZSJMURpO8S5v/NCRqY8KtC2MIRtEQMzxMxtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290684; c=relaxed/simple;
	bh=8AprB/cMUBt+pEMNoNB01bka+Ef2XKR3JwTcZPiklMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8z/QvbqAHQGwG/DpeqqOATN03Jswco7bFj1IySDwZZ8HKo9stRcBljUTnDeTCsqCp1FufpecgAIpgomFFkilATjoU1rdy7qWXoWT1aXxtOAR44XXhgd4gabPhtbADOBsVj6PXht9PBuEjGJhZdZ6nwOLUPLX8Uitkahe+2UZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQMVqhMZ; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQMVqhMZ"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso2900245eec.0
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 18:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778290681; x=1778895481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kJjPazFhKl4AEbgyP7l4SZncr5vrrdtv6/1UCgkvoI=;
        b=pQMVqhMZT4nl67BUBrD8fSxCnpPE9nINctw6jlx5xlwWyESCpAlrNmU4gehWBGJOHE
         7KPck7tOuV2w0a32NljrBrLFtYF4BSD3/iiLdLddIldiOx1u7ShlDJzr8YJnw4urPMSq
         lXZqIuVPn6PQmP9VQfqh6tTtCFuUHOfuPgoPFG8aG+Tc+Ziybz3P6PTZUu/lvQjsyyM0
         /+hq8ZrRjqlcLGypzsL31NPvXILQZX6KFZJtbG1tH1fgHJxQRUU1Fcul+S/v6MSgtAVr
         UxH7YJigv7/sYZb87L3U74GrG22OVWLb7g1RBZZoQE6tAvUusHn24hBMbO0VNyyEQgmY
         l5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778290681; x=1778895481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6kJjPazFhKl4AEbgyP7l4SZncr5vrrdtv6/1UCgkvoI=;
        b=WefxM1nCBOGf4DOAO+Hr3iyyQJzO9qaS2XVcW3FkhPOOuGNuUeYVgqIk6+9P8qKA7g
         /VSd9Hjx0H6kYN4E6utXPXqBZ83lCCbKnwZtErriyCRNlxf6bhqXjsOv9N+mxeKO2udg
         tDjravYqhR2S6Ou8w9jpK70cplawK1ooF8deOzTTmNRSB8onIVxmM8bvah44+b5FipkD
         BIgpK+1S1RDzAvLYbILiQDmvowQhIlhs1Vq8XduG22xhgGpsxkYgazyaLpcP+/Zj2roG
         eNWoL6TK/zeK/i2sv++qbLELztmlRBRgHo7u3o7FvfKvtGyMJbfqPzqRv2s2Hvj4WgMi
         oimA==
X-Forwarded-Encrypted: i=1; AFNElJ9XsasKDdinBIkiNi3B4fNe6FpdKKIEZOIDI6y9DuTrWPFoubaqEZe289f2HVD5HzzpEP7NHwBs4vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZsWQUn+OMyQXU3oT8LRRFKgZYlO9hKYKi/46haba3zuhjKkzA
	LgB4fQRMYRpaTDNMc//POXjV6qMKNwNd2GBFciGJbZB80nsEzKeG9pIv
X-Gm-Gg: Acq92OGi514tGQqIvTBSsexQSy0+JIJOFSJ8rJKZltqH1/FJ1YkuesWtDG0DhfgRcm5
	vsQvnCfKzY0rOzeU91fI9TB+vCXqzkVdxJqDJZmscmWcJhN+27al5Psl6hCqSEa5SFkNRdejYUz
	0tua7COVQyXvgkNdypkja8lNwiZDBWsGed/WkX1aTFYAGXxrZkEI9Y5cqy2pWYI1TzbuEw2k+u1
	WxKULSWlNj8n57e3Kb+Y9DKRao1rw3UeU9mjoEOpoZYi9mRe00lw6CGauMfz4/qa7s+M9SstI+h
	Uyqph97I4kopZNLtBIHGQvnxBE/WM9EQLzNYf10XzNeg1N8qGrPGBkA1WMzE6yWoxAsz1ki4Lyu
	Wwfq69p41hdZYyJWmy4cmPCaEOFtPZwNX6wgnTv1mHhbF39APCt+UqshzRYjDyflXBmwO/y5urB
	REC8dMZT1kKKbaqyEBnxAmyFxUdQoN3JO5KgOGN9lI0PqXA39s1l8A/1k=
X-Received: by 2002:a05:7300:ac82:b0:2ed:e14:7f5f with SMTP id 5a478bee46e88-2f54b89a1a3mr7346685eec.35.1778290681258;
        Fri, 08 May 2026 18:38:01 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d43b4sm4503230eec.11.2026.05.08.18.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:38:00 -0700 (PDT)
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
Subject: [PATCH v3 1/1] dt-bindings: iio: dds: Add AD9832/AD9835 binding
Date: Sat,  9 May 2026 01:37:45 +0000
Message-Id: <20260509013745.80478-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509013745.80478-1-dennylin0707@gmail.com>
References: <20260509013745.80478-1-dennylin0707@gmail.com>
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

Require spi-cpol since AD9832/AD9835 use SPI mode 2.
Update the example to include spi-cpol and use a generic node name.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 .../bindings/iio/dds/adi,ad9832.yaml          | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml

diff --git a/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml b/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
new file mode 100644
index 000000000000..9f3e41cb0a0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
@@ -0,0 +1,91 @@
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
+  spi-cpol: true
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
+  - spi-cpol
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
+      dds@0 {
+        compatible = "adi,ad9832";
+        reg = <0>;
+        spi-max-frequency = <20000000>;
+        spi-cpol;
+        clocks = <&mclk>;
+        clock-names = "mclk";
+        avdd-supply = <&vdd_3v3>;
+        dvdd-supply = <&vdd_3v3>;
+      };
+    };
-- 
2.34.1

