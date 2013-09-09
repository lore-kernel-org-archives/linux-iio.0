Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:63426 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab3IIKKX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2013 06:10:23 -0400
Received: by mail-ea0-f172.google.com with SMTP id r16so3031132ead.17
        for <linux-iio@vger.kernel.org>; Mon, 09 Sep 2013 03:10:22 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 00/14] iio: ST clean-ups and new pressure sensor device
Date: Mon,  9 Sep 2013 11:09:56 +0100
Message-Id: <1378721410-30937-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch-set includes a few clean-ups surrounding error handling and
non-mandatory functionality along with regulator support and the addition
of a new pressure/temperature sensor (LPS001WP). Everything has been
tested with Device Tree.

v2:
 - Rebased onto Linux -next as requested by Jonathan
 - Reworked clean-up patch to address Jonathan's concerns
 - Added binding document (inc regulators)
 - Extended regulator support in the driver
 - Re-worked Data Ready pin handling

 Documentation/devicetree/bindings/iio/pressure/lps001wp.txt |  21 ++++++++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                           |   5 --
 arch/arm/boot/dts/ste-snowball.dts                          |  10 ++++
 arch/arm/configs/u8500_defconfig                            |   4 ++
 drivers/iio/common/st_sensors/st_sensors_core.c             |  51 +++++++++++--------
 drivers/iio/pressure/st_pressure.h                          |   1 +
 drivers/iio/pressure/st_pressure_core.c                     | 300 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------
 drivers/iio/pressure/st_pressure_i2c.c                      |   1 +
 include/linux/iio/common/st_sensors.h                       |   6 +++
 9 files changed, 299 insertions(+), 100 deletions(-)

