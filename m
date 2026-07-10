Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47D407CDB
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723913; cv=none; b=hl2+yND7iZK4z8TL7gwVhpZ03ESX4xs7ISJnsy+DtoP97jedb1Wj85Cc2OES4Yza6lKSZ8ifrHch++raNM0gJo5UzMVkzzP+o0u2rRpaNqj7mYGtNYAnwZXSr2umevKtjAjW88JP2a/DTKwFUC8anB5ATrWmy3/YkxFbBOgyNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723913; c=relaxed/simple;
	bh=s5we3EIogjcFMVGpKBg1jRISXbFhD/6aQFi9zxu63xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+O7jRdllTgyEelEjlogUu6xXWMn7At06jdaBFUeX/ze37VZ6Fxr4YRXtZoakCWc1EACKYYsSOG41sRrXu+VfmEl3yVt69v3x6PS57QKc5ApzNShehoeIvYkCOsxMRnqRSa0aEptK3b4V7c75GVvO9L4m52U21bJBVbWJ1+cytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dFAHVYAo; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dFAHVYAo"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e9f69eeb6cso888039a34.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783723910; x=1784328710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CnM6cAp2TMWm35jXNIN+b+Kb6RD7lXwbzaZa1hCMfZM=;
        b=dFAHVYAofKR18Koen/BF4zwKlcfSApRiqLsRwS0759EZMB4XtDCNacF9zNUcB9IiH0
         pTJvFKES8MvkSGwwIkCRNt+yEWx9LWR7TMOhsB1DaM1bFqVORrNxRV/cu2dC7Bxf9pUy
         0cnwEjsskn4kkJDqobbMJBo79Zt8vQz8g3/SS9WNUhWnpuIEY9VS0ZVYe9iK5SILtX5X
         TAqDlhvfQb5Ulxmdx/C/B1msaHUIm8KqQB7yJlbF5nsj/U+To5tRvTnWl0KMupz4Mm4q
         YOFa5296L0CdU5vm1xhMX28/YpN/hzhVc0lu3ShdadVJHRMDcqziR9/fANU3omkBT+YO
         j8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723910; x=1784328710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CnM6cAp2TMWm35jXNIN+b+Kb6RD7lXwbzaZa1hCMfZM=;
        b=QcO7AW1wSpB0CNqlpYgs0qO8EfwhIjbkHK0qSF5mcUJ141ibDYNm08tMuKHgBqfaax
         /4uPZW5kGtOvrZ6L5yCn2Y8UbNtGFJRZCxc20QOJIjcu3uJwa5sZIC9PxVS+/3TiME+4
         jhrK4tTtzIHDQapwojrzFEk4MQfbtYlGC6rF2TNZ1oUIEFykbx8RPTr50K1qmOuCQnoY
         +nKlRAeKNve+KQLfkq1/f8VRPe/yqnCVLj28Fad7Zy3FADG/FRioVZFnHe0L43Cr6zab
         rTyRF/9thqzIa/lYWM+4joIv9gYUU9igh4NBLvuDNyj7oZCh0WLx04IHond2BUlok+eE
         xXmw==
X-Forwarded-Encrypted: i=1; AFNElJ+lvnoJ2NDwZDP016eDbPBPGpfjfnizn2ZKS1lPNC1wC4Of3FGpvUtNvW3C5SsS3Ckcd54WS3ZCxOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8miS6VxFkmGMC3SS6xrXe0WdR+UDp09ZqZsOCuHBrgNrPQaA
	051kJvgtVvJx7DJQ04UMnjPIPltQxvtrjbAT6ajGRNB/k0rKGRG8KQyj5SjzwmqGY6Y=
X-Gm-Gg: AfdE7cn0R3qll9vn6Vp3z9/kJosh1pyC936SyUNxM6anaNhRNT6vBc6XD3E4YEC6hzb
	pV4Am1aFWDm4SdhYV4+oyWJDnZYS4mpo0K11BbkYYL70HSFI7wcQoisUI9JA7hrgJbJMeA/V9yf
	Uz1wICBXvVv0+980ZFfe/p6DZ9hOUVwqjBcNQMhII05RNMe+smVO1yaMxWSNExLAbfgrPKbn2gr
	Cuyd1Btl08haW7KJQSmhGAcvODsCEKoiPN71TX76mckMnzfDbjoadbMJn9SjoKZkC4hhLGt2Byn
	lpM1EO90Wlxgbsdu5cbNDTKE+vNY6GW/RvhW0rmpm04NnKTcb2n7e+sKlmDjzqP9vPaXYI8Eojv
	FPiMAIQfBVtYwQ5TkUPOoisTd+eFFZcbps/AWdkX3EUYOBRo3fLnmXnlIsw6lkCpfCGf1mxfqnt
	X3HjvsTwcZ8wSfITsr
X-Received: by 2002:a05:6830:dc5:b0:7d7:c985:3a30 with SMTP id 46e09a7af769-7ec096772fcmr556049a34.11.1783723910329;
        Fri, 10 Jul 2026 15:51:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae177c5sm7613512a34.5.2026.07.10.15.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:51:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 17:50:34 -0500
Subject: [PATCH v3 1/8] dt-bindings: iio: adc: Add reference-sources
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-iio-adc-ti-ads122c14-v3-1-746d52cbf1d0@baylibre.com>
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
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=gnJcOpkZvI6QrZ8vVSRd8XUtUDqGn+U84NE4BPUS78o=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqUXdLdBIxUMh8djEQQGZS15inbRwmeySTH/7Xu
 OGzaAFwsRqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalF3SwAKCRDCzCAB/wGP
 wK4fCACN1zA4AKg+WrGqIBacqTUYBki4LyYu+S9YK1DP+11MYY1sx0QxQwJcWnfSJSlhvUEU5ag
 5RdXqvJFbIvwoVi7a/Bql8DaUSz8L2p/uNmO9sBSpYlAl9Lo/CM7PNytb+wc5FF013EoRMagzVk
 /5DEKcV29l1m6hdYQDQWYsk/EtDDeT5oAkoXwaY9pv/Rj7NasKFbIp00XpZjkYh1zQYcoSO1THZ
 uaFF7IAqU154zADGgXyt+gx4D3kacukKFzg21Zfl5Ha/mOuE6yXu+i58+UAocFCqikKQ986cTMn
 xJBRer+t7GjGCZXOTqg++PuvEnbY7yDomjJ6I5L6xzQyVLH4
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

From: Kurt Borja <kuurtb@gmail.com>

Some ADCs have configurable voltage reference sources for each channel.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v3 changes:
* Removed minItems.

v2 changes (compared to Kurt's RFC v2):
* Drop maxItems.
* Drop 2nd paragraph of description.
* Make reference-sources plural since it is an array.
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index b9bc02b5b07a..8f608bf0b24d 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -73,6 +73,13 @@ properties:
       device design and can interact with other characteristics such as
       settling time.
 
+  reference-sources:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      Indicates the voltage reference source or sources for this channel. Some
+      ADCs usually allow choosing between internal reference sources or a pair
+      of external pins.
+
 anyOf:
   - oneOf:
       - required:

-- 
2.43.0

