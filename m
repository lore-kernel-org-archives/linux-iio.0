Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CDE37475D;
	Fri, 31 Jul 2026 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528114; cv=none; b=vAyhj2hlSw17+Z02nYbZjoMv/0xQBZQKFNEHExisu1P6uIxyohnvMVzzmWeLj4NND5jGVSt+2gzogQka0IXRkHjVNuMpzTAoC/+7Mq2l5DWQ3HpZjrePPsFHQ00RlZh4kXFPKQk7ufo2MEXSJt5djtyLe0YkXqO9OAMDL4KdxWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528114; c=relaxed/simple;
	bh=gArvHX6U8v1D7I1UAlBQVbrrB18/2Zk9YkpQoejANOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=apolfFX2dlfCrPalK/QVU6M6AJWfnJV/urkx4tNN20Mjxih+UjGtuIKZm4A0jblwj5rkORkzg/HiKvYZc1RcKuXvGC13VrjBgbSP7+RSQM5aV92Rbhu/HoyhhwDuNNxy0gzsq4/4aCsh02oiQL1Uc6pbfN2XIpRao+SLWsNiqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=BBF9/R22; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="BBF9/R22"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D83B142AF6;
	Fri, 31 Jul 2026 21:53:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1785527615; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=+UkdKfIJJQSeLhhu4WLHwevrdXWHT4a7esktEKst5TA=;
	b=BBF9/R22gkxAa92l4g3JpbrRh+ZQeI7/zAs/xHoPDqCMQAjCNK7jO9KvClTzs1pzDeiYy2
	jeSyeFPWfYW9zXmylzcEGF7fNQJNaaB8ocPe4EU+1CP/4adIzhtrgQ9s7OBQ/szszKmChx
	r5nrCT4NdGvZRvwHcG/TKc6pg0k5d8RxCBufVZG/bQf2nH9ITDC/oiISmybOEDMz8RRe1/
	kBXyZgCRufhNR93rxRInVeOCGv69V80PvOGHfqBZrcsRjqoeDTIS8idPyC8ZU8Q6FbhTxY
	hmdxsr9mE+HwAPNolF6YQTVMrfammEh0H5/MLJlJk3m/jOii/uZ+COvyi1z9Iw==
From: Philip Mueller <philm@manjaro.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] iio: imu: bmi270: Match PNP ID found on gaming handheld firmwares
Date: Fri, 31 Jul 2026 21:53:21 +0200
Message-ID: <20260731195325.44453-1-philm@manjaro.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Within "Add i2c driver for Bosch BMI260 IMU" by Justin Weiss we had the following PNP IDs:

static const struct acpi_device_id bmi260_acpi_match[] = {
    {"BOSC0260", 0},
    {"BMI0260", 0},
    {"BOSC0160", 0},
    {"BMI0160", 0},
    {"10EC5280", 0},
    { },
};

Some of them weren't added when enabling BMI260 support within the bmi270 driver.
The following patches will fix that and enable several additional handhelds using the bmi270 driver properly.

Tested on close to final prototype of OrangePi Neo 2026 8840u model.

Philip Mueller (4):
  iio: imu: bmi270: Match PNP ID found on OrangePi Neo 2026
  iio: imu: bmi270: Match PNP ID found on OneXPlayer X1 Pro (AMD)
  iio: imu: bmi270: add BOSC0160 PNP ID for gaming handhelds
  iio: imu: bmi270: fix typo found in dc757dc

 drivers/iio/imu/bmi270/bmi270_i2c.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
-- 
2.55.0

