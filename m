Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A94E3C1981
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604454; cv=none; b=IZsdypzgXveiz0WPTwzGu9gKxWvyIduDxms/NtT0iXZfvuSwqeL/kIojJeQYr4LXwYP6i3101Iy/RnHtZd8G5MsL9PLr+khElkcpHqcFSteauZdf8UoUieZcygqAamjaiFMQuSmjanwrrmHJ4gdiaas+1ZDEU+kISXxdxJTE/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604454; c=relaxed/simple;
	bh=FqHvX9O1zkuY1T3DJEz0v7d4sZWj17CD+sgaaE0/jz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMDfVygT0mlHcwxQDq2ZkGb6pvbAGpFdg/XNy9XRlf1sys3hGETiOkqONnxTa09R3KA7oo+TwTsKZ8Xg6js2OSA5WMtHKDiMM+dwJWhH0ZDnbS2mze28+7I/lFx41NHkc3DXY97d3c9XC1lMxnkhFUjhnbz3HwiF3mAtIPyvA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtnlGLV2; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtnlGLV2"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e701435806so688474a34.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780604452; x=1781209252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9oEuLk7XB9tvetuqp5vhLFFB3pUTzFDIh+xJJF43t34=;
        b=PtnlGLV2XuWAYQS/tMHEBSL3ejc2Ujy+DBzYRXQHWxQNqOelCRI72cVpBB5B2fAUDO
         O/NT9CpcKLh9qnJs5dqYOfLBV2r/0NAq1ARdVIuPWfKPY4kD7zrHbFUIjBg7nJpv1DmU
         702OA5dvGiifMeEHbIKJrKJvrxwdduWzxo78Lf+j+wM58qh+OM5mcx3lokjQnu1Qe31S
         XY5Js8bQckyH+h/CS10iKwOHQM3F4ipH4313zHDb5Trgbnu4oibs3v57KsR7ZKldTbpa
         wEs+QpmU4InMOgKX3lLzP+dsODGtcF+T1UZNjDY46uHidnk18PTc6Zs7Q6iAUTMH/A+0
         hZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780604452; x=1781209252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oEuLk7XB9tvetuqp5vhLFFB3pUTzFDIh+xJJF43t34=;
        b=GIoGXPeADANgJKZx8AV5kEASwuTjzJIqj7OpD1r7OUCqR0lyVS9FvHd18vvV3J5W8c
         +mC8nh3wn95q/80Wp5eZE6tm5S3xoad29I2oO+BG+h+Jri7djLa8HPXFTCTl98nSvpJO
         H6Po146kU1R7/uJuAzYpNgewk2a819fAiLASQ4/lfuH0zfJn2naO/GDsxDgV6OD9qPw0
         QMJ8xdm39lnBYbxWVgXLeRzxYPht94FXFDKwYn2WIq0+moHnAawFZgqEYnBKMmsPZhIV
         J+fxEt/Am1dST/53s7cAT7/vMBszIeo9lOJUZXUsL1trmHFWgQ/fMWPVIjNegtdpAcDm
         JQ3A==
X-Gm-Message-State: AOJu0YxNOmJ0zSKZUSMBhBccPgPuWc5Ei/0FNBxXhfPkA7NwASKxXho/
	3YXj77kb2J9Z8wgsXEBTkZy+TR23oDDICnxNhhlBO6fJuFgfRXHA5A05gVP/Rm1S
X-Gm-Gg: Acq92OEQCSFLa+TM9bpukJSqIV3q9/yhCJF+lNeZeuWXLSeWYhPdq8OLOKPXzjs3gh/
	CmYMQGWY1mQSUWHe8rVLnvacfOciKnYx6cJzoLD9cFElwa+j+6wF6s9Ofzsuxj8NleLOvTzY3Dz
	veMI52HaLC1fV1Uaa4SgQvlHDzye9Nj0DiFAHVoGmRbsViKfdSvFoYBRmpzjU95b1hVWfLnyTuU
	J3U3xK1CtgkZQymanflh2wkzU+xeyDGbm0f0qykbFvwvXvQTJCOSVcOvIjbsVEQ3Hs9n+mTd4OA
	+GTxjWSWtYXnul11E8vdw/RkVMpNj2VQBH+Df3TPrk5wsh4yJbFVij2cISC3MV+9x7nMIudkfmd
	kzFgAgxCcuFs3DKyv0VWsnWEiDEITygR5TY0vMM/eIQ0Hfh4lnThM/OPyFBLQJOyj0OwUV6PtCY
	gnynTrNu0SbCTgmWz9NcUa1c3swQYHUcE=
X-Received: by 2002:a05:6830:2643:b0:7e6:fed6:3c33 with SMTP id 46e09a7af769-7e70caa9215mr135327a34.22.1780604452284;
        Thu, 04 Jun 2026 13:20:52 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e796c675sm4541800a34.24.2026.06.04.13.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 13:20:51 -0700 (PDT)
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
Subject: [PATCH V10 0/9] Add Invensense ICM42607
Date: Thu,  4 Jun 2026 15:18:22 -0500
Message-ID: <20260604201832.60656-1-macroalpha82@gmail.com>
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

Chris Morgan (9):
  dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
  dt-bindings: iio: imu: icm42600: Add icm42607 binding
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
 drivers/iio/imu/inv_icm42607/Kconfig          |  30 +
 drivers/iio/imu/inv_icm42607/Makefile         |  13 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 421 ++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 465 +++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 539 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 437 ++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  95 +++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 107 ++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |  82 +++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |  33 ++
 14 files changed, 2250 insertions(+), 2 deletions(-)
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

