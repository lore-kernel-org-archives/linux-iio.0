Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E8F349AE1
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504401; cv=none; b=UMeP6h4zGcmGrrKSmbI/38VRTuvrg+RmrFIhFJBlp/qLjs3c2Gl1xcDEFx38dmzUExffwXj3FEEl/2Q8cu9ZzbNC3yGUg7uQWfEW2e1k8YZD3aNNqAlKZ+dOha4nvbj9fWaUS/4AJ9ceoj5xyQbpMsJBCe5dAOywIPISWfnbOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504401; c=relaxed/simple;
	bh=lHEF6gffcSJSnQo4z2EbBuNrPboTiVaWCanIyhfeSeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QWxt/DLD8wMes4QQOZQBlaN4EEiiQ+J2gq4BF63FlKc2kYuMdTJm27Faldnr71q1Cj1EMFgnCXi1KC1q1qaGIAu99Kvb73m6w3bh8zJ+kbFwZ8v5jvKIN74+yTV8tq2HikKthD33dtmSBJBN78JsrwKB0Zy5QH83KP/Apg2/bAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iW3Jcuom; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iW3Jcuom"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6630858b4ceso4466903a12.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773504399; x=1774109199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+I3WG1paH1NyUuAIPAj7t3lCASphrEGmzEIZovUf74=;
        b=iW3JcuomsN5uwmuYAgh8XnBNYkOXoV3luzhQ99V+l6Bwv9qacQzW3RN3a7QjIyj8Z7
         //Lic3exO5wkJneyPI+S8GhXCw4QL9DBj3FtVDphK4BhybgDFUKLJvxOGmD57hbqnx+r
         AwyKTAEjeEoJQKkqIlk3JjHiyfZPcBtzU8rFgAjNXIJ3lJCy312oquV3M/x6X4yr1Ioj
         EgqqPO/MEoeFbg6FGahv3uU5wO+YK5fTmJtKrfavIuyM/wxeFuxmk4IZ4BQcCXWoO3CD
         oqoJAiY4WY2X7TMsLvZyEgpTYXfSyhx8YLdbRX3j+SUEXKrIqPwO8lKnylTdoGkVgnOa
         kT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773504399; x=1774109199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A+I3WG1paH1NyUuAIPAj7t3lCASphrEGmzEIZovUf74=;
        b=Iepy9xbwewosmkYWblnA5hQd9wUBcdAWjTPSA2cIj7xENxKI0xT/ZWPjpfvol0gSvR
         wEq+bpa9NFJ1EUYNXhbtZq03C9TZTwf2y5sMXkj6KbYfu8qPTeewgSMQJHUk4O1dhFIw
         G6p8BA02Gih68tZI3vCZRdE1Y1aVuu8DJ4ln9k9GU89YFnB3oiEnwmAQQK+sSghtccSm
         zVaVrk5vPAFBGxfjscHJy4m1i2WP45NV0C9ynkoAeuXHdCUBXXY5epwu4BabaeAfbybv
         7Dxo5RfqE6Tukd+LmBLTjTLmUFAhLKK2ZkrFwUstxU7S/Bs3oFfozVB+7pBjuWGM9gL2
         WTMg==
X-Gm-Message-State: AOJu0YyA09qtbzu075i5XOMvK3l5hAv5Z2LcbOhkO61NEVKqzPhyUgD3
	RNPsJpGbpCEgyKW3ysUPxKY+Er4ty2ncePthGgMSW+AI4xr0ITxm6CPp
X-Gm-Gg: ATEYQzxmH1ZP5Z+HXoTPyxybwWtGQ1gD3oIrwZ3pJDvjHRmRE0URhITZ+mOYMI4LCbk
	Y071ahIjP00ltqNrFzTZdHbuyMJGG6B66TeNWagnRyzUJAJsWUfD5teDkaf8nNj2MJVVr2N4ms6
	yRVnsRpqGJGE9vsPfSiHTnaLiIi0Mkibw490MYOctALvqA7ivkfJs7BSRx0I7b17TP33ikWGq7U
	9xwngBhOIHymi2OxM+45bgYoeBV5ym+jiU+0KDR84vyTT0JncodbkyeeeXMOlFm9Fb9t58QP+k/
	mf6yIViBjfcxIugm8Z+9txbo1+QqlyOagj2R6Dm/wUGcVGAF7qrTUUYiygLS2D0tH0AF738N4J+
	Us3o5Mp5KRF0uZus6pD1EmuZ809FHinobbY86M8H2vpi4zTsngmRczLwvDlnhpU92WPpPlggxqR
	4y4oGWUqomy6kbtyFzVzjXq1Mcjg==
X-Received: by 2002:a17:906:3419:b0:b8e:8874:8384 with SMTP id a640c23a62f3a-b9764f8b1fbmr330896066b.4.1773504398404;
        Sat, 14 Mar 2026 09:06:38 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b978b8625d3sm151722366b.52.2026.03.14.09.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 09:06:38 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sat, 14 Mar 2026 18:06:30 +0200
Subject: [PATCH v3 1/6] dt-bindings: iio: light: vcnl4000: add regulators
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-vcnl4000-regulators-v3-1-3c4a48d30676@gmail.com>
References: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
In-Reply-To: <20260314-vcnl4000-regulators-v3-0-3c4a48d30676@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

This commit adds supply properties for the sensor, I2C bus and IR LED
anode supplies [1], which can be found in vcnl4000 ambient light and
proximity sensors, to ensure the sensor is powered on before proceeding
with setup.

[1] https://www.vishay.com/docs/84274/vcnl4040.pdf

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
index 2ba4d5de4ec4..a1b4c02db246 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
@@ -33,6 +33,10 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+  vddio-supply: true
+  vled-supply: true
+
   reg:
     maxItems: 1
 
@@ -54,6 +58,9 @@ examples:
             compatible = "vishay,vcnl4200";
             reg = <0x51>;
             proximity-near-level = <220>;
+            vdd-supply = <&reg_vdd>;
+            vddio-supply = <&reg_vddio>;
+            vled-supply = <&reg_vled>;
         };
     };
 ...

-- 
2.53.0

