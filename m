Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFACE555
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777202674; cv=none; b=JQR+1KF4XS60h6zC1BLTr9gTJgdk7Ia4Ux0ZQlswOZTXAsOBRVDuGlovtVShJjRwtKLaXBjS2NzFFmLEXN6xRYaDQI4pnsp8dDvzCwdEPJ7BIat7kFzYeypqqAhqxRXm0ug4VX7Uab/Mf7r0+yP3hdkyVO4cRRiBQXnuXgn8AL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777202674; c=relaxed/simple;
	bh=z2wZij3bny+uXmdQQJsHW7j/9rQlXSaWcQkTUzYT6go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pUUHNJmwcKM6rBVT00kxQ0n/sRzZWeRmVSdOhfev/7atHOt19QK7HzTuZ6Np9g6++LQwk3jjFY0YcQsyPQZQKrRVxKtcqsNRQCCCdf+bFOAqfBbAqXv1PP9AbXqV7VmNz1xq9SXAjvTpHk6+IlrtibbUpET62Oleobf1gy/CNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3bbGJqj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3bbGJqj"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so8384660f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 04:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777202672; x=1777807472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yvA4FwjLsk49yxx4ydlEPgnd8VTUl40wcz3Ovmub84=;
        b=F3bbGJqjHXfcih4p7BAXi0UuApvIWLkhuHYToVmiGpyVmvCgOPv2sgH0KGy6IoHx9j
         PyfHt6QLM7eQpjTRnZ582meXvkHVreZYIF11Vv08OMBs7pJlTs3NDAjyy5Er6DlvTMpR
         xZ2Fme/tm42XXBd+zqcndRoYL/D9Xm+d7+VvJSytn9uVX5+ESSccJPCK2d+odmhRFqM/
         K4XLkpeY7la396otI05Iuz5A3TFy4WmCLfrUNUBby4C/FonzwKGyymxaFKfmJam4mGcE
         B617zg5bjjYm0JKENMwKf/S71ekhay8H3krdKxx31/EGuHad8z7MRFA8ksRxUglA2Ha4
         h6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777202672; x=1777807472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yvA4FwjLsk49yxx4ydlEPgnd8VTUl40wcz3Ovmub84=;
        b=HapoQgBEMl0slQ6oQGOSKEEVdDgG5HZ63BJirarKQyxVaXMRvO3fA5Oa4S6pklHb86
         E9nbJlsAb2IP1IsYkxoH+qrzFRZsHI2lXmwF24qVAkEdyyOlFsvJ0Whu4UxWhPlao4ON
         fD6BrTvPm0v39+nt4CrKOjHHY/rmrVYiyot91iei/3NZbsnQDHxvdMASK9Yfu42TH16D
         9ADQoxmN7f5y+/hxgmC0T8VHcdpSs1CB167fTwq2Cd5ZfpQ1q0FAiYnYRkkq8j66vw+Q
         J1Nt91XLwjkwpJRMnQfZWi7oZ89cUR+17qaVgtnSYuXpxkccoy4f1Qaha1GKnHZNoyMw
         63cg==
X-Forwarded-Encrypted: i=1; AFNElJ8u7xHYBPGsE4oNOc+nvyJQBQQ0UXe6OFjB+Gp92AlASGwOP8546Bwc9x3imySfGSFX+QD+Xe1SZ5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YycR0uJNV9mOeo2bhgS3e0okmeFQ7JjkyXhQ2c0AfHDlqVR3Wae
	VSz0JbGGmuwOrEZBcA31sL3EdYelmztcCZjEpQCJqM9IhGKOkKVLhdyx
X-Gm-Gg: AeBDievPAtwG8YpzJ4NgANNZCNKzIy9jOu5Fib7iWtjoi1Sr54WdXC+GV25qdPymt5Y
	2FplPb7OM4AT60yj/9IUkAFs9QjAhbCdBlAY/w1lt618J0RrmD3IScRswBu1Fver8KiNMJ6u5he
	SWrXUgR0ZiFiSugre0hEqSVxw45PuwgCT48evDoM/9sgObnqUVnal3dZ5il59ed9yryXxexsZJY
	e5cbWfdBSrzQutpDkowjrRKvudPN8YrnxigxiA7qC+s/4of04elXb3hFQGMHU2IXVCbImoxTwFJ
	WU7lzDQZi41HIBIKACINyXxbnhdm0F6x4pDd+vZzsdi4GZDoaKPqB+n+lB4QI9+40l7gt+KQ4w6
	haTrp28fo430aTxTm1nEaCCZM/8rBZKRHDHOZI57JLGMahWebN/Zi+iSM7b968q9HPgGZzIZ7LE
	XHr8U7tRBnFgDQlWKBZZrZXAnsfBBTfY4yUzuF
X-Received: by 2002:a05:6000:2f83:b0:43c:fd7e:72eb with SMTP id ffacd0b85a97d-43fe3e144b5mr62221533f8f.41.1777202671893;
        Sun, 26 Apr 2026 04:24:31 -0700 (PDT)
Received: from new-nest ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44123d23e0bsm33285999f8f.15.2026.04.26.04.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:24:31 -0700 (PDT)
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
Subject: [PATCH v3 0/3] iio: imu: inv_mpu6050: runtime pm fixes
Date: Sun, 26 Apr 2026 14:23:31 +0300
Message-ID: <20260426112334.3938774-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.53.0
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
  iio: imu: inv_mpu6050: fix unbalanced regulator_disable calls, when
    probe fails
  iio: imu: inv_mpu6050: use devres-enabled version of pm_runtime_enable
  iio: imu: inv_mpu6050: control vdd supply using devm-helpers

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 61 +++++++---------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 -
 2 files changed, 20 insertions(+), 42 deletions(-)

Changes in v3:
 - make patch "fix unbalanced regulator_disable calls, when probe fails"
   with Fixes to be the first patch of the patchset for easier backporting
 - don't move pm_runtime_set_active, move devm_add_action_or_reset for
   inv_mpu_core_disable_regulator_action instead
 - update commit message in "fix unbalanced regulator_disable calls,
   when probe fails" to fix Andy's comment
 - remove blank lines in "use devres-enabled version of pm_runtime_enable"
 - no dead code in inv_mpu_core_disable_regulator_action anymore since
   st variable is used to get 'struct device' now

Changes in v2:
 - minimize call trace in commit message
 - use runtime pm framework to track vddio regulator state
 - include specific driver name in patch subject
 - add more patches to use device managed functions

--
2.53.0
