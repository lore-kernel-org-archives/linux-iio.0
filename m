Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47708 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136Ab3LVRkY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Dec 2013 12:40:24 -0500
Message-ID: <52B72407.80905@kernel.org>
Date: Sun, 22 Dec 2013 17:40:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, features and cleanups for 3.14 - set 2
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c3a09c18ed4698ff80408af7bec8ddd28608b7f5:

  vme: remove DEFINE_PCI_DEVICE_TABLE macro (2013-12-03 11:15:58 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.14b

for you to fetch changes up to 6fd92d3add999fbcc7178a07cbc6360f66a306ba:

  staging: iio: hmc5843: Remove redundant of_match_ptr helper (2013-12-22 16:02:14 +0000)

----------------------------------------------------------------
2nd round of new IIO drivers, features and cleanups for the 3.14 cycle.

New drivers

* HID inclinometer driver.

* DHT11 humidity driver.  Note that previous humidity drivers have been in
  hwmon, but no one was ever entirely happy with that, and they should find
  a more comfortable home in IIO (their original placement in hwmon was my
  fault - oops).  As this is our first humidity driver, core support is also
  added.

New features

* Two of mxs-lradc channels are internally wired to a temperature sensor,
  make this explicit in the driver by providing the relevant temperature
  channel.

* Add support for blocking IO on buffers.

* Add a data_available call back to the interface between buffer implementations
  and the core.  This is much cleaner than the old, 'stufftoread' flag.
  Implemented in the kfifo buffer.

Cleanups

* Last user of the old event configuration interface is converted and the
  old interface dropped.  Nice to be rid of this thanks to Lars-Peter's hard
  work!

* Replace all remaining instances of the IIO_ST macro with explicit filling
  of the scan_type structure within struct iio_chan_spec.  This macro was a
  bad idea, that rapidly ceased to cover all elements of the structure.
  Miss reading of the macro arguements has led to a number of bugs so lets
  just get rid of it. The final removal patch is awaiting for some fixes
  to make their way into mainline.
  In a couple of drivers, no elements of scan_type were even being used so
  in those case, it has been dropped entirely.

* Drop a couple of of_match_ptr helper uses in drivers where devicetree is
  not optional and hence the structures being protected by this always exist.

* Fix up some cases where data was read from a device in a particular
  byte order, but he code placed it into a s16 or similar.  These were
  highlighted by Sparse.

* Use the new ATTRIBUTE_GROUPS macro to drop some boiler plate in the triggers
  core code.

* ad7746 and ad7280a - stop storing buffers on the stack, giving cleaner code
  and possibly avoiding issues with i2c bus drivers that assume they can dma
  directly into the buffer.  Note that this cannot currently happen as the the
  i2c_smbus_read_i2c_block_data function has a memcpy from the buffer actually
  passed to the bus driver.  I missed this element of the commit message
  and don't think it is major enough to rebase the iio tree.

* ad5791 and ad5504 stop storing buffers on the stack for an SPI driver.
  Unlike the i2c drivers, this is a real issue for SPI drivers which can dma
  directly into the buffer supplied.

----------------------------------------------------------------
Alexandre Belloni (1):
      iio: mxs-lradc: compute temperature from channel 8 and 9

Axel Lin (1):
      iio:trigger: Convert to use ATTRIBUTE_GROUPS

Harald Geyer (2):
      iio: Add support for humidity sensors
      iio: Add new driver dht11

Jonathan Cameron (19):
      iio:accel:bma180 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:mag:mag3110 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:dac:ad5064 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:dac:ad5360 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:dac:ad5380 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:dac:ad5421 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:dac:ad5446 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:dac:ad5449 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:dac:ad5504 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:dac:ad5624r replaces IIO_ST macro with explicit entries to struct scan_type
      iio:dac:ad5686 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:dac:ad5755 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:dac:ad5764 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:dac:ad5791 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:dac:max517 drop specification of scan type as unused in this driver.
      iio:dac:mcp4725 drop specification of scan type as unused in this driver.
      iio:light:adjd_s311 replaces IIO_ST macro with explicit entries to struct scan_type
      iio:light:tcs3472 replaces IIO_ST macro with explicit entries to struct scan_type
      staging:iio:ad7606 replaces IIO_ST macro with explicit entries to struct scan_type

Lars-Peter Clausen (20):
      iio:ad5504: Mark transfer buffers as __be16
      iio:ad5504: Do not store transfer buffers on the stack
      iio:ad5421: Mark transfer buffer as __be32
      iio:ad5686: Mark transfer buffer as __be32
      iio:ad5755: Mark transfer buffer as __be32
      iio:ad5791: Mark transfer buffers as __be32
      iio:ad5791: Do not store transfer buffers on the stack
      iio:ad7266: Mark transfer buffer as __be16
      iio:vcnl4000: Mark transfer buffer as __be16
      staging:iio:ad7280a: Mark transfer buffer as __be32
      staging:iio:ad7280a: Do not store transfer buffer on the stack
      staging:iio:ad7746: Mark transfer buffer as __be32
      staging:iio:ad7746: Do not store the transfer buffer on the stack
      iio: Add data_available callback for buffers
      iio: kfifo_buf: Implement data_available() callback
      iio: Add support for blocking IO on buffers
      staging:iio:ad9832: Mark transfer buffers as __be16
      staging:iio:ad9834: Mark transfer buffers as __b16
      iio:cm36651: Convert to new event config interface
      iio: Remove support for the legacy event config interface

Sachin Kamat (2):
      iio: cm36651: Remove redundant of_match_ptr helper
      staging: iio: hmc5843: Remove redundant of_match_ptr helper

Srinivas Pandruvada (1):
      iio: hid-sensors: Added Inclinometer 3D

 Documentation/ABI/testing/sysfs-bus-iio            |  13 +
 .../devicetree/bindings/iio/humidity/dht11.txt     |  14 +
 drivers/iio/Kconfig                                |   2 +
 drivers/iio/Makefile                               |   2 +
 drivers/iio/accel/bma180.c                         |   7 +-
 drivers/iio/adc/ad7266.c                           |  21 +-
 drivers/iio/adc/max1363.c                          |   8 +-
 drivers/iio/dac/ad5064.c                           |   7 +-
 drivers/iio/dac/ad5360.c                           |   7 +-
 drivers/iio/dac/ad5380.c                           |   7 +-
 drivers/iio/dac/ad5421.c                           |  14 +-
 drivers/iio/dac/ad5446.c                           |   9 +-
 drivers/iio/dac/ad5449.c                           |   7 +-
 drivers/iio/dac/ad5504.c                           |  46 ++-
 drivers/iio/dac/ad5624r_spi.c                      |   7 +-
 drivers/iio/dac/ad5686.c                           |  11 +-
 drivers/iio/dac/ad5755.c                           |   9 +-
 drivers/iio/dac/ad5764.c                           |   7 +-
 drivers/iio/dac/ad5791.c                           |  55 +--
 drivers/iio/dac/max517.c                           |   1 -
 drivers/iio/dac/mcp4725.c                          |   1 -
 drivers/iio/humidity/Kconfig                       |  15 +
 drivers/iio/humidity/Makefile                      |   5 +
 drivers/iio/humidity/dht11.c                       | 294 ++++++++++++++
 drivers/iio/industrialio-buffer.c                  |  33 +-
 drivers/iio/industrialio-core.c                    |   1 +
 drivers/iio/industrialio-event.c                   | 154 ++------
 drivers/iio/industrialio-trigger.c                 |  12 +-
 drivers/iio/kfifo_buf.c                            |  23 +-
 drivers/iio/light/adjd_s311.c                      |   7 +-
 drivers/iio/light/apds9300.c                       |   8 +-
 drivers/iio/light/cm36651.c                        |  35 +-
 drivers/iio/light/gp2ap020a00f.c                   |   8 +-
 drivers/iio/light/tcs3472.c                        |   7 +-
 drivers/iio/light/tsl2563.c                        |   8 +-
 drivers/iio/light/vcnl4000.c                       |   2 +-
 drivers/iio/magnetometer/mag3110.c                 |   6 +-
 drivers/iio/orientation/Kconfig                    |  19 +
 drivers/iio/orientation/Makefile                   |   6 +
 drivers/iio/orientation/hid-sensor-incl-3d.c       | 428 +++++++++++++++++++++
 drivers/staging/iio/accel/lis3l02dq_core.c         |   8 +-
 drivers/staging/iio/accel/sca3000_core.c           |  16 +-
 drivers/staging/iio/adc/ad7280a.c                  |  28 +-
 drivers/staging/iio/adc/ad7291.c                   |   8 +-
 drivers/staging/iio/adc/ad7606_core.c              |   7 +-
 drivers/staging/iio/adc/ad799x_core.c              |   6 +-
 drivers/staging/iio/adc/mxs-lradc.c                |  91 ++++-
 drivers/staging/iio/cdc/ad7150.c                   |   8 +-
 drivers/staging/iio/cdc/ad7746.c                   |  14 +-
 drivers/staging/iio/frequency/ad9832.h             |   6 +-
 drivers/staging/iio/frequency/ad9834.h             |   4 +-
 drivers/staging/iio/iio_simple_dummy.c             |   8 +-
 drivers/staging/iio/light/tsl2x7x_core.c           |  40 +-
 drivers/staging/iio/magnetometer/hmc5843.c         |   2 +-
 include/linux/hid-sensor-ids.h                     |   4 +
 include/linux/iio/buffer.h                         |   3 +
 include/linux/iio/events.h                         |   4 -
 include/linux/iio/iio.h                            |  34 +-
 include/linux/iio/types.h                          |   1 +
 59 files changed, 1241 insertions(+), 377 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/dht11.txt
 create mode 100644 drivers/iio/humidity/Kconfig
 create mode 100644 drivers/iio/humidity/Makefile
 create mode 100644 drivers/iio/humidity/dht11.c
 create mode 100644 drivers/iio/orientation/Kconfig
 create mode 100644 drivers/iio/orientation/Makefile
 create mode 100644 drivers/iio/orientation/hid-sensor-incl-3d.c
