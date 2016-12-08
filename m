Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.megiteam.pl ([31.186.83.105]:56528 "EHLO smtp.megiteam.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932298AbcLHPA4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Dec 2016 10:00:56 -0500
From: Marcin Niestroj <m.niestroj@grinn-global.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH v2 0/6] iio: bmi160: cleanups and hardware fifo support
Date: Thu,  8 Dec 2016 15:22:53 +0100
Message-Id: <20161208142259.26230-1-m.niestroj@grinn-global.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This patch series consists of cleanups, of device tables, device-tree
bindings documentation and finally support for hardware FIFO.

Patches have been rebased and tested on 4.9.0-rc8.

Changes v1 -> v2:
 * add of device tables for spi and i2c (suggested by Jonathan)
 * device-tree bindings documentation: remove "gpio" keyword from
   interrupts property description, describe "INT1" and "INT2" cases
   for interrupt-names property (suggested by Rob)
 * introduce mutex protection of data transmission as a separate patch
   (suggested by Peter)
 * fix time needed to sleep after command execution
 * add __ prefix to all functions that should be called with mutex held
   (suggested by Peter)
 * get rid of non-constant array size (suggested by Peter)
 * disable irq on init failure and module removal (suggested by Peter)
 * make bmi160_buffer_predisable() the reverse order of the
   bmi160_buffer_postenable() (suggested by Jonathan)
 * remove realignment for iio_info structs (suggested by Jonathan)

Marcin Niestroj (6):
  iio: bmi160: Add of device table for i2c
  iio: bmi160: Add of device table for spi
  Documentation: DT: Add bmi160 imu binding
  iio: bmi160: Protect data transmission with mutex
  iio: bmi160: Fix time needed to sleep after command execution
  iio: bmi160: Support hardware fifo

 .../devicetree/bindings/iio/imu/bmi160.txt         |  36 ++
 drivers/iio/imu/bmi160/bmi160.h                    |   3 +-
 drivers/iio/imu/bmi160/bmi160_core.c               | 678 +++++++++++++++++++--
 drivers/iio/imu/bmi160/bmi160_i2c.c                |  21 +-
 drivers/iio/imu/bmi160/bmi160_spi.c                |  21 +-
 5 files changed, 711 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt

-- 
2.10.2

