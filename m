Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0023914E5
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134874; cv=none; b=AzMzltuS8xn0xab9tf9QxyHQEoQ1IXz40MqswfOmV4JXbJb0bsvrktcBys6LJKcswKbu199pyTlBH0YlqxvyClYHFqYJxjDojtzSjaUeRUABLN9CUX8XTMHB3p94V4tGMjDt4EJSGBkIpGk68sYswtOYFwolVGWPwPKcFmyFaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134874; c=relaxed/simple;
	bh=mg1u65/hNDUSb1m380zCiWkHQxdvyCwTPY+JWCPvED4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xd7A4V+jz7WGPqprfH+5J4L74m+uUIg8IY18GyQllJzvlqSpnmlC9uWlCAEqLLyQDSGBTJ/qwrwXexoXjvMzfko7Sf8vEs0dgUS4+MVammkGjG0otaZuNUP9zMdvb3NwVfHKJGlaBYo6ZlE2l7W08b57MpvfnjqGXRPz5Q25waE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flFdXhUI; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flFdXhUI"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69d42abd04dso272411eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134872; x=1779739672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+2ydEn6hztRE9Iv70/dCmwY4D4SjSGA68XyIdXdlEs=;
        b=flFdXhUIOb77A4qD3Wkbs1ccsPzMzHQZEf08uiJLzXD0bHZT/hjUiP8H+ZdtlHmYF5
         Nz3CKOwnjD1piCMqtHwhgfdmWfNW2U9LaUuVONm7v83SWFQXbUceLBcI7pij8FgVz5yD
         r8zEzdv2wVjLxAw/rwloHT+civjbd9g+f9urgLuQ2cNO8CPRTKMDNId4uUUYnEngUqd+
         axC2YNGPmNW+zvplguRmJPi1rxYkY4tMs4TIZfSYw8dSupQoyu8k0FzZmw+6JqlbFYmS
         IoV3k9UgG+4Ny0YOmLb/pmPOlB995xBGDJTOfOtpFGtQ9T5YMWsCDr0Fcwyp8DmSpdlt
         9gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134872; x=1779739672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q+2ydEn6hztRE9Iv70/dCmwY4D4SjSGA68XyIdXdlEs=;
        b=hbXSpNDfZD/aBoUGWlwo94upDIR6mzx7LzQqH2nnQOQd3jRZRwaXB8NiOpOFi+Knt7
         SZfVcVB5YiqL2XrnzWNhIDcO3rYGctxdJyJVtElgpibZhX+QuYyB1bJZTvjteku7p0/Q
         UQvIG4sF742OwbDqRc2eWN2SiGD7SImN7ODirDNfzk8TlhQ+ndOqYtLppxb2eiNaUOAY
         NYaOrGsUJpgZg3QeyGHPg4GnaTusWXfQp0no0F/XOpAGVOAeYPl/rOsdh+bLve2rGfOl
         xjxFRhzpaIVOXFzS+AtlkG050zirHqYeZKY9V750OXWyE/fph1zo8eo66v/TVvcdv0wB
         lodA==
X-Gm-Message-State: AOJu0YwtKAMIVg5WAqh2IaCq5U96WfFrxQklWbbXESmQK/0HuhWMkOv5
	aTcuvRQcVR16YkpL3Mg22nhMke3OXMOxKksPk3oHFx/fulDaG9HP+aAmVeAEaGLX
X-Gm-Gg: Acq92OEvPkQWFAFoTaLbM1Z1S28+3L5bm0WwpTbkwGetlXGhijgHOoZ2bkbGuN+vnpn
	ukXYs4l2taP9D/cpwDVOnGEjFdyETYfjwB6x5Le2/vej6jW5aNsa206YI3MSs/LPfBgBVSf00hz
	M+82NTVUcjM1wVBpBZjAdzEDhqh3//l/NIx9S4ru0RoCutaasQcENkDfrSU5gpERM1VZuVelyBJ
	s4jOnL2udepL1ny3LCTO9M9nW52jIVd+UvUlkDK48O8CZo8YNjkmuz7Z1yxeduJS+R2IXbysW1/
	StP4/hI/hELKDWcX+X+4aCijvSMitZPuxQUcyUCxwal3MbvfoFLutryFXKTjPPtdXH/oNmERLni
	G6QELmV7a6BpMr5U6b/1g2I2sL2Ev3bdTtwF1IITdIjB/2AKxYCWUXhGIT6R4rzZ2Pvo1f8SiVU
	kw1dH0X5BxCWJ4mLVOdYrE
X-Received: by 2002:a05:6820:a04:b0:69b:5696:e63f with SMTP id 006d021491bc7-69c94303bccmr9698331eaf.24.1779134872076;
        Mon, 18 May 2026 13:07:52 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d0462e85esm6113360eaf.6.2026.05.18.13.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:07:51 -0700 (PDT)
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
Subject: [PATCH V8 02/10] dt-bindings: iio: imu: icm42600: Add icm42607 binding
Date: Mon, 18 May 2026 15:05:17 -0500
Message-ID: <20260518200526.458421-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518200526.458421-1-macroalpha82@gmail.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add devicetree binding for the Invensense ICM42607 and Invensense
ICM42607P inertial measurement unit. This unit is a combined
accelerometer, gyroscope, and thermometer available via I2C or SPI.

This device is functionally very similar to the icm42600 series with a
very different register layout.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 9b2af104f186..b69c6bbb6f6b 100644
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
-- 
2.43.0

