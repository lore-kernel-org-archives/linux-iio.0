Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57A351C31
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114247; cv=none; b=X7aeMNwCiTDCohc/zU8tMw7zdLlzomytnZ7ABySx6o0kdnL5YDqDbYw4gwmm+RPvBIGUDvoAEQlgNJfK1ass+zAPHm+O148WiRQ9f9bQhaNipw/x+0Dk2daH2XR7qQJpMvE1kTyP8qT71/Wx0mSkgfbhoHKGJJLcazuhAdUB8Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114247; c=relaxed/simple;
	bh=DR1Jz8Ufye+UWwdXk3++DJObV2DI+okNt1wRJSPg5jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mu8FEshWbkoY5u3XUrjj/wTvKvAOubYCfRJVlmeb6DUZeVyHIcy2BUEIhW0jODTxDSiBiIKyU7H3P+X4ARvpI8TEgP+R+WOo1wc10krFQWNrPQ2KTRf6k+FIgHJyOXKOetJZBvxnbSoVPiCmoQJPujO40w6piFMfwx2m1ooAXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/CZ9FqY; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/CZ9FqY"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-486b93fc7c8so2060895b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781114244; x=1781719044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gutVdtz4CinnpieRqcTWignYTqVgqqCK7KQYfyHnkpY=;
        b=s/CZ9FqY+jnFptc4JbvMUHmQwLuAdHxpXfIlN+rkCoDDpFe4nosGdPrFkcdApq6AYh
         2F/9rG0uGf/cHu9tcA7v6vwHW99K1oXGPMylDnXaE8J2qI8yHd1qi5hVqjN9Fc23t0Iq
         +CxKHH8uwTcI5CD2mkgaQQ/msdGSGuXdAuxq7fcWdHohjXxIy6DEANlS1yMlZ13MJh5x
         /VZ1LcQLP4Xr+29HNGpuxjOYpZmlJNBmD8nMWW+P+/0shn7ERkUCKO09MZJOdi6uAWkZ
         Ly7dqQF4mQ9j+XBkaThvxFA2r/uthXP/2QzUQasN87NtvaCF0qSyV9gQzjz1azbCOd9O
         NWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114244; x=1781719044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gutVdtz4CinnpieRqcTWignYTqVgqqCK7KQYfyHnkpY=;
        b=QCpIQrNcS+NSYQ1OYOmtArm6FcCwhH9cdrySKixIvfU1Rb+4C+zCwjtoDaSKZE6rSg
         KNu00BfLriUUAqijQEi26tb1ZnyECgYyWjnFcAOGGZjIHeSDXQWMXYdNRhwtKMctYv+S
         2UdhqJARmaCdvEp8BnP+QzeizEbqTNLIP/ecRSFzyNhnP/vIMXz7kgRCurOjzlhXsQmO
         PuHMc44zSn2BY1IqryFFn7UtmVWEoy5Wsqa/csfXUgmUaZUKm41oezVZ+ZU0Y8f4KSlk
         Oy9yjutNCq0HkHPnI12APCOs3dkWqmdTvulQCleQG87efWkuazstSnaU9BbBHLWtnGr0
         I+pQ==
X-Gm-Message-State: AOJu0YyBh/rOrHy0B9v/C4coy0NTY+90GQlQzmrC3LqfPFdUm6JP3FIc
	J5LzfHrBTpSDjxtOPaibp33Pmj9xsB4t38P9J7y+wtSUeNIVGicyiUVbuFMHYw==
X-Gm-Gg: Acq92OEeC8X+PCRtJlw8F+OF5U9vTDxlRvHGqBKodVf7YY9xy8sPZcwjgxLjZP2iGv1
	EzLHJ0V2e3kToBVds8Y1bPlrlA1vJm592RbujDneyQ/vog/woGVqYV/wzLPUqVT/Tt0Qx/ApHhs
	Pn/Rfoo6aZQqbCxX1erIlcdhnR/nsoVvjlc1MbVzllHVCc2PDnRcFeZ2NTFdOf5BqX7BLdl736P
	s7I9hG+pThSwZBrAqDuGh6hYLr8dzGartCo2SSY1ZL0HYdPrO+LkkWu05lCf8u3bEva6ct3nN9p
	E22K/2CsInyoMLLzHSrbykAayAKCmKTQxLdO+kB805cuRWfjPEjin+Gk6c1yMZyWZORzzndd9rO
	2L7ytZQ1P0OejJfoR2v9Xl02T7nbqNL8j6JD3zByN9MQh4J8CJA8GnmdjhOeBYPDpdjgr+/Y5UH
	HNH00lPzQkVn9AtgIDQ35F6EcoaizjzuXc2oznLJikmgvbgSrvhQ7Ouw==
X-Received: by 2002:a05:6808:3442:b0:486:523b:3c03 with SMTP id 5614622812f47-4868dc827camr15600027b6e.18.1781114244214;
        Wed, 10 Jun 2026 10:57:24 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:b86b:51ed:28ca:695f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d7d4f449sm21180794fac.8.2026.06.10.10.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:57:23 -0700 (PDT)
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
Subject: [PATCH V11 0/9] Add Invensense ICM42607
Date: Wed, 10 Jun 2026 12:54:44 -0500
Message-ID: <20260610175455.19006-1-macroalpha82@gmail.com>
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

Changes Since V3:
 - Numerous small fixes (too many to list here). Thank you to everyone who
   provided feedback.
 - Split power management additions into an additional commit to break
   things up further.
 - Consolidated devicetree documentation in existing
   invensense,icm42600.yaml file.
 - Removed most of the FIELD_PREP from header file to c files to make code
   easier to read.
 - Changed scale values to 2D arrays for Gyro and Accelerometer.
 - Removed IIO_CHAN_INFO_CALIBBIAS attribute.

Changes Since V4:
 - Additional numerous small fixes, thank you again for all the feedback.
 - Dropped power control API and instead run device in low noise mode.
 - Split devicetree bindings into two distinct changes.
 - Reordered adding of enums and structs to main header file so that they
   are only brought in when needed.
 - Stopped using enum for driver data and instead am using pointer to
   device specific driver data.

Changes Since V5:
 - Corrected use of "dev_warn_probe" to just "dev_warn".
 - Fixed some return scenarios which would unconditionally return 0
   when an error was present.
 - Corrected use of max() to min() for bounds checking. max() was
   incorrect.
 - Fixed using "st->conf.accel.odr" in the gyroscope function. It
   should have been "st->conf.gyro.odr" which it now is.
 - Additional small fixes suggested by "sashiko.dev".
 - Added a regmap cache. I used the datasheet to try and determine
   which registers might change without explicit writes.

Changes Since V6:
 - Corrected additional errors identified by sashiko.dev, mostly
   fixing potential deadlocks, missing calls for pm runtime, and
   potential overflow issues.

Changes Since V7:
 - Dropped Wake on Movement patches, since some of the functionality
   was only available for a device on which I cannot test.
 - Dropped support for SPI 3-Wire mode, since it complicated the
   bus setup (and I lack the hardware to test such features anyway).
 - Fixed a few additional bugs identified by sashiko.dev bot.

Changes Since V8:
 - Added back IRQ dropped accidentally when dropping wake on movement
   patches.
 - Dropped "Reviewed-By" tag on patch 2 because of substantial changes
   made to devicetree binding documentation.
 - Additional small fixes as suggested.

Changes Since V9:
 - Removed interrupts (and buffers) from the driver. I previously was
   unable to detect deadlocks because it turns out my IRQ was not even
   wired correctly in my device.
 - Updated devicetree binding commits to make interrupts optional for
   users of the icm42607 driver.

Changes Since V10:
 - Explicitly specified enum values in header file.
 - Removed additional dead code for buffer handling.
 - Cleaned up headers.
 - Added additional locks as requested by sashiko.dev bot.

Chris Morgan (9):
  dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
  dt-bindings: iio: imu: icm42600: Add icm42607
  iio: imu: inv_icm42607: Add inv_icm42607 Core Driver
  iio: imu: inv_icm42607: Add I2C and SPI For icm42607
  iio: imu: inv_icm42607: Add PM support for icm42607
  iio: imu: inv_icm42607: Add Temp Support in icm42607
  iio: imu: inv_icm42607: Add Accelerometer for icm42607
  iio: imu: inv_icm42607: Add Gyroscope to icm42607
  arm64: dts: rockchip: Add icm42607p IMU for RG-DS

 .../bindings/iio/imu/invensense,icm42600.yaml |  20 +-
 .../dts/rockchip/rk3568-anbernic-rg-ds.dts    |   8 +-
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/inv_icm42607/Kconfig          |  30 ++
 drivers/iio/imu/inv_icm42607/Makefile         |  13 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 415 ++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 379 +++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 506 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 369 +++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  93 ++++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 105 ++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |  82 +++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |  33 ++
 14 files changed, 2053 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/imu/inv_icm42607/Kconfig
 create mode 100644 drivers/iio/imu/inv_icm42607/Makefile
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_gyro.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h

-- 
2.43.0

