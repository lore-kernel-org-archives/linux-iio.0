Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36246 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbcGRUyd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2016 16:54:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so248421wma.3
        for <linux-iio@vger.kernel.org>; Mon, 18 Jul 2016 13:54:31 -0700 (PDT)
From: Jelle van der Waa <jelle@vdwaa.nl>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jelle van der Waa <jelle@vdwaa.nl>
Subject: [PATCH v2] iio: accel: add support for the Domintech DMARD09 3-axis accelerometer
Date: Mon, 18 Jul 2016 22:54:22 +0200
Message-Id: <20160718205423.13081-1-jelle@vdwaa.nl>
In-Reply-To: <20160716195152.30109-1-jelle@vdwaa.nl>
References: <20160716195152.30109-1-jelle@vdwaa.nl>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds basic read_raw support for the DMARD09 3-axis accelerometer
which can be found in a q8 A33 Allwinner tablet. [0]

The driver is based on the Android driver which can be found
on Github. [1]

Unfortunately there is no datatsheet of the DMARD09 available online.

[0] http://linux-sunxi.org/TZX-723Qa4
[1] https://github.com/JujuXIII/android_kernel_acer_v370_KK/tree/master/mediatek/custom/common/kernel/accelerometer/dmard09

Changes in v2:
  - Use ARRAY_SIZE instead of the #define DMARD09_AXES_NUM
  - Use a function-like macro to generate the channel structs
  - Remove duplicate 3-axis in driver description
  - Don't initialize the u8 buf
  - Use devm_iio_device_register and remove the now unrequired
    dmard09_remove.
  - Remove device from dmard09_data struct and use the client member to retrieve
    the device.
  - Describe the read strategy of the read_raw function
  - Simplify reading the X, Y, Z axis, by introducing DMARD09_AXIS_N_OFFSET,
        which removes the required if statements.
  - Log the _STAT address in the dev_error in the dmard09_read_raw function.


Jelle van der Waa (1):
  iio: accel: add support for the Domintech DMARD09 3-axis accelerometer

 .../devicetree/bindings/iio/accel/dmard09.txt      |  13 ++
 drivers/iio/accel/Kconfig                          |  10 ++
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/dmard09.c                        | 149 +++++++++++++++++++++
 4 files changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/dmard09.txt
 create mode 100644 drivers/iio/accel/dmard09.c

-- 
2.9.0

