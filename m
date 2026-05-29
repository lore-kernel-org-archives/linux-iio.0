Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282A3DDDD4
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056651; cv=none; b=cmnTi15i+6Mt/ktv3bC9PZf+/CJ9i3NkA00dVJw+EszVE6RFR1LXGMmCZShQtwN2vFc3Aq4zYVRdbFvenAiqdtN0klmyG0+SM0lgYQalV5zkt4pIWQx9dDc6mKyQ1T8RNpjZnxDpNqDPibjNOAK4ABZ815sO6VIVaA3NHz1FgUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056651; c=relaxed/simple;
	bh=JnGEEFp8WTXWR0uwBO6AmcqSpeSfcYZH5tJyzNik8gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feWUmib22kIvdMQjXOhcn6kOJJeigszYW0ddgEZQlsai/sTJcCpW2RkNqewfNpePRdzyfURKOY89sEBRqXoYNTcfNtBOrXoUc/HpnC1dhXuP3OICkRoS6gPraBi/4WMB1DyWBBAXjiQWpRtfssi9IzkeKfK7FG7gLUhupJbC7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxRbdapE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxRbdapE"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3664df32e91so15505575a91.3
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780056650; x=1780661450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80UKwhf+3B8/I9ptiFQwWeU5LzEfb4vtDtyUw96NZBg=;
        b=HxRbdapEgceDRX4beW2i+VZBJyxGAOPQ7bTna9vcX6ATKFae4K66YJqhwdovn1RTbn
         AEhaZrMKEx33QTqnPTfeJ2EgLCp5x//xiInhsU6tmmCLEuGORpvHrueTREc+OnW6bFO7
         FcB+qZS3PT00EI66+wATRt1qAwkdmgoI6CBcSNNcpIiN2vzwssqgqA2+k6y3yEk9Fgaf
         ptRI3/ydHPTmTyblfZoq8gG/uGLGkJVD63mXls0r48Am6TvZKL/LVEOPKSt9v432d0RH
         LxWGM/toI0UdZBzf0NF6vtnwnCw1usrWUS+VMZFk0YZUE2Lq4M2byStgeJh6qBzw9kSR
         Bhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780056650; x=1780661450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=80UKwhf+3B8/I9ptiFQwWeU5LzEfb4vtDtyUw96NZBg=;
        b=acGvk/0DYEi+1ueL4h16pdKR9oVxZfPitHs2oennbFEh6TJNbfgdUBWhegJ7RKU2hi
         E8uKi6Ct3drdFDIfEtTvWCWNqpOKFRg9zb2BGv9lYJVzu1NA/drnu8/B1V4n8EGSAWi+
         imPwO2MXzUE+ljmTvuaGRZUIgaguMnln3FmEWMgGRHki9SEGcaSFrOPKykfLxTxGsEMz
         3E5BRl8t/qMvDctnHv+8ofZmDxOmXZa6QcFlaEHhigVsQZTlMu6BbCnnUwhfBJCu0l5T
         +lrj1/eVUvDXU1NrROXTZ6za+3vBPTbJHKqAVqg/AY/sTgva3fyq5q7mA26hSmfXTBcp
         S7OQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZAChehVrvQAW9VOfWrc2FYeLy1CRrxc3FQsYT9oiLUvlihQ3r+mIvJTaOgN/Ab4FMl00B2Ezq6sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIHg6X8UqRT8xCH8Z3H8dAQhLioY4F0O86TABXw+S3F3Q1Q5E
	qFlecnCeqNWgcHw/CS+ZYXvP5iI8uEdH+9vWeoX/GLR03xM66sNuLWvU
X-Gm-Gg: Acq92OEOVSR1xpFqv/53lqmIpZmn10VrSiJGvjqCSBgcNVVdIDSnJFErwRpc9gVJMsO
	avvOQqoJqiEehA3IvbKbSpYs9+E6SjcqqSmSxhE5adL4Uzend0WIlM3buNYVeHQ+DcdLrno2wEi
	jX6CRTJsFC9W1e58UayDW22I8G7U5VP5PGpzxDClIHRnwoQfPdNJodGfjfU0L+6d2f1dc7UB9J8
	/gQQnl3TZACTBHRjAjK8+InKm9pqeZ5wx2qyEVe2UPR2MjWvh7ErkXULM54urhX7xuwhOeGU9dS
	bJ8248XCigtYGfFRZyItle301Og77IMWsBRH+DwRGGj/wLAWpTSuOSPPRjBoT+HxU+dQBERaiMS
	rT61yf5mv9B/sADPHYtVYUx5/b+Td4dIXhmsx+LvXvkiLVYcHqy5HNwPYRs8CXer4gpUkEf+f8X
	7/uGf+ueC60imZm6D7+3WGT+VBUS1QY9oQrgZSPB3MHeTYEPy76MEI8h8nJGdbxT3iHY/PvNnFX
	RxVSDlHvLMxC2PVBSOzJUlGpDogcWAZ4ucqnD07fWBDg1zA
X-Received: by 2002:a17:90b:3a50:b0:369:a359:b192 with SMTP id 98e67ed59e1d1-36bbcc160damr3225238a91.10.1780056649582;
        Fri, 29 May 2026 05:10:49 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbdf3afc6sm942820a91.7.2026.05.29.05.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:10:49 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v3 1/6] dt-bindings: iio: add OSF GREEN sensor aggregation device
Date: Fri, 29 May 2026 21:10:00 +0900
Message-ID: <20260529121005.1470-2-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529121005.1470-1-kimjinseob88@gmail.com>
References: <20260529121005.1470-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe OSF GREEN as the first board target.

Add vendor prefix and MAINTAINERS binding entry.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 .../iio/imu/opensensorfusion,osf-green.yaml   | 43 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  5 +++
 3 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml b/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
new file mode 100644
index 000000000..626b41fb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/opensensorfusion,osf-green.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OSF GREEN sensor aggregation board
+
+maintainers:
+  - Jinseob Kim <kimjinseob88@gmail.com>
+
+description: |
+  OSF GREEN is an STM32F405-based sensor aggregation board from the Open
+  Sensor Fusion open hardware project. It sends OSF0 capability, status, and
+  sample frames to a host over a UART link.
+
+  Open Sensor Fusion is not a generic industry standard. Public project and
+  hardware documentation is available at:
+
+    https://github.com/opensensorfusion
+    https://github.com/opensensorfusion/opensensorfusion-hardware
+
+allOf:
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: opensensorfusion,osf-green
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial {
+        sensor {
+            compatible = "opensensorfusion,osf-green";
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66a..f1b1f2ad3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1237,6 +1237,8 @@ patternProperties:
     description: OpenPandora GmbH
   "^openrisc,.*":
     description: OpenRISC.io
+  "^opensensorfusion,.*":
+    description: Open Sensor Fusion project
   "^openwrt,.*":
     description: OpenWrt
   "^option,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index c2c6d7927..26bbdf8d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19977,6 +19977,11 @@ F:	Documentation/networking/oa-tc6-framework.rst
 F:	drivers/net/ethernet/oa_tc6.c
 F:	include/linux/oa_tc6.h
 
+OPEN SENSOR FUSION IIO DRIVER
+M:	Jinseob Kim <kimjinseob88@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-green.yaml
+
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
 M:	Rob Herring <robh@kernel.org>
 M:	Saravana Kannan <saravanak@kernel.org>
-- 
2.43.0

