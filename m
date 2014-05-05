Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37171 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932134AbaEEMjG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 May 2014 08:39:06 -0400
Message-ID: <536786C8.5070207@kernel.org>
Date: Mon, 05 May 2014 13:40:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, features and cleanups for 3.16 - set 2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 37aa48368f2508defb1976be62e1ed6ca4dde683:

   Merge 3.15-rc3 into staging-next (2014-04-27 21:38:34 -0700)

are available in the git repository at:


   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.16b

for you to fetch changes up to cd5b700f998d9e1d8e6dbc62aeb0351bb2216e22:

   iio: hid-sensors: Pressure: Raw read support (2014-05-05 10:59:53 +0100)

----------------------------------------------------------------
Second set of IIO new drivers, cleanups and functionality for the 3.16 cycle.

This set contains a change to the ABI for the hid-sensors drivers to bring them
in line with the long published documentation.  Unfortunately, rather than
reporting true scale and offset values via sysfs they were reporting
some magic numbers that could only be converted to anything useful using
the HID sensors specification. I missed this entirely through the introduction
of a number of drivers, only picking up on it recently.  Srinivas has had
user feedback about this as well. The patch set is too large to go as a fix
at this stage in the cycle and is not a regression fix as this was never
right and so will have to wait for the next merge window. Srinivas assures
me that there are relatively few pieces of hardware out there and he has
had a number of people contact him to point out that the drivers did not
obey the ABI.  Hence hopefully the fallout of this, if any will be minor.
If we don't fix it now, it will only get worse going forward. There is no
sensible way of maintaining the incorrect ABI as it is simply returning
the wrong values through the standard interfaces.

Non IIO elements
* Introduce devm_kmemdup.  Does what it says on the tin.

New drivers:
* hid-sensors rotation devices (output as quaternion)
* Freescale MPL115A2 presure and temperature sensor.
* Melexis mlx90614 contactless infrared sensor.
* Freescale MMA8452Q 3-axis accelerometer.

New functionality:
* Addition of multiple element callback to allow for sysfs interfaces to access
   elements such as quaternions which have no useful meaning if all 4 elements
   are not presented together.  Other future usecases for this include
   rotation matrices.
* Support for multiple element buffer entries for exactly the same uses as
   the sysfs related elements described above.
* Quaternion support via the quaternion IIO modifier.
* TEMP_AMBIENT and TEMP_OBJECT modifiers to distinguish cases with thermopile
   devices.
* hid-sensors gain sysfs access to the sensor readings. Previously these
   drivers used the buffered interface only.  This change involves some
   additional hid-sensors core support to read poll values back from the devices
   to allow the drivers to know roughly how long to wait for a result when
   polling the sensor.  There is also an associated hid-sensors abi to allow
   the devices to be turned off between reads and powered up on demand.

Cleanups and fixes
* Hid sensors fix as described above. Result is to make the _scale and _offset
   attributes applicable in the same way as for all other IIO drivers.
* Some additional documentation - mostly covering stuff that graduated from
   staging without managing to take it's ABI docs with it.
* A series of little tidy ups to the exynos_adc driver that make the code
   nicer to read and improve handling of some corner cases.
* A tidy up to mag3110 (logical fix rather than a real one ;). Also enable
   user offset calibration for this device.
* Drop some left over IS_ERR() checks from ad799x that snuck through during
   the cleanup in the last IIO patch set.
* Fix a naming issue from clashing patches in ak8975 - note the clash only
   occured in the last IIO patch set, hence the fix needs to go through this
   tree.
* A format string missmatch fix in ad7280.c. Unlikely to have ever had an
   impact so not worth rushing through.

----------------------------------------------------------------
Dan Carpenter (1):
       staging: iio: ad799x: remove some unneeded IS_ERR() checks

Masanari Iida (1):
       staging: iio: Fix format string mismatch in ad7280a.c

Naveen Krishna Ch (1):
       iio: exynos_adc: rearrange clk and regulator enable/disable calls

Naveen Krishna Chatradhi (3):
       iio: exynos_adc: reduce timeout and use wait_for_completion_timeout
       iio: exynos_adc: do a soft reset in case of timeout
       iio: exynos_adc: do a reinit_completion before the conversion

Peter Meerwald (10):
       iio:magnetometer:mag3110: Fix initialization of ctrl_reg1
       iio:magnetometer:mag3110: Enable user offset calibration
       iio: Add Freescale MPL115A2 pressure / temperature sensor driver
       iio: Add TEMP_AMBIENT and TEMP_OBJECT channel modifiers
       iio: Add ABI documentation for object and ambient modifiers
       iio: Add Melexis mlx90614 contact-less infrared temperature sensor driver
       iio: Add intensity including ir and both modifiers to ABI documentation ex-post
       iio: Add ABI documentation for illuminance
       iio: Fix spelling of illuminance in gp2ap020a00f driver
       iio: Add Freescale MMA8452Q 3-axis accelerometer driver

Srinivas Pandruvada (23):
       devres: introduce API "devm_kmemdup
       IIO: core: Introduce read_raw_multi
       IIO: core: Modify scan element type
       IIO: core: Add quaternion modifier
       iio: hid-sensors: Added device rotation support
       iio: Added ABI description for quaternion
       iio: ak8975: Fix issue with the name
       iio: hid-sensors: Convert units and exponent
       iio: hid-sensors: Add api to get poll value
       iio: hid-sensors: Accelerometer 3D: adjust scale and offset
       iio: hid-sensors: Gyro 3D : adjust scale and offset
       iio: hid-sensors: ALS: adjust scale and offset
       iio: hid-sensors: Compass 3D: adjust scale and offset
       iio: hid-sensors: Inclinometer 3D: adjust scale and offset
       iio: hid-sensors: Pressure: adjust scale and offset
       iio: hid-sensors: Add API to power on/off
       iio: hid-sensors: Accelerometer 3D: Raw read support
       iio: hid-sensors: Gyro 3D: Raw read support
       iio: hid-sensors: ALS: Raw read support
       iio: hid-sensors: Proximity: Raw read support
       iio: hid-sensors: Compass 3D: Raw read support
       iio: hid-sensors: Inclinometer 3D: Raw read support
       iio: hid-sensors: Pressure: Raw read support

  Documentation/ABI/testing/sysfs-bus-iio            |  38 +-
  Documentation/driver-model/devres.txt              |   1 +
  drivers/base/devres.c                              |  21 +
  drivers/iio/accel/Kconfig                          |  12 +
  drivers/iio/accel/Makefile                         |   1 +
  drivers/iio/accel/hid-sensor-accel-3d.c            |  45 ++-
  drivers/iio/accel/mma8452.c                        | 439 +++++++++++++++++++++
  drivers/iio/adc/ad799x.c                           |  15 +-
  drivers/iio/adc/exynos_adc.c                       | 131 +++---
  .../iio/common/hid-sensors/hid-sensor-attributes.c | 134 +++++++
  .../iio/common/hid-sensors/hid-sensor-trigger.c    |  17 +-
  .../iio/common/hid-sensors/hid-sensor-trigger.h    |   1 +
  drivers/iio/gyro/hid-sensor-gyro-3d.c              |  45 ++-
  drivers/iio/iio_core.h                             |   2 +-
  drivers/iio/industrialio-buffer.c                  |  41 +-
  drivers/iio/industrialio-core.c                    |  68 ++--
  drivers/iio/industrialio-event.c                   |   6 +-
  drivers/iio/inkern.c                               |  16 +-
  drivers/iio/light/gp2ap020a00f.c                   |   8 +-
  drivers/iio/light/hid-sensor-als.c                 |  48 ++-
  drivers/iio/light/hid-sensor-prox.c                |  25 +-
  drivers/iio/magnetometer/ak8975.c                  |   1 -
  drivers/iio/magnetometer/hid-sensor-magn-3d.c      |  40 +-
  drivers/iio/magnetometer/mag3110.c                 |  19 +-
  drivers/iio/orientation/Kconfig                    |  12 +
  drivers/iio/orientation/Makefile                   |   1 +
  drivers/iio/orientation/hid-sensor-incl-3d.c       |  37 +-
  drivers/iio/orientation/hid-sensor-rotation.c      | 346 ++++++++++++++++
  drivers/iio/pressure/Kconfig                       |  10 +
  drivers/iio/pressure/Makefile                      |   1 +
  drivers/iio/pressure/hid-sensor-press.c            |  41 +-
  drivers/iio/pressure/mpl115.c                      | 211 ++++++++++
  drivers/iio/temperature/Kconfig                    |  10 +
  drivers/iio/temperature/Makefile                   |   1 +
  drivers/iio/temperature/mlx90614.c                 | 150 +++++++
  drivers/staging/iio/adc/ad7280a.c                  |   4 +-
  include/linux/device.h                             |   2 +
  include/linux/hid-sensor-hub.h                     |   8 +-
  include/linux/hid-sensor-ids.h                     |   1 +
  include/linux/iio/iio.h                            |  24 ++
  include/linux/iio/types.h                          |   4 +
  41 files changed, 1851 insertions(+), 186 deletions(-)
  create mode 100644 drivers/iio/accel/mma8452.c
  create mode 100644 drivers/iio/orientation/hid-sensor-rotation.c
  create mode 100644 drivers/iio/pressure/mpl115.c
  create mode 100644 drivers/iio/temperature/mlx90614.c
