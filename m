Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55782DECBA
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 02:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785466592; cv=none; b=mBnYdvPm6d7hSYgViDRmBVgpPVk+pehRQbv6cHr5mNCgLAPUnHHHZwU9p/+TWDoPkRwIB2/QMtWsnjLwBm8LH0DkoP2tx+eo5zUliUNQ3myR5zIRAAAtxCAHHZc9F91SXV4bhbhoUk2I3IgT7uM3wp14tRBRyqycXFpRxjAc7Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785466592; c=relaxed/simple;
	bh=KjZ+uACRxumlfzhanLvQ89GnZNvCbEi1KvNHScewSgg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TxXNSq045RDHVyogQn//vQp6Mi0oL7y4xhO+Qg+hKYNrK5fyVioTl4rGRWJEgq+o6z8M8i/b2BuSvN9gFls50HPYuXoKQUWtlqA5Zd5QT58E6D6a2arOPzGW8DGJul+BoRPd9LFVCz9g/HN7CZdk55m2gWYhys4MES/G1X+UOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oS5arSxX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oS5arSxX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d0407aedd6so4805495ad.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 19:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785466591; x=1786071391; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w0g6HPpKwMIM98vY4Fw9uAXjnXbrYgnR7YtUXIf+Ruo=;
        b=oS5arSxXcvumUQ5AaHMLJeHJsOJLgbjJ0S0le8ZON/DT1cfs5Ukhotg6h4XbbdoPUi
         6vbqJBdPOXgH7+tSF/YK+RWVg6C7EUo3ZyVC02NtRkPAWD5U+O4xwFwKw2tYiIpPPUtQ
         3uBWZfwil4ihuOQQB7Q7DJ6nH1PuXG4KuDHT8UYFu0QbYf3wqYDosbz3AFrL0ILkYEfL
         nOOblqM9+kMVHI2tBgNTfiPN7Ld7SnTGX3WGUdWHYZwaSIszKumGdvt9sU8iGJGqfR3m
         l2W492JtGMm6c/xB31/B7guD3i47cfgqIZ93177NnncIdT+hrhl7RSQdx6mXQMCSmL8J
         zrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785466591; x=1786071391;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w0g6HPpKwMIM98vY4Fw9uAXjnXbrYgnR7YtUXIf+Ruo=;
        b=oUfiark8OWmH7mLi998neGXLPMX00Td+iads3s3HvKIAnG+veJOgED3AIevlba9c9b
         L+WKt0LzraC28ZccpcabVVN+j4R9uXhajB1b5blAeCD2g2I69bhnLvh84DRkJUi9qFc0
         v51ksFlOc7I//TupewFlvipetSMQn4yFD7ReqJu+0su9+6rVe4flIXRo2UNTzkkiinTv
         KdH99CreVWKSTDEb1DOQc/guEy4jd5JCqEGLgOezSc+/jZ7Eq9CAMg1ZyNlJu6eRxy/4
         Oso/vUCLXkXg8iqQ+x4avJ0AQZyTPaLFHHmiGuAABTCXX19H6mkgt63ZcYw4LzxkRFt2
         Zhrw==
X-Gm-Message-State: AOJu0Yxb3aKR+yH7TytRCWB6sG6qWx09fflNEZbA0DKGVyQieyTPNT6f
	PDlNy+uqRjdMUoNiGMRGcCgb9zYDuvJYZ0/0p2rkW/4wXHtIjNgpXv3F
X-Gm-Gg: AR+sD13xZ8JctfVSYSfxDzQZi8Srv8XYdRnBmQNrJhTn/CL3wriIpq559d3l919Pyho
	AEUcIkNCvGk9qplkEMdc1SJEXPVBdnPohDS1dHeXft7+gz1Zkp7wfCZd7fqITFvnbiW/33yswNK
	dih1x0VSay5Aflxn7+mB/CcFXTiGK8iUgbE9+r/nUu7BEMY4XQHLLinhL54zZb+GIqIxDYMEogU
	/8lr9UTOERSnif3GH/OOOGSjjEjkKfDGWpc197bGl/28CSsKO9Djg56oFJ1d3MKT2dS9VgjNyWa
	PUWuKNKBIDOoQEYefDxqzpww+UzeNZb7VuTWmK1fCqze1GeoMtt6tcl2hNGPf2SWclvLQoaEyhJ
	mMX4jOiAunKkfNnuTjrj3LYJ/oXhK9+XzY38rdFn2+RywvN9+TkV6zpJstAKohWoJQhDb2E0BRN
	5/+QNnlkF2j/U4ApUgXLQmnrtSVI79LQeWdxwF3O7ioYyAA1UJQbHMVUqM3CJ2+6I2M8HxfvLOS
	KIGKPkNt0f/aCamzs4XCDtMmRVt
X-Received: by 2002:a17:903:2449:b0:2cf:906c:7d1 with SMTP id d9443c01a7336-2d046db7f95mr4374975ad.20.1785466591024;
        Thu, 30 Jul 2026 19:56:31 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0478d9da2sm753915ad.7.2026.07.30.19.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 19:56:29 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v2 0/2] iio: adc: Add support for Texas Instruments
 ADS112C04
Date: Fri, 31 Jul 2026 10:58:23 +0800
Message-Id: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE8PbGoC/22NQQ6CMBBFr0Jm7Zi2VltdeQ/DotABJhFKWtJoC
 He3krhz+V7y318hUWRKcKtWiJQ5cZgKqEMF7eCmnpB9YVBCXYRRGhdG55OUqhUafeRMERsyZK9
 CG3vSUJZzpI5fe/VRFx44LSG+95Msv/bXs397WaJAbc7UkSbVGHvvR8fPYxtGqLdt+wAhsuPmt
 gAAAA==
X-Change-ID: 20260724-ti-ads112c04-driver-be7e89047834
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=KjZ+uACRxumlfzhanLvQ89GnZNvCbEi1KvNHScewSgg=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqbA9T8AWiWNqXcFaY47LrIpNPX5EHoLvgSa1br
 O9uveQDc+CJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCamwPUwAKCRClg0K3CVbE
 gdlJCACOO3helD+XRRW279Sak7M4XJUADoFQT9V0a6+COMit3kC6bYAgtdA+ZldlMX8zZF+A3ad
 In8Aa5ZJLMXen/evkpiHTGUzwy68OfT1ppJWH1DhvndTlRAhel+VZl0AP2bc1CqgZjJQNS0l6nq
 y6YKgLcRRqTj5MypHQTYrO7n4tRBu9ff3CbXhl3OdK6MGSWbxPgfcVAGDi4A9lKfq0nFU95lvef
 tAZMZYhPsfkyZWSf/qAcfGtkFjGa7Q6QRa2VD3o0EOjMpwC4RNoh9iAF/rfCEluMX6yzjvG5H4I
 jO6I9dZ2C33cW795f8QU0LbXfM4lds+4qlCCfiHe54EcTXMD
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

This patch series introduces support for the Texas Instruments ADS112C04
Analog-to-Digital Converters.

The ADS112C04 (16-bit) is precision, low-power, delta-sigma ADCs with
an I2C interface. They feature a flexible input multiplexer supporting
single-ended and differential measurements, a programmable gain amplifier,
and an internal voltage reference.

Note: While this chip shares similarities with the ADS112C14 (currently 
being upstreamed by David Lechner), the register maps and feature sets 
are sufficiently different to warrant a separate driver. However, the
DT bindings and channel parsing logic have been aligned with the
ADS112C14 conventions.

This initial submission provides a minimal feature set (single-shot 
conversions and basic DRDY interrupt) covering current use cases.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v2:
- Replaced `vref-supply` with `refp-supply` and `refn-supply` to accurately reflect hardware.
- Refactored the driver to dynamically parse channel configurations and routing from DT child nodes.
- Modernized the driver using kernel macros.
- Handled endianness elegantly.
- Added hardware reset fallback logic.
- Inherited IRQ trigger type from device tree instead of hardcoding.
- Fixed a bug where the MUX software cache could desync from hardware if the I2C write failed.
- Added strict return value checking for all I2C writes during probe.
- Updated the `i2c_device_id` array to use C99 named initializers.
- Link to v1: https://lore.kernel.org/r/20260728-ti-ads112c04-driver-v1-0-475efe4e2b78@gmail.com

---
Kyle Hsieh (2):
      dt-bindings: iio: adc: ti,ads112c04: Add binding for ADS112C04
      iio: adc: ti-ads112c04: Add support for TI ADS112C04

 .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  | 122 +++++++
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads112c04.c                     | 378 +++++++++++++++++++++
 4 files changed, 511 insertions(+)
---
base-commit: 4539944e515183668109bdf4d0c3d7d228383d88
change-id: 20260724-ti-ads112c04-driver-be7e89047834

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>

