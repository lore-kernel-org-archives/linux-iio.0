Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78542DA29
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071362; cv=none; b=fwq3/fOimmen2xliqP7pIWP02qN9VEQNqOX/qY17whV0JEq0smFHcZaADYfVUplv5OnqcWcKjuTVsAtr8oKtGRfVa5o28TR4yAh1ZJoxinFlJtmblxHyQC+VpWjfmg43OcXXFYFYDEcakDw5hy+Pbfuc3RROfWFoHjaOjOwjeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071362; c=relaxed/simple;
	bh=TfVJkaOJjR+FVvEc3u4C1RbJVpPaZ8OuJ8zPygdP9l0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ad4R3AlTxrUslUrayXg3G208hVe0c1AJgm2E0T+7S2vEQz0AUqDv5AnP/sNV3SKuvyEInp60JpxaJ8TnIDV3J8+4B66FLyceJK5aZWh0tUsTaURARrqaw910kMVeZpcwfw2QZrjp0eTfu0uMquFERQCf7c+uBDhJ3f1ocrHirTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=T1GT3o0c; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="T1GT3o0c"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a31b9a492aso3134660eaf.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 16:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784071354; x=1784676154; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S6toAopr8F8rTSSWjDWDH2rtjDknkrCnbrvnm6omNuY=;
        b=T1GT3o0c76FuNUkSFWHMuuPVTOfezivPGnTZlW+h0I6vLADo+HsiHDNYtpoAukeYlv
         4abpoHzayrS0SVJH4YCUUi4cizuEVV/C1YToev08hgrhwi5Ys0XwtKY9ClBoWtD9FLsH
         Bn1WFOgOko9md19FLM+fT40KwsAdBYFo+2vPTBjZIFEL0AfwALu2z5WSeFx1i+Gthqju
         ta+xDAF7oalrTDJ7FgJ0FM8yPFTWFtPjJaVDVRfL5xCcUMtefnYUV6EkKGQ/m8n0dHse
         G2YinPbmqJbll1TQp+pi6trd6t9/cGJoyoTgHC/mFCW8lcynU7OkT5BdgD0pX9lY46Kr
         4VFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784071354; x=1784676154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6toAopr8F8rTSSWjDWDH2rtjDknkrCnbrvnm6omNuY=;
        b=feahQ7djKtlr3VHFm4TPE0W/3/+N186Yr0Xi/ggHguewuvn1ivhxKJ3B7G672Fi7Qk
         enKiT/Xd1xy+6bmqob9CvSURS9DEecGwiN6FGBCQJ7HvrHTMyJKxFBKEwnFWG4afha7j
         5mt22oFCqNCTRcljLDHn7vyQsiaYoKF0vxCGEqJe9/+6VrjLqaqo1uP/ly9gKnx6x8Qr
         Lhz/u57iCv5TgZhQA9zuYWfpiS4Mhnui3v/TvC5ov4QRjI/kioMRChW35mELXP/0HhqL
         8fqHX8EenGjEi4cPSoOmCmdRNUlXR+zDjuBQQwGULgFDzSu0wMq3i5LKflHsJonVs18n
         9Qtw==
X-Forwarded-Encrypted: i=1; AFNElJ/+b6BDjm9iyOIyDyUx44tJN5LJIT8mdd1STolvW1MerScOnkzAhv3AcPKUvSl7ssKKRv0gtiyBySA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr5n3YAQ8ii47KY4NRz+9aijCMuxyn5urbGFiGhAuO/N2/PMQX
	nbjhhUUUwboGcm5W+epxUc2tQuKJRs3NXlGFB8cpJFCC8rrSoSZg/0eXzfUKW6Hluhk=
X-Gm-Gg: AfdE7ckDkAho2XmLZeAaLZ8gcOfMxo6q3h1CfEvC8z/05R0VR1JZxxTDzMXSBEFqShu
	kXVg9Vk45jdHHTo5aaTlHsixEa/fLJJAAa/EhuCPAhjx+pR9F43wnc5zgoD19fFm95Ujs6zDoZH
	VZTm0DE9d0STymgCO65xvVfuAzHqDTU0T6L12s+omdvUEtWlvbLVywVMfpgAGqRQtZSpoIGNGr3
	fmy62NVOQ/Afhnh3FH/360tv3WYcm6uxdskQxrsWO3wBxQQ8dC1gRa+QXBIUg8ztKVOjLLGwpZc
	ikT+xXa/5tFcP1LO1J0wgKqY+qEN/fePoR7w9fXBdm1Xk+tZ7L7RuEpbUdVMQG38Q6o22b5PCik
	kH6XBXAee6/FeGn5skF7iy8Wp2sLqSY3EH+GElCIzzOtsk6VMs8RA2aZwPxchZdXnJOwayXP02r
	E7c0Bcd6W7WhuLi1kTUg==
X-Received: by 2002:a05:6820:174f:b0:69e:b41f:1963 with SMTP id 006d021491bc7-6a3cbbd4a5fmr2341508eaf.48.1784071354502;
        Tue, 14 Jul 2026 16:22:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a39af0e953sm7561978eaf.3.2026.07.14.16.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:22:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 14 Jul 2026 18:21:25 -0500
Subject: [PATCH v4 3/8] dt-bindings: iio: adc: Add burn-out current
 properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-iio-adc-ti-ads122c14-v4-3-25f8e3084485@baylibre.com>
References: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
In-Reply-To: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=+GUNuuQMtib4Kibx1H+tAJiwv94cfO9xjtvXTTsu6EE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqVsSK2ikdAzyGcKq5rUo+8ZJ2AvgO5A2eHZ4U9
 CcKvt7ojLuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalbEigAKCRDCzCAB/wGP
 wJysB/9XlInnk9loRJLMo2JjVVmYH85uIxCwTOFEILsZbeDdS9cjEofLQkwJPzqRzQZ8qmQKvjS
 FQP6yw//jnCqzuAlzHSUwbWLQ6W7HkqJuqrTbcRUrYiMd3c4mz8Q8KKlLYlrSWR2ttwl96ptPI+
 5iqB4ae43XBtvButX/ehtkUdNgEuW46lMiX8ueBMvFx7BSQspxVgeqqQdZ++A+u57X/aRvPvuA8
 ywTOuIw+EBAtp2ukaipdrnFGGQENzVyj7yM2aO+0P6xaE3uLbxw3IjjMgMoOfB0+zRC1I+ZW5Lu
 Y1O6AZlJOwBmFHtZQWLcIAX31m83L3qlc3FlXfS/CmfqQDbX
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

From: Kurt Borja <kuurtb@gmail.com>

Some ADCs incorporate burn-out current sources that provide current to
the channel's input pins for open-circuit or short-circuit detection.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v3 changes:
* Removed maxItems.

v2 changes (compared to Kurt's RFC v2):
* Changed units from microamps to nanoamps to fit known devices.
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 9f7196d61ac3..e1da63119648 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -101,6 +101,11 @@ properties:
       sources. The index in the array corresponds to the same index in the
       excitation-channels array.
 
+  burn-out-current-nanoamp:
+    description:
+      Burn-out current sources provide current to the channel's input pins for
+      open-circuit or short-circuit detection.
+
 anyOf:
   - oneOf:
       - required:

-- 
2.43.0

