Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7240912B
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723920; cv=none; b=oXJJ5nt5RTZVD+nA1PR3VW85PHWggy0VLScqmAB3KbT9MvQjfgn0rqCnIbny344o8ZKF1nJuIsG4Oh+jAWP74ICme+XOsf0DveAT8TzyV8oxeV7iuVoM0G6vADXqM1zOZDfELj+WRSMEqZwkdHKtDDay7/6NL3/up/oPTjKaVaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723920; c=relaxed/simple;
	bh=V5fWst+0b6cKzAQMTeg3av2XEUe1OOXEPBymCJlGpMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kd3QJJDVHFxIZRvebagmN4tf2LCBtt829MC/luG3zWjQs/zYeexyoA1EffjJOOtfHa7i0vXZ4WIzmQTLC4ZgyCHEGte4VszOznwaYRbA2byEyOzzbdSQzOQ3+akHA0JcnMNYuL3bKTf70B0ACugZuDA3sb5+G+FQtHkAHmbe6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=i1Xn8wgh; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="i1Xn8wgh"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb68bdf53aso587832a34.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 15:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783723915; x=1784328715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZdHmMmCay69oBUIlqzo1cr3jDiH7vEkdEbVbyYcLvkc=;
        b=i1Xn8wghAoxOry4OLdc+xG0lUV8gCN5CAGWc5+ixsdWf4gMOPwlEN3wGWbU00q1C4j
         dOtKox1UF6QQfQvrJUfRXy9TQrdBEgH/nd0n2yADjnY9YWi6O96OFw2B/22v5853ypXy
         Qr2KTj92lI8ZE4Pnp6UuS4wzo19f1qU/BYT0fFVQhXVQ7EvVDG9BiL+PYQtosHvqY81R
         mFbK65vbywxW1++PcRWxkXZsdaLWM1gT33+fhPB3E15uClHUyYLHMszLsN5F+YKbIWlz
         kLq/+F+U8Cd9WvCKkuGzRmvjDexHnkwdoshkyOrl86OA+N9UpZ8CdI7iZRD8C3t0dktb
         lhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723915; x=1784328715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZdHmMmCay69oBUIlqzo1cr3jDiH7vEkdEbVbyYcLvkc=;
        b=hOdxO4QU1y7UY3gzaKcrOdToH1U9cr//CjiCVWHwDsAIPtoOkjSIWJfcG3VPPHPqE5
         /xDlL7iB1PzNCr7VPcx9F+H90ct4NNvu13F+aJlSr3Xuh/byslCI+BsV0CMACQPt6bnn
         XoZZZHHyKTFXtFahn6I70zuajRsb85flsa4t0EHaUdZ4njtJJbEwXLoiF/OYTQU4znqW
         vTsNpbzx8vOJhPnmHBPSv63YNbmfDL3Llktj6qv7+r+Cmb+VZO/nwZ2bLdRNvWS1WcmP
         vl97G4XKCF6Gpx8suHGJ6ny1cvci6h5UPFy2aGr+YCROE8DTUefpyXfvUMaZZXU8UhdL
         D5FQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5y0WdBsKE4+Yy8nqF4vCixRH+2vXcNNWV5C9fLazLIOA3lf1oT612zeRx3+r6rYyvUBAn8ACCWm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47bbcdlso8CC1H6E3kKjUkWTfsSWWKgXYPVRzTlvAIW3PqlQq
	zMI1uLuvLhbNOkAU34SHtfHfThRo62HuP48jvhvkRV1H6KPYn2YYoeXJD85tRxVrSdk=
X-Gm-Gg: AfdE7ckBIkKMAQpkwi78yuzxS7WCOa93i0fxNEB0HSMu/pyMPyUgsPgAEOUGtZsKDOT
	3bPG8qDj4upfUr/Usb3YzK0UN5/pngw+Xo0JMu8xmMUpC9eUQYi6GcWMwuBD5sLGOtnwcNXN+Ez
	vGZb5V93Dd9y0xE/bL4Avvn73BUyTBm9FK0yf6Cdy7U/zj96PqglCRfIPA76OjWHw54gW2L0IxO
	XiNIHfobp6pe5g5ZrfTZKEK+Zq01EXXs8Y2SPEP8HZQWeKomAOPa3QwUYkQGMwbhCHEe/e3WemX
	37O7GRmCszPbC8B7pgLwncf5VW+3dPZg2ZB0Bpupl0lk0w8o4qCBX7Wpx0Wq5meoT7tsEs+thxq
	BlylWHOpJ2C744gIkp2VClEuZ89T77YnKAzUkFkwuYbf51p6pRHctG+i+Ae7n4IlCYtRkNgjiq2
	rnQm5fr2hPW/D6i9/T
X-Received: by 2002:a05:6820:168e:b0:6a3:1556:7a5f with SMTP id 006d021491bc7-6a39a8281ffmr740962eaf.58.1783723915693;
        Fri, 10 Jul 2026 15:51:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae177c5sm7613512a34.5.2026.07.10.15.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:51:55 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 17:50:37 -0500
Subject: [PATCH v3 4/8] dt-bindings: iio: adc: add input-chopping property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-iio-adc-ti-ads122c14-v3-4-746d52cbf1d0@baylibre.com>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1835; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=V5fWst+0b6cKzAQMTeg3av2XEUe1OOXEPBymCJlGpMY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqUXdfr2AfRGcSbBQp9gUXYSLRFDFyW0fGGy15Y
 yaW1INWfA6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalF3XwAKCRDCzCAB/wGP
 wB2oB/kBa75gl9Cpb8iM7Otl174qGVgR1fEOu4WEFz0tndxfU5yGdiEjyLPXO0VHTndYtBQIsia
 Z8Ym7lTpzSNazYMXGXOt3qhA7v32qGPu246eA/9Stz9/O3CzPtEkuNbWr7hZsgsKJXIjJhqvewm
 N7FAuu6YrhUPFyWdgJmNXjbnbn9B6AgRwCKQOUMRR/nnTRb1DtkqZ6aTgB78Fifwrd/+wMk9yYp
 /gj5+kCJNsAP0YFaKLYVICfa3FRBg+LoCo4cBczAdFW34CuKRMWqnrR7LafQN+IoUFpiVoTWML5
 KzvIXG5vyC3OVik8HqY0wE5zH54qnduPtoPbocJeSskmizgE
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a generic input-chopping property to adc.yaml. This is a feature
seen frequently in ADCs that are designed to measure resistive loads,
such as RTDs and strain gauges. Enabling this can reduce offset errors
by swapping the positive and negative input channels on every other
conversion. This can have side-effects in timing and filter response, so
it is not always desirable to enable this feature in some applications.
Therefore, it is best to make this a property that can be enabled or
disabled in the device tree.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v3 changes:
* Renamed property to input-chopping to reflect more common terminology.
* Removed "allowed" from the description.
* Extended description to explain when it should not be used.

v2 changes:
* New patch.
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 308857f11220..c408feebd46d 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -80,6 +80,14 @@ properties:
       ADCs usually allow choosing between internal reference sources or a pair
       of external pins.
 
+  input-chopping:
+    type: boolean
+    description:
+      If set, the positive and negative input channels are swapped on every
+      other conversion to reduce offset error. This generally comes at the
+      expense of added settling time between conversions, so should be omitted
+      on systems with high-frequency signals or high data rate requirements.
+
   excitation-channels:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description:

-- 
2.43.0

