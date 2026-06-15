Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5C94183A4
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544491; cv=none; b=JxepM0funcs7J7QU/Gav2qR/QU1nl6mKoWIdOsX+C3pG+TcV5ou0ajwyF+I/Nnc0IqjT3UPyF4H6uYOemNGYxllmqt7t/kzqIP8INSXuAK/TsdmDxKhpe62VNrMzgeFRKq+na8R3kIUF+ry0eBUt8/xbt9vJbsuY45zkqq0HJP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544491; c=relaxed/simple;
	bh=m4VJh9EbIbh8eyI4rIksAQyPQ9mm0Sq5d8HU0Pg5gcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9P9C0mLeq2Uv68WkphdJgtzE4JgrfTnA1YMgCXDblak8UrLybmm8L/jWLkibtJR2CjNiAnWgF10Z7nuUFnfn1ijFA2quNHgaXL6MHF7EuWYw1Hwmq0jkv9+IPpD/s5mX5O27icErDoDDGGsKDvavTf3h+R4vWPxzQERhSf3l6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCk9AT77; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCk9AT77"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6f922e49fso2792834a34.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781544488; x=1782149288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DtjS7+FokRO/CCMwdq59ej7kactnqHdhl1aTtVDIodY=;
        b=GCk9AT77c+dM41NTat6d8g2uZftmKbQ61WrM2Phh8FyN35YPj8jthxE8ZGHnxsUovC
         G/SqVs3WTe4ihtok1J1MojGMqIbz5PcY+U6eqWHFe0D6P5nU0mA1D2Jr+9x2tQhBKkca
         gUmolRckq4zz4qj5vhH8mSwzxEH+88yHotrf+o933Kt561qXRsE13virwarpsiXtZvuH
         4jntVJLQWJyQLQeTd3zWyAyXo4Vwy9fNqgSdWZ2hlBRHcOUUcO7CIwdw19xzcaWQQCwa
         iWMFwuVKcGssVEcsxCybHJQx76YFQ76AC1a6m4GU7cY+fYiXDCrtWSyF+2poh3+fRbJ9
         GorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544488; x=1782149288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtjS7+FokRO/CCMwdq59ej7kactnqHdhl1aTtVDIodY=;
        b=NUf0uU3+gr57dt47zXPsHLFfcZ3z9uY+8Ha9rQq0bS4wvSeeFrPDOIvyyXsKuOCNEi
         PSiMZ5RMTUajvwiSowkXwVUenjGOto0s05aBdJOrzp8MUkNpFMZsTzZERq1aDSDjPM1S
         L9HxDePRuXHPiHYZ3mOYR2hRAPBxzR+YTK2LULPbF3nZrodW5GGjqdufMQCZOPi4fBQv
         6E0G9aw1Tl7S6NrwLN8X33WvEwZJO1bHKCMJl4GYXrTZWhYOBJD1ASHoEMISmZXbnY1L
         puVqoKP/grvBd4FM3gY6xqbZvZduOM9YciW5n668/jB4ZoP2sb+DjsQs//Kgn590O+GI
         Q55g==
X-Gm-Message-State: AOJu0YyEYzNwrKJIMtxZ+kcKec5uMwMobu5RefzZ9EVie41wqJ5QheCv
	aCo3FKeF/V+r+0x+c7CeZhzFwhKKziRsweKYnh5nHwHUiL3+AidRrdXexrhDVgXg
X-Gm-Gg: Acq92OFFbNi8YRz9qFdKJvIbfvSpGW7zOKdgOPWIIIoAY62tI+TTUVwcPw8m7oeXOjR
	vSoBzXiouKz5ip3xwir+3evR213J4QWQqBPRlOS9GZgwTMzoBIr257ovyQNGME2+9COODUS1NjA
	lVY5q0DMJmHkYOSiYMfkgmEXEyLuuRNbg61LC+XgVeQweXADwwD32mu1OWjRba82Wcj9zYVpoyS
	WWTD7tqg8bJI6/dRqtOrFyV+Uat58S72UaS8OnMV3dlEBGk4J7M5eX21O6qdvgiuALGPf6nmJTO
	XjNswH7isiUsqskIcCwQIoBq7p1ixT3IkPr7KqMbDdENAq9dk/u4dtjd7AlPQGoZel3ihtTJI3z
	CeIgcBX33BR+mkDro3c77QdoJXMgA76wWds0lH0YWviFe4A9MH+i13DpBIk5MHi9SSJaJ5tnup/
	S0rGKlYjiNxm8bZ4gCJlUgBIc4osfMTJTk
X-Received: by 2002:a05:6830:d11:b0:7e6:d542:aa with SMTP id 46e09a7af769-7e8fc512f82mr347687a34.23.1781544488082;
        Mon, 15 Jun 2026 10:28:08 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f451fe7sm4480033a34.0.2026.06.15.10.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:28:07 -0700 (PDT)
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
Subject: [PATCH V13 0/9] Add Invensense ICM42607
Date: Mon, 15 Jun 2026 12:25:43 -0500
Message-ID: <20260615172554.160910-1-macroalpha82@gmail.com>
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

Chris Morgan (9):
  dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
  dt-bindings: iio: imu: icm42600: Add icm42607
  iio: imu: inv_icm42607: Add inv_icm42607 Core Driver
  iio: imu: inv_icm42607: Add SPI For icm42607
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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 410 +++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 373 ++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 546 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 369 ++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  98 ++++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 108 ++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |  81 +++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |  37 ++
 14 files changed, 2093 insertions(+), 2 deletions(-)
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

