Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:57799 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab3IJMts (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:49:48 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so3892699eek.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:49:47 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 00/38] iio: ST clean-ups and new sensor support
Date: Tue, 10 Sep 2013 13:49:01 +0100
Message-Id: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Sorry for the continued development and resubmission. I won't write
anymore patches now. At least until these have been accepted.

This patch-set includes a few clean-ups surrounding error handling and
non-mandatory functionality along with regulator support and the addition
of a new pressure/temperature sensor (LPS001WP) and extended support for
a new magnetometer sensor (LSM303DLH).

Everything has been tested with Device Tree.
  
v2:
 - Rebased onto Linux -next as requested by Jonathan
 - Reworked clean-up patch to address Jonathan's concerns
 - Added binding document (inc regulators)
 - Extended regulator support in the driver
 - Re-worked Data Ready pin handling

v3:
 - Standardise sensor names: <model>_<sensor-type>
 - Added error handling clean-ups
 - More binding documents; for magn, accel and gyro
 - Message on successful sensor bring-up; for press, magn, accel and gyro
 - More device enablement for ux500 by way of CONFIGs
 - New neat reorder/grouping of patches 

 Documentation/devicetree/bindings/iio/accel/lsm303dlh.txt        |  21 ++++++++
 Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt          |  21 ++++++++
 Documentation/devicetree/bindings/iio/magnetometer/lsm303dlh.txt |  21 ++++++++
 Documentation/devicetree/bindings/iio/pressure/lps001wp.txt      |  21 ++++++++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                                |   5 --
 arch/arm/boot/dts/ste-snowball.dts                               |  34 ++++++++++++
 arch/arm/configs/u8500_defconfig                                 |   5 ++
 drivers/iio/accel/st_accel.h                                     |   4 +-
 drivers/iio/accel/st_accel_core.c                                |  28 +++++-----
 drivers/iio/common/st_sensors/st_sensors_core.c                  |  79 +++++++++++++++-------------
 drivers/iio/gyro/st_gyro.h                                       |   8 +--
 drivers/iio/gyro/st_gyro_core.c                                  |  24 +++++----
 drivers/iio/magnetometer/st_magn.h                               |   3 +-
 drivers/iio/magnetometer/st_magn_core.c                          |  27 +++++-----
 drivers/iio/pressure/st_pressure.h                               |   3 +-
 drivers/iio/pressure/st_pressure_core.c                          | 303 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
 drivers/iio/pressure/st_pressure_i2c.c                           |   1 +
 include/linux/iio/common/st_sensors.h                            |   6 +++
 18 files changed, 453 insertions(+), 161 deletions(-)

