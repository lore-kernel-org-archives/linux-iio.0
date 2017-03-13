Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37007
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752053AbdCMT7l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 15:59:41 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-iio@vger.kernel.org,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yong Li <sdliyong@gmail.com>, Marek Vasut <marex@denx.de>,
        Peter Rosin <peda@axentia.se>,
        Marc Titinger <mtitinger@baylibre.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Giorgio Dal Molin <giorgio.nicole@arcor.de>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Constantin Musca <constantin.musca@intel.com>,
        Tomas Novotny <tomas@novotny.cz>,
        Wolfram Sang <wsa@the-dreams.de>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Martin Klepplinger <martink@posteo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Slawomir Stepien <sst@poczta.fm>,
        Irina Tirdea <irina.tirdea@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Amitoj Kaur Chawla <amitoj1606@gmail.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Crt Mori <cmo@melexis.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 00/17] iio: Add OF device table to I2C drivers that are missing it
Date: Mon, 13 Mar 2017 16:59:00 -0300
Message-Id: <20170313195917.12190-1-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This series add OF device ID tables to IIO I2C drivers whose devices are
either used in Device Tree source files or are listed in binding docs as
a compatible string.

That's done because the plan is to change the I2C core to report proper OF
modaliases instead of always reporting a MODALIAS=i2c:<foo> regardless if
a device was registered via DT or using the legacy platform data mechanism.

So these patches will make sure that IIO I2C drivers modules will continue
to be autoloaded once the I2C core is changed to report proper OF modalias.

Best regards,
Javier


Javier Martinez Canillas (17):
  iio: adc: ina2xx: Add OF device ID table
  iio: mlx96014: Add OF device ID table
  iio: magnetometer: bmc150_magn_i2c: Add OF device ID table
  iio: dac: mcp4725: Add OF device ID table
  iio: light: us5182d: Add OF device ID table
  iio: light: tsl2563: Add OF device ID table
  iio: pressure: hp03: Add OF device ID table
  iio: imu: inv_mpu6050: Add OF device ID table
  iio: accel: bma180: Add OF device ID table
  iio: light: apds9960: Add OF device ID table
  iio: dac: max5821: Set .of_match_table to OF device ID table
  iio: adc: ti-ads1015: Add OF device ID table
  iio: magnetometer: mag3110: Add OF device ID table
  iio: accel: mma7455_i2c: Add OF device ID table
  iio: pressure: mpl3115: Add OF device ID table
  iio: accel: mma7660: Add OF device ID table
  iio: gyro: itg3200: Add OF device ID table

 drivers/iio/accel/bma180.c                 | 24 +++++++++++++++++++--
 drivers/iio/accel/mma7455_i2c.c            |  8 +++++++
 drivers/iio/accel/mma7660.c                |  7 ++++++
 drivers/iio/adc/ina2xx-adc.c               | 34 +++++++++++++++++++++++++++++-
 drivers/iio/adc/ti-ads1015.c               | 24 +++++++++++++++++++--
 drivers/iio/dac/max5821.c                  |  1 +
 drivers/iio/dac/mcp4725.c                  | 24 +++++++++++++++++++--
 drivers/iio/gyro/itg3200_core.c            |  7 ++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 28 +++++++++++++++++++++++-
 drivers/iio/light/apds9960.c               |  7 ++++++
 drivers/iio/light/tsl2563.c                | 10 +++++++++
 drivers/iio/light/us5182d.c                |  7 ++++++
 drivers/iio/magnetometer/bmc150_magn_i2c.c |  9 ++++++++
 drivers/iio/magnetometer/mag3110.c         |  7 ++++++
 drivers/iio/pressure/hp03.c                |  7 ++++++
 drivers/iio/pressure/mpl3115.c             |  7 ++++++
 drivers/iio/temperature/mlx90614.c         |  7 ++++++
 17 files changed, 210 insertions(+), 8 deletions(-)

-- 
2.9.3

