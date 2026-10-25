Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792905497;
	b=PAF2rXC5F748Z/HkoXqmtFUNPHVeEXN17sg37Lct8z64M31vsQDossjuiE0nxFNs7yJq
	 RhRkJ3aauId/baH/+HC+cTQwOKAz5nggCMFr8h5pM6GlFBGvr9Nkgxg4xQdOCcWSiJDNk
	 LPG1XzyjbyXA+S1eQykkfPmE4H2CjsSp6WDLYJvczRMavINvRIryNgXEy9jZeaX/6+gM5
	 P7IeUBK5gvsNayB7kuORgsiJM0trc2LHRQKzNdUjN/MVnqPbAInOG2P/5uUWgL5BkPY7f
	 PIQ9CXa/PZhLbXsYVhElV8/1a9qIsX5ktxOvZUIohyJspB2fQh4ktY0VvWWgQT9TieQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792905497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Ao0LzEZOUNstisYoUSRpO7xtRQdZ2FfSYO9nengEgWU=;
	b=SsCE/lPm1pmnCNEPDwgUXMu10KnrTko7WGd+s22rymAiTNjPTmFq/5NcZZLh4ZWv5fwi
	 C6VH8Liq7TRl+wbGqScsY+0pOrEPR2F7HuGUrjU3SM86ffZWn9o0wEEgblgKlhkejSGhO
	 mRfu+KMfvnlF4eCnEExSruF+2gRLAq1ucsjeDy/yvOX5pgtmyXNMofoD/qfOeqGZxaLV2
	 iJDA4uHbeKPjsEWEZdpQyLy+I9nEtS39c0wFqa9T6BooInl4spcd7zChGAPHJxwD8c1OK
	 jdhwdQ8guBgn169oAhRNqD2WVynpmNhXkn9WMRfJ0pj0dwE2dpd+dvWeCrKnmYgz48Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E2Y2mH3y;
	arc=none smtp.remote-ip=74.125.224.129
Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C286606A32D
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 05:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C286606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E2Y2mH3y
Received: by mail-yx2-f1.google.com with SMTP id 00721157ae682-8b0b14dec7dso2403867b3.0
        for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 22:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792905495; x=1793510295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ao0LzEZOUNstisYoUSRpO7xtRQdZ2FfSYO9nengEgWU=;
        b=E2Y2mH3y9BR6KBrsEgj7Sna2sKPp9+kmOOJJM4cqS0AN88itfHUyGGAIFtcLfpKd70
         0xfYWCBIxeB3ADWEVUvcXMz/u6JdJvcoYeZAWWrJUL7Qx/IMaTAINZn93dTnbpjszQUM
         /9IiEjGy3jHj+qDM1OrSblWbhfSdliqBbpaDaqjA7pSM8yBYGBmSJfPPko53WsXhVRvP
         Ohbj/7pm5tYKJE6OQslsfo5/82solLi/PhES9I4mniBLrWzN5/1fnvEoDHMBlnqVO8to
         ahufBHThVj58T43LabKebXpghhYtEzLMpcW3GJNX7iKAlkcRc1+dVtUz+jrpSRXl1tQL
         YXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792905495; x=1793510295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ao0LzEZOUNstisYoUSRpO7xtRQdZ2FfSYO9nengEgWU=;
        b=W/LBIf4vVM8M+Htw2n9jGZFKRDXMtjvrGekYwPs75VYhmj8i/X/wiaNqkKy5uXC7T2
         82avF2MpBBkE1f9D7d2oOEl8453MK1Xqv4ANqmLBrXGsmM1sy/pUejFFXjJzzvlNevvm
         37UGkpmlYrLKyCXr1n1lzPV2shTl8+WHJytiHEUKn1E2PTcZxg7jSvHSPq4maojuYiIc
         CB6gsgut+25BE2TCNz50FubBkzze/tCTDLeago1cZ5m+TQ6W0TG6BGH4BMuTE+U0tVAi
         ObynOcKQxz0ffghwtcMTAKZ/6kU1GyUHPfFA/QRzTtUc0dfsxxCu9uqDqAbYQ63vvhx+
         098A==
X-Forwarded-Encrypted: i=1; AKwUvBwLWRevopSc9uZWPOaHCFrdWZp5n5kn4eQsV0mEse4X66MwR8rzs8JsefvgzDtwjH45quQyKy+/5/U=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTB+KuMoGdVYWaDzN3eu9pCwpeMc7Q5Bm2YfTWuHpuX/U3gSgg
	2OPzmdhCSNha8NANfbJYj2kkvb5GKiSnvUcRBLwj2bGuqch6awn4IEUM
X-Gm-Gg: AYBFou0VOIDEs1+eO6ljum1+Voj243/SXVp6FZTyWROB59FUsZ+i+2AuFpaw7LXnXl0
	QRRq77iKXazhxeCFYRU2BJrhxiHppp3gWOySoGEGDCQr1t04Dm/NORWp6bADCmFMgpfSwrxZfpR
	88mQ/aSUIB4gMOSUjMhiweRGoErHiLsS340ut0gd4OG/o7M8vXkObxLkNIDsINvaoeMR8FdJPiY
	QaYaCodARY1WoGlUkpbQakfbjn7CKGPkXi7S5D9jqxhk1znyI8UU9RUg4IFs7o46uZSOghyNM9M
	Q45i3I1zxMw0byRjygnBQOE2DdX4CcO9XCtXN6YAgvm3OmY1iAR9LU7Vk0D7X8G78n/Bm7LBDrg
	BsG+tRJfsUXvvJUAvRBGaMy4UjMfDiM+kJpHEFFEw3VbnqKUfIhGEkzgRLEd/uF0N87KzY3K+OJ
	NaaYwglakXNrGmrHWEZz7vK0WvBWJDNXUN5M8qVsnDUzKAvPanFkBAGrRPciBCNKOcpH8ftQgua
	AR8M8PNn4ped3Y2O1B1Nk0myvxO57L8WeI+thYXDemRWg==
X-Received: by 2002:a05:690c:c4f9:b0:8a0:e27e:8e75 with SMTP id 00721157ae682-8b166c6f987mr22449797b3.82.1792905495289;
        Sat, 24 Oct 2026 22:18:15 -0700 (PDT)
Received: from [192.168.1.91] ([2600:1702:894b:4a00::12])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166c5d605sm16477797b3.5.2026.10.24.22.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 22:18:14 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 25 Oct 2026 00:18:08 -0500
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: mediatek,mt6359-auxadc: add
 mt6397 PMIC AUXADC
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-1-5c3c7a5a1851@gmail.com>
References: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-0-5c3c7a5a1851@gmail.com>
In-Reply-To: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-0-5c3c7a5a1851@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Roman Vivchar <rva333@protonmail.com>, 
 Luca Leonardo Scorcia <l.scorcia@gmail.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792905489; l=2798;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=JdiGQh0KVm70DbIkS0pQKFBLtV68drIsj5z75XBPwxA=;
 b=YQht8FlXebiSXOai3WM/zuvpDL9fEatxuBpgvv5MqOVMjp8xIC+PbWFLP4Kp0ZyoptsaARv3W
 OS3S7UU/Wv5DKYeQ8hVE8LNFldXHmNwewYh+zNK82rW2cP6MJ9/KpZd
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The MediaTek mt6397 PMIC includes a 10-bit AUXADC used for battery voltage
and battery temperature measurements. It is not register compatible with
mt6359: a conversion is requested by writing a channel number to a select
field and pulsing an edge triggered start bit rather than by setting the
channel's bit in a request register, and the results live elsewhere.
It therefore gets its own compatible rather than a fallback.

Add the binding and the header naming the channels a consumer puts in
io-channels. The battery channel is named for the input it measures,
ISENSE, which is what mt6323-auxadc calls the same input.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 .../devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml      | 1 +
 MAINTAINERS                                                      | 6 ++++++
 include/dt-bindings/iio/adc/mediatek,mt6397-auxadc.h             | 9 +++++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
index c2f7387e4bfc..2847bd5d5bc4 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
@@ -26,6 +26,7 @@ properties:
           - mediatek,mt6359-auxadc
           - mediatek,mt6363-auxadc
           - mediatek,mt6373-auxadc
+          - mediatek,mt6397-auxadc
       - items:
           - enum:
               - mediatek,mt6365-auxadc
diff --git a/MAINTAINERS b/MAINTAINERS
index 02426f316faa..b5417c02eb01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16780,6 +16780,12 @@ M:	Roman Vivchar <rva333@protonmail.com>
 S:	Maintained
 F:	drivers/nvmem/mt6323-efuse.c
 
+MEDIATEK MT6397 PMIC AUXADC DRIVER
+M:	Ryan Brue <ryanbrue.dev@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	include/dt-bindings/iio/adc/mediatek,mt6397-auxadc.h
+
 MEDIATEK MT6735 CLOCK & RESET DRIVERS
 M:	Yassine Oudjana <y.oudjana@protonmail.com>
 L:	linux-clk@vger.kernel.org
diff --git a/include/dt-bindings/iio/adc/mediatek,mt6397-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6397-auxadc.h
new file mode 100644
index 000000000000..b696c1cb5ebe
--- /dev/null
+++ b/include/dt-bindings/iio/adc/mediatek,mt6397-auxadc.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_MEDIATEK_MT6397_AUXADC_H
+#define _DT_BINDINGS_MEDIATEK_MT6397_AUXADC_H
+
+#define MT6397_AUXADC_ISENSE		0
+#define MT6397_AUXADC_BAT_TEMP		1
+
+#endif

-- 
2.55.0

