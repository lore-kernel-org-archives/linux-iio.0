Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80AE2D739C
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850164; cv=none; b=jHhjS1pR/dCgXmqtGWrfX5AXw3rNJmAj0HXiJEMv8jvDeutgc2Bx8B7B7P4o3jsG+nPfNSs6+gMpCfixYXQYM3LC7N3BjOc04SSY80+D7ZoOxX0HoTNSoKjA/6hppOX3m6ApPX+3A0hNSTXnHpVXf7PN26uaY/6Yy9xlGL2jbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850164; c=relaxed/simple;
	bh=mg1u65/hNDUSb1m380zCiWkHQxdvyCwTPY+JWCPvED4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LM/cEo4JxVl+VyG1EAPIcJTR2lHDFHg4XdC7/nVvEmeuWDcZH643s6rIMIu6MFkBuG4tKJuNX0B9Jis8Vm9r17+K3Jcy4+pLgwsnosj/BSuQ4NfTD4x6xqcstbxO4OGfQaoXdFZbHGrvODuzDWefUCI3aJwF/eUoVgfG/0XNV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba0GAdV2; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba0GAdV2"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-439cae0dc81so1329827fac.1
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778850162; x=1779454962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+2ydEn6hztRE9Iv70/dCmwY4D4SjSGA68XyIdXdlEs=;
        b=ba0GAdV2nPJFpratL+uvOROpayhGYkFDDDaKXRiqaInfHt3j9jZl37SIrXHMHxtgc8
         eP+HbHFlWPOJ+6n+iRBL9H9QXQAZE25ZbT5TvS5PiTz0R/Xs+NIawhXfPJ5Ow4fE3yOR
         Zc1UMKnltwJgo+/m1tpWG6urZ5HDADD9ZpYYa2biv0EYG/PPYZV/YzuZaZzluGcBBvUV
         DLEVeuTkTWTBXcZAIdcuXfxA7VuU7tbUo1EV8jaY0D+b4/8FMB0ieeCS1ylSTgvurRIo
         EODEVJJO2OUNwFmlhSDK6zYO7FpEP+cdpcT3EC3sn2Y5oBfG7wuF1zVge6SRiKjHm7K3
         IilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850162; x=1779454962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q+2ydEn6hztRE9Iv70/dCmwY4D4SjSGA68XyIdXdlEs=;
        b=laZzwhB0xacxwYZIIxB00gM098FHKVJVFXjHP6AQt1vwLCIu18Z7KStZnhz3JKlnkv
         gv8TkEkmArOFzaf8Ss/1TBqT8t+EExgQVCMENCHP2+a8ykxyZv/LOQbu4WtEdONPNmd6
         rc5AndK+4yBS+umL3S50b+TNWMqdd39r5sbOy6urccC42iDr4YVGMH1wWgNQ5ErsIywZ
         WMfyGNWhaxQI7BttWAutN/skEniv+8tqjHLJhfi8xfDx8j7rbo08icEl9frwyPbgkci0
         0ngUZJsZZW49dIlX34q/C2ZHeDwknEyCVcjcY68Fmft2KgYyz2L6MZP6q7h0pr3aJVAn
         2XYg==
X-Gm-Message-State: AOJu0YzlmuTmI+x+4mMwaMn9Co+7pQuJwW7SEdlM7naiAf1FQ8+ciIJ9
	TXBxS0qS1Uutsr9E13quXa8wnX6QzlKfKJ8kEmFqQUeTiS/RHseYKEF87QYJCmOn
X-Gm-Gg: Acq92OHEMvo/D/Bb21gu3IOC1ofM/gNYnaEZN8oqa6l1AOZQmuFegMlGg80TVI+zWe2
	58jQCRQGcgo3CDYv4RGqmEzpPdT9LhjM92DGhsxD875sPjB89SIGKO4hHJZ2MbgTaHZIPxq87Yy
	wMsSyIufnIijyKgFGEB+TThTXIYt/G5qNASjrqcNclwma/FdMwX3GbXllv4q7I9xMvmCU3mJIDK
	Q3V7UNRr9qdkMbXTRqUdFYTkbtFB7yvTceJYgYt/5GVLkUvJiptCwypIrqTSVr0axbJ70keVVFn
	mpmEC1OaOCEHTEQuHVM3AYBJBsweFlBlZLPBJLbsq4+FeK7rUwktkR6lbpDsA69EigARxxfdWi1
	cEGLhr6xHuGmLkEfwPg60cmm/tYMn7fI8KJxiVUeOWw5b8f92LGkmQq8mczmQz6e31G3oOVjtgI
	5rxZJdTjiqBZfWq+GpKS14359hwN5IhL3zQ2TW1AoxxA==
X-Received: by 2002:a05:6871:68a:b0:439:c869:f5d6 with SMTP id 586e51a60fabf-43a2decabadmr2469552fac.36.1778850162214;
        Fri, 15 May 2026 06:02:42 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:8c2e:6a8e:445a:9169])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc53f2acsm4155822fac.14.2026.05.15.06.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:02:41 -0700 (PDT)
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
Subject: [PATCH V7 02/11] dt-bindings: iio: imu: icm42600: Add icm42607 binding
Date: Fri, 15 May 2026 08:00:07 -0500
Message-ID: <20260515130018.237378-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515130018.237378-1-macroalpha82@gmail.com>
References: <20260515130018.237378-1-macroalpha82@gmail.com>
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

