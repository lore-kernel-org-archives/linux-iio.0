Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1872436195A
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698024; cv=none; b=NBbIJMmtWcJ3TmdT9GYxOg2X9RK11X9hK8TjkkNspTTznztEqLrliXpoCC9ECkcAv4jeSD/XZC7Hh1WMWsLh9PuA+NsowFyCgdu0v3STJi/T4N2kEm6zr+VuWiG4985YqfnX8r81NgP9Vlxp4SzcPN8RjoD2Mh7KSpJQc+XN5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698024; c=relaxed/simple;
	bh=fwlPkqstrQlpYtzSAbjI/xkIKHHpjI1afmv6T7fC7po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPqXJbK7+7WzUe36JORITHnEyfyT6MzFhd5ChWB6yQ3Hq5sy9C/+pAl1fhuSNLJ2gVRjRoFkh7728zfGT7+8djrPGXpYXSH/U64gws/zluVqYP9X/TIVnsIN40GMuiUh2+l9LOn5T69V/KYWUDqGsuDgxFhcihT+0wVF07DgQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sWgwSNNt; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWgwSNNt"
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4c9a4910efeso75157b6e.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 19:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789698011; x=1790302811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqP4V2+10gRQA7yGYe82IeB5bWtXD1MRgeLzqXm0MrQ=;
        b=sWgwSNNt0yWL5eFck2KEZUlm7e9hGTU+v+yXOuttMIZ1ktUuP0WpoAT8H/hiE10MOH
         WBQr9tf0skJZBNGxdI18+cm5Nq8uH/MwI3B1yTGu6pkE0WKzcTiICQXW08zggU2IyaGO
         O3Fjxppmi7Mel6f1UWP/UtLzuKfUdaZqhBEeCS85rmJ0Cpvs4hExSRfCm+RlJiYGRUBe
         6n/I/lj3/cfWaLa4SqBBib+c+vSeaIuCacUFBx5CHZzNlssOogB9HvcS+1BllymKJFj7
         JrHvQknMSojS+Wa0hVbRldw8FgpfABxssrKdCrZOlSlgXoaqF02RpJVA8hmXXcHcw3Yn
         KPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789698011; x=1790302811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SqP4V2+10gRQA7yGYe82IeB5bWtXD1MRgeLzqXm0MrQ=;
        b=KTzAovIMbB5I3WAsN+u1KyZbtg64vEX5ykCNDNqUaH08yeHPquPieNBTwIBNofzlyK
         AuqqO4/LLKDuusVh7jblTN2n20YhmfApVQBLX+m3afwUdzvBF7P9gyAgzRmv8Dw4Ol2g
         +kCTVmk1x4BJRxYgNMFJhuEDyzyJnHslsgYNxlclPK1Ahs3Ga979GwLrZYjzjdyNjNw1
         iHZ+wxl+prBYZQiONULleLFPEfdUZgPX8Cda74waRXEgxqeCPeqpMoecWmpRY9+4N2G7
         bkIqDogaDUf1fslWMqH82Acc8APGlVBNGtzZQ5tWlLOUmQxr1uTYil38YjMla1BS+5t7
         IH6Q==
X-Gm-Message-State: AFuF++lP3J1A8Wvc+nF6Z6vft+mSdSJd9ObaBWZDS1zVIopW17VprC85
	rlOxTw36xa88qZ9F74ea/3BWhapMMG7BfOOQd4tQ9L0lYjzo9TQ9EMKU
X-Gm-Gg: AYBFou2cGz4xn9JiASjFfYRgD2O1EKO8tlCAXpByeLq4sMDmie//0zs55xo3bAKKLgS
	F/vikZ3XBxA6ZkHpIFWJg8ER1NxHEmknSMkoMtyc7Vt6K9XkIxiUeqf6K4NmVBtm/tsA6KOaGx6
	Py0W9MBMjH4gBPJdRXmBLx772Xjjej9CKwO6VcoyRQbcgFgScl5Y8OV9/FT8r3dPri8L5HvQrPK
	N7IVHhj1vGxiUm0CHRCSJYpxEanwLxh4JBQ6aWdWdzP4oEqXu9lCjbIhTsO4O/Tn/sFSUZCDpHy
	hzmbuYJkw61RxjS+X/T8iGO8dg9JkvleB9fqo/03rw0tCL66PfDb0MZXVhzE7eZBa//40C6q6aJ
	BCP6OQORqRuoARsPEApmSDy/JeZVtw3kLOU0qTrQk8QtRXfpyHw74BznqDJKj71/XilcJNflU+w
	wLVqf3C8Gm6r+pJ6kVx7lCxP3yuI5/mNa1024AZsGyIJn/HaUTF9AU5K9/zM/n1SX1hA==
X-Received: by 2002:a05:6808:3094:b0:4c3:2e7:55bb with SMTP id 5614622812f47-4ccf977b99fmr1600319b6e.38.1789698011513;
        Thu, 17 Sep 2026 19:20:11 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80e5226786csm295476a34.22.2026.09.17.19.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 19:20:11 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Thu, 17 Sep 2026 21:19:50 -0500
Subject: [PATCH v2 1/3] dt-bindings: iio: adc: mediatek,mt6359-auxadc: add
 mt6397 PMIC AUXADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-1-db35882a6080@gmail.com>
References: <20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-0-db35882a6080@gmail.com>
In-Reply-To: <20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-0-db35882a6080@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, mfd@lists.linux.dev, 
 Roman Vivchar <rva333@protonmail.com>, 
 Luca Leonardo Scorcia <l.scorcia@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789698008; l=2681;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=fwlPkqstrQlpYtzSAbjI/xkIKHHpjI1afmv6T7fC7po=;
 b=miNvqU66NVjsZoTcnVnB/kgVEaxWAqjFh9azbHOFtnGSnkRq1eftd6rcrmBB+2/4rlXYfBEUw
 Zyvg/aMLPnkBOPbEyLLlzDeEXx4kS9ytIIdtF8pPiaejam11tPa+fMv
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

Assisted-by: LLM
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
index c2414447892c..41d7b3a67415 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16713,6 +16713,12 @@ S:	Maintained
 F:	drivers/iio/adc/mt6323-auxadc.c
 F:	include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h
 
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

