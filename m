Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF02D24E4C6
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900868; cv=none; b=ANeSyBfs0k3KXn8UIacdTCQ4Hsvx3S2n5dZBQWA0Lw4DKoBTQyamublMdLwqk9rEn9jowRXgYInj65iK5ZNlwHLlMNvCw6TnNLP+djki3Ca1FDRUb6dDewiSb2tfQghgj36M1i5wWLBa/qTVtbwNo7KUvfffBOUWgd1HpQ6Jv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900868; c=relaxed/simple;
	bh=BOgXm1/gyoBP6uulTOs3CmkhaYrIIhLPEBJ9uoXBChs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U1fP4u2jFU+by4HCG+m22g4WeEfsN+Kn5uRikwYUplkYkndROZ2lvsgmCGTN7Ij8mtk7OpaF9jz/xdnYzK7sU3E8pcwgNbWT7i/PljfuJuebqsL90PxnIjkS7ODl5A4+89JFSgzaG0YfM1oPcI0yIvm8AFMhnf7haGMHG7XlSSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfNuzQrg; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfNuzQrg"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d7f09aa39fso5883017a34.0
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 13:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774900865; x=1775505665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LLWSGkC1hPKbo8hCDY87YS3QDQG9Xg0HOko4w4pFuyA=;
        b=jfNuzQrgAZQD7aKet41n5RwuNXrrhHYZpKoVleEmmuDBWmyqZKp3xqPuHN+HKITyCH
         TKndBuU781S9zsL/BOdyvKL+FS491B9bbJoHc1NbmANA14Cen6Sx3Dp4mN3nbddy/Kr0
         NENNBw69QFRaJR+LL3HSx1DCm1EjOt8OigwgPamWcfN79aAXAbdbaxjN9+VuOmWQph6s
         C66EW/KK/QxPBsN4oyp4PTsRbjCSryfWHRtHIYblACm+SEEv6MM+BP+5u6PGONMPU6hB
         jqE7CM9LOKvLzGGQfNRJgcvJbEBeRJdIUxnyi1EXOYrs4pYS8T6FM1asGXZw0+DPbT+7
         QTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774900865; x=1775505665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLWSGkC1hPKbo8hCDY87YS3QDQG9Xg0HOko4w4pFuyA=;
        b=e6ev3kCnPLQkfoSBY0F/fd/gJXssk6nfPtFWLLOez+1N/B7AVD6RqNCJiOBMwzmQyw
         ttbFWe65f7xkfdwr8VvNITwnN81Wlhxf4afyKTeHZU4b0GRZNHOtduy4MeKaZGygf3la
         6ILxK5pdaizW+5SHTC0UzcKs4j+6JHcu/6kO+MkARDX48O4LvSlwI6RGMteuaZCgZ4R2
         Tlv64HRIJwWpfTOZS8qKbk1tAXBVMrMH0qsWxka61eLXHN4zwoeM9mTiSpTDcpgsYqq7
         bENfzf1qzQ81ilui90wb0Jd4Z91e3NVTPApFEAbvC5GXbnW6FP80fkb9N/iQ9amxF8iG
         URAw==
X-Gm-Message-State: AOJu0Yz2cTlw9HjtZpJBr9bU+1e/HZtEaWSotnjKyzmeWLvnXumiVbvg
	jmgRO7T6LkvRXBFkfVOVnimb2aqAQZZhs8yixLPx+4fYj4wOsC17QsDFDRPM8V3/
X-Gm-Gg: ATEYQzwR7mkLvpB+d/m2kDczvXBuTllJlz2ljAAU4/7yEEe4Eb3v6CD7C1o3TtJIY7J
	myssPEcVIIbOryuP1eaG8N69pKftlNlsY+wxtgZ/R+PZSyn6D6Jk+K/Z9Kf1yy4wPAEqj17ir2l
	zgWjCE2Pm21j/NhVcCrChHQgvR8hiCdWQUjwLUoT+QGmMtkHmw9Vvn0cHm7jvMfSf+0rVf3oqN/
	kzBSWUHPIIIeHngoVYXwuXYgES4V8ulvVSn2NFl3mALhHlj5I2zZpzPs3Hq/F7b1WmekdhiHHi+
	+vMISNkE64/LN5FASQ38pIUuBwzfumrQIn+3T/YHmoVBYq/7jalnC+IR4APA+LUfoHoRvMTzDKd
	DJq19KYmPb+rxUr0uS2wOXi8pwLSm/tTO8twXQ4RnKDh/R1BYOv3X7vuSd6XDxI8wR+/C/2e6JX
	EbZvpQK0uBMolWz7kxHWaT2UDy0pQFZoc=
X-Received: by 2002:a05:6830:67c5:b0:7d7:b85f:25e7 with SMTP id 46e09a7af769-7d9faf3b967mr7706158a34.28.1774900865528;
        Mon, 30 Mar 2026 13:01:05 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a336353sm6601068a34.2.2026.03.30.13.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:01:05 -0700 (PDT)
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
Subject: [PATCH V3 0/9] Add Invensense ICM42607
Date: Mon, 30 Mar 2026 14:58:44 -0500
Message-ID: <20260330195853.392877-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the ICM42607 IMU. This sensor shares the same
functionality but a different register layout with the existing
ICM42600.

This driver should work with the ICM42607 and ICM42607P over both I2C
and SPI, however only the ICM42607P over I2C could be tested.

Changes Since V1:
 - Instead of creating a new driver, merged with the existing inv_icm42600
   driver. This necessitated adding some code to the existing driver to
   permit using a different register layout for the same functionality.
 - Split changes up a bit more to decrease the size of the individual
   patches. Note that patch 0004 is still pretty hefty; if I need to split
   further I may need to create some temporary stub functions.
 - Used guard() and PM_RUNTIME_ACQUIRE_AUTOSUSPEND() on the new functions
   per Jonathan's recommendations.

Changes Since V2:
 - Went back to using a new driver on advice from Invensense engineer.
 - Further split changes up into smaller chunks of functionality. Note
   still that the largest patch is approximately 900 lines, and that while
   the driver compiles cleanly at each commit it is not able to drive the
   hardware until the commit that adds the Interrupt (as it also adds the
   Makefile).
 - Change the error to a warning when the devicetree binding does not match
   the hardware ID.
 - Dropped the ack on the devicetree bindings, as I am creating a new file
   (for a new driver) instead of modifying the existing one.

Chris Morgan (9):
  dt-bindings: iio: imu: icm42607: Add devicetree binding
  iio: imu: inv_icm42607: Add Core for inv_icm42607 Driver
  iio: imu: inv_icm42607: Add I2C and SPI For icm42607
  iio: imu: inv_icm42607: Add Buffer support functions to icm42607
  iio: imu: inv_icm42607: Add Temperature Support in icm42607
  iio: imu: inv_icm42607: Add Accelerometer for icm42607
  iio: imu: inv_icm42607: Add Interrupt and Wake on Movement for
    icm42607
  iio: imu: inv_icm42607: Add Gyroscope to icm42607
  arm64: dts: rockchip: Add icm42607p IMU for RG-DS

 .../bindings/iio/imu/invensense,icm42607.yaml |   95 ++
 .../dts/rockchip/rk3568-anbernic-rg-ds.dts    |   20 +-
 drivers/iio/imu/Kconfig                       |    1 +
 drivers/iio/imu/Makefile                      |    1 +
 drivers/iio/imu/inv_icm42607/Kconfig          |   30 +
 drivers/iio/imu/inv_icm42607/Makefile         |   14 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  472 ++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 1028 +++++++++++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.c    |  566 +++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.h    |  100 ++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  |  806 +++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  |  579 ++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |   93 ++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   |  100 ++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |   81 ++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |   30 +
 16 files changed, 4015 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/invensense,icm42607.yaml
 create mode 100644 drivers/iio/imu/inv_icm42607/Kconfig
 create mode 100644 drivers/iio/imu/inv_icm42607/Makefile
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h

-- 
2.43.0

