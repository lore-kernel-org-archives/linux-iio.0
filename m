Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4C0212B0A
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670806; cv=none; b=CgB6mRb9PLBIma7RWbJjUmHDjiz98XbCZrPw2tOuRcHwJJul87/rXNaA+mLbmR+k2IqJ1hrVv1PqzJYWp3kuEQaHQ4y8tActLnQ7fyPgcrhzIe3A7CTy3T7fbG+vNPx7/uUeeZCuiZNpNg0u/AhjNVcpWLo/58OfGzCm/Y7TfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670806; c=relaxed/simple;
	bh=p9UFRzF8kTIYoqUigZjD4noD3QMRcYLM8lia3LQYS7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gGYEekm37bSlep95nInFPLREAHr8h/un00+LtwuX2mGYubh01FPvDGTjERL2Sf/5nOj/lGA2c8rGgRb18Brdw8HZGG4FrD0IoFT6dPqJFEpp26bixasGnM9PeHwZ7Zy+nwNa++oGqPmgAR0LflVM7ow4VvsdQVat2ONwW+4tBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8C8Qmwj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8C8Qmwj"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a2ea96930cso4585385ad.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 23:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769670804; x=1770275604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E3phpUQoO69zrOUwV1tyBLLk6DjOMH+Lu3vPhU0jOq8=;
        b=Z8C8QmwjIK3PmVr/6yeOLJO8CeQBr4G1W1LNHNE4TiXVkvUqtsp+X7eVtFIAs+pSPs
         VfBx96oWmjY27qjK0sxsoHQ1PFDGgIi4HcZfH+E1hFg/RGRYrHUdAkmfiHijehYPOg8Y
         4OcZIaqxlGD8SXvwyUb+EIlEO8WTf2SukYN58Niw2q77lbZCdR3o6dKNVtfJpMt33ljx
         clAe+u04NsXCIGMV0ZRleOh+PAZsBEvJF2wbwdePodYF+9cyC7myniZRWRY5Ts8a4lb1
         7OyfGsGTB6PvMBIW5hwMrp+WKOp6KC9WP+jddBTMNzNLmzHn2BumgPdBWEobC29TUbyr
         T5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769670804; x=1770275604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3phpUQoO69zrOUwV1tyBLLk6DjOMH+Lu3vPhU0jOq8=;
        b=ubjsR0DxP4j7bOvFCOibeoVPyjWv82+1U0Wz+m9WF76x9jeESO1Pq6cUm3OeKF6/nO
         bZEszzj047xmBwr6j7Q/MpemLm/l4QLICglVqQau/4b8+d0hbICegOFVG6icGDBUHfMv
         KA3RunwpgRGNKBFrnMNyKLljQqGYuj3pB/6fM0W/mOGmDjmsuN3/NTSoW7yEDcTldn3S
         CPVRE9Xq+mn8B3af5Z8VkA5o+GXUAYEcUjnwWMA3ahk45UdKW9zST23LA/wCFLpGGhk0
         hI2XH3HsE97rk9KFQXLyAzZf0dJOEOZDE36Gjd84mVKOyYyEC9yyvw7Z0WECPbKkhDGG
         R2QQ==
X-Gm-Message-State: AOJu0Yz1Y0flY8XJ9IGTR9HKiEM38HUm8kBaNHEsKbbZnDqdtwgVMzlA
	d4FDrjZmnTsKVroOeTTaUG95FqYhkcJJtof4oAe7PDfTlVirt2UstYO12GzO2o8R
X-Gm-Gg: AZuq6aLrr5tVnp+VBZ/xijXkvJMvVK6CO4NePQeOiEccZ7XADbn5uIptJ++PyZj6rg2
	KwPGICBeyeuB9XzYBEhi2hrPuVA6vuGxelECsgv2KwHVq9zGo94j2ut/C3/a0C+eqsvPgvc/0kr
	3O4EP1HlHeuKM0uG1HJSxtwxeg1awTrFobbP4kCYVOKTPmNzTBPKEWR944pMQBzAL8hwx5BLfFf
	PWJdpiEIFy+/HN8441QIUrqCx7oqzdyBKne31l1pjgsRrRrAzfbtM72c1LIupVPCIG330mDtHfh
	r6+PX2Qa5yX7J6b/46AdzdqPhRsMV2S8Pvh1QHKBXgMHwbJRHo/RH8HbrneB59gD4kOo/DwwjQF
	D19e4tbX11l25qAr03kkPM0q0BturfAvLqYU0IGIhxwTkjTbcX9qqLX3efeQAf5UmfAOy5lN4CI
	O8jBs4+TtmUE1bsHUnQW4JIh6RbN7voNiedwl7KmmfAW7q5EvH
X-Received: by 2002:a17:903:234a:b0:29e:e642:95d6 with SMTP id d9443c01a7336-2a870e54eb8mr83236225ad.59.1769670804111;
        Wed, 28 Jan 2026 23:13:24 -0800 (PST)
Received: from arch.localdomain (awork135098.netvigator.com. [219.76.135.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6ed92dsm44160135ad.93.2026.01.28.23.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 23:13:23 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH 0/6] iio: add support for Bosch BMX055 IMU
Date: Thu, 29 Jan 2026 15:10:56 +0800
Message-ID: <20260129071105.389493-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The BMX055[1] is a Bosch 9-axis IMU integrating a 3-axis accelerometer, 
gyroscope and geomagnetic sensor. 

It supports SPI/I²C interfaces, and existing compatible drivers can 
be reused by simply adding the corresponding device IDs as follows:

- accelerometer: bmc150-accel
- gyroscope: bmg160
- magnetometer: bmc150_magn

[1] https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf

Jun Yan (6):
  dt-bindings: iio: accel: bosch,bma255: add bmx055 accel binding
  iio: accel: bmc150-accel: add support for bmx055 accel
  dt-bindings: iio: magnetometer: bosch,bmc150_magn: add bmx055
    magnetometer binding
  iio: magnetometer: bmc150_magn: add support for bmx055 magnetometer
  dt-bindings: iio: gyroscope: bosch,bmg160: add bmx055 gyroscope
    binding
  iio: gyro: bmg160: add support for bmx055 gyroscope

 Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 1 +
 .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml       | 1 +
 .../bindings/iio/magnetometer/bosch,bmc150_magn.yaml          | 1 +
 drivers/iio/accel/Kconfig                                     | 3 ++-
 drivers/iio/accel/bmc150-accel-core.c                         | 2 +-
 drivers/iio/accel/bmc150-accel-i2c.c                          | 2 ++
 drivers/iio/accel/bmc150-accel-spi.c                          | 1 +
 drivers/iio/gyro/Kconfig                                      | 4 ++--
 drivers/iio/gyro/bmg160_i2c.c                                 | 2 ++
 drivers/iio/gyro/bmg160_spi.c                                 | 2 ++
 drivers/iio/magnetometer/Kconfig                              | 4 ++--
 drivers/iio/magnetometer/bmc150_magn_i2c.c                    | 3 +++
 drivers/iio/magnetometer/bmc150_magn_spi.c                    | 2 ++
 13 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.52.0

