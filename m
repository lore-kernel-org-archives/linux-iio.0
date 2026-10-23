Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788133;
	b=NqWSXmkc1AWtXo4vmupB6vnSvQL0V4iHTLdX5EVJ/Zj+TVWRwiD97xtvecLYlEpdzwYv
	 sEfeRG5m39egcTrWoLI3g7o4/N/lEuXazbwHBNITwp0Qqm1A3wlJnsQadn4mBKhD897TH
	 RZkFZnrvncKGST6QkH/+iyIieDc3rULP/yhcf77MssjKGi9QVfUuhFpoDhnOApbK+SKva
	 t+lm910zDwwSsClrqjBbbb0xNaDzJ/PYJeERT9AhDEy5gUvvat7NdIlz2sZ2ic6ZnEseW
	 KKgvvv09OZRYozYjWyagUDZ4/tSGGmG463QlfUgu4tr79z6vbAIM8f2cipbIRg3ljjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CltLoSVZI1vl9e5Xk8AH5ABIellf5efpdTrcem8ydxA=;
	b=auS/mDXMIfDRBhiZXV8XocnkEsyJUtaX/f8bLDCsiV5M+1cTIDdbUw4IdccoRsxRHf7i
	 6qDKDsFIoc5NpCxbL3Zt4hItbLI0hlZO08XXSPQw5SJwa02eY7BzBVNc6S/JNamEUr1af
	 ccKRmEX6Bi6aHsM3Qs0XwhdGUgEplx+Z+Taldw4b+TEEK58B2q0pt3sRKRZbNx1gpy9ni
	 qhsTcLE2fVQ1+dVXb1PTKgAp7DmAM+oRAYNpF8/3rK/2n3Col9iasG2Wp70b8PlU25cNe
	 sgtz6czYqBHGfrjTzRLSActcAgUzzLcLvkdiJOtGmLjmX2ZAQlCWg1iQjbpy2FoK6Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=oBwgfwHm;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D3606A322
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 20:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 265D3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=oBwgfwHm
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so1720044f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792788130; x=1793392930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CltLoSVZI1vl9e5Xk8AH5ABIellf5efpdTrcem8ydxA=;
        b=oBwgfwHmsmBxfTS5JX5faiudumKHXgvyGSxkRfoSfRdtoBdDGifQhNkwXDGZFrdbLM
         8cFvt7/panM+aqJVOdfJZE6KWSVNcByOIC/JoCTQZYTPP4uWqSRBG4PBQz75NV0Ipe9F
         wHUFc7co3li5NzRlwqZY6l3sXhtOW5hRYK3uT8jlE1HAFYYaOjOhoIum+LErH+ls1efd
         GmmpSqooWmac6Lpyas+yN0e+D5maG6px4YdIK/DL6dqJvU31vbeJwit18gc06ZkwjCk+
         GDffnYK0+S7/4E8YjhLF8buPz+z8XeTCz54JP+vYhxw/74iPIcDJKZXJP5PTVXYyitTZ
         wQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792788130; x=1793392930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CltLoSVZI1vl9e5Xk8AH5ABIellf5efpdTrcem8ydxA=;
        b=COvmBAO4KuVf7rTgGMfbJxgjZR04jFBEvXkXUX4eIGhX9sUDaxznzeaw8Z6Cs2ucke
         1ocEr0l5BqpXPzYtCvvr8yi6YRR1LOFNIWWNLuwH9J7FTA7xxv0/+k5A2jG32LpgTDLY
         AmDTHAU24TvHDBVmWNm7AX4ojgaNHcJMXRdTeYOXeL2VXa34tFyi42GFJdPtrJUHVZeX
         S+8v2HXXO/qzixnKg8sLHHgBNT7x8cWVJkVUuCjVJWQwTBkJiGeJBwp/2RT6z3Gx4NFG
         sTO58k0ke4gLh3drovifED7Dehsby01TVpkCwN6sPFZMQxjOgDT23QoODhaOBsj22uCj
         wgAA==
X-Forwarded-Encrypted: i=1; AKwUvBx5eCwFX4taZ/zNXDn9fquVZo7E8eMiRCk4pVm4uOf+1DhsOld0ZkVRXXJkuoPEIYpdj364RWe7j8w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwhleW2di7ZSyHaggPhXAykmi65StiV0X65IrKtTfZvF+McNlv
	3/hYkFQm11ZplAd+EivFj3Mi8TQkruC8FNTQDhjQAuBcSUDgwZ8JBVEiZvpNSacH2Vo=
X-Gm-Gg: AYBFou0wYRObex66Kz7/ineAEmpOakaNdzFAslTOFlyCjoTLCZWhawfho5L/bjSZnWz
	AfNl/yl5mht+7juLWpeLrBjS4apb2mMFbCzz5JaMXOqTTx5ovZAv7x+SfbdKj8FcszdWUdyBK5T
	6V3SU3qjPPv8qFnkktx+LLnNusMlwzVOrATOzmi+ufgZIYgBGqU/Qbq53dcKMOJN+Or+EbOCEDf
	6PBLs61xb4PFB8jaa4j/U2g+RyxuXeT+O2EANs7/E5umUjtEFS+HiMRM9ognLmM3Cvdw0Y//EGO
	M1EyZOSzE+MZjI64XgwxMsNNHnC/Kw5EgzyjlmX8RJHnrLYrKt4oVP4UH6zK3UB076rCOgsi9LS
	HbTHIf70sN819exLjRw8Jn6YMi2QVQ3IZWlfv280aG8KBA5JIHpqwwVCwuRzI8UoyLfBekKS0eJ
	RUuhS6k8JQDzyclr+LR/wn2MVqrs/jAULBG5q9RSp7qzH0RA70xZOQxPHKeGhMmIo+FFLuqtdYh
	LHVMCcL50pLFDs8JFwSiJR2XssuxXhbxMfY2zppvWmP/WxnNsvO28OUB2dKKzQkS3BkZsy9k5Kf
	TYxOk3lI9Vg=
X-Received: by 2002:a05:6000:470a:b0:48a:f4d4:e1f3 with SMTP id ffacd0b85a97d-48e3ed1ef39mr167225f8f.13.1792788130622;
        Fri, 23 Oct 2026 13:42:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9c3:9990:89bb:701c:1852:56c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4ba7sm200998f8f.33.2026.10.23.13.42.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 13:42:10 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Date: Fri, 23 Oct 2026 22:42:08 +0200
Message-ID: <20261023204209.48556-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X1600's SAR ADC has four auxiliary channels and none of the
touchscreen or battery engines of the JZ47xx ADCs in
ingenic,adc.yaml, so it gets a binding of its own.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 .../bindings/iio/adc/ingenic,x1600-adc.yaml   | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
new file mode 100644
index 000000000000..7886836b10c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ingenic,x1600-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic X1600 ADC
+
+maintainers:
+  - Olivier Louvignes <olivier@mgcrea.io>
+
+description:
+  The SAR ADC of the Ingenic X1600 SoC, with four auxiliary input channels
+  measured against a 3.3 V reference. Its clients select a channel by index
+  through "io-channels".
+
+properties:
+  compatible:
+    const: ingenic,x1600-adc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: adc
+
+  interrupts:
+    maxItems: 1
+
+  '#io-channel-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - '#io-channel-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    adc@10070000 {
+        compatible = "ingenic,x1600-adc";
+        reg = <0x10070000 0x30>;
+
+        clocks = <&cgu 28>;
+        clock-names = "adc";
+
+        interrupt-parent = <&intc>;
+        interrupts = <11>;
+
+        #io-channel-cells = <1>;
+    };

base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.39.5

