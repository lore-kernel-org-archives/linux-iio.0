Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3E3AA182
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032101; cv=none; b=m1WYljm+r3K5dEkvG64Y/9FY0CWlNTTVMOjz3Xq9dlcKdYE/C3kKDCJfMWHx4hsx2xi9+vl7/y6WLbIzZAanzN0GIlLVhkqhY8444oTG8Nn/E9EYPr2yyUST/l8/LpywdeLSO4m/YFjQyVSiQF6OxspM/wOcdSSGsEXkzrh3zow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032101; c=relaxed/simple;
	bh=eyJqIyKFTHGTfwY5MwJsRfca9vZA7qBVsjRTLuadjHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1eSgJBQUFVmWCwhQ8pFL9fWCpSXoXg4h/6xUTdcbDVZv45noItJU6H97gGzECCWxUB4qEsGIpMTkp4gkMMndvUwPTrHahxacUrDYkVEISAPQWMdSJgY+zIl827IRsGh/n6G1LRReH2ARpizpj0JtsYGIg8/o7tMERsvQDzoyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQDlelsL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQDlelsL"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d965648a2so2808915a91.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775032099; x=1775636899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yX/27nndWmhcWYHwvRZKh3pU05ngpyx6Zb/ZQXvu9M=;
        b=bQDlelsLIc304XsM3gC892kJyisWWXI9Rj4z73kowGeva1mITC0G0bmYwUE4UErtIm
         wMrA1EcOrjT3eREOlLgcMHkEUPCzkOoQYus1X8i67jkHOx/e/3tc7/8SLbJdj9mhM3fQ
         IFyU+bEa9hvAkXWRacyw/LQ45Al1FuHZvdcgS7kN+fUbUxlQshuOWNwPfIwoaCNugUwf
         CG7r5RKI8MwZNnQBR7YJUGZn/tQorzzlCTBT9JWDH2u5T4Cr75+IH2I/V5IoTaKAXGwH
         /O9378gjNoDClRezw7CC62fOeif9IqrWkb7RQyNmUwV1bEjI54IzeRTHr40ufdG0u6D6
         ZRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775032099; x=1775636899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yX/27nndWmhcWYHwvRZKh3pU05ngpyx6Zb/ZQXvu9M=;
        b=Eg/7SJvEvLozzKsjGmBgWmnyY5vujqlJFDWjrtitf8Uf637/cke7wju9Z1lv1MG77d
         zzHv9QcV/VwFsn3qsIcYMZ5EXqsjftYsGdSibKUfZhbSdZ9VE+eHF2UIZAlYCdkUmaCU
         QirnZPP2d24KZ/eCMr7QRlznKbG2EXt7k24OxaW0WGs+f8RquoGbWYz9IA4R8xm2KCpR
         24ZMPnE5I6FKAGy7VO9A123NWQ3lqBD5mms7W1deQGCbB5p/4jqVXcPc84eKsj7ggzTt
         6YCqS2YXQ99I9+acfNlsiSqhjcRZyScR0/g5YnDbINvHUBjiWaq//IYppW8Lj2eCe0HH
         Uy+g==
X-Forwarded-Encrypted: i=1; AJvYcCU8Dmqay3bb2pIVs0CH3y45hhUORZaFho2oDjA3he6ELbF5uiijpbrz5AE07mY8oTiIFGS3mEw8gGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZETrw9R4qXNeuEoPFufTJJXAWYpHXLLwMVYjmF6ovFKqP1gLJ
	cSrPqul2Em4pZURJ06VNojIIawrKIrbbXsDdO7P5tjw+yKwZRZ7+PlsA
X-Gm-Gg: ATEYQzzKslkOCi50OGWbJpLvaX3M+tWINXu87AF2g/EnKhdMIeqPjOb1HL2pOBh2UbU
	8yvSAEWNCFaroi/hsMo8SH6W3TMPNSjRA7OcYWqOZ4C3VRLbbHd1lAlrNgELBSJYaw1aZVkt4Wn
	MOiornd3jomHK7e8zJzYGCVqy3aPvasZryduJlRVtWW8na18LLi4QWsRQQKTBC7TjTJLLJjmX10
	zdS94psIejqw2NAasEHCYc6dobTO3+Eonq4EBp8sOVUyQPY2IE/RxgL6AMBBj73U9M20DYLEnHQ
	Z9k1iJb4+mDGjk3O/dKB2L6L4SMjm1FQ4K22VC4qb24fiUgYrnB8kuEGshw3K3XmqHl8yvjR9iI
	WzWl1ER8zL+4INpjdEjePs0PaDYJWTq810a0ifWA3aT7e6V+Uy4xPMcsLGPCDS5OlBortBgdJbD
	3YZAb9bYnIKXEy0BYZ4Sar4z8jOis=
X-Received: by 2002:a17:90b:1d02:b0:35b:8d89:7199 with SMTP id 98e67ed59e1d1-35dc6f6150bmr2460983a91.15.1775032099484;
        Wed, 01 Apr 2026 01:28:19 -0700 (PDT)
Received: from new-nest ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe5e519dsm4118561a91.2.2026.04.01.01.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 01:28:18 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>,
	Rob Herring <robh@kernel.org>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v2 0/3] iio: imu: inv_mpu6050: runtime pm fixes
Date: Wed,  1 Apr 2026 11:27:34 +0300
Message-ID: <20260401082737.781018-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes problem with inv_mpu6050 driver,
when it fails after device is suspended by runtime pm during a probe.
To simplify runtime pm handling in the driver more devm-helpers are used.

Andrey Skvortsov (3):
  iio: imu: inv_mpu6050: use devres-enabled version of pm_runtime_enable
  iio: imu: inv_mpu6050: control vdd supply using devm-helpers
  iio: imu: inv_mpu6050: fix unbalanced regulator_disable calls, when
    probe fails

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 52 ++++++++--------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 -
 2 files changed, 18 insertions(+), 35 deletions(-)

Changes in v2:
 - minimize call trace in commit message
 - use runtime pm framework to track vddio regulator state
 - include specific driver name in patch subject
 - add more patches to use device managed functions

-- 
2.51.0

