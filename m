Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71CF3D1AAA
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734936; cv=none; b=KWVnyTHZ8Q0QLcO+nVtOQhN3zt5/E2cFkUzFKPXhaTXinxQYH2zwC4N//Mev5j7tBDvc3ykosro7WmlH/XBgMP58hxtNvbXzDElgBgbIdMSVnzjESgDfwcV1rpl+6YPg237Q0W2FEgI31wQsiFF0MX88mOF5oSKDyh7A2/3KJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734936; c=relaxed/simple;
	bh=0k6bV3LH2ghjcSL5r5b8oHagkbu8nFD06A6dOv4SBPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxp+EXHu3rkmzEYmvbLH8lAeaa9Frcn0LVAiuJJUWSiCwaWgWvaEcsoL9RQH6Ytcar7YI48RUD0TXAZbh+GMPx6XAn0mDb9Nd7Z1Suz9HDZ5vW009ZUDKDtZE0r1fU6TGeUlAjR1ByfDCYuSQOiEUJvztpqRKWaBFE1UKIEtjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCtFr+a7; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCtFr+a7"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7eb5a9f02e8so5995022a34.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784734933; x=1785339733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GK+FG51ApM0c5ceijH9gfcRis3iTLtG8+LrJylpTuMY=;
        b=hCtFr+a7eKK5JEtn0q9fxFuyVBkJ1F/ZLxiV2qgx6zJSBOaUCa6NgM+xbnFRtivXUI
         yRBcH1/0/E4Mx98W34qzzEbaHZVnsTGVvedbTjhq/ndzj5aYw71e+HxPbjIkEBY6wvOW
         EICkYNyO0qQ+egjXQiyov6aRTiLbfCrrLSNfUI7Qo15k9dD3KWDfZ9eAmc9o+/QboX0T
         Er3ZDiSEdGroK5A7jzlyK0rV2N+9uSHVIyKljcyJ/O4FJlL8pZKpgw4sIbKsWYHag0aJ
         NG7MUTrAQmc3O5yJKIREK2Cbtg5TB3hVWSS8oEDQ90GZ0uz7mpksBpP57BscblOYGIzV
         3K0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784734933; x=1785339733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GK+FG51ApM0c5ceijH9gfcRis3iTLtG8+LrJylpTuMY=;
        b=btBeZ/FTK3UniSNC4AzzfaYYHW+AFFuee1f1uN3KN0bMj2HcaAtFl0TsKkBVHQR3oa
         R84Xu6tXkE9UG26ETmHmYqtNsBtDzKISRxbn4TLzydm1iSd0M4L95ksU7OB1vXGsryv+
         LV9Gs75A2Slng9E1w3AzGK842siNdtzyZjhrlXKk6XbUBUSDzK4AqWzu1CUQ62gQuwGu
         sRKS+4inU7UuInqR3QKRvKqV48t9nl6V0WHkXP0CEuWo5qmwiH8jxafhkxdk+jQPBIcl
         6IYBwOskLZd6ZNpo9FlekCy8glA6m5YmsZEMZPi+DJHSEwz8Pd3518xAQC1t2EG0LGOA
         whtQ==
X-Gm-Message-State: AOJu0YxgapA3TpnDpwMIOG5KFIHrwr1WKtV186g267S8ViUv1RdNyQSv
	w1Owys1dkPlqx2NBGjhIg01luR6LTjDHHuw54E17INPbMSOqnoyGISRuVWJa4w==
X-Gm-Gg: AR+sD12IzPRhinvJ0wZPvuIZShu9q8zEnDsIxizJkn2vvdvKsZWxrJZloNRZkaZOqS1
	Aza01XEtPwhO4AEOTWiH8MrSdUBnqJ/vhY7SLe258AV8dqnciWESFyAV1i624rvzIxUE1zUbKZK
	tcCSkMHwFSkLQnTiTl/7IN1+0HQHNrhZZx0wGFUp/cpQ4eOLQ63MowHhtM9FD/xc6IpgYjVjqba
	d8abFUSKEbvBWAHhGLTcqpZdzECUfd7PWprkFg9xMHf2v8D9enqZblla/RibqG5aSjca3fl/EVR
	lgVQsdMzqxrcpP7hQ8QBPAt+mU5cJEh4tBr3TdB/7GJovZDry7V/1znQM3hzqHnyM0270AEh8Bo
	Ej9/dMZEjMcLaMuKgh6dKi8/S6sov/DyMgQBO5pddpPxZ9reAZCW2kN5FmHj1xqOL1n36Um5C7s
	LD
X-Received: by 2002:a05:6820:1844:b0:6a3:98e9:c979 with SMTP id 006d021491bc7-6a5366a2cb0mr12382376eaf.14.1784734931621;
        Wed, 22 Jul 2026 08:42:11 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aac3a494d4sm1300804eaf.3.2026.07.22.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:42:10 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V19 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Date: Wed, 22 Jul 2026 10:39:33 -0500
Message-ID: <20260722153942.144387-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722153942.144387-1-macroalpha82@gmail.com>
References: <20260722153942.144387-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the ICM42607 and ICM42607P inertial measurement unit.

This device is functionally very similar to the icm42600 series with a
very different register layout. The icm42607 currently does not use an
interrupt because wake on movement and buffers are not supported, and
cannot be implemented on my test device which lacks an interrupt line.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/iio/imu/invensense,icm42600.yaml  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 9b2af104f186..81b6e85decd5 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -30,6 +30,8 @@ properties:
       - invensense,icm42600
       - invensense,icm42602
       - invensense,icm42605
+      - invensense,icm42607
+      - invensense,icm42607p
       - invensense,icm42622
       - invensense,icm42631
       - invensense,icm42686
@@ -67,10 +69,24 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - invensense,icm42600
+              - invensense,icm42602
+              - invensense,icm42605
+              - invensense,icm42622
+              - invensense,icm42631
+              - invensense,icm42686
+              - invensense,icm42688
+    then:
+      required:
+        - interrupts
 
 unevaluatedProperties: false
 
-- 
2.43.0

