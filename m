Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992364302E4
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171047; cv=none; b=s6ByCotFLVfwWiGOFfjdBA2ZcRTQB67T+aJjq30Q0xFSaaZIhVQNgj3tysZhQsN/TqXjM9uybvVxZZ7eHUIrpPjFto9BLY0Yt9BuWTdkjJ6dIEfuDPzmIATK05SgGeErWpMbSmTLNXpwuJ459y0RauDHhqoL61+Ls8QNjfTdBss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171047; c=relaxed/simple;
	bh=N6Mt37MLnolvrPo+aqkWls9HKHSbzmyYjg1JYsSb0NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMW98nsHwr2Mxtun6gCGC/mWFO6ED2BaHjhlRTdRIM6aLnpFo2Mj1MOpGBMH/WfXQthHlGx7d+wY2W5KKkJri7z0765CewQA62SgirH0XpJF6BZgetksBAWpqKuJsf9jyuIwuIHXmgkYGDSW+/qAiC9wDTnzteWVt2YSmm7CVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht6J2nPQ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht6J2nPQ"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4a456e44e01so1329022b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171042; x=1785775842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HnScrm/QNzvILrm1ApAkfFM0TdWjjJ4z7eAH67qDRio=;
        b=Ht6J2nPQqK30YncOisrO/MV03qEiXD9bbsPgAq75xvAf6+8Rmg+ERT0wqW5j8MD/LO
         8wcgkLRf8QfXi5FkoyPhDB9Ssl5gF8W4mgSmMRbt6ZoUBOO9YdjEu6Hnfz46UiTTSrRw
         tBCWdiXisnefmVTIuH/kfVLGdUmCrQaT0UPPOIO14kGTrlM2cC/1N/Xy+742PglEdTBO
         +q//UScS5Sb5G8etm6eMfMgGDwW0/ljzKT0CIREuV/87IeX7jsBjPJephJHJizJbKlJm
         IQTHRN2q67MCF52scqmSULsEB/HxgqRk5fTopTNMr+LzuDJADbvIiTinuAJCrMAiKj6O
         GBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171042; x=1785775842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HnScrm/QNzvILrm1ApAkfFM0TdWjjJ4z7eAH67qDRio=;
        b=gUz6TkKxzes4aPi2uGLFBMfTUuOs9Oi9/v/SOW5j73i3DkSiiHQy01DlgfzdBjemVF
         78XIkVv4gv5HK5fPZuyb7lHraARQpFzDJaxAP/pu0hE2J2j0dpzM3TMcYTynGg3YYcKv
         St9JQNoa/ewG2ePTtxKiA1JfZFUyzvGSGixj4h9hhj06yuSvYDVozutQT2cJvrEp0Oiu
         s/qVfhDCjTatxtcbvHOh+YMpmpIL0i1wpkQHvDU4VDgbX+iaNHscf/JNRSCNd1ElmKLG
         pplqYBaMzULyvFUjwWn+fYgGYPbAPQWqc3OY2N6es7vQP7uF1ICPjHXtyXRF0fi6ifvU
         Ha4A==
X-Gm-Message-State: AOJu0YxnYv2ZdR/uCKtrHz1fQKe4CDxNwYbQ4vM/ixWW4rcwaB6jOZat
	ikiWyb6qjMft55kX05JjfCStzK6L3WTKjtKOtMnwb5LQ/0u1T7x6jzwBETumsw==
X-Gm-Gg: AR+sD12lZSS6QzsfgG2h//bmDFT+/VRV4gfw1YlW+piYMEzKuURhS3eK9C3U3qrnCSl
	CfY+2u8azKYBo7hP+RnwstS05WIj4/X9n8PNVI2FHyR0dcjtzq3F0ocqW371EdO++0vG5HI8YwZ
	I5uaDyLvhSyLjERBRplucWfmgsko7tXhTCHt6/cjS+t1RB6R+wJy8QTIOZsBwobsajzkSo+fxRV
	3rv4LtBTuXNfm46bJPgxcXHJvQ61lwEGsQ1Eb4pNMx7GRdwHUIUP3A4cTdtByQmT8ku3gKnT+a8
	5kQ5+OPpMO5SltkHwEMJmLqbpe29aUEzwRnGVXFbH5e4sk81W2rN2ucug/oGjrXGcNPPnwUM/m+
	lAqqJDZMMpHQC58d0aC+1gWlHSC+7zwMx11SawZR8k+1hYNhDKxwPbdBRb3t9enww2w5UHjbhYH
	lvpfiHuQvJ26FHUyFHOPMkka0bQWBHwKk=
X-Received: by 2002:a05:6808:23d4:b0:4ab:24df:1113 with SMTP id 5614622812f47-4ad55c27175mr65171b6e.34.1785171041724;
        Mon, 27 Jul 2026 09:50:41 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:30e7:7cd7:b59:5863])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab0c7a1912sm11395050b6e.2.2026.07.27.09.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:50:40 -0700 (PDT)
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
Subject: [PATCH V20 0/9] Add Invensense ICM42607
Date: Mon, 27 Jul 2026 11:48:04 -0500
Message-ID: <20260727164815.65190-1-macroalpha82@gmail.com>
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

Changes Since V18:
 - Changed driver remove function to call a new function dedicated to
   setting sensors to "off" instead of calling PM to shutdown sensors.
 - Corrected to add an exception so that read_raw() functions will
   still call the accel/gyro sample frequency.

Changes Since v19:
 - Removed remove routines and converted call to sensors_off to void,
   and then added a devm_add_action_or_reset() to call it on device
   teardown.

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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 421 +++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 316 +++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 661 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 313 +++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  97 +++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 107 +++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |  98 +++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |  38 +
 14 files changed, 2122 insertions(+), 2 deletions(-)
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

