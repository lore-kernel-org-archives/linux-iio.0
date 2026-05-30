Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D291346A07
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780111218; cv=none; b=qxZt/b210/PGP2xKDdZZcTpM0C7BtSqf1QRVGPuv4M18dGwCgSmzXLVqcXnO3zq0KMsVh3BHcFHIjB5xJ8qWfw2Y1HDatOZ8SwDh9z9cB7TVWCM0gQuiOUmPPyLFoXigiJf6UnSA2ACuSNJHvZot6YE+slFCbEtggCh9FVLlZHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780111218; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2NECaSlS5mkKBJceJtirJSydf/UU1ACOZvTNpER3ZBPMZbNL1WEzkQ3sQJR+l9YaWjECBliahC+OTcfAHrtbwEsHOaqZExyy045uiqLsPiecMD17g4GFreZ/v/qk+Hst/+GJ8Kq8eGMrJA34DH0CAkRdHtF7u6R16qA2W95Ko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeUFRL18; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeUFRL18"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69d8091533bso3734967eaf.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780111216; x=1780716016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=AeUFRL184/r9zeP6w7TjOO9W7SwyO9fwaHwo49wMIk7mkk1FNhShblGns/5phj4soS
         jHfA73cf8w5W5ZoMRRF57/vvB11B9c+UJqDZHZh8ouqJJS6SDLaPs1QjsESoa75t3aTl
         cR0KV1GqSzY6mtE1AkvrZ5x+U5eF9yTD5tAoW8vIXCj0IRslThG7Hr8KdBiequL04Gg/
         UdCanZN4HT2rCRruKY8lDMsR+yYid7gEU1XYG2f/DkDnEV0pQ3uLMqiqkNmGTtFjMEmS
         Evs/HtHTNy+2fBOrCMzyhZ842/L6jZXTNF/BElcVLSv2Iqn2+iY/0ygTu1Gah7+EwUD+
         ygUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780111216; x=1780716016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=RzrPwnncPdl9GxuXV70XvJHqomI97Yc5OMKhTDPDT5eih8INlaR0tFK+kCp+yCLHTr
         ZDPMhM7wd72fqay/u0Gbnqyzbpf+hvmWii+zZoTqrtEfaO1FwUwsQF1K9xZ7N+yno2Wt
         WGqMcFNxe/KOapN825Dr5cU3o0AkJgwmjhrhRHQsMTzMCRnP8RXIF8WHvxGJkFPrXnwa
         HqI2lHnUu1GXERxAv0/ciZQ41ivrAx60jaoRqLyiTIH8pyWz7RReObwoj+55ptHLqpxu
         OdKq1/OzOUAwdtJ3rnd227ZK+ddrzkDz3ojtV1w2NnxTgeRkJy0mo4S5hjNPTPmjcsYT
         puWg==
X-Gm-Message-State: AOJu0YwwxAwOxPgJAcPuaked72EWxlU5ZySP958WjiNNFl0l5cKsuw7v
	UBXFuDptFS1jAb6Pvx+AIXB7Z33UBr04IEh3+2bEhwXOcB3EgAs6AcBaGlaSyUvB
X-Gm-Gg: Acq92OHDkj58JHNMVSwiUAaslnePD3zUmi1ZE6crhmmOm5hu62x88Zd+oK+b76zFqV5
	hUFIRivjB8wmi4zlElUGSucuLAiMYVoMk8hjYBKn7lDw45sgRY1QPodImNCq44akr5HyeYAletw
	blATMZpEZezl43tzgyX8C7YwjYl7bP0IQO617YnqkdUEl7u/N3Mk+21y/IxEkMz6JXAb9JU9jiB
	LNx5KwidtVWNY8RtLj31LsqfbvKKzo6duPxtXciFrBqchjYXFu2sOtegHzEUdYgCSs6neQlPOMW
	8aPZN/U4TKrL1vY1EIJacdfh+oe3mG4Kuz7OFlyflE3qWKX+/5/kBpSaqM8ODZBuJongXw628m2
	YUU+RmvpIvXn6MX8ZFUPFv/6CvjUr5RYUYWIT6FaQaWTJXSWGO2w+aia7u89efiAW9eeAambXgk
	YoVG/iu+5QVWAItU1Ebu5+mt1a+MGgbsw=
X-Received: by 2002:a05:6820:1510:b0:69d:f3a6:1f59 with SMTP id 006d021491bc7-69e102fb42amr1171488eaf.27.1780111216200;
        Fri, 29 May 2026 20:20:16 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e067e911csm2130737eaf.5.2026.05.29.20.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 20:20:15 -0700 (PDT)
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
Subject: [PATCH V9 01/11] dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
Date: Fri, 29 May 2026 22:17:28 -0500
Message-ID: <20260530031739.109063-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530031739.109063-1-macroalpha82@gmail.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add mount-matrix attribute to schema. This attribute has been supported
since the first revision of this driver, but was not documented.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 119e28a833fd..9b2af104f186 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -53,6 +53,8 @@ properties:
   drive-open-drain:
     type: boolean
 
+  mount-matrix: true
+
   vdd-supply:
     description: Regulator that provides power to the sensor
 
-- 
2.43.0

