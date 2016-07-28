Return-Path: <enric.balletbo@collabora.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Olof Johansson <olof@lixom.net>,
	Lee Jones <lee.jones@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 0/4] Add support for cros-ec-sensors
Date: Thu, 28 Jul 2016 15:49:32 +0200
Message-Id: <1469713776-5062-1-git-send-email-enric.balletbo@collabora.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

This is the third patchset to add support for the sensors behind the ChromeOS
Embedded Controller.

This version has only the patches to support common functions and 3d
contiguous sensors like Accelerometers, Gyroscope and Magnetometer that are
presented by the ChromeOS EC Sensor hub. The patches were tested on an Oak board.

The code was checked out from the ChromeOS v3.18 tree and forward ported to
mainline solving all the conflicts and build issues. I splitted the code in
single patches that have sense by themselves in order to avoid the chances
to fail.

Note that the patches depends on this [1] to apply and work.

[1] https://lkml.org/lkml/2016/7/1/188

Waiting for your reviews and feedback.

Changes since v2 (requested by Guenter Roeck and Jonhatan Cameron)
  - Rebased and fix build error.
  - Include a list of possible values in the description of location attr.
  - Fix some typos.
  - Remove id sysfs entry.
  - Skip filling by zero structure parameters that already zero'd.
  - Order includes alphabetically.
  - Propagate error codes.

Changes since v1 (requested by Peter Meerwald-Stadler and Jonhatan Cameron)
  - Check kernel-doc documentation and 
  - Bring some patches together.
  - Fix some spelling mistakes.
  - Include ABI documentation.
  - Be more careful with buffer sizes (sprintf -> snprintf)
  - Add cros_ec_sensors prefix to all function.
  - Check return values on some functions.

Best regards,

Enric Balletbo i Serra (3):
  iio: cros_ec_sensors_core: Add common functions for the ChromeOS EC
    Sensor Hub.
  iio: cros_ec_sensors: add ChromeOS EC Contiguous Sensors driver
  platform/chrome: cros_ec_dev - Register cros-ec sensors

Vincent Palatin (1):
  platform/chrome: Introduce a new function to check EC features.

 Documentation/ABI/testing/sysfs-bus-iio-cros-ec    |  18 +
 drivers/iio/common/Kconfig                         |   1 +
 drivers/iio/common/Makefile                        |   1 +
 drivers/iio/common/cros_ec_sensors/Kconfig         |  22 +
 drivers/iio/common/cros_ec_sensors/Makefile        |   6 +
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   | 322 ++++++++++++++
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 491 +++++++++++++++++++++
 .../common/cros_ec_sensors/cros_ec_sensors_core.h  | 177 ++++++++
 drivers/platform/chrome/cros_ec_dev.c              | 159 +++++++
 include/linux/mfd/cros_ec.h                        |  10 +
 include/linux/mfd/cros_ec_commands.h               | 183 +++++++-
 11 files changed, 1385 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-cros-ec
 create mode 100644 drivers/iio/common/cros_ec_sensors/Kconfig
 create mode 100644 drivers/iio/common/cros_ec_sensors/Makefile
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h

-- 
2.1.0
