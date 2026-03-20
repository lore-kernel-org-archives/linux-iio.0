Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B173D301E
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025148; cv=none; b=LEiITeQ8TdEFt0/2wqYaVxUDqGY/HTZtdCYEoe1qj4yft88QWyV50xTyw+U1nea2199njFXt9p4AH7Q/fw8wTi0OuqyzUvwyDHyemgUEYFcuDYRu+/UNGHM+yP8byWFw/3kEc9DUDMC5oH875kAuyvWeYlABAp5Z7BlhOQaulUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025148; c=relaxed/simple;
	bh=TDGGomY91nN+1JyvI5TZ4EVzE30ok0VSWE41vwKqiD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yk323w4Qx3rxOUJt+zdXdZjlIg7aMhOFf4A4Q9bgFaJ1w9EpPSoPQP3eHGUjahYGtfIjd8q2dFU4eR6YGX1NB6g21cKjMA9XTdOzp2jITUlRlLkLIjmRMTaenmZ59my5mrcAjc9QWKxN5ZNYqKEMk3bUkaYmaAHDh/TyNjefRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4C5h1c3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4C5h1c3"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b93698bb57aso439546266b.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025145; x=1774629945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0j1VhXqL1sZ8EwZY7NLMpbNkl6FM/lHHiEwrtRqEHg=;
        b=D4C5h1c3OjwmIar1o1LvKWf45bI8Z62PgEO3mAk42Ke6vDUH7rDapPLufhh6ZLLo44
         lK+qOPBklDCxqtzPjIh/qLme3MKwcEU26GjH3OZKWKGqcMFN059GdnA+sgJasj2Agx5Y
         ODNJy9R3i9wQaGRZA9UqMkoxxN3EN2ZsHrVduVQNwohiVIHlBnFi/1irwZZ7UlRKzuPG
         PI9z1Ty03tI9dWIvE9qpAqEt/uz/JUf3WKBMju8IC7sXMrWhSggSRGdO3Gv1rx0sLrma
         lLBDnyfu3dI9/WD3RandDaBSTIHxm/wEqQjnif55CApo80EDK3ubKSo1HBu8aSZxJohk
         8jUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025145; x=1774629945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j0j1VhXqL1sZ8EwZY7NLMpbNkl6FM/lHHiEwrtRqEHg=;
        b=CFhy2wTYMbIA5YN5CMYqc3zMTFBEDydmXfC+LZl8nyn8n4eI8TibdzBznlD2Qlu2hw
         mwi7bJvyAkjlLQtZbU6qaxUrDMP4vqO6skpyl3adyc8SuzOaMGgCEK6i1uZDyGZJ0Qor
         jRCNPabtNBeQJnfA8lKp3xvSM4mA0YLO8/Wj/4s8R0C85sft/CwtUDNNcbWQUYE4GaGh
         HDuDisosuP6qUACA47Xr7RPoZa+hl/eZOToZkA1/eY7Yw9GMF/WFrOeJqkxT6q4gVEd3
         heeqMfETmPaD05w6FK3aM0dO3He5Zxk4d/wiIuFMKKxb1BMh3bLoRrsXtVJ0TXh+eQGa
         NbKA==
X-Gm-Message-State: AOJu0Yw8IWYhtJxtj4WmgZyPdebljyP0xv5YOhcEz5MqYcr8iYutF9DZ
	TiGqLYXDLNbLFdnXwMaWvHNeAvON0XtSdl0LI1SXDdtY8tdSXjDp7ttC7vC/eGtk
X-Gm-Gg: ATEYQzxO23KQrPgoYLvVzBRNC9ig1zQrhV7x+9cBbQRtHUsaY+Y0GQkVXpJUXusRTx7
	qWlUobw0defC8jzQ7vNHWlk2fe/hf+tzHyN+4FAUHiwG7L+cyUOKKvzyxdH4JUtQEVhVdyVA0Fv
	CwieQSyWxlHNMrMHcLH9T3t1byOStnOBQN6pYaR1VqT/0koYI6wOZEJy8vCWXQVDXpAtfdrva1T
	UsIkHuM+Sg5/9K14P0FZBqY0OMhsIiaj252DLNREM4MhI/FEKjQqTb6gzCvp4JQ/jgTAOPGUyI2
	LC9XTDBEGekcYR40/qRABeGGGOv4tqpSAtajkPzQof1dGXjBJOX5hk/x+ZwZTXWnsm4Bvu4Ty/Q
	JIn58CXhiTcJF63hNwFiaUbvOyTyZBCWXiTeIdoGJ5n0Di0T7q+DObHTwmDVUK8a+/YXs24ZHZj
	L6a3vO2OWji0HXXVE4z6u9h45AYQ==
X-Received: by 2002:a17:907:94c4:b0:b97:3376:7b5 with SMTP id a640c23a62f3a-b980fa62dabmr489218266b.21.1774025144508;
        Fri, 20 Mar 2026 09:45:44 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b98335f1747sm176730466b.33.2026.03.20.09.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:45:44 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Fri, 20 Mar 2026 18:45:36 +0200
Subject: [PATCH v6 1/8] dt-bindings: iio: light: vcnl4000: add regulators
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-vcnl4000-regulators-v6-1-0d24d20b1a5b@gmail.com>
References: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
In-Reply-To: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
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

These sensors can accept 2 supplies - one for the sensor and one for IR
LED [1]. Add supply properties for the sensor - 2 for the sensors and
one external, for their open drain interrupt line, to ensure the sensor
is powered on before proceeding with setup.

[1] https://www.vishay.com/docs/84274/vcnl4040.pdf

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
index 2ba4d5de4ec4..516afef7a545 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
@@ -33,6 +33,17 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply:
+    description: Regulator providing power to the "VDD" pin.
+
+  vio-supply:
+    description: Regulator providing power for pull-up of the I/O lines.
+      Does not connect to the sensor directly, but is needed for the
+      correct operation of the I2C and interrupt lines.
+
+  vled-supply:
+    description: Regulator providing power to the IR anode pin.
+
   reg:
     maxItems: 1
 
@@ -54,6 +65,9 @@ examples:
             compatible = "vishay,vcnl4200";
             reg = <0x51>;
             proximity-near-level = <220>;
+            vdd-supply = <&reg_vdd>;
+            vio-supply = <&reg_vio>;
+            vled-supply = <&reg_vled>;
         };
     };
 ...

-- 
2.53.0

