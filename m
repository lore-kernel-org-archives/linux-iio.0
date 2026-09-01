Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCE448C8D9
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2026 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288190; cv=none; b=UHd+qe9wzyTfrIv/JKa3gjYeAIVBLyL/B46eZHEATIrFP+3m9HCm8NvR2VTpXamv2qL4oUKrZJkaB+Kc52uldd49WD0LKQ/fuqIezRjHfi7AcmgLI7Agcgh6WMeSqyhMMFj/TF2dazkJPDyqc0UKJ+pW8kY+gucJ/x3W8poI7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288190; c=relaxed/simple;
	bh=Nr5B9X/EA/TPHrdPqN5lYHsqf+HIQ0e6gSRt/7NYRVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TN4iaStb2/MR7+RXAW6Hlb88b3xAU8mi08NDZq0UZTcrBCxXC/HEJP4m4WXubYWp6n12vXfZEkJ1QUwm0bzEJXMEOm8dB/tzGgJPOMk4kKK5vq84GvUAvkMedStVu7KLn1dbRQdQuLEmNsePPBzsUgbCQWS6P4WkIccNnPJ1hko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxJrSd+n; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxJrSd+n"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49557167508so1187045e9.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2026 11:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788288187; x=1788892987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gzeE/hU4D9bblLATFtWOwYmE1vpCRHRwseWHzl1OrOs=;
        b=dxJrSd+nCz1zSAvEg62OoeSgSIIoQ7VPBbdx1S63Ph3i/xebLfQdCsbjhnGyEUOIq3
         k0MyhHtUXoKPCCaWLi8jPm5TXnj5pHiboRpI54UJpW0GIAYSAh5slXJSf4HJeHAyqR+d
         p+mNx/QLVYJOelGxBtghwuMCx3BOZ4VZWFUBwL7rM4IfKUJw0iKEXduJxnc7ggpuNT7n
         yjKav6Esuyz7qQvcoqPkWpLD/bnsyoAcENOhNm9qQlsLpFYFB4orU2jzGow7OPzj24CN
         1S2DR540+rrZwGhP6kBiBO23RGLs3T7AffCEVtcV1CM39pS8Blxpswq4Zgj6MiKQ0qz6
         gykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788288187; x=1788892987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gzeE/hU4D9bblLATFtWOwYmE1vpCRHRwseWHzl1OrOs=;
        b=Zc6c6S6ewkujhyAyA072NKib4MuPOK2rK/vfQr2lKFxKlAuTx5jyGiL62TDwggra4r
         grASrBXKfhe/1iMCoDJCMk45AtgxFdtpOUaqKTAaEawL0RlGo6XOrc2l+qaqi/4Sewy4
         udM+os5ZDZQS/gmggCHZFtOBzmR48nlphwV8cAaSuLw857NR7cN8TwYQsHN9alIlQlL9
         eMVJtC2EHIbVBasVosS68VZvnU73i0+9fCywmWW0w61FKto8JfSxgAI0de/+HlZC2q+0
         ErDdPxhHhpR/3ATIiOIZOctzdQjps5CvgNH2Nt33wqQdlk7zaAuOfrrsVj2DdehcJQvH
         hkVg==
X-Forwarded-Encrypted: i=1; AHgh+RoYPERFQPSg2hY5Y4Wx7eWSwXdJvumSPWfa/NDc+h3SrBaNZJRaL1ZwJ+PlDRhtP+GBxVqx+oTgE40=@vger.kernel.org
X-Gm-Message-State: AFuF++mTOKDqvpklcrCDV7QnRAlvdgkwrDroYAArg+ygFeb/GjizirTb
	WYwKs0MFjcPkDSa+f+EzaSC605tX63SfKoBb5qHTNzJdxKlE7MjPbmFP
X-Gm-Gg: AR+sD11IFco4BT8rxYg5tXzaXL2ifT92UnaDFSIqj65ngx9bKr5GuOjn+Ql0TltO6zX
	ZMoyGAMbrufOJl8Ru8jxhTT/r7/CnobWsKEiwTYXJRCWog38AVBhxV4DKaqHAQKAe26TN/4V/I6
	OAkuXHBwz0mCL7PGB9B9lPjR5nwNuayKRF42pEKdsYhDFotRKdxBpCCbZ3nvkj3Xr01/qmhzUpQ
	is92BRzj651bVqZebTfWWIUb8fWNlnASUv7yAhrWQjXRPfgdfJPr4vwBI/4450MuSDKB1D2Dr5e
	rfGuTfQNkHFczgaDh7+pZptOhmyhWk3UZEWFyIrGGNG6LKCZEQg40V80AJwchTbfebD38kJMnb6
	uC77ZRUXFuiraJinUUtd3C4vRPTjblgOywtagMmji92wv4or466i462nd7q0vg7uRtlCIOpZM2l
	8RoEKKvuHjsx/X95UH50ED64GbUasjcW1apIz1EW/qRUHM8YQTPZBCmePr4IHObKHk12i2hc3Og
	NzOtYQS2QiPuk01LkmYhrp21RYmZP/5n9hj
X-Received: by 2002:a05:600c:64c6:b0:495:52a5:8829 with SMTP id 5b1f17b1804b1-49cdc558470mr204496575e9.11.1788288187157;
        Tue, 01 Sep 2026 11:43:07 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.67.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed30c0sm822987f8f.24.2026.09.01.11.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 11:43:06 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: adc: ti,ads1015: Add label property
Date: Tue,  1 Sep 2026 21:43:01 +0300
Message-ID: <20260901184302.8127-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for an optional label property per channel similar to other adc
chips. This allows assigning distinct names for each channel which can
match the schematic signal name.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
index 718f633c6e04..777a75c21d7f 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
@@ -66,6 +66,11 @@ patternProperties:
           - minimum: 0
             maximum: 7
 
+      label:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          A descriptive name for this channel, like "vcc_ram" or "CH3".
+
       ti,gain:
         $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
@@ -125,6 +130,7 @@ examples:
                 reg = <4>;
                 ti,gain = <3>;
                 ti,datarate = <5>;
+                label = "CH3";
             };
         };
     };
-- 
2.34.1

