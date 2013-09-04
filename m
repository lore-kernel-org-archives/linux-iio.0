Return-Path: <lee.jones@linaro.org>
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de,
	linus.walleij@linaro.org,
	denis.ciocca@st.com,
	linux-iio@vger.kernel.org
Subject: [PATCH 00/11] iio: ST clean-ups and new pressure sensor device
Date: Wed,  4 Sep 2013 10:31:32 +0100
Message-Id: <1378287103-21765-1-git-send-email-lee.jones@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This patch-set includes a few clean-ups surrounding error handling and
non-mandatory functionality along with regulator support and the addition
of a new pressure/temperature sensor (LPS001WP). Everything has been
tested with Device Tree.

 arch/arm/boot/dts/ste-dbx5x0.dtsi               |   5 --
 arch/arm/boot/dts/ste-snowball.dts              |  10 ++++
 arch/arm/configs/u8500_defconfig                |   4 ++
 drivers/iio/common/st_sensors/st_sensors_core.c |  11 ++--
 drivers/iio/pressure/st_pressure.h              |   1 +
 drivers/iio/pressure/st_pressure_core.c         | 276 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------
 drivers/iio/pressure/st_pressure_i2c.c          |  18 +++----
 include/linux/iio/common/st_sensors.h           |   4 ++
 8 files changed, 230 insertions(+), 99 deletions(-)
