Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1E426ECF
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778352; cv=none; b=GREZQ0CA2NuDcBMrTTE9QpmTZGnSf0y3DcAGzyt2FEaUwoHq2uNpEYvfblXZAcuAzXkN52oYy6JIT3FJ3bOwtpzXj6YhEiPybz4ON91BT59RJEb40HSDhfRndL4VsMOJ2gv2vKJbRBZ/EV1KCgL/5dkPtCJWCkXyuGH8enlKfrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778352; c=relaxed/simple;
	bh=wWpBNc6BxWkqVoO6oeJahIhF95WJn6KMiQW3lSHoUjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/G2LS5u6jkTOd/lVlziPCYSwvcuSvdvlZ725shKpim4utlWJF8BMsZ6Dm0jCt3tKrs2h7GapsK1fpdU4sPAWaDyBCvUhBj+bFk83nn0J2J9hNydE71PfWwuN2hyFp/V1NNrOAPA4N1Dkzh7KQ5C/IFEtUd4w5OS6Wt1YvXa6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P51j8aY1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P51j8aY1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954d29264cso12310765e9.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 10:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785778348; x=1786383148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5LPQS6tMBZYVLWJlki8rMIsiVgDBwXQovUEzCbj6uYE=;
        b=P51j8aY1TorfnEkdOAnbevGKyCrWzFPQ87STWG7B4crHgmIzVa7kXNpzJGQOQX+tFJ
         f/lINpzV54QTyywkcviDHK3TVkHzf9SEVMppmtYYm8+6CZ39ujHpG5UW1/vhNZReMmv2
         O9f5lIaNJsxa9C54euYDfkVGNg8LSF8/X+SB1RPZRiyhSV6o3u9LOPKi1hUKBWqXsB1a
         H6hDJFWvs/VOFtGwSaYa4pYtNL/nalRnOnHS63/gMwHZRfLm+++otMmtdipgxN+baaM6
         0Us+zRC2AqAtdTUwRSVchUn9cmLUt6nk6bbEqqY5Kgs/PCY5Ycll22Z0hmGgDpqGQCPz
         cmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785778348; x=1786383148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5LPQS6tMBZYVLWJlki8rMIsiVgDBwXQovUEzCbj6uYE=;
        b=DXj6B/NzSAMA+odNhWy/KfmL8lE3QxVDI4rTypWV67D8AuY1d59VzUWCCswRnkAQpE
         mnZ0EWR361l042j45QvmIrVe6iax25GsxajBSWRvg0cZEgfDAMNOaGMa2dDQA10NlZmS
         oOmucrUKGxWrixQQ0gc1l2+CpMW9IfrLq++uJB4ytQdkVKacjWJFHSviTjdyIQc+XAyX
         UhErCHsHvJpAs5IeHMcJwpBeCk0RHW6HNGimAQjpQcV2/HdL+QduH9lkRoIVQOzfdXNr
         GoaUBtdeH2BKunlQnm4Sk00IZFvAqKRrSySaGrHpA47+E9ir1Zz2Oesv+5nh3i+5BJp0
         H/WA==
X-Gm-Message-State: AOJu0YyxsyfCrIYLFEyjokv1z7ThbD8LmHV0P5cWJjPjqab/Y32GXIpx
	3ree40kDLUTFw1K/z8feRSHA5AZcd+NdtCPymduzsq/kLXwduW9arKpK
X-Gm-Gg: AR+sD12HtKdgy52Rbx8zMCXevV4eRVsraa51FBuGKYP1oUnr+f3hZv+BlqC0KKtVazZ
	evy16gaVmUHEFR+U1psc0IMoS7ZHY1FYmYNll9256J1q0syQkzzhyORxkAggVt4x5cimP2IZ8Tw
	o7UfCy21z1D7zHaQbDz96yndZGtb3C10vS+htaeF8YH6RtEvGLqyTfM1c/BS6OBRQbQ6700+H8M
	50sx8gEMqj+1fs7aB9bs4GCmUxST1XBcwcmabfxTw4Z1ycwlQxe1lVV/qhXXIBGCvkPxRLK9ssV
	sHCAW0336qUPj76LP4GoyPTDw+cmrHY7/m5zJ/AOz9R1vcMT7Dl9MNYkUaIuspjg5Kx3Tv3WhKd
	K8NsZVRRWPiH23j69jwMUkHOKRNnsV2PcTxntIjW1NxsJQXXMPSKoD/RfS6e1hP5eyMY7jbHf0j
	BubOvcyGn+GBsZ/mFhhKynbYqvkLsgoGuM+q8Rxvu5nfAd3KyuZrQYKLNDdv5r4bK8nxSeg9Le2
	bt57yPrZfh3HVUvZnmqkdfNb89TT6omWzTv6gbDoeg4Fmv3OJkRjVdhryfcuhJEpa1BlT+QObzM
	NJpQ4aXXxv6bTQriQTMV4RsZ3c3EDd8yjdGG/ab/881yC6+FtnrM8MUSaNeYAmiFl6eolhRw86J
	gVBNu0Amwsg1s6y4t9Wdw2ZIXw/BoOiENUQC0
X-Received: by 2002:a05:600c:350c:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-4980f23180fmr188978875e9.2.1785778347747;
        Mon, 03 Aug 2026 10:32:27 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808199a68sm176259975e9.4.2026.08.03.10.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 10:32:27 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 03 Aug 2026 19:32:25 +0200
Subject: [PATCH v3 1/2] dt-bindings: iio: dac: add support for mcp47a1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-mcp47a1-add-support-v3-1-540e71b4fd2e@gmail.com>
References: <20260803-mcp47a1-add-support-v3-0-540e71b4fd2e@gmail.com>
In-Reply-To: <20260803-mcp47a1-add-support-v3-0-540e71b4fd2e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785778346; l=2425;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=wWpBNc6BxWkqVoO6oeJahIhF95WJn6KMiQW3lSHoUjo=;
 b=mVceFDVBaFVLylHV6ll9I0bhPKHpIffShIK6GlePRJfjWkyrR5NouPejfQt6bud3QQgKpJQM9
 x6KkhSvDltZDuRx9UxfAq7yL0GYXKkxdMmEUXvRIl+0fETlFOIz3I7l
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converter
which communicates via I2C.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 .../bindings/iio/dac/microchip,mcp47a1.yaml        | 50 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
new file mode 100644
index 000000000000..b181fe73dce8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
@@ -0,0 +1,50 @@
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
+    items:
+      - enum: [0x2e, 0x3e]
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
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ce020ded5fd3..8c8118eb4141 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17699,6 +17699,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
 F:	drivers/iio/adc/mcp3911.c
 
+MICROCHIP MCP47A1 DAC DRIVER
+M:	Joshua Crofts <joshua.crofts1@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
+
 MICROCHIP MCP9982 TEMPERATURE DRIVER
 M:	Victor Duicu <victor.duicu@microchip.com>
 L:	linux-hwmon@vger.kernel.org

-- 
2.55.0

