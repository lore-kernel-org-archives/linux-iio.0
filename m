Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928163BF66D
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579167; cv=none; b=LAym98S16No9Q1nDg/TF5e8E7qvEz0tZkFbtRSA9s/OxDE4UtiQgKeTjpdRrQp/omqOyDIkXSUnuK9hEZYGm5m5Ig+OBmI3Kcz5PXkHv5MOCwO05JPZLPMBbRYFmqeQHeI35v+cjB4lipPdWCh/4r1B/6cF86PhWVIV5zy6ttsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579167; c=relaxed/simple;
	bh=9yl1RDVRAf8BpeYgdYtbW22ucI45KKBYM/ADxGwjcSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dm7mVNWuUuWFCce/uJWzhIU91jmFGJ6WDhwbYWM9w7mh40tXB+T3o14CPau2oBiDDdPTFEjmYSPhRz1+n6EcqZtDPI61D525PVZ5/DTys1iNbvK8ZLgyjuqvpMrjoDk3IY9M0Ft3pVMdPXVK4279NxhrqjsB2DMxKYhOVlFDs3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJVhgnkO; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJVhgnkO"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-48d6c621a67so4414010b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579163; x=1785183963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XgGv8dwczX0vaEZLCkEmThFftXPI/2VXbSxzjWtQbhM=;
        b=gJVhgnkOiob4r/8Wacj8/0wktGhXXnWkegL8piUkyAFkphzWLYdtbg87kQhWlCB806
         XfoaKaM7QUsQ1WmlsHBTfGWGApPegK9giCQcgNmdBhWiVd0eI8pVc8Z3czFy+hjcssQX
         Ke3AzJldkIyNf60OtlklQiqJoVt50ihMQIG/e7IdGQWraC6Fd2J5/6/ThDlHNomMklaV
         /hyY+yBiCtL5BWGTa6DorlZ7XhgF103qroxmuJ63uXGdnNTOXb7MW5XX5TfqZREou09D
         GrxoVei71srzongkA0hX6PKTsLVVDwJFzirhFmaQkCt1d11YODg79BaR+Pg5bEclKMbm
         e7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579163; x=1785183963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgGv8dwczX0vaEZLCkEmThFftXPI/2VXbSxzjWtQbhM=;
        b=EyyGB7WK1I3Dgs51q+BFL7LihaHoLnIx8LTVPopdehRjFCVSIfgVBgqZfvX2kzrFwM
         9ws/PIjPCJwX7eoMSNeXcoaFB2rFsH1ijH8C/QbBJVTBhsi8HfM28xeaGwAvimrwtjHH
         pf6tuV1KAOdHNKUx/odn0QHzCSQdctLFRGV2uRi1i7RzqJY3KW9kikuHVC2+eKJevWrU
         OBTR/zRosYpheCBSyxN+Oy7jTKhh6f0WexGvC1JgN6YF9bh5FunrKSw6f9Ov9VfKQli/
         gTVHrykOp5B7ig+K8QOBkPFIQ6GNnyKk2uwxwPsuRKsL64tQwcaca87fcctLUKnnd9P6
         5l2A==
X-Gm-Message-State: AOJu0Yy/pnRAlhL/Dk2HTXL2LI9ZYoM1SyPZx9ZRKcw1JQj4msntOnMM
	pAbgnTOoJlGbCg34JtK2zprLtcs7RaU4gXACtnUAiMQve3rNUxdGs2T/mZqkgw==
X-Gm-Gg: AfdE7ck1dXDsNMRAll+ybjG8jEPwIfirtnkk3QTI9m1g24Fj9H3vgS1sTJi9Ua9Ois8
	YH4RlX/MMUZOPmwKuLgPyFBVv9grx7ZzQYnuZYd19jWOJqCLWY/CXgkknWbzJWxHvsGhSSKjTo4
	7oT20kiXE/8DKzqVqXDjT3oiBLroEsB+AP/2+ogLVY0FNMW7n02l/FypLyJiPWM1Y3bNawKh8eS
	Idp0D5b5wNNxGrTrow6t0ixTUjnGch43oR/+k9N63lla63WMtbLWBPcigBVrPtp060YWMUKnWpv
	Z2w3oLI6zsgjn2FJUh79TlORHU92MeOEgoNHbZjcSFRXP4yMBZ9o+/qis1EycdfXvwkxwaI8Fis
	yE84llWyGyntDwnuhIl4tCTV+BRHr0XoHyLDav2vS+9h98GYzyhPuEIzFjz+aTI4K7tRkpbLmqV
	T91xtgNdPDo61IwxwYThPkZQ==
X-Received: by 2002:a05:6808:4fc8:b0:4a4:2654:1a48 with SMTP id 5614622812f47-4a4d05a08bbmr9864324b6e.39.1784579162688;
        Mon, 20 Jul 2026 13:26:02 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:9988:5abf:3c51:d168])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a4d3e5a0cdsm8029550b6e.18.2026.07.20.13.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:26:01 -0700 (PDT)
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
Subject: [PATCH V18 0/9] Add Invensense ICM42607
Date: Mon, 20 Jul 2026 15:23:32 -0500
Message-ID: <20260720202343.70138-1-macroalpha82@gmail.com>
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

Changes Since V11:
 - Since driver has shrunk in size considerably, moved i2c bits into
   first code commit. This ensures that the very first commit with code
   can now be compiled. The commit after that adds SPI support as it
   was in the previous versions.
 - Used pahole to optimize inv_icm42607_state. Reordering elements
   reduced size in memory from 384 bytes to 256 bytes.
 - Added a map of all readable registers and all writeable registers
   according to the datasheet.
 - Added back some missing headers pointed out by the maintainers.
 - Added FIELD_PREP in a few more places to make the code more
   obvious on what it's doing.
 - Added a comment to the power management code to note that
   temperature sensor being enabled doesn't matter as the clocks
   are off by default when the gyro and accel channels are off.
 - Removed iio_device_claim_direct() calls since it was no longer
   needed.
 - Fixed shared_by_all attributes for temperature sensor.
 - Additional miscellanous fixes as requested.

Changes Since V12:
 - Removed aligned buffer from inv_icm42607_state struct as we do not
   currently have the need for it.
 - Corrected the order of the odr values in the accel and gyro files
   as the values were out of order (the place in the array corresponds
   to the register value).
 - Stopped setting the clock value depending upon the temp config. The
   datasheet advised to keep using the default value.
 - Corrected logic when changing between states. We only need to pause
   when a sensor changes from off to an on state or when the gyro
   changes from an on state to off.
 - Added missing includes for several files.

Changes Since V13:
 - Refactored inv_icm42607_set_accel_conf() and
   inv_icm42607_set_gyro_conf() into a single function.
 - Refactored inv_icm42607_accel_read_sensor() and
   inv_icm42607_gyro_read_sensor() into a single function.
 - Merged inv_icm42607_set_temp_conf() into initial init function
   since it only really needs to be called once.
 - Saved adding temp sensor for last and updated
   inv_icm42607_temp_read() to either confirm other sensors are already
   enabled or enable the accelerometer so it can get a reading.
 - Updated inv_icm42607_set_pwr_mgmt0() so that it does not update the
   sensor mode and forcibly keep the sensor enabled.
 - Added inv_icm42607_temp_filter_bw enums since it appears to use
   different values than the accel or gyro sensor.
 - Set the temp startup time from 77ms to 77us, as I previously misread
   the datasheet.
 - Additional minor fixes.

Changes Since V14:
 - Added IIO_BE for temp sensor.
 - Switched from ktime_get_real() to ktime_get().

Changes Since V15:
 - Removed interrupts from required property per note from Jonathan.
   As a result of this change I've also removed one of Krzysztof's
   Reviewed-By tags as this change probably requires further review
   from them.
 - Corrected a comment about reserved values from 0-5 to 0-4.
 - Reordered some operations so that only runtime power management
   turns off the sensors now. This removes the "ping-pong" effect
   when switching between the accel and gyro sensor, at the expense
   of leaving either the accel or gyro sensor enabled until runtime
   power management turns it off.
 - Fixed the shared frequency value not being available for the temp
   sensor.

Changes Since V16:
 - Reverted devicetree changes back to removing interrupts only for
   icm42607. Added back "Reviewed-By" tag, hope that's okay since it's
   what was initally agreed upon.
 - Removed PM runtime resume code, as there is currently no need to
   resume; instead the raw read/write calls will enable sensors as
   needed. This also allows us to remove storing the sensor state
   prior to runtime suspend and instead we just use runtime suspend
   to disable sensors while not being used.
 - Additional formatting and minor fixes.

Changes Since V17:
 - Added remove routine to ensure device is properly powered down when
   driver removed.
 - Corrected issue with reading scale and offset values for temp
   sensor.
 - Set regcache as dirty and re-sync when resuming from suspend.
 - Added back driver data to of_device_id table for I2C driver. While
   Uwe told me to remove this in a prior commit Jonathan requested it
   back and it is consistent with other drivers to be there.
 - Removed linux/mod_devicetable.h header for SPI driver.

Chris Morgan (9):
  dt-bindings: iio: imu: icm42600: Add mount-matrix
  dt-bindings: iio: imu: icm42600: Add icm42607
  iio: imu: inv_icm42607: Add inv_icm42607 Core Driver
  iio: imu: inv_icm42607: Add SPI For icm42607
  iio: imu: inv_icm42607: Add PM support for icm42607
  iio: imu: inv_icm42607: Add Accelerometer for icm42607
  iio: imu: inv_icm42607: Add Gyroscope to icm42607
  iio: imu: inv_icm42607: Add Temp Support in icm42607
  arm64: dts: rockchip: Add icm42607p IMU for RG-DS

 .../bindings/iio/imu/invensense,icm42600.yaml |  20 +-
 .../dts/rockchip/rk3568-anbernic-rg-ds.dts    |   8 +-
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/inv_icm42607/Kconfig          |  30 +
 drivers/iio/imu/inv_icm42607/Makefile         |  13 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 421 ++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 312 +++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 641 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 309 +++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   | 104 +++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 114 ++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |  98 +++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |  38 ++
 14 files changed, 2108 insertions(+), 2 deletions(-)
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

