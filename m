Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33607 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbcGPTwH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2016 15:52:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so6765730wme.0
        for <linux-iio@vger.kernel.org>; Sat, 16 Jul 2016 12:52:05 -0700 (PDT)
From: Jelle van der Waa <jelle@vdwaa.nl>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jelle van der Waa <jelle@vdwaa.nl>
Subject: [PATCH] Add support for the Domintech DMARD09 3-axis accelerometer 
Date: Sat, 16 Jul 2016 21:51:51 +0200
Message-Id: <20160716195152.30109-1-jelle@vdwaa.nl>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds basic read_raw support for the DMARD09 3-axis accelerometer
which can be found in a q8 A33 Allwinner tablet. [0]

The driver is based on the Android driver which can be found
on Github. [1]

Unfortunately there is no datatsheet of the DMARD09 available online.


[0] http://linux-sunxi.org/TZX-723Qa4
[1] https://github.com/JujuXIII/android_kernel_acer_v370_KK/tree/master/mediatek/custom/common/kernel/accelerometer/dmard09


Jelle van der Waa (1):
  iio: accel: add support for the Domintech DMARD09 3-axis accelerometer

 .../devicetree/bindings/iio/accel/dmard09.txt      |  13 ++
 drivers/iio/accel/Kconfig                          |  10 ++
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/dmard09.c                        | 180 +++++++++++++++++++++
 4 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/dmard09.txt
 create mode 100644 drivers/iio/accel/dmard09.c

-- 
2.9.0

