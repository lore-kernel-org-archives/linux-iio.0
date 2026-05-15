Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797C73F7A84
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831927; cv=none; b=C9jlny6gAMG3Z5c7HPPDwZspgkhHn/mP1qW/XsabNYICZmfxtfnxefNtCdvBuntOQNQcRyKMrVHmBMtpsjTh87qc93WY7J/fN0vJAqZlG3vM3/+et33mq5Wa2QFrIaTBq7GX07pAZB3rsboNdWM7GCHlxJLn+BYIkOpBIaxURBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831927; c=relaxed/simple;
	bh=wyYa8gIFgLjBYlLhyXw9vzSHb5OxneEJ6CcsElborA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBue3hA8KfjRCz+WE1hYivtihI0ZTngxjmK3uV+NnkV3hv3z4EithlmmAIucphGevcw1XUyNe3sDwIIiorbJZN2W6JoUIkNzR4UyaSROimGYL02jQ6jhZuhx/CzBrrbGm6iJBLFyNw3AMdRTSe2wHbgqoF+igDQPhZF9qA8vPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOyUGC8z; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOyUGC8z"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-365eecc5885so8835139a91.0
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 00:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778831924; x=1779436724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MiS+JhxTiWTYXV5rcm6uEgwCs/g+gk9Na8Cem5QvF0=;
        b=GOyUGC8zk2B7f1atKHeOFC8hTNzjFpG8l0wfhMd6NehmJYo0p6jPcvKvZCAYAzF7Bs
         91X/PJJ+3425G8d+eFddfzeZNiCqoYudAR5iWKwJfUbOAP9Da25AAPsZHK/3Db2cELIL
         dXoJqaNBAQOwMqfUxoTNnQWewjyFDhvMLH7qVf7GfocPdXY3GApQCDFTFGepQobbAkuI
         sXfouRycjEbD5AHxKLUzcsfpl5YFON/SI77PqWuTPGDeb/ZXUXkoipj6TsWenWitIEIa
         fNO0xeDgDfT/MPY2kTZq5RLZ1SgviWMYmGpqUVSxf+Sh6V8Z8DFnGJ5rFFnvItAinvtB
         4tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778831924; x=1779436724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5MiS+JhxTiWTYXV5rcm6uEgwCs/g+gk9Na8Cem5QvF0=;
        b=CAH7sGfB1mIPUIQKkT27mWAgp+FNz7PLMUBDDp2+Pko94NbpqtfNBT21GKEOoUSjkJ
         7QKVJMfnp5gfF3ghFvGJQTdorQ6ANZGah0KiJ2mGg7mIYYtAcynSm2tJwcvLVp21xyO+
         4jnS+Ebu+DsN/nCJNKdXZIqEltk9BP38IHJJ6E0DBa5FTfRNzEobTgGGC+kTky+/oL2L
         IQLoOQT6Azy6srK86hdai4eP9MSEsl7AUpQ2p69+0fKm8HuWWTRo2jT7DkiUwvPRf5om
         bXHlxA32ExnJA8k/kSPWP/PzC1vxWV3ac8YxnjoeOCs07ctKh/GHC39YJ1R0Scpbk4ML
         utqg==
X-Forwarded-Encrypted: i=1; AFNElJ81wm483uAFS0aM5K3lpNgmxoH+VuJbTuQgwYdhRdKkSfqr7xTuAu7/f+ho16IOfy3Z+E66wf4zyPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5ms+FGBi9/Ef6ucXwrTK/VFXdsSc0Vk81I1zkpeLMlnfTB4k
	hck64u1oIaePJPV5LDUHpeFProsDoBg3o+qTffbbZPGXnnrJfF6GMpwxlcSaBa9rtkc=
X-Gm-Gg: Acq92OFviZBKN/Wz3h0SpL7WLxKNwIA+fLB5t/66abnhJrfNVCykRdclsvNVoHFpxvH
	JqCRiI3F/Hc7Bbz3ZLGbkShGosWDkKU0xJaITUADs+Vn7bLjwCGokTTgno3ys2qj2Pea7BVd9mX
	XrOmlwEfsJGUJjwt5Euw4u817TwS9lK3oL5mNH3jtyh9vXXJwDaCFz0/bGh1PvfWCwWnGRsN8bi
	Tk0qshXH4zw6YLeCHnwJ4myOYR29fJNTQcKwTPGZ9fJvAYgd91w5E9WKQ/WwXJJeUDOKr86DdOv
	pYVtMTK8Z9bRErIYeKsZAWLk7RvuPUPzPQonqd5Pueg7nRpFauQ7kd9R88gIOERxmZfzQhJsci1
	tn8lqjgCj0ifHTqoDY5dQrAZzcBy2wnEqG0LiT5vxDFMcrvL4SXKGvnZ685Fz6iCGTR1mUZhOtJ
	1Dgdln+IyaiY1CuH9Jn5wNMXsP8ZUQH2kL62+VVo2F
X-Received: by 2002:a17:90b:38d2:b0:366:33a6:9921 with SMTP id 98e67ed59e1d1-369519af699mr2924409a91.4.1778831923836;
        Fri, 15 May 2026 00:58:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d008:80b:a00:27ff:feb6:42dd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36959c7eacesm542040a91.2.2026.05.15.00.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 00:58:43 -0700 (PDT)
From: Pramod Maurya <pramod.nexgen@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pramod.nexgen@gmail.com
Subject: [PATCH v4 3/3] dt-bindings: misc: Add binding for Xilinx AXI-Stream FIFO
Date: Fri, 15 May 2026 03:57:36 -0400
Message-ID: <20260515075736.172172-4-pramod.nexgen@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515075736.172172-1-pramod.nexgen@gmail.com>
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
 <20260515075736.172172-1-pramod.nexgen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a YAML schema for the Xilinx AXI-Stream FIFO IP core (PG080).
The binding documents the three supported compatible strings and the
vendor-specific properties that the axis-fifo staging driver reads from
the device tree.

This resolves the following checkpatch.pl warnings in
drivers/staging/axis-fifo/axis-fifo.c:
  WARNING: DT compatible string "xlnx,axi-fifo-mm-s-4.1" appears un-documented
  WARNING: DT compatible string "xlnx,axi-fifo-mm-s-4.2" appears un-documented
  WARNING: DT compatible string "xlnx,axi-fifo-mm-s-4.3" appears un-documented

Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
---
 .../bindings/misc/xlnx,axi-fifo-mm-s.yaml     | 93 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s.yaml b/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s.yaml
new file mode 100644
index 000000000000..f4ef7c277cd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,axi-fifo-mm-s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx AXI-Stream FIFO
+
+maintainers:
+  - Jacob Feder <jacobsfeder@gmail.com>
+
+description:
+  The Xilinx AXI-Stream FIFO (PG080) provides a memory-mapped interface to
+  an AXI-Stream FIFO IP core. It allows a processor to transmit and receive
+  AXI-Stream packets via simple MMIO register reads and writes. Currently
+  only store-forward mode with a 32-bit AXI4-Lite interface is supported.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,axi-fifo-mm-s-4.1
+      - xlnx,axi-fifo-mm-s-4.2
+      - xlnx,axi-fifo-mm-s-4.3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  xlnx,axi-str-rxd-tdata-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Width of the receive AXI-Stream data bus in bits. Currently only 32
+      is supported.
+    const: 32
+
+  xlnx,axi-str-txd-tdata-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Width of the transmit AXI-Stream data bus in bits. Currently only 32
+      is supported.
+    const: 32
+
+  xlnx,rx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Depth of the receive FIFO in words.
+
+  xlnx,tx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Depth of the transmit FIFO in words.
+
+  xlnx,use-rx-data:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Set to 1 if the receive data FIFO is enabled, 0 otherwise.
+    enum: [0, 1]
+
+  xlnx,use-tx-data:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Set to 1 if the transmit data FIFO is enabled, 0 otherwise.
+    enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - xlnx,axi-str-rxd-tdata-width
+  - xlnx,axi-str-txd-tdata-width
+  - xlnx,rx-fifo-depth
+  - xlnx,tx-fifo-depth
+  - xlnx,use-rx-data
+  - xlnx,use-tx-data
+
+additionalProperties: false
+
+examples:
+  - |
+    axi_fifo: fifo@43c00000 {
+        compatible = "xlnx,axi-fifo-mm-s-4.3";
+        reg = <0x43c00000 0x10000>;
+        interrupts = <0 30 4>;
+        interrupt-parent = <&intc>;
+        xlnx,axi-str-rxd-tdata-width = <32>;
+        xlnx,axi-str-txd-tdata-width = <32>;
+        xlnx,rx-fifo-depth = <0x1000>;
+        xlnx,tx-fifo-depth = <0x1000>;
+        xlnx,use-rx-data = <1>;
+        xlnx,use-tx-data = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 58d35c17704d..bbb6b8c20ed6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29164,6 +29164,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
 F:	drivers/iio/adc/xilinx-ams.c
 
+XILINX AXI-STREAM FIFO DRIVER
+M:	Jacob Feder <jacobsfeder@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s.yaml
+F:	drivers/staging/axis-fifo/
+
 XILINX AXI ETHERNET DRIVER
 M:	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
 S:	Maintained
-- 
2.52.0

