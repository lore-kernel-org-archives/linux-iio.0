Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105401;
	b=E48V8i8IoSlcTnLA9peETSO98cKgUyWIo7WNf+3zyH/rJ692x+4ZZpZeO/nL/W+/+aZa
	 zTcwhu+l/EBK96eOK0FCZO9CvP736AHdwpsCNyM44RxGZWbqYddIekDPl5Q016HIqycmp
	 gB3wAuuhyeNpr4124z49+JnvBg8JY/ZwJM+KQvrhjCho2P52bHCYvu7ssxMF/NILFjGYn
	 SZwy2nIUWAufhpWahDABwEcIt9EyHP2TqIK3idLgFADmaQCSDl8RaOWMdS6OBh1ekib6O
	 GfQ7QsxXygn8vYlI1cP86bFuXccuDQWEsdzAXS+H/I/jL+Pmr+g5rZeoxXpSNYRBfoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i3eoTk/bStSxof4N8Gfz3DvypjlvmOdA8edsrMpkUbM=;
	b=Mxs4HiZb99u3mSAzU8s7w8/70xnYRcBENdYmeO1Pr4uOIhADfiWtFvxdLCyVLUESEeDx
	 9J8U+59NtKmuhFvQ1O9Jz+zly0DvphX4fbKxyxu2XiduSGv5T5wrV3PK8BAxap4gNF9Iy
	 cNmoeTFyWtPHtRe2k4A/GM1rpslBNDcFtRKWzGsA1kqHrpfzz5OIUDiqT3Uz7mszTOjQ7
	 CHMbbdrBb1gdv6OAUJbDQcl2NIhTKqlOsVUdFJWW2S7XmgDRdgkObUmT+X8ZSnc/O8q/3
	 x4c+QQf2l4FdbhNmBxqCkjKkQpHo207xHHESCHJVdXVMsd6dZpHtFDgq//52tcrxtyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hmwLS0X3;
	arc=none smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F60606A31D
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 12:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20F60606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hmwLS0X3
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a9787a156eso35230431fa.3
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 05:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793105398; x=1793710198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i3eoTk/bStSxof4N8Gfz3DvypjlvmOdA8edsrMpkUbM=;
        b=hmwLS0X3VwBzPUhDQ4GJnqIBZcmagCbYccapc6RXsOEsStOprIPW93h+mJOTrqUupa
         DVOeBpvClqXRrWUzWFSldeb23OWkRq3pRLtDRe3cuOD4QLzkz3/lfzm8LLcRDZgqRHgN
         6fmYllJ9tz/5QXpgx3Z5MBEYIXFiQOfvPQ+mAnlWglizCNr0wnERfZL5an4u3KosXl82
         GwZ7FKyjRyVqSJM0cDUJMKCOp91eLvh7lljoIYYfcp7HUvHC35tg4qXqkZMSSply3D9e
         vSHlVm7bvk/JdyMdOZP99vLkfFkPoxka1MBMuHl/ZPBzS4CQ0JuzAYvbaYLCW4FSM/Pq
         N+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105398; x=1793710198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i3eoTk/bStSxof4N8Gfz3DvypjlvmOdA8edsrMpkUbM=;
        b=Lw9nEqxZlYfM20GZlYWPtAJeYZFHF0pOAWY4wc64mg5z4xuYtlPKCQZugCIaBdODAo
         tgB6QIXHI+Brk4vhHM+qOBQx4TWXRIu1FmG00qEAfHGWGUzLHsGOb/dWZrAXmjJPyAPH
         vmUIhhaeCo8yfOdEdgNhd4vBoSMxL6HgruR2JkJNLcGXAXKe3wXRWp/Gxi9nIGfTcL/i
         buM//eAFzF35mOVGDf28yqLyvZSOSTgwADKP+MMz/V7MPJ16gMvWBQrzGcTaf2g862mu
         ql92Gomx3BWQRvyFeQ8WXnPeHKguF3zbh23QAnSR5Ep0a/MrFe0Sey19pQCUUszht2pT
         UB3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxp3pyH8Jo/dG2eQAd4kQ0kM0MGAl9zW64qLgqdDPDLd98PO/uB9mMOeUjwHQqapvyBM6dibOeU7c8=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3bCQ66K0/dEJlOtG++hdvBGm3uzgBkviwW7pk+8Hw+eHr2RO1
	JBDXgaYbGOrFHod2PhOQBduWJMM2Rt+IjSRQGLx5OSaIlzytdoo+rRyS
X-Gm-Gg: AYBFou3hZteV1akrJJ5cxIzmem0QkoxL3qvJ7WvWvee6ZlYgCPMfMt21tA0nRvajrJg
	2+slEgEQrqZHjDeJ5QeeZIbsA7q8YowQjEOBfj31n4mJXTxORKcwjT3zMABYwJpT/vAUcmKCp+i
	wi2AXEl1Pk9gyqrejGXSPcI0oQvHJmXDiARv0HXU8sguu2f9bD+PvihIVeLxZh4AYIQ+52/PefJ
	ZQiy6+QlpgGWMveL8cmw1Ehbm5BlPYz9bT/3LbZOW1yt4m5YJnsqRpJraDGW43wrONToN7LU3tz
	r2L2DdzEjtGAI3IOtxpiYyE1O1tkXLF0SpLAVbyv/cIU5YcOUeQHphvgOd5v7LQEwvhVRwAoKHO
	0TqcRwfOOPtljPIf3Th5cSLZ7hO40BB/181AN+pcdwMkG68ifPeGzbevCIYIJRyZSr2Kdm41+5+
	3o8aN4Xsh5YTNqwqPTfYKYZIGqlP5+kWB6x424xP22dCRF/GHz2u5/GEfpA4Cyb5We9SePuf8lN
	uaTaS/SyREMYuYGDVV7e8Oncod6Xle1KBGbfKyx4OQfPJEPxH9KDeh58OKBaXT6JQ6MuytSKk2L
	dD+gXghnWVkY/kwhCTxJlGDA3HRKd/pTPKdAyyayOGDiU2U4mTQAl8QCKiHQ4/422kWKDSbpiIN
	V/TdZdye8VA==
X-Received: by 2002:a05:651c:b27:b0:3a9:e428:d2f8 with SMTP id 38308e7fff4ca-3ac6fd68faamr25300931fa.29.1793105398128;
        Tue, 27 Oct 2026 05:49:58 -0700 (PDT)
Received: from yantra.. (nekmmqtcmoboczbkdcs-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:55c8:a52b:6ba2:979c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7e7cb24sm2052803e87.25.2026.10.27.05.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:49:57 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	David Lechner <dlechner@baylibre.com>,
	Guenter Roeck <groeck@chromium.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Remi Buisson <remi.buisson@tdk.com>
Cc: chrome-platform@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 0/9] iio: enable context analysis for all drivers
Date: Tue, 27 Oct 2026 14:49:45 +0200
Message-ID: <20261027124954.110697-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jonathan asked for the qcom-spmi-adc5-gen3 fix to become the first
patch of a series that enables context analysis across IIO [1]. This
is that series.

With CONTEXT_ANALYSIS := y in every drivers/iio Makefile, testing gives
256 warnings and 2 errors in 126 files (x86_64 allmodconfig, clang
23.1).

Patch 1 fixes the two qcom errors, as v3 did, but names the lock the
way Bart suggested [2]. Patch 2 annotates the two conditional mode
claims in iio.h, which accounts for 241 of the warnings, in 120 files.
Patch 3 covers the core helpers behind them. Patches 4 to 8 annotate
lock helpers in kx022a, meson_saradc, the DMA buffer, opt3001 and
veml6031x00. None of them is a locking bug. Patch 9 enables the
analysis. The common and sensorhubs Makefiles only list subdirectories
and are left alone.

With the series applied all 726 files build without warnings, also
with W=1. bma180, ab8500-gpadc and intel_dc_ti_adc are not in
allmodconfig and were built on their own. gcc W=1 builds show no
warnings. Removing an unlock or a release is still reported, tried in
kx022a, ms5611 and veml6031x00.

Bart's thread-safety branch [3] has most of the same annotations. For
meson_saradc and the DMA buffer he uses __context_unsafe(). Here they
name the lock, so the helpers are checked, and for meson_saradc the
callers too.

Written with help from an LLM coding assistant.

v4: was a single qcom patch, now the first of nine
v3: https://lore.kernel.org/linux-iio/20261025191510.22261-1-zoone.rupert@gmail.com/

[1] https://lore.kernel.org/linux-iio/20261025215954.73549810@jic23-hlaptop/
[2] https://lore.kernel.org/linux-iio/76bbebb4-7337-486d-8f21-a39bcb6dca93@acm.org/
[3] https://github.com/bvanassche/linux/tree/thread-safety

Cc: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>

Rupesh Majhi (9):
  iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on mutex helpers
  iio: core: annotate the conditional mode claims
  iio: core: mark the mode lock helpers __context_unsafe
  iio: accel: kionix-kx022a: annotate the lock helpers
  iio: adc: meson_saradc: annotate the lock helpers
  iio: buffer-dma: annotate the queue lock helpers
  iio: light: opt3001: mark the interrupt handler __context_unsafe
  iio: light: veml6031x00: annotate the event enable helpers
  iio: enable context analysis for all drivers

 drivers/iio/Makefile                         | 2 ++
 drivers/iio/accel/Makefile                   | 2 ++
 drivers/iio/accel/kionix-kx022a.c            | 2 ++
 drivers/iio/adc/Makefile                     | 2 ++
 drivers/iio/adc/meson_saradc.c               | 2 ++
 drivers/iio/adc/qcom-spmi-adc5-gen3.c        | 4 ++--
 drivers/iio/addac/Makefile                   | 2 ++
 drivers/iio/afe/Makefile                     | 2 ++
 drivers/iio/amplifiers/Makefile              | 2 ++
 drivers/iio/buffer/Makefile                  | 2 ++
 drivers/iio/buffer/industrialio-buffer-dma.c | 2 ++
 drivers/iio/cdc/Makefile                     | 2 ++
 drivers/iio/chemical/Makefile                | 2 ++
 drivers/iio/common/cros_ec_sensors/Makefile  | 2 ++
 drivers/iio/common/hid-sensors/Makefile      | 2 ++
 drivers/iio/common/inv_sensors/Makefile      | 2 ++
 drivers/iio/common/ms_sensors/Makefile       | 2 ++
 drivers/iio/common/scmi_sensors/Makefile     | 3 +++
 drivers/iio/common/ssp_sensors/Makefile      | 2 ++
 drivers/iio/common/st_sensors/Makefile       | 2 ++
 drivers/iio/dac/Makefile                     | 2 ++
 drivers/iio/dummy/Makefile                   | 2 ++
 drivers/iio/filter/Makefile                  | 2 ++
 drivers/iio/flow/Makefile                    | 2 ++
 drivers/iio/frequency/Makefile               | 2 ++
 drivers/iio/gyro/Makefile                    | 2 ++
 drivers/iio/health/Makefile                  | 2 ++
 drivers/iio/humidity/Makefile                | 2 ++
 drivers/iio/imu/Makefile                     | 2 ++
 drivers/iio/imu/bmi160/Makefile              | 3 +++
 drivers/iio/imu/bmi270/Makefile              | 3 +++
 drivers/iio/imu/bmi323/Makefile              | 3 +++
 drivers/iio/imu/bno055/Makefile              | 2 ++
 drivers/iio/imu/inv_icm42600/Makefile        | 2 ++
 drivers/iio/imu/inv_icm42607/Makefile        | 2 ++
 drivers/iio/imu/inv_icm45600/Makefile        | 2 ++
 drivers/iio/imu/inv_mpu6050/Makefile         | 2 ++
 drivers/iio/imu/smi330/Makefile              | 3 +++
 drivers/iio/imu/st_lsm6dsx/Makefile          | 3 +++
 drivers/iio/imu/st_lsm9ds0/Makefile          | 3 +++
 drivers/iio/industrialio-core.c              | 2 ++
 drivers/iio/light/Makefile                   | 2 ++
 drivers/iio/light/opt3001.c                  | 1 +
 drivers/iio/light/veml6031x00.c              | 2 ++
 drivers/iio/magnetometer/Makefile            | 2 ++
 drivers/iio/multiplexer/Makefile             | 2 ++
 drivers/iio/orientation/Makefile             | 2 ++
 drivers/iio/position/Makefile                | 2 ++
 drivers/iio/potentiometer/Makefile           | 2 ++
 drivers/iio/potentiostat/Makefile            | 2 ++
 drivers/iio/pressure/Makefile                | 2 +-
 drivers/iio/proximity/Makefile               | 2 ++
 drivers/iio/resolver/Makefile                | 2 ++
 drivers/iio/sensorhubs/osf/Makefile          | 2 ++
 drivers/iio/temperature/Makefile             | 2 ++
 drivers/iio/test/Makefile                    | 2 ++
 drivers/iio/trigger/Makefile                 | 2 ++
 include/linux/iio/iio.h                      | 9 ++-------
 58 files changed, 121 insertions(+), 10 deletions(-)


base-commit: 7d80b4b383bc53b48abd3a30ca4a91cdab568bfa
-- 
2.43.0

