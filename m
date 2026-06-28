Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E6430F95F
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782674063; cv=none; b=b84bp953TAobggvsfU1/2L/KnTj/AiteLR9nVYOCStB5DNX+OHs4BJSIIEeQLqL+4Z7VXQKogSPQn56vqVrNUfrDkfXW+xExnKyo8/yPx7sJOjAjAfuSKUqy7ETWik2Zz/ZwqQzIOJbZSgzHFVMro6fH2BIaVx2qjTdsEXE2l0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782674063; c=relaxed/simple;
	bh=wA8JNmn3A5+dDyuybDhvw9w3jbayZYBxH3aZrZNNWws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpRGGS6GTJ5F1BHls6Bw4LFrmW1R2A5PSIHwDGKyMnHH/j19VPAHIx4fl7AVxna7jeVNY643oKZzj/xDMtkxesDVUicw7TOYyxhSKZt2ZUINWeDs4NxHSP1lrmDaxSFlQ+3OnbSsCiBPSA39hbSrCdniSdet+uwVbVCSRNpbvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDitKAH0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDitKAH0"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c9d87b1f9eso3213815ad.3
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 12:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782674061; x=1783278861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXbBJ9Y4kfhHHzoTBBCDKg/cyCBNNKfvMr52MYhNSck=;
        b=XDitKAH0T2npFm5mrdQ2CFCwNld22XWu4pdHpQSaXYzpb4Xcr5u44L2s5A8/BmBgdx
         ZxY/niIUcxSq6qXv1bN4GsamWZE0q0zP8XeU9UftGxCRKnp9tDwydbgqx9mWjRxU30lQ
         lZrO+7i3FzoKQ20K5vEdTn5B1DrBfGXTt+YFanaGk/rarsKkV3qAnkAi1LffuDZ+wJxn
         7H+nYuf5kEUb2WsE/dCwntYazsIED0lVi6J4aZ0ojE6Q08T0qtzjQkKOpIzknOQaAsFG
         nhXhLoG6Dg3lJm60HXduqsKMnTj4nxg/aaXOnmfRdiLv10xQGutSuGlfY3+Ef7EUySI1
         4eUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782674061; x=1783278861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gXbBJ9Y4kfhHHzoTBBCDKg/cyCBNNKfvMr52MYhNSck=;
        b=b18nnqi4uTxD92OgB+A6VJimvYyHNpN5EgdTq8oakYFSwDQKqaStxXqkaNa1R83pF9
         BHgWGbvAbYM/D7zvafFf5GxEAzdkvyCg9gV9+IGo4xhOhAC1kvqOW5Bn1vESn3/HajvF
         lcrk5mCqaphOVhS7qgMRNcwmEt5zVK7oRdBltQtj+rTVdn6EUsvzqrx44DrmoZqMnJTn
         9ZBPu3td/Hj9ER/dzxRLwoaBIsv6Lja0Tf1Pi91siN5+S5uqIuZcbFrs9dkwJQCbE3Gd
         hc0NInS1d94XDOfWMEzUbl0SpIbvj5W8xE70luACmgUFkHsQgiMadwNKLkrXmBdUx9K6
         QBQA==
X-Forwarded-Encrypted: i=1; AHgh+Rpe4iSPgBlMgFTSUFNYKfKWkybAmk6yFLj+0HsrS0Sbu2fW0cuWsstK5Ha1yDn6CdeIcXZbnHRxkX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZpv2F5rce8DoHPTmtKYY0rZ6V5WELEKrVmVNgDzDGTJrSFJ9u
	dvp3q00Ho7Rsi0vPt4sGXE4qKtSo1cYqb5OOjlYSm3T7nsLoxqYuKQVw
X-Gm-Gg: AfdE7cmKGfeCzT5Q1p3b90diSGKTGlpY2Of7hyeJfYuZrHgnnJanZ0fAagCIrHHHWOl
	s3VkI4rq/1sUaA7jZBHYVVyqEO4AeKTWbh7xSYBPsBVrjXtCn2jy+ijAqiVmdu0ibly7ZUiboDB
	p1ibamHfhPAnlVTyjulUMwKVjdTTBGcLalzE18MyEMjgIqWVoeRnIUfUUDV7oOG000fhNpsqis6
	OEJNVDwnc8riRC2t9iVPnWvHcHzp8uFF2GskriIRELBatf1CZ3KQwYytula8hI3wsS64ojsjfUH
	WSwIYoJkxTFQB10l6tcgFR4/k6MM7pxw440vXpmT0qXlw4/bPWlMbqDf+o7LvSZa05kZlZGazEw
	dvY9v7rEt8s851AUUajz0A3nSQSQiNVTv4goznNL2nYQ+svS509wYK4sgl4IJsx5OHYDvZWGZ7I
	iUThXLdoTqdQy/Yc7qzt+Cap5OnYaP0A6rm0o8Z0jic0xidBKWaCklXXVx6faBu+Ftss/0D4V3v
	4TSHUNYyXvvjjkjn5RfzDMA5dyc
X-Received: by 2002:a17:903:2a84:b0:2c8:4c29:afe7 with SMTP id d9443c01a7336-2c98549cdc2mr77081575ad.3.1782674061260;
        Sun, 28 Jun 2026 12:14:21 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca0b454815sm1354385ad.2.2026.06.28.12.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 12:14:20 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v6 1/5] dt-bindings: iio: add Open Sensor Fusion device
Date: Mon, 29 Jun 2026 04:13:33 +0900
Message-ID: <20260628191337.937-2-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260628191337.937-1-kimjinseob88@gmail.com>
References: <20260628191337.937-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a binding for the generic Open Sensor Fusion host interface.

Open Sensor Fusion devices report capabilities and samples over an OSF
protocol stream. Sensor channels are discovered at runtime from
capability reports instead of being described individually in Device
Tree.

The protocol version is discovered at runtime from the OSF frame header.
OSF GREEN is a product identity, and OSF0 is a wire-format magic value,
so neither is used as the Linux compatible string.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 .../bindings/iio/opensensorfusion,osf.yaml    | 54 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  6 +++
 3 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml

diff --git a/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
new file mode 100644
index 000000000..8016d582f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/opensensorfusion,osf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Open Sensor Fusion Sensor Aggregation Hub
+
+maintainers:
+  - Jinseob Kim <kimjinseob88@gmail.com>
+
+description: |
+  This binding documents the generic Open Sensor Fusion host interface. Open
+  Sensor Fusion is a sensor aggregation hub. The hub exposes an OSF protocol
+  data stream over its host interface and reports capabilities and samples for
+  multiple sensor classes. The actual sensor channels are discovered at runtime
+  from OSF capability reports instead of describing them in Device Tree. The
+  protocol version is discovered at runtime.
+
+  Public project documentation is available at:
+
+    https://github.com/opensensorfusion
+
+  The compatible describes the generic Open Sensor Fusion host interface. It
+  is not an OSF GREEN board identity, and it does not encode the OSF0 wire
+  magic. OSF0, protocol_major, and protocol_minor are wire-protocol details
+  exchanged in OSF frames.
+
+allOf:
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: opensensorfusion,osf
+
+  vcc-supply:
+    description:
+      Regulator supplying power to the Open Sensor Fusion device.
+
+required:
+  - compatible
+  - vcc-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial {
+        sensor {
+            compatible = "opensensorfusion,osf";
+            vcc-supply = <&vcc_sensor>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66a..88172d4a4 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1237,6 +1237,8 @@ patternProperties:
     description: OpenPandora GmbH
   "^openrisc,.*":
     description: OpenRISC.io
+  "^opensensorfusion,.*":
+    description: Open Sensor Fusion
   "^openwrt,.*":
     description: OpenWrt
   "^option,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index c2c6d7927..e4df9d8dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20011,6 +20011,12 @@ F:	Documentation/devicetree/
 F:	arch/*/boot/dts/
 F:	include/dt-bindings/
 
+OPEN SENSOR FUSION
+M:	Jinseob Kim <kimjinseob88@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
+K:	opensensorfusion
+
 OPENCOMPUTE PTP CLOCK DRIVER
 M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
 L:	netdev@vger.kernel.org
-- 
2.43.0

