Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A3B3F9F47
	for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490496; cv=none; b=uo+DwwZfYLVO9cUvUW7N1HkAPOCyfaciD0GK4yem9kJKbFhw1c1RQ60V29tRORmnDYf4bIVFEBU9qSBiHT5Jz3dVnnmLv2ww0CFIYcNf1JJTLNxXZ+nJbZ47lxhdf97IBA1n/mdxYMk1bIV/PS6TzauOm8WgWohGoPSw2dsaFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490496; c=relaxed/simple;
	bh=Z4P9SpvY/otKIUQeO1nInbQcZUYx7xU24QUGtzVVMoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kk9IxiwRwbpq1mXjZ/hASsDLb8NeX+OtR/yluANKHG8P2JaQDaVaNUtrRBBzznh8YpW7J8LvIq6WkIZyvDQKqir36A2nFW9RHQILt/kItq1mt6d4w3eVYM+cewRB+/FJhd+V9jlPgwUAjAlZHNfpWHOD4pbFqwIveDX6NA9ZT4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RirL8m/v; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RirL8m/v"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9b4f8ade0so177132a34.2
        for <linux-iio@vger.kernel.org>; Fri, 26 Jun 2026 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782490493; x=1783095293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4xHWEOper191CMSyTFNthImMht5LodlFV4q9KnknyWQ=;
        b=RirL8m/v+HEUpiW+ovwUbjn0KVT5ezQs4anz5oyGPLKAmyaQhzuKQ0lzepaXtUwbr+
         S2VEKkZYenPa2Zs1rT8xiMr91XWT/DfrSW/uclQbfJIW+9TB2yv+f0Wkz41vbzadEJ4O
         Q+v4dfa616U1NZSGRRK1FprApW3kFqXtKescRTY287ZQPRioxURDLJG4LOXrcpmVJGML
         R+6CFUWfyMOmqVptlTKBsNV2y6GvgiWSQgOGLPk0u9pgw8oOrq9tn8+QsiInpzXi4oT4
         INW3PQYJ5VJFcvsvH6HM3HYD1mMOl2pqKkxVVRtqTQC/vJxf0Urgbrq8Z8HRVkghay4e
         KoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782490493; x=1783095293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xHWEOper191CMSyTFNthImMht5LodlFV4q9KnknyWQ=;
        b=MNRvS/29qQ1SH+V9HfiG1/J4AQ+1HMOFC6LwElDDyCl5fCvYwDTtFs9cAm1s6KXuYn
         d0a/GY2HQX9p1lVNbBKozqH4w2c+Ng8FycTxETysR/9h+X3s2Ty9Dbgl4vKIQutjeFcG
         7SfqOUsDZmfvvPO09VJ3sqR3Nc4f+NO0HKuIkuLEc4bkQzPuX6y0skCY2D6HQBSZgwg5
         D7usMvP+LUVmsaU7847v8AkzXfylCEO5aTXrIEsj6lvqO+hoXDx0mm4xMhH7iPeMYWPH
         DVz4mEVS4/G7PEsJrQmp581C/yO0H+I8Oq+TEt2mGEu/wKNIl9GGEvPo7UywFx/W1+fg
         XoXA==
X-Gm-Message-State: AOJu0YwxORWUi1tqMSj92yuL8vEZIsvNLQ0EWclOPqiaR+D4P2fG5o71
	r1lUoTPeMqb/Ugw5TLuVGXQS1Z8Ul7JCPKVpY+EN1bWvvM7iBu43Zd23BiSeqjsO
X-Gm-Gg: AfdE7clbXSa7Iia4mQGjZD00TlPjoW2Ico2/OgxtCmgSl4WZsDeGq2lauvDLge6C8Kg
	Dbr4o6zyudS2Yaui+AqRVHYvl31LO0OA497ohpo/8yfpKTIBf/r2HqcIfZC3r5d9yybDkN0H3It
	pkSSLOsvhECdUDbcsCYman2/h5FVDut/4oUHA49gLXnNtK2bDS1nVnTAgJL9z/vlMxCXlSzUTR+
	XHvNQXPg3/mdUXhQHQnJMI47fitaSQ5DhJ0RK1WhVE5RrTZdu0gPUcOd9Fyn1TzC/57ZzI6LguP
	t5NokNDKEBRKUzNP7cFboRrymbaQzmTOrrHsdzohiu3CAPMQYd+rK3hH4QLTdhChGWc0Dr5rvpg
	ACJvVTMikW24O79yAH2Jh/R+wW9UMq9CEjx+VXFYcJM1VE+E1wMkDr1mzEUBsnZUhDlD2UvxusS
	6WaBquOh7Uqq4=
X-Received: by 2002:a05:6830:6e08:b0:7e9:b4d0:539e with SMTP id 46e09a7af769-7e9b4d064dbmr674821a34.31.1782490493445;
        Fri, 26 Jun 2026 09:14:53 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa579235sm1970211a34.1.2026.06.26.09.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:14:52 -0700 (PDT)
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
Subject: [PATCH V15 0/9] Add Invensense ICM42607
Date: Fri, 26 Jun 2026 11:12:21 -0500
Message-ID: <20260626161230.93069-1-macroalpha82@gmail.com>
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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 423 ++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 317 +++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 606 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 313 +++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  98 +++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 108 ++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |  98 +++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |  38 ++
 14 files changed, 2072 insertions(+), 2 deletions(-)
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

