Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41226 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbbEGJp3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2015 05:45:29 -0400
Message-ID: <554B3435.8010300@kernel.org>
Date: Thu, 07 May 2015 10:45:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers etc for the 4.2 cycle round 1
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c610f7f772aa06ae2bd8e5ace87cde4d90f70198:

  Merge 4.0-rc7 into staging-next (2015-04-07 11:03:02 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-v4.2a

for you to fetch changes up to 1038a6872802bb4a07f627162ff989bf49e2e5cc:

  iio: magnetometer: support for lsm303dlh (2015-05-07 10:42:34 +0100)

----------------------------------------------------------------
First round of new drivers, functionality and cleanups for the 4.2 cycle

New drivers / device support
* st sensors driver, lsm303dlh magnetometer support.
* ltr501 - support ltr301 and ltr559 chips.

New functionality
* IIO_CHAN_INFO_CALIBEMISSIVITY for thermopile sensors.
* kxcjk1013 - make driver operational with external trigger.
* Add iio targets to the tools Makefile.

Cleanups
* st sensors - more helpful error message if device id wrong or irq request
  fails, explicitly make the Block Data Update optional rather
  than relying on writes to address 0 not doing anything, make interrupt
  support optional (Not always wired, and not all devices actually have
  an interrupt line.)
* kxcjk-1013 white space additions for readability, add the KXCJ9000 ACPI
  id as seen in the wild.
* sx9500 - GPIO reset support, refactor the GPIO interrupt code, add power
  management, optimize power usage by powering down when possible, rename
  the gpio interrupt pin to be more useful, trivial return path simplification,
  trivial formatting fixes.
* isl29018 -  move towards ABI compliance with a view to moving this driver
  out of staging, add some brackets to ensure code works as expected.  Note
  there is no actual bug as the condition being tested is always true
  (with current devices).
* ltr501 - add regmap support to get caching etc for later patches,
  fix a parameter sanity check that always fails (bug introduced
  earlier in this series), ACPI enumeration support,
  interrupt rate control support, interrupt support in general and
  integration time control support, code alignment cleanups.
* mma9553 - a number of little cleanups following a review from Hartmut
  after I'd already applied the original driver patch.
* tmp006 - prefix some defines with TMP006 for consistency.
* tsl4531 - cleanup some wrong prefixes, presumably from copy and paste.
* mlx90614 - check for errors in read values, add power management,
  add emissivity setting, add device tree binding documentation,
  fix a duplicate const warning.
* ti_am335x_adc - refactor the DT parsing into a separate function.

----------------------------------------------------------------
Antonio Ospite (2):
      iio: accel: kxcjk-1013: add the "KXCJ9000" ACPI id
      iio: accel: kxcjk-1013: add some blank lines for readability

Daniel Baluta (3):
      iio: light: ltr501: Fix alignment to match open parenthesis
      iio: ltr501: Add support for ltr559 chip
      iio: ltr501: Add support for ltr301 chip

Irina Tirdea (9):
      iio: accel: mma9551_core: wrong doc fixes
      iio: accel: mma9551_core: typo fix in RSC APP ID
      iio: accel: mma9553: check for error in reading initial activity and stepcnt
      iio: accel: mma9553: return 0 as indication of success
      iio: accel: mma9553: comment and error message fixes
      iio: accel: mma9553: use GENMASK
      iio: accel: mma9553: prefix naming fixes
      iio: accel: mma9553: refactor mma9553_read_raw
      iio: accel: mma9553: fix gpio bitnum init value

Jonathan Cameron (3):
      iio:light:ltr501 bug in parameter sanity check.
      staging:iio:light: Add some missing brackets to make sure code works as intended.
      iio:prox:sx9500 trivial simplification of return path in init function.

Kuppuswamy Sathyanarayanan (5):
      iio: ltr501: Add regmap support.
      iio: ltr501: Add integration time support
      iio: ltr501: Add interrupt support
      iio: ltr501: Add interrupt rate control support
      iio: ltr501: Add ACPI enumeration support

Linus Walleij (5):
      iio: st_sensors: print error when failing to get IRQ
      iio: st_sensors: make interrupt optional
      iio: st_sensors: make BDU optional
      iio: st_sensors: make detection more helpful
      iio: magnetometer: support for lsm303dlh

Peter Meerwald (3):
      iio:tsl4531: Fix leftover TCS3472_ prefix in tsl4531 driver
      iio:tsl2563: Use tsl2563_ prefix for driver's functions
      iio:tmp006: Prefix #defines with TMP006_

Roberta Dobrescu (4):
      tools: iio: Add iio targets in tools Makefile
      staging: iio: light: isl29018: Remove non-standard sysfs attributes
      staging: iio: light: isl29018: Rename lux_scale to calibscale
      staging: iio: light: isl29018: Use standard sysfs attributes for scale and integration time

Vianney le Clément de Saint-Marcq (6):
      iio: core: Introduce IIO_CHAN_INFO_CALIBEMISSIVITY
      iio: mlx90614: Add devicetree bindings documentation
      iio: mlx90614: Add emissivity setting
      iio: mlx90614: Add power management
      iio: mlx90614: Check for errors in read values
      iio: mlx90614: Fix duplicate const warning

Vignesh R (1):
      iio: adc: ti_am335x_adc: refactor DT parsing into a function

Vlad Dogaru (7):
      iio: accel: kxcjk1013: allow using an external trigger
      iio: sx9500: add power management
      iio: sx9500: rename GPIO interrupt pin
      iio: sx9500: fix formatting
      iio: sx9500: optimize power usage
      iio: sx9500: refactor GPIO interrupt code
      iio: sx9500: add GPIO reset pin

 Documentation/ABI/testing/sysfs-bus-iio            |   11 +
 .../devicetree/bindings/iio/st-sensors.txt         |    1 +
 .../bindings/iio/temperature/mlx90614.txt          |   24 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/iio/accel/kxcjk-1013.c                     |   42 +-
 drivers/iio/accel/mma9551_core.c                   |    8 +-
 drivers/iio/accel/mma9551_core.h                   |    2 +-
 drivers/iio/accel/mma9553.c                        |  148 +--
 drivers/iio/adc/ti_am335x_adc.c                    |   29 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |   23 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |    4 +-
 drivers/iio/industrialio-core.c                    |    1 +
 drivers/iio/light/Kconfig                          |    3 +-
 drivers/iio/light/ltr501.c                         | 1233 ++++++++++++++++++--
 drivers/iio/light/tsl2563.c                        |   36 +-
 drivers/iio/light/tsl4531.c                        |   10 +-
 drivers/iio/magnetometer/st_magn.h                 |    1 +
 drivers/iio/magnetometer/st_magn_core.c            |  116 ++
 drivers/iio/magnetometer/st_magn_i2c.c             |    5 +
 drivers/iio/proximity/sx9500.c                     |  457 ++++++--
 drivers/iio/temperature/mlx90614.c                 |  355 +++++-
 drivers/iio/temperature/tmp006.c                   |    6 +-
 drivers/staging/iio/light/isl29018.c               |  297 ++---
 include/linux/iio/iio.h                            |    1 +
 tools/Makefile                                     |    7 +-
 25 files changed, 2373 insertions(+), 448 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
