Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11246346A0D
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 03:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780111218; cv=none; b=m1Sw7kBjVOLEtIVkLmFqh/dHK9ZfoRyiSd3URr/obLrd7+bfmxzdl7/3SpIl2paCOfOl4ACGEj/m3XRzVAczeE62c4f7B0KSKOOoIRG7pcJU4oYmyrCaeiesP2eRYiWg1XULSXXDvNPVSGrA/82d2XR3M0ooq4yhpz1pchz3GYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780111218; c=relaxed/simple;
	bh=3a6HpY3mKCiozL+NetYa0YjE2lfJxogGFOuxk6859QM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2h0p4MsqtAXzrEDbocs2BsjYYWfqy/KeVlsiMgzALG6rzaFbKnhiWNwhTDpCNUhjtcdQuKeh1MoNsqBa3hJtxm8B9oGTAbHpjG+oi/c+HVhmYQ6OZkTT0vj3xcisR3C5ZslOsBWqKdvHeGIgRu0ECv5uDMSl+PE/ychAvsyYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qvpz+VO7; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvpz+VO7"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6969c864c89so8039542eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 20:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780111215; x=1780716015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tUr91O3haAau1lya5SbGJW5FOuVPHJMzYdG+hkCJ83I=;
        b=Qvpz+VO73eCoksR0EMRdSNqpIdbLjht3IYSL+idRA5SxOJZ4DpemgPOq33aa/JMUD9
         IY8KdvANHeRkRdnWsb+sZ0+tf5oxBFeTv79Rm1tIXRaHus8aj2bBDIKEAhnVEfZDHw/q
         pUJ6TfDNhwS1g0RoQY82Zt6VYH/GcQzy4UfUjj2iCRjsuY820pMmE8GKjl3/gEPv6CK8
         MKYcw0hf3skzPv/l0AOWLDe8NXF6oR1NgHgOn2nnUvxVyhKqc0/+SwXCGgvp99vDJY+S
         TYRdv50PyKKiypDNpbGMjdYWxitIMjTsY9jR5lKDRZcC7HqjBkun45y3TkRMeeJS5m7J
         VZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780111215; x=1780716015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUr91O3haAau1lya5SbGJW5FOuVPHJMzYdG+hkCJ83I=;
        b=scbe6N5A2SY9hiQWMA7HG2bY/Oi1+PDUm1SPqTeDtHjdGdPHsVfQn3+IgJRkOt6Dv2
         C/s5WhSDUgp+iXWHyEok09+Ez2WPs+QS5gRCiJ3DbaMfcZMAy+gt/WPvFus8mffImgwY
         ZmGYv9adnnpB7NE2iu9TQKYm2s75TeA97SNgELbBirKL2oevf7lcoPmFvo1T5qJXy+QU
         CR+7W04mMG5UjRbxLhSkQ9OUcBy51vwVN7xGQxri+wcl4KB3/a8xxjR/BcE3Gi8PSKgb
         RdfMbqTrJ9d1EvNZVfDhg6zNmkpzki0uuOrTODR2tI1x+k4kEWjwsVjqeH5LfFmgeuL+
         lV9Q==
X-Gm-Message-State: AOJu0YwoyV5MXsuuwCNPNjOIVb2DK9DQp7nuSvqvIOyohaHFpQcRgkLQ
	hCYO/u8JP6qb+94+KySBvVU3Skm14a9jNOXti4XciAhro0GYUp/D5Xvdi2axCv4E
X-Gm-Gg: Acq92OFCsoWL02Jvl7jCXwEdBMK1Hv3DQ9R9K31bvHsd4ya4fYec0WjjQOsuFTm8UK2
	z7K2u1UE8oKn/mJGK9JNNPozcmsqQHELW+f+Q33AUhcsydDGgI5MPmk3GRJrjNONDB7y468hyeU
	iSJQuv3lfgdGp/0Sd0cHq04pBNe4OyH8jfjPhZcfGGSzVkdZjto05m+ViFDY9ChM3mDZaijzvH5
	gOhvmCkzXbCosXaF1ITV0KmWxqQEWgqaRxtTX9UvbHv6hwxP4UJr1j310zz/Hg8pgiBZnvj3giK
	onJJ7JIO2EbhSbJfvpF+6JzKW2EUqhK6JkGX7REZnccckI3lo43otPOyscQhey2bVqpUxBDUBzN
	Uo73KZbu1OYRV08NeYn9XMGQbkaAs6aquHf31K3kuH72xLrftcQOUKAc6+t8CsCB4Ku32EOtRL0
	5mq/2xtyqGQw3bBPeBNajdkXgFBWYQsQgIZZAnCWvvZg==
X-Received: by 2002:a05:6820:f01:b0:69d:7777:75a0 with SMTP id 006d021491bc7-69e10308647mr1117894eaf.24.1780111214885;
        Fri, 29 May 2026 20:20:14 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e067e911csm2130737eaf.5.2026.05.29.20.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 20:20:14 -0700 (PDT)
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
Subject: [PATCH V9 00/11] Add Invensense ICM42607
Date: Fri, 29 May 2026 22:17:27 -0500
Message-ID: <20260530031739.109063-1-macroalpha82@gmail.com>
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

Chris Morgan (11):
  dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
  dt-bindings: iio: imu: icm42600: Add icm42607 binding
  iio: imu: inv_icm42607: Add inv_icm42607 Core Driver
  iio: imu: inv_icm42607: Add I2C and SPI For icm42607
  iio: imu: inv_icm42607: Add PM support for icm42607
  iio: imu: inv_icm42607: Add Buffer support for icm42607
  iio: imu: inv_icm42607: Add Temp Support in icm42607
  iio: imu: inv_icm42607: Add Accelerometer for icm42607
  iio: imu: inv_icm42607: Add IRQ for icm42607
  iio: imu: inv_icm42607: Add Gyroscope to icm42607
  arm64: dts: rockchip: Add icm42607p IMU for RG-DS

 .../bindings/iio/imu/invensense,icm42600.yaml |  14 +
 .../dts/rockchip/rk3568-anbernic-rg-ds.dts    |  20 +-
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/inv_icm42607/Kconfig          |  30 +
 drivers/iio/imu/inv_icm42607/Makefile         |  14 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 436 +++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 589 +++++++++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.c    | 574 +++++++++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.h    |  95 +++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 693 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 559 ++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  95 +++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 107 +++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |  81 ++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |  33 +
 16 files changed, 3341 insertions(+), 1 deletion(-)
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

