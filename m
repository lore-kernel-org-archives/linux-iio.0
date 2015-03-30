Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48548 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbbC3T7a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2015 15:59:30 -0400
Message-ID: <5519AB1F.90101@kernel.org>
Date: Mon, 30 Mar 2015 20:59:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new device support, cleanups and functionality for the
 4.1 cycle set 2
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 153fe946412b5da1a8808f79d4f7f4ebfa7586b0:

  staging: fbtft: Do not use binary constants (2015-03-24 23:06:56 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.1b

for you to fetch changes up to e0631a31b9ed501415e552a783b1f1e3988c7c46:

  iio: Documentation: fix kernel version for 4.0 new ABI (2015-03-30 20:24:36 +0100)

----------------------------------------------------------------
Second set of new devices, functionality and cleanup for IIO in the 4.1 cycle.

New Functionality
* Watermark logic for buffers.  Allows for blocking reads to block until
  their requested amount is available - previously they only blocked until
  a single scan of data was available.  Also allows for polling for a
  watermark amount of data to be available.  This feature was first proposed
  some time ago to good responses, but not taken further by the original author
  Octavian has picked up the gauntlet and taken it through
  to merging (along with the hardware fifo support that follows).
* New approach to hardware fifo handling - in particular handling the
  interaction of a hardware fifo feeding into a software fifo and their
  watershed events.  We don't have every possible case well covered yet,
  but this is certainly a good, flexible starting point.  This will replace
  the previous approach used in ancient drivers (sca3000) where we just
  exposed the hardware buffer directly to userspace.  Very few pieces of
  hardware have sufficiently long buffers for that to be an adequate solution.
* bmc150_accel - hardware fifo support.
* mlx90614 - support dual IR sensor devices + some refactoring to clean up the
  code and allow some other functionality currently under review.
* L3GD20H gyroscope support added to the st_gyro driver.
* lis3lv02d accelerometer added to the st_gyro driver. Note this part is
  also supported by the older lis3 driver under misc.  A lengthy discussion
  took place and concluded that holding parts out on the basis that whole
  driver would be subsumed into this one was counter productive.  Better
  to add part support and add additional features as people need them.
  Basically there was not advantage in not merging the support.
* max517 driver gains support for MAX520 and MAX521 DACs.

Documentation
* 3.20 -> 4.0 renaming for recent docs. Whilst technically a fix, I think
  people will cope until the next merge merge window.
* An ABI typo hat -> What:  More ABIs should have hats.
* Document in_rot_offset, illuminance_raw and illuminance_scale.

Cleanups
* Fix a scale extraction bug in generic_buffer.c example.
* Constify a load of device tree related structures.

----------------------------------------------------------------
Antonio Fiol (1):
      iio: max517: Add support for MAX520 and MAX521 chips.

Darshana Padmadas (1):
      iio: Add ABI documentation for illuminance raw and scale values in light

Fabian Frederick (1):
      iio: constify of_device_id array

Haneen Mohammed (1):
      iio: Add ABI documentation for in_rot offset value

Irina Tirdea (2):
      tools: iio: generic_buffer: Fix generic scale extraction
      iio: Documentation: fix kernel version for 4.0 new ABI

Josselin Costanzi (1):
      iio: add watermark logic to iio read and poll

Linus Walleij (1):
      iio: st-sensors: add support for lis3lv02d accelerometer

Martin Kepplinger (1):
      Documentation/ABI:iio:fix typo

Octavian Purdila (2):
      iio: add support for hardware fifo
      iio: bmc150_accel: add support for hardware fifo

Robert Dolca (1):
      IIO: Add support for L3GD20H gyroscope

Vianney le Clément de Saint-Marcq (2):
      iio: mlx90614: Add symbols for accessible registers
      iio: mlx90614: Support devices with dual IR sensor

 Documentation/ABI/testing/sysfs-bus-iio            | 113 +++++-
 .../devicetree/bindings/iio/st-sensors.txt         |   1 +
 drivers/iio/accel/bmc150-accel.c                   | 408 ++++++++++++++++++++-
 drivers/iio/accel/st_accel.h                       |   1 +
 drivers/iio/accel/st_accel_core.c                  |  81 ++++
 drivers/iio/accel/st_accel_i2c.c                   |   4 +
 drivers/iio/common/ssp_sensors/ssp_dev.c           |   2 +-
 drivers/iio/dac/Kconfig                            |  11 +-
 drivers/iio/dac/max517.c                           |  45 ++-
 drivers/iio/gyro/st_gyro_core.c                    |  83 +++++
 drivers/iio/industrialio-buffer.c                  | 166 +++++++--
 drivers/iio/kfifo_buf.c                            |  11 +-
 drivers/iio/temperature/mlx90614.c                 |  93 ++++-
 drivers/staging/iio/accel/sca3000_ring.c           |   4 +-
 include/linux/iio/buffer.h                         |   8 +-
 include/linux/iio/dac/max517.h                     |   2 +-
 include/linux/iio/iio.h                            |  13 +
 tools/iio/iio_utils.c                              |  20 +-
 18 files changed, 974 insertions(+), 92 deletions(-)
