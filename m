Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2539BFF1
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624344; cv=none; b=SRjKyF+CT3xSUkfFf3TqXsfzEjWSHXqv8YZSJ6RRlHNX7HXBNN+Nb0kQ+XUUz9Cld3wP1RulslBd2PY6BbDPO8rU+/E6+xNswXTPxbqpyWTgK9GDmytHICWgYtIS96LuPFtNFRmsQvTb0arJe00XzBWoSGO5XYSZDGNf1pFhF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624344; c=relaxed/simple;
	bh=rs16wt3AuyZwC2/wSTnW6JyrGVk0XNOqxAOEv9iUOkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCw7tKQtZeSSmniqjEXYg1wSAD50Rrb4ELKyo/mjdLfntr1Mjn+Qj6pLOYClt3SeEf1xWs8//ITymE3k+6OdrYHzkpHAPMYCMPM70fy2rJJeCrCj/knKWzF1ZvODBFOFSqvqBU/y4ePu7djYBilqJkJcUhOR3gKrCSkPD3uqjdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjXigAla; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjXigAla"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479f7e75a6bso2483105b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778624342; x=1779229142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbOAkAosV36OhwkLLEx/+s1EaAlqex9RxH+DuxyH/Ng=;
        b=pjXigAla+L31u9DWuYSWuT522BTb4qij5+J4HENyFHWTHNcMUu6o9BPFztqxi/R+AL
         XBZheeozLEfKxc3ZtsqUjokJpGJWxUseVURMO0KC7Q6PPS9Jqcbk6hyh5uEqQLh+/9Gh
         l4UAMUDv7dFdHg4qUxZidbte/f9VMDIeq1e4WGfvtSCIM43BUdwKGtd09v/uyx9Ho4/I
         j0htZnqFM+ldEGwPxafV/Z4NgF48jZ0IiWRBg8tAxnwpmK/hmj9i4R+ziRqOStRRqiGQ
         fosIFK1dxqKVfY+zM9ViJbdvsqvZJI0yI2QupivlksPm6bZbdy027ToiLWsdyleAkDCg
         X3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624342; x=1779229142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbOAkAosV36OhwkLLEx/+s1EaAlqex9RxH+DuxyH/Ng=;
        b=gwngx5caWJd3mNMJsS/dW6iHkOrLMV724JQhJUxzTn+Qvp3anCVlhZsnjIY+GhrU4v
         NtfRRFVp9y1pR39eFOs4yg+K94ZB7lPbOFKkilstUfc3QoLveOeUUnyup66X1W5mRsPf
         vFQOhREp7qOkdGdhPF5gvyrHzSTe4hcBPrH8aZGhdg/PqVdukIh0iqRTgnrGJPge5ikr
         t0ZlBIPBIJiXfPd3wjrUFwDE04wUAeq++inFO1Cg3dtf4pU9liEBtUA7tHZ3trvgtgXF
         sIcw0IP5eJ2Zg/EReaOYhYqTUXrRdVVihz7N6yojijkXEDb1uujjKaVEWULg7IlDKgv5
         F2Dg==
X-Gm-Message-State: AOJu0YxT7nhgfBCa/iyDz6u1UleSp68SMWB1eZDAdrHxJt1C35l7zkuF
	5cmhp+iQDRXyNssoUbBgubRDgnBpRqyP2oUlVdHzC7SbST8aUGj0Z6UBNvJ8H7aJ
X-Gm-Gg: Acq92OFFWqIfE70owaraexnYWuy0h9MU5D0GPpNn/08Cln1ZlADMutn+P1KvwyIjx3+
	T6sNSy4VliLTEikiX2gJXDRTAjaIWKFlpG3vA+Pi5aqgvKiXDzFq1TZFCR/lrU2oGvmH5N1h0dg
	r1GJEAS2gVOVcbmhN/SFCf3DM5WwBO/6lPV5XGY8A8w+cqaEngO3QOBCYIKSVWHPHFL44yIfDJr
	6HWVJDQLVkijLfHX1v9qZbc7BsEolv3bkjUnb7wxqtgQenc7i3ElG9+qYL2UtLQg2oCKP/h6Jz5
	k38VVhzn54VQ99mc6ehQ44zgaurWWwsICpywtYDnmqIc90EAUw3WN1E5eC6mLLad1cQbdFV8jBl
	QHvj+cUtu0mLt6EHyc7kEfmlh63pA9Sy+floM7LrIXX/0Jq7AHuS9dldMfelchXlYv0XW9Ui1y1
	IgJfnaEB35Dopz17l8Di48
X-Received: by 2002:a05:6808:4f29:b0:466:fd51:6a65 with SMTP id 5614622812f47-482b2d05a43mr651761b6e.23.1778624341793;
        Tue, 12 May 2026 15:19:01 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986f87sm23291473b6e.13.2026.05.12.15.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:19:01 -0700 (PDT)
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
Subject: [PATCH V6 00/11] Add Invensense ICM42607
Date: Tue, 12 May 2026 17:16:21 -0500
Message-ID: <20260512221634.256747-1-macroalpha82@gmail.com>
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

Chris Morgan (11):
  dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
  dt-bindings: iio: imu: icm42600: Add icm42607 binding
  iio: imu: inv_icm42607: Add inv_icm42607 Core Driver
  iio: imu: inv_icm42607: Add I2C and SPI For icm42607
  iio: imu: inv_icm42607: Add PM support for icm42607
  iio: imu: inv_icm42607: Add Buffer support for icm42607
  iio: imu: inv_icm42607: Add Temp Support in icm42607
  iio: imu: inv_icm42607: Add Accelerometer for icm42607
  iio: imu: inv_icm42607: Add Wake on Movement to  icm42607
  iio: imu: inv_icm42607: Add Gyroscope to icm42607
  arm64: dts: rockchip: Add icm42607p IMU for RG-DS

 .../bindings/iio/imu/invensense,icm42600.yaml |   4 +
 .../dts/rockchip/rk3568-anbernic-rg-ds.dts    |  20 +-
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/inv_icm42607/Kconfig          |  30 +
 drivers/iio/imu/inv_icm42607/Makefile         |  14 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 457 +++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 879 ++++++++++++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.c    | 565 +++++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.h    |  95 ++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 854 +++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_gyro.c  | 510 ++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  90 ++
 .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 103 ++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  |  80 ++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  |  33 +
 16 files changed, 3735 insertions(+), 1 deletion(-)
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

