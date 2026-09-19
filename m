Received: from mail-yx2-f28.google.com (mail-yx2-f28.google.com [74.125.224.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A43655F5
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789861914; cv=none; b=Wacyy5XgaEPa5Y733AX43aQJqmfXP7ny/bC7lIbvF/drSRY+DEoRCH3Tl40UkArqR06UogwuT7hctwE95lCCuxtyuSW/ehif47tS0GrA1kBTykf5B2KTPT2RfJny56TKJ6WnwZzhJgoEfwVVHhe1dSOJwOC2zBbWLM9S1DhStvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789861914; c=relaxed/simple;
	bh=Y6ZObWU1Z2ZztY/hYQNoKGTSXkwkmhRskhS1y/6eADA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxPovusCTt6VvQu7yRSTJwXnQ8ms0XVkgtIMv8w+bkw2KX2Ls/bu2wrioGc61bHnokQSHNKTdc9a9BhZY3DtpEzGTlpQOhhVWCT2unylfv5GGCkaKXS5eif9aFMQmnIBcYACofwm/4ncQsqGs+GY66Bw3l+EBA8NPBlN2dOQm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXEsPluR; arc=none smtp.client-ip=74.125.224.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXEsPluR"
Received: by mail-yx2-f28.google.com with SMTP id 00721157ae682-85d43db0c16so14125887b3.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 16:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789861912; x=1790466712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ST8aG/F/FNnjM5J68hWhWpomXQzQDyZYeETFKkQSf94=;
        b=DXEsPluR1+YcMAvvmMu34GWAzjus7Mui477frcxfup6WDUUdfSvd1fITpL6vYhYrxN
         8fjrEXcPVPoj1eZ3/bc2zP6pyzxiwxuMySiiTrP8xrLEftMLexahEs8zTaR34SKFX0Vv
         c+vk3tr4KjoZkHVAvwApplDL4WcHYOqN+G22l7twhQC5+VmoNTw/KDDdjWqqgBiu+uKD
         O1iUzJkhHJCkdl4oo7s2uHNG8mS0Xb8Fp+4ABLZJvJU3IhZzAttODk0i2zfCSAQNXVci
         cxXZvqBvVncsVIOCooFDNIFbmOQmSTj6eE0nIC+Fz1oNjEW/E/7Tzu0Qt2P23875IGYl
         Ju6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789861912; x=1790466712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ST8aG/F/FNnjM5J68hWhWpomXQzQDyZYeETFKkQSf94=;
        b=X4g9ixyqfnOB8fBkI+mZw24/jXGhg+8aGudjNbRtQZ+QIqjjLAHXZe/H9Dq20wF4eH
         UDVZ/4bfFk325Idv2vKQr+bqzfy3OnrLQHmOecSZ5BpuLJ7TGrUJSbC36lDzUZtCSe5K
         OBO9k0v8Eoltl4jweSuSzoscMSuBLsYMX5n2ovMmU/tOvDOup3XTpiGXYGwn4JtA8LIq
         rRDQlD20O0WyZuoVvbGusRwGJAdYIezC6oZUHYkYtV6i6WA8lrX3/Q22GPBj6kFp+K1c
         znypxlb5wn7U3x4pBRg+9Q/Ehy7Y8eVX90hEJkvmHwmoAGFEeFgpnLThloxdnG2pkNiJ
         OPUA==
X-Forwarded-Encrypted: i=1; AKwUvBw7Q/7+K0CwrmhBQf9oenx9ehOOedveQe84gjj9pc9v/2/Nki5PiuxnW+Sd+Qf4mVvcjBy6danEBSw=@vger.kernel.org
X-Gm-Message-State: AFuF++nwQ9wRFo5yqRddk2vM2KUas70/IaKNOsRTJI8meWGU+GM1vf7Z
	6onMReZlD2V6FVwx909l9aQhGZqzNDGlDWs5MIKXI3xvJGlLzdK4xig5
X-Gm-Gg: AYBFou0rRkFgypwEyWo43Fnj2yzpJc7PNSHcP+Zo2yN6zp039Sc9GGCSbc6i83Z2NHU
	hUWI0R9bdNss2gC5V+4p98LOTt6rDLyNGxzjGZFKXvkOp8WNqbGRBrP5QI4C2bY9V3fsDFc13tz
	iypd7yRfc+jgsmudGEj53ygIPUyD8MHD91BDHT/nx0kedF5hkp1WTQDQMSvmb8hoOndXgWrCyr3
	cKa3Lt72UZFX1fP3o5FW90A0WxjlGtMz4Cu7wMdAe8Sl61RKMeHRiOLnd8RydDFlSVwmaFG+7wr
	KSuNo3g40ruLQMnIbYV6jozE/0JsdT5KjkPW8HDeg+clIU76/+mSzIhaCam8HCa50gQnKwqu9ux
	MAFKO2m8xtNqZbZy4CXU3RBPxzn8csB4MUR7uq4e9BfJPXryJ1bHXBh6cut6zU8ZpMafJXtQpBX
	xewR+UC17lzUWtKjyFXslXNHt94JiIj73gHxaOp3zQ8V9grP83i7InpZ9L37HwRCjM
X-Received: by 2002:a05:690c:498f:b0:896:632c:85d9 with SMTP id 00721157ae682-8972ca6e635mr19752237b3.0.1789861912006;
        Sat, 19 Sep 2026 16:51:52 -0700 (PDT)
Received: from localhost ([2600:1700:5431:250::3e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a480d7131sm12548687b3.37.2026.09.19.16.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 16:51:51 -0700 (PDT)
From: Chang Yu <marcus.yu.56@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chang Yu <marcus.yu.56@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] Add support for AS7343 multi-spectral sensor
Date: Sat, 19 Sep 2026 16:51:43 -0700
Message-ID: <20260919235145.48273-1-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds initial support for the AMS AS7343 14-channel
multi-spectral sensor.

The sensor has 14 optical channels (11 visible + NIR + clear +
flicker) in total. This initial driver supports reading raw counts
from all 12 spectral channels (11 visible + NIR) via sysfs and basic
power management.

Not yet supported:
- Configurable integration time and gain
- Interrupt support
- Clear (VIS) channel and flicker detection

Patch 1 adds device tree bindings.
Patch 2 adds the driver.

Testing was performed on a Raspberry Pi 4.

Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf

Changes in v5:
  - Remove the GPIO pin from dt bindings.
  - Add autosuspend.
  - Start measurements before setting up runtime PM.

Changes in v4:
  - Fix led-max-microamp property in dt bindings.
  - Use REGCACHE_MAPLE and add volatile table.
  - Use PM_RUNTIME_ACQUIRE* when resuming.

Changes in v3:
  - Fix gpio description and example in dt.
  - Only start measurements after suspend action has been registered.
  - Add a mutex and pm_runtime_resume_and_get before reading measurements.

Changes in v2:
  - Add the LDR, the interrupt pin, and the GPIO pin to the dt bindings.
  - Adjust the default gain to x256 and integration time to 50.1ms as
  recommended by the datasheet.
  - Use read_label instead of .extend
  - Remove all unused scan_index related constants.

Chang Yu (2):
  dt-bindings: iio: light: add as7343
  iio: light: add AS7343 multi-spectral sensor driver

 .../bindings/iio/light/ams,as7343.yaml        |  63 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/light/Kconfig                     |  11 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/as7343.c                    | 441 ++++++++++++++++++
 5 files changed, 523 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
 create mode 100644 drivers/iio/light/as7343.c

-- 
2.55.0

