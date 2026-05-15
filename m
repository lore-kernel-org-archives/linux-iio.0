Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199D26F2BE
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850163; cv=none; b=KNp3NEjiHvCnWQn+OZGdxc+bjmLSrig+iHVeg5/t8qtJm30rF4KrGOl2Qmg5CdoBdprMhzR0ke7uXDtRAP7ktQTfWBBE/LGoifmuR0qkqtie7tQ0NGERO8zSXQYCqcGk5fepOZRY4bdD8gHz+DRDLXGTvP0JqOpV0QoiHJNQuxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850163; c=relaxed/simple;
	bh=T7AJ7tn0qgkJaoOf5XWjLOJc+h99gjgVzND7aw/tnYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J788xctV5nh/PU2tMlr7KQ3wjOdgcMU3FzSMpqakCl/DD7t8jExBS3yq9cvuYtT+fwaKJDAVVUS4R5ZpxIiLS0riw45Uiq2WSdMw+e+7+BkAxrJRpqV96rHGRo+zaujVD2YkQ89gviYOXAaRxPAvmSEmze2ASEHVLBStWE4yDqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rh4ZBzJO; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rh4ZBzJO"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-439acb393f7so3862494fac.1
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 06:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778850161; x=1779454961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4KVzd01T5sf0R9FhB15rxjDpz8yPmArKGvd/XLI4lM=;
        b=rh4ZBzJONR75BASZ0C9mW2PfkqagC8hMgPOY6yl0UcOLZeNPbmy81ERho584XGEQ3I
         T1uJ1FpbNOUtkW9NVn6u7vRcBewt+9GJYlvsitcUgDBkumg/rtyrw374j6o6aAxsE+uJ
         pVPkY4IyagIhFIdmEp+D9UwiMDK1iz39pF55hDXgKWFWseZKeagylqBpHyR9VrBpY3PC
         qhf0NN0DWjn6gAOoPHpZgW2EMQi7ijVjtfxAWv1m0R/U9ihNgT4HJbRiAnXuFezzbQFY
         mzjRR+nBg3lDaXgDXExQSmGQg4oxGKtgOMXxrGnbG6r1eFnK11odv/nH/qbcsTlICth3
         dovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850161; x=1779454961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4KVzd01T5sf0R9FhB15rxjDpz8yPmArKGvd/XLI4lM=;
        b=kpP/eQhEZXOzt1pLZATitpPRW1gUyt6E7N1GC2tGPvORIVPnEy3smAwpbJslgDRAx2
         DqDjFtSIkvJggyFeoIL5hLtTaVTOPHmkVUjEfmwHLKrl8pV2g9T9uL/yIpTDG0qX2PtJ
         f8GDO2vhE2DWQJAm5KrKQXMfr40Y2jvYkqknla+7hrivJjfh63TZ4BnSneljDjvqEdIS
         AtH+O0/isA2h2zq0nBGF1hWX7LEGiOhbe+dh/8k+r5/k6tSkAxKsMus61jM3Pvd66+6G
         gjqrID/WoIvvotgblTUjG0mB0NErqDSQcPP3FY2xbuxCZcaHGKAAP5bfRfvlVtv0fpqx
         v3PA==
X-Gm-Message-State: AOJu0YxAZZCa+K89OcOge2J7r0nLxIaEpHcn0r7kAzN6gllQajYACg+q
	6O4yDaMXvSv5gm0Y5prKirAH5akVEdtL//jQqhd2kYGPwViML6/W62WDSb9rWU8u
X-Gm-Gg: Acq92OERCYSDji8whbXzOQS9bIGedQCDAOjWvxvyLLtJ33wH+jQr/SPK88U0th0jODo
	Nq/WQb6OlCFU6bF0PWNXsu140bkmsbaI3ybqYIcDL7I9rRq90czCaNZ/8Q0gdxt2J0P73fQ7yMh
	4j19bTfSG+75uFK4sctu96GZzYHiKsto0CT79m47uFF4ThJnT25pc0Sieu46od3yQyxZfQcKSNd
	NyCY8vnqmV9IRzv3UmDzkYkGPFRz6VMXUxC+8gw711li38CNnwq9HaBZXXgE55bFmp0a9iaDTJa
	+g0yn8QKITgs4zi3YL9cHh7lsuw5RrK84APrvbmJeOID8E1DA5oPEdpr9IzvUej64zGlcu+Bjzv
	C/bnHLv/nIhOGkYbaVrSVJETVBYqNMprXo2i0HvtADziSbSXZV+FgqcH+ep5FtbHhh/91Q2vbq2
	22zNaBhIoyHjFgxMhSnhQEzI2roZTjPC+GGLVjmGy1lA==
X-Received: by 2002:a05:6870:31b6:b0:42c:24e7:f074 with SMTP id 586e51a60fabf-43a2defc241mr2647034fac.17.1778850160475;
        Fri, 15 May 2026 06:02:40 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:8c2e:6a8e:445a:9169])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc53f2acsm4155822fac.14.2026.05.15.06.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:02:39 -0700 (PDT)
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
Subject: [PATCH V7 00/11] Add Invensense ICM42607
Date: Fri, 15 May 2026 08:00:05 -0500
Message-ID: <20260515130018.237378-1-macroalpha82@gmail.com>
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

Chris Morgan (11):
  dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
  dt-bindings: iio: imu: icm42600: Add icm42607 binding
  iio: imu: inv_icm42607: Add inv_icm42607 Core Driver
  iio: imu: inv_icm42607: Add I2C and SPI For icm42607
  iio: imu: inv_icm42607: Add PM support for icm42607
  iio: imu: inv_icm42607: Add Buffer support for icm42607
  iio: imu: inv_icm42607: Add Temp Support in icm42607
  iio: imu: inv_icm42607: Add Accelerometer for icm42607
  iio: imu: inv_icm42607: Add Wake on Movement to icm42607
  iio: imu: inv_icm42607: Add Gyroscope to icm42607
  arm64: dts: rockchip: Add icm42607p IMU for RG-DS

 .../bindings/iio/imu/invensense,icm42600.yaml |   4 +
 .../dts/rockchip/rk3568-anbernic-rg-ds.dts    |  20 +-
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/inv_icm42607/Kconfig          |  30 +
 drivers/iio/imu/inv_icm42607/Makefile         |  14 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 457 +++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 890 ++++++++++++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.c    | 565 +++++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.h    |  95 ++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 863 +++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 545 +++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  90 ++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 103 ++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |  80 ++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |  33 +
 16 files changed, 3790 insertions(+), 1 deletion(-)
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

