Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4C9372EE6
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673664; cv=none; b=UtKHibotb0pi6R0pxs6Cd6Ra+aVgahmGuxk7mGvMIpMP5RlLbGJWTM2DlE1Me/yvKFEFZi+CXA5FaaHQXM/rq7p3CIWlDv1fCmX8fS5pokmtz062Ar9HCIGDvQ1gY+sNxZZz/DQkJ4FA6HC4SIJEzecR9buI9piLbMHiLcWCAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673664; c=relaxed/simple;
	bh=TAFf11R9aLDLqch/+6yvhRCIXcRZtIkal0oYdv3f42U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duIk4qGKAbMj/czOfvw4K/4F/jWUmPCJU5qpTxwEZmqwqwslTJ8u880oY8m8p+Yzdk6EwwCgEuVYmfSamGzTn/QJ0s8WmoyqJxeXCPg0VbojStID19PwNF6OUUN8sNn+P4t0YeG/KszKeR4b95ZXQ/ILrUr/h4iOe2iZPMmMvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKO1b3d8; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKO1b3d8"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d4c383f2fcso2170053a34.0
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 15:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777673662; x=1778278462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh2D404GmTWC6zLAhnnfq8RU6EGIGncop+92KcJ8XSY=;
        b=iKO1b3d8ON83HfTkMj6DEuMqF1tgVf7z6X7+5sqhQC42YwsVsnxZvFubcCMNg4/lzL
         CRuWNQ6Jrjs9ZgHCYXyilx3uFeVndGB/M52zU9hbpxJeo7CmchY9cNTwSKb+DOgt/kKM
         xQ8YedAalOiTfSnXaYDxCVhb3Lzhd91Y2ihAjThL43q1rBPxOS+72Ek61FsL3iXa026g
         38x1AGkEILeKt/6Gj0lQyOnzKcog/Ri+0HeoJ5XF1dtpRCaqjCu2aPPBc55ZApDDwvgV
         mr5QlF1m/mTKw8NvhxgqwbNIzGSiYgf5aW0XqjbxghI3rd1QOaMOh3gbWjXWC4pj7ASP
         aSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777673662; x=1778278462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rh2D404GmTWC6zLAhnnfq8RU6EGIGncop+92KcJ8XSY=;
        b=bPBme4mQnRjAfCiRGviPU9fwH+8ZA6xE9dAMGvrkNmP1t6gCI4zdo+bYVrXeUpuVAT
         xXDzkG96yikDxz2LmEjCaT1WMvG9I/8qba4TzvCO4F/cSzS18yN+rt9xeXMDEE47kjCG
         jbY/y3ZSfhidDKLH/CYPCavgVL/+XFuh7ZHoaxXyHs8uFF6wLMYBCBI1jkfa1i4IsT5l
         9BLnwl9GZyPGkAcEF0oh16V3VFmNTpNI47hnwczOD+wATz1NM2YtOakZx1AkIDLN5Ho5
         TbAP5Nk0x+isc2xERKlrPPejiXfbAz880VQmKp1vB93pCHc983a5xsKZo8RNnkxdJSv5
         XkvQ==
X-Gm-Message-State: AOJu0YxiGRUJm5KLVs1rUYbCmJ72xyzADn/4G928gjUiOcF2vYS9IsTc
	y5WXEp9Bh0fnLdA4eTJ3KR5rmzzXncR/tOW4mg/vZInhbOE/8zQ0cJq8htFpBA==
X-Gm-Gg: AeBDiet7rpp+mI4R6cYiK320xw141vQTF4j87RzsHec4GIOIGpjS6hFeeaXYEYHfjAO
	Vm71AQyzV11meW7Da0cKVxs6emu+SmftdnsSdBIGOayy4Wh2s3VZg/rVYlz3hNIsY81udTagB8x
	HTSLaIeW5BR0l/gjB+7TsLOy+pXQGr3wNJFIKcM4Gh3OMJCwWinOVuDvfuX+gscwaN0dVPRB2Pf
	2SzmxIrfyeGiRBm8OLwU31lfaQb/LannXeV+k6Z+6HWBS4rIgy4IWJywX/KmANkerExtQLlqDPs
	gm3g8aRkkZ3jzUikd7oTW+b/E6RqATXyim92bz/957PVvtWgTWFmkQdLAoWDJ1v32GTaRLsH9HH
	8MxnyHJnH2xzknglCatOxCZ9Clurd8/wtu/vXsPuB3sBC+DMI1kxfTK/juXVTM/OdYcCvHaorrA
	LrCjxD18Yu77XxM3iYNalCqQVtftEbVGXXQrNznkzC8w==
X-Received: by 2002:a05:6830:6008:b0:7d7:ecfc:76d6 with SMTP id 46e09a7af769-7dee13974e3mr850626a34.17.1777673661845;
        Fri, 01 May 2026 15:14:21 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ded51a9612sm1827337a34.26.2026.05.01.15.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:14:21 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 01/10] dt-bindings: iio: imu: icm42600: Add icm42607 binding
Date: Fri,  1 May 2026 17:11:40 -0500
Message-ID: <20260501221152.194251-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501221152.194251-1-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
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
very different register layout. Additionally, add mount-matrix
attribute to schema.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 119e28a833fd..b69c6bbb6f6b 100644
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
@@ -53,6 +55,8 @@ properties:
   drive-open-drain:
     type: boolean
 
+  mount-matrix: true
+
   vdd-supply:
     description: Regulator that provides power to the sensor
 
-- 
2.43.0

