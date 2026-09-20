Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05073D566F
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 05:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882324; cv=none; b=JCp56eW6WZFJtG93Ju3QXICptK+AH1O5mK6noXG7HTSyabrMmVOdLSnuPiTL4opCIvcBxajZ3PgZY67fdwbgZ7ikTYyQ446QckA+bJmBOCUOy1NOumRvxnRD/kRqE3yPMS9xwBBvjlvoAzWZxB4KV4BmIQsi72/GLZhrzvLBe40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882324; c=relaxed/simple;
	bh=fwlPkqstrQlpYtzSAbjI/xkIKHHpjI1afmv6T7fC7po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eYpFT6XrwKXoJdvZNlVx1jhlv2wyatZeaUJ4Uh7QBvsu27f+4aaGVA2eVQPVQa/j5hf9uoh3WwbDpkqIeZ9IfkHvjgAqkR/xCAg6C2fYzzIGdHXpx/ehlaKWcl3ajmhJhTd5iKlNIhnPSX3dcABdXeZ+4W3ZPBog8yR2wjNmonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2OxweBi; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2OxweBi"
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6aafac56856so892863eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 22:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789882321; x=1790487121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SqP4V2+10gRQA7yGYe82IeB5bWtXD1MRgeLzqXm0MrQ=;
        b=n2OxweBimzodcV9kpyfGfSjjlRiIknR7qOhHuila2d3TDcvB5dv+ChEW7y4BpshfHs
         NJVtHmifhQzvOD4YdTiiQifW5pLf4lB6qA2G+BVpvMND2t1/lAYh9f5og187T+9xSGm4
         hSeWTf/YBPu4Cdvp00gJl2kbRa9tnB/Rg4IjghbnvCovo/EbnzWuGZo5bW98eDsD7b8P
         NIs3kLb71TAITRb4Yt1GL6jkWu67dKkty92YQw+LNtedqJWhRH0P8BFA+BKOSjWi2p0h
         XznFV16k1gX7kXxvU3iuPqNAunvwZdT2o8/791dGue0HF7akc/6zdQg698N70SP13hp2
         +4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789882321; x=1790487121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SqP4V2+10gRQA7yGYe82IeB5bWtXD1MRgeLzqXm0MrQ=;
        b=L5ZJodm9GNjBlW/BotcfGH75c7euzUF8oFwues+Aqskc8ETxw4vw3+i4r20dgH3nfU
         5fAZSJj4uJQ0NvVrIIFVfsV/Uvkqz6uRNCkanD1pkB3+uP0iLHvAi4iobgOJ7CDieZ+f
         2e43AOtIZxbzLHFRi/IYPVqpL9KJ1Du95mlhsxKTEdLV7rNxCsH7coJjBJCAnJ6gCKNG
         BmRjAvlqsusVta1BfaHjL1igegV0tcNVEbcsE/6o9WKBkUElCGWlzYP/Fn8pY9OirqDG
         TaTVh/+Jsmki8QibFqUsvlAvPKBZOuRVViA5cmsM79lYRYU1wAc4MPLTc2AlXQOFGU4a
         za7w==
X-Gm-Message-State: AFuF++lt7DwSjeM+6oHdk8hMx9dg0T83q/A0un5vAD+DqPXD4OiLoe9A
	GDXB0krqPhqw4hvgyDkXO35pmUxHvNbVt7rxFWqCa9esWlLaFOh/R/jK
X-Gm-Gg: AYBFou0xiBIYr1gbvDU0CO/HXqg3jbR4tNq13LCb25tSBphtwODiqDX8cIekMx4xmpz
	y31Jl1WqvTMjbzQmPTYAUJ8+QRmGraYQSCZE3p/SnJHUzqiiyr4lPIHS4yE4WWX4g/02nJsMc+7
	Zf1jOwYXn/wD88vuVgCuAOQesCaPTkSeBxmt/6enHSn3k2Yg2AIv7YmuCmxhuVe7oRXRIgrDptO
	FNvn2W8EjJ/JLTMU0C0c7Z3El7Mgdvt7bdtSt6eA4ZY9juVVedsSHMEV+NAGyMf1zG5eVlVxMJ1
	RXjjHN6zhA9TJoFmUCtjyhPZLKsD6JPVyGOYSVlGycmbn5wIMggSaeyJeVOrYx5EaDRlzr4rdEi
	j9n7DWDu8DjF+CjzAZbyVlMCiNS//g8/49NZGUBTL4v3yPmuProrFo93Er7VaXs1Yk9qzqm9VRV
	xRA5K2PvU5kPusCLrAl+i7g+bIpIATqjjd1a+Jb6jcv/tsiuO2N7vIWX90qKMx5vnqE5A=
X-Received: by 2002:a05:6820:c0cf:10b0:6cd:3fdc:6009 with SMTP id 006d021491bc7-6cd3fdc6073mr2569288eaf.90.1789882321459;
        Sat, 19 Sep 2026 22:32:01 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::2620])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6cd3541f07fsm5007319eaf.10.2026.09.19.22.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 22:32:00 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 20 Sep 2026 00:31:51 -0500
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: mediatek,mt6359-auxadc: add
 mt6397 PMIC AUXADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-1-c00edacbee64@gmail.com>
References: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-0-c00edacbee64@gmail.com>
In-Reply-To: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-0-c00edacbee64@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789882316; l=2681;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=fwlPkqstrQlpYtzSAbjI/xkIKHHpjI1afmv6T7fC7po=;
 b=Opl97KH8MrqT3zIoiO069ry22IpQqYaPkHHieyAt0MVeeRXmAV1cUFOzXcG3h4gqUISqz8ECP
 zcigdUcPK5ID5aT4XknZj1qigND/X/OZwurcQvc1nDaYdP5H9wRI4Y3
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

