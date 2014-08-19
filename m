Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52124 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbaHSURY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Aug 2014 16:17:24 -0400
Message-ID: <53F3B0D0.60003@kernel.org>
Date: Tue, 19 Aug 2014 21:17:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, features and cleanups for 3.18 - set 1
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit e010a2a04c3179c342e370e93ffb7d13eaf90dc4:

  staging: gdm724x: fix misplaced open braces (2014-07-26 19:26:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.18a

for you to fetch changes up to ff9e7621586ff8b86a18cfbb7c437c277ebc1970:

  iio: adc: xilinx: Remove .owner field for driver (2014-08-19 20:25:10 +0100)

----------------------------------------------------------------
1st round of new IIO drivers, functionality and cleanups for the 3.18 cycle.

Maintainer Updates

* Add 3 designated reviewers for IIO.  Lars, Peter and Hartmut have been
  actively reviewing a lot of patches for a while now so this reflects
  the status quo.  These three are probably the only reason I keep
  my head above the water!

New drivers and device support

* max5821 DAC
* Rockchip SARADC
* TI ADC128S052 ADC
* BMC150 Accelerometer
* exynos ADC driver gains support for s3c24xx and s3c64xx parts.
* kxcjk-1013 gainst range control and runtime PM support to drive
  down it's power usage.

Driver removals

* Drop ad5930, ad99850, ad9852, ad9910 and ad9951 drivers on the simple
  basis that they drivers just provided a register write function with
  no compliant user space ABI whatsoever.  Much better to drop them and
  start again for these in the fullness of time.

Core Enhancements

* Join together neighbouring elements in the demux units that feeds
  the binary interfaces.  This cuts down on the number of individual
  copies needed  when splitting out individual channels from the incoming
  channel scans.
* Other demux related cleanups such as using roundup instead of a local
  implementation.

Cleanups

* Drop an unnecessary double setting of the owner field in xilinx adc.
* Some more patches to use managed (devm) interfaces to cut down on
  complexity of removal code.
* adis16060 coding style fixlets.
* Fix some incorrect error returns in the Xilinx ADC driver.
* Coding style fixlets for various accelerometer drivers.
* Some sparse warning fixes to do with endianness and sign of variables.
* Fix an incorrect and entirely pointless use of sizeof on a dynamic pointer
  in hid-sensor-magn-3d by dropping the relevant code.

----------------------------------------------------------------
Angelo Compagnucci (1):
      iio: adc: Add TI ADC128S052

Arnd Bergmann (1):
      iio: adc: exynos_adc: add support for s3c64xx adc

Chanwoo Choi (1):
      iio: adc: exynos_adc: Add support for s3c24xx ADC

Heiko Stübner (1):
      iio: adc: add driver for Rockchip saradc

Himangi Saraogi (3):
      staging: iio: ad9951: Use devm_iio_device_register
      staging:iio:ad9852: Use devm_iio_device_register
      HID: hid-sensor-hub: use devm_ functions consistently

Jonathan Cameron (1):
      iio:buffer: Wrong sized allocation of demux table elements.

Julia Lawall (1):
      iio: fix error return code

Lars-Peter Clausen (5):
      iio: buffer: Use roundup() instead of open-coding it
      iio: buffer: Coalesce adjacent demux table entries
      MAINTAINERS: Add designated reviewers for IIO subsystem
      MAINTAINERS: Add entry for Analog Devices IIO drivers
      staging:iio: Remove ad5930/ad9850/ad9852/ad9910/ad9951 dummy drivers

Michal Simek (1):
      iio: adc: xilinx: Remove .owner field for driver

Murilo Opsfelder Araujo (2):
      staging: iio: accel: sca3000_core.c: Adjust code to fit 80-chars limit
      staging: iio: accel: Add blank lines between declarations and code

Oussama Jabbari (1):
      staging: iio: adis16060: Fix coding style problem

Philippe Reynes (1):
      iio: add support of the max5821

Reyad Attiyat (1):
      iio: hid-sensor-magn-3d: Fix build warning

Srinivas Pandruvada (4):
      iio: accel: kxcjk-1013: support runtime pm
      iio: accel: kxcjk-1013: Set adjustable range
      iio: accel: BMC150 accel support
      iio: accel: BMC150 accel documentation

Teodora Baluta (4):
      staging: iio: ad5933: fix sparse warnings
      staging: iio: hmc5843_core: fix sparse warnings
      staging: iio: isl29018: fix sparse warning regarding incorrect type (different signedness)
      staging: iio: adis16240: fix sparse warnings regarding incorrect argument type

 .../ABI/testing/sysfs-bus-iio-accel-bmc150         |    7 +
 .../devicetree/bindings/arm/samsung/exynos-adc.txt |   18 +-
 .../devicetree/bindings/iio/dac/max5821.txt        |   14 +
 MAINTAINERS                                        |   14 +
 drivers/hid/hid-sensor-hub.c                       |   33 +-
 drivers/iio/accel/Kconfig                          |   13 +
 drivers/iio/accel/Makefile                         |    1 +
 drivers/iio/accel/bmc150-accel.c                   | 1307 ++++++++++++++++++++
 drivers/iio/accel/kxcjk-1013.c                     |  294 ++++-
 drivers/iio/adc/Kconfig                            |   22 +-
 drivers/iio/adc/Makefile                           |    2 +
 drivers/iio/adc/exynos_adc.c                       |  137 +-
 drivers/iio/adc/rockchip_saradc.c                  |  317 +++++
 drivers/iio/adc/ti-adc128s052.c                    |  179 +++
 drivers/iio/adc/xilinx-xadc-core.c                 |    9 +-
 drivers/iio/dac/Kconfig                            |    8 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/max5821.c                          |  405 ++++++
 drivers/iio/industrialio-buffer.c                  |   63 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |    7 +-
 drivers/staging/iio/accel/adis16201_core.c         |    5 +-
 drivers/staging/iio/accel/adis16203_core.c         |    2 +
 drivers/staging/iio/accel/adis16204_core.c         |    1 +
 drivers/staging/iio/accel/adis16209_core.c         |    1 +
 drivers/staging/iio/accel/adis16240_core.c         |    1 +
 drivers/staging/iio/accel/lis3l02dq_core.c         |    4 +
 drivers/staging/iio/accel/lis3l02dq_ring.c         |    1 +
 drivers/staging/iio/accel/sca3000_core.c           |    4 +-
 drivers/staging/iio/frequency/Kconfig              |   35 -
 drivers/staging/iio/frequency/Makefile             |    5 -
 drivers/staging/iio/frequency/ad5930.c             |  140 ---
 drivers/staging/iio/frequency/ad9850.c             |  120 --
 drivers/staging/iio/frequency/ad9852.c             |  253 ----
 drivers/staging/iio/frequency/ad9910.c             |  371 ------
 drivers/staging/iio/frequency/ad9951.c             |  209 ----
 drivers/staging/iio/gyro/adis16060_core.c          |    1 +
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   10 +-
 drivers/staging/iio/light/isl29018.c               |    2 +-
 drivers/staging/iio/magnetometer/hmc5843_core.c    |    6 +-
 drivers/staging/iio/resolver/ad2s1210.c            |    4 +-
 40 files changed, 2756 insertions(+), 1270 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-bmc150
 create mode 100644 Documentation/devicetree/bindings/iio/dac/max5821.txt
 create mode 100644 drivers/iio/accel/bmc150-accel.c
 create mode 100644 drivers/iio/adc/rockchip_saradc.c
 create mode 100644 drivers/iio/adc/ti-adc128s052.c
 create mode 100644 drivers/iio/dac/max5821.c
 delete mode 100644 drivers/staging/iio/frequency/ad5930.c
 delete mode 100644 drivers/staging/iio/frequency/ad9850.c
 delete mode 100644 drivers/staging/iio/frequency/ad9852.c
 delete mode 100644 drivers/staging/iio/frequency/ad9910.c
 delete mode 100644 drivers/staging/iio/frequency/ad9951.c
