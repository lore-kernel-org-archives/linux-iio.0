Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065813D1CB6
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921563; cv=none; b=Fhr9OH4AzaPlKhrwjaAeqnMEzejkYyhmdlp+P/DsN6yfwfSrZRDVLuv3d5Z0IU3Ra5JJsA4+AqQLs11qAeAD8TqLnZqoxaqf87/wjjaFlNzDL7YmlO9SH6V+zUtH4C4F8nRPE/9RydxZ2FOW72td7mqoYMDaU73RqllYjlrncxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921563; c=relaxed/simple;
	bh=TzB0TDBcyModHlhscKkRyhu+DntXkSWYAGvIUGrcGVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+P9TVkgq57Bkr1CCstc0a6p1YRjvn/Qgr6z3ITp+TD+17qbn66sShd0upW0+V0yhSfA8NwVOSBZlC0VhfiRaEohkz5njgxTSSa5l06w0tNSoDriLnKp+j1dsrhEJ/qJyYdVY3PCIuwIpIItBfvu0cI7be1jvt/y2DtO6yEJisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMkyFP2+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMkyFP2+"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66732a99928so947853a12.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 04:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773921558; x=1774526358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUcQHeprPMeRllf18ooNN99GRIW3qgL3Mo3SFM1oI1s=;
        b=DMkyFP2+RoShdqM5fkCewz3/YopJRFfIKyjB/7aWy43bEWh7HaSr/E5vUqANaoMSuX
         epwv4rj/yKxfFnO5X7ZoNgVkm/eLO5nUnAKPaZolMz/hEvbO9vzUkCqbJcf/5tiFR8xK
         lJNhKfZL3YFeyYEb0R2KAWan3neVPFB5CzaPTHyj3ltIPH0ECgf2aWlbwVlRFe/qCTJf
         /ecaUNRmxeNcWfc7BNh4H7VxZORFDn+yd9o3UEAq7aBhCQsYbvuMm2DQ3mvRS9rU5Fxm
         Ssc08XU5QG2VdaDTCJPv1Ze9w/2da9rPljuW0wFIs2r46kQF5Tjy6YY4xQ7rRaORXjel
         2vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773921558; x=1774526358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WUcQHeprPMeRllf18ooNN99GRIW3qgL3Mo3SFM1oI1s=;
        b=gJwgIO960f2G1/dtcNUi4v2FWW9r2mxF9WMGy53C7O3xQo9TFX18TLN+qiUrKYhzEn
         mBfG9bjeqYrRnglC5GCxqzDgx10QLYjyUTGg7D8SPZCxd86zOB+Dq7pVwlHQ+jeNfPLs
         4RnfS3yLNXjPfZvNwZJTUjt2Y4qHsw7WLIz9udWJCe0vU08qButLdXOiXSZVGfQ8tZAA
         W28iwoU+dXSA+uqq7RlaXiETwXTlna/G3VN+8ebvXXxNxABa2Tyowto4XKs5EIxxd65r
         c9ZZPwCB+Ib0NADqNx/uTxYU+DKnyvZl0sqAYVZYLGuG5j8XvMwlWUjCWCxESstKvuDV
         XNOQ==
X-Gm-Message-State: AOJu0YyeRtuUyLfQppMbASxaZa+rDobdCvM6Bl1sSxWGc7cxApVVpMI7
	AxhNCz3SYyUoAbWg/Qxbbv0kdr0IjC7JTjQSZN5A0tTlKYw6yoY2ULED
X-Gm-Gg: ATEYQzw9Q7bSHPFegVR8cdjdpIU3ue2cIwdWIKGeS8XCk+RY3w8fZspiMZ3wTq+Tw8E
	FyrkskEB2sFTojMAZB58nXFPgwZuF3REpOUlME3pWbUXgqncI193qAEmNGgeO6NwedJQUo6FnSk
	y8cz6nww7YBYoyGxehluUzAmJrrmVuiX0nG89tcLk9IunB/dsMmx068nwQopHxzSUKLeYJ69okP
	v9ywy9RqtCHc1Edy5Ax7dpAdJLwMvAbKPr4afkHzdEKUrC9FBaVM7lTCM7d54w6I0/O4pfVKJSg
	+JL5utAHNuI8TjvJOl7PyVsSo4dWO8/HPta+dptOzksO2GnWhwzuqPClMUsbY9eKfby7tGtdGlh
	BXKy5ycY2aglbQ2QNWgkgqfmnKl5Zu7InfFKCRbdM8LR2lDHm+VKk1QEljHuoT04KyDV+Mja8jH
	55tkTPvzU2TijbUKR+7WRgxrvdzQ==
X-Received: by 2002:a17:907:806:b0:b97:a9ac:5e05 with SMTP id a640c23a62f3a-b97f4a700e4mr524920666b.35.1773921557711;
        Thu, 19 Mar 2026 04:59:17 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16d3380sm461399166b.42.2026.03.19.04.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 04:59:17 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Thu, 19 Mar 2026 13:58:46 +0200
Subject: [PATCH v5 8/8] iio: light: vcnl4000: add support for regulators
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-vcnl4000-regulators-v5-8-a025d3332805@gmail.com>
References: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
In-Reply-To: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>, 
 Raymond Hackley <raymondhackley@protonmail.com>
X-Mailer: b4 0.14.3

Add supply, I2C and cathode voltage regulators to the sensor and enable
them. This keeps the sensor powered on even after its only supply shared
by another device shuts down.

Reported-by: Raymond Hackley <raymondhackley@protonmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 0a4d82679cfe..9650dbc41f2b 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
@@ -1985,6 +1986,7 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 static int vcnl4000_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const char * const regulator_names[] = { "vdd", "vio", "vled" };
 	struct device *dev = &client->dev;
 	struct vcnl4000_data *data;
 	struct iio_dev *indio_dev;
@@ -2000,6 +2002,11 @@ static int vcnl4000_probe(struct i2c_client *client)
 	data->id = id->driver_data;
 	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
 
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
+					     regulator_names);
+	if (ret)
+		return ret;
+
 	ret = devm_mutex_init(dev, &data->vcnl4000_lock);
 	if (ret)
 		return ret;

-- 
2.53.0

