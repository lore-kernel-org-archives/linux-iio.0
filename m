Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43292 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab3IVSUH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Sep 2013 14:20:07 -0400
Message-ID: <523F42FA.1020706@kernel.org>
Date: Sun, 22 Sep 2013 20:20:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, driver features, core functionality and cleanups
 for 3.13
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 91121c103ae93ef117e58712786864270d7f488e:

  staging: dwc2: make dwc2_core_params documentation more complete (2013-08-30 14:14:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.13a

for you to fetch changes up to 074b6a8d9d73db27d48abe4200ce149bd4189b39:

  iio: ti_am335x_adc: cleanup error case (2013-09-22 19:02:48 +0100)

----------------------------------------------------------------
First round of new drivers, functionality and cleanups for IIO in the 3.13 cycle

A number of new drivers and some new functionality + a lot of cleanups
all over IIO.

New Core Elements

1) New INT_TIME info_mask element for integration time, which may have
   different effects on measurement noise and similar, than an amplifier
   and hence is different from existing SCALE.  Already existed in some
   drivers as a custom attribute.

2) Introduce a iio_push_buffers_with_timestamp helper to cover the common
   case of filling the last 64 bits of data to be passed to the buffer with
   a timestamp.  Applied to lots of drivers. Cuts down on repeated code and
   moves a slightly fiddly bit of logic into a single location.

3) Introduce info_mask_[shared_by_dir/shared_by_all] elements to allow support
   of elements such as sampling_frequency which is typically shared by all
   input channels on a device.  This reduces code and makes these controls
   available from in kernel consumers of IIO devices.

New drivers

1) MCP3422/3/4 ADC

2) TSL4531 ambient light sensor

3) TCS3472/5 color light sensor

4) GP2AP020A00F ambient light / proximity sensor

5) LPS001WP support added to ST pressure sensor driver.

New driver functionality

1) ti_am335x_adc Add buffered sampling support.
   This device has a hardware fifo that is fed directly into an IIO kfifo
   buffer based on a watershed interrupt.  Note this will act as an example
   of how to handle this increasingly common type of device.
   The only previous example - sca3000 - take a less than optimal approach
   which is largely why it is still in staging.
   A couple of little cleanups for that new functionality followed later.

Core cleanups:

1) MAINTAINERS - Sachin actually brought my email address up to date because
   I said I'd do it and never got around to it :)

2) Assign buffer list elements as single element lists to simplify the
   iio_buffer_is_active logic.

3) wake_up_interruptible_poll instead of wake_up_interruptible to only wake
   up threads waiting for poll notifications.

4) Add O_CLOEXEC flag to anon_inode_get_fd call for IIO event interface.

5) Change iio_push_to_buffers to take a void * pointer so as to avoid some
   annoying and unnecessary type casts.

6) iio_compute_scan_bytes incorrectly took a long rather than unsigned long.

7) Various minor tidy ups.

Driver cleanups (in no particular order)

1) Another set of devm_ allocations patches from Sachin Kamat.

2) tsl2x7x - 0 to NULL cleanup.

3) hmc5843 - fix missing > in MODULE_AUTHOR

4) Set of strict_strto* to kstrto* conversions.

5) mxs-lradc - fix ordering of resource removal to match creation

6) mxs-lradc - add MODULE_ALIAS

7) adc7606 - drop a work pending test duplicated in core functions.

8) hmc5843 - devm_ allocation patch

9) Series of redundant breaks removed.

10) ad2s1200 - pr_err -> dev_err

11) adjd_s311 - use INT_TIME

12)  ST sensors - large set of cleanups from Lee Jones and removed restriction
    to using only triggers provided by the st_sensors themselves from
    Dennis Ciocca.

13) dummy and tmp006 provide sampling_frequency via info_mask_shared_by_all.

14) tcs3472 - fix incorrect buffer size and wrong device pointer used in
    suspend / resume functions.

15) max1363 - use defaults for buffer setup ops as provided by the triggered
    buffer helpers as they are the same as were specified in max1363 driver.

16) Trivial tidy ups in a number of other drivers.

----------------------------------------------------------------
Angelo Compagnucci (1):
      iio: adc: Add driver for Microchip MCP3422/3/4 high resolution ADC

Denis CIOCCA (4):
      iio:accel: Register buffer also without specific trigger
      iio:gyro: Register buffer also without specific trigger
      iio:magn: Register buffer also without specific trigger
      iio:press: Register buffer also without specific trigger

Fabio Estevam (2):
      iio: mxs-lradc: Fix the order of resources removal
      iio: mxs-lradc: Add MODULE_ALIAS

Jacek Anaszewski (2):
      DT: Add documentation for gp2ap020a00f sensor
      iio: gp2ap020a00f: Add a driver for the device

Jingoo Han (1):
      staging: iio: replace strict_strto*() with kstrto*()

Jonathan Cameron (5):
      iio: drop info_mask from struct iio_dev
      iio: refactor info mask and ext_info attribute creation.
      iio: add info_mask_[shared_by_dir/shared_by_all]
      staging:iio: dummy driver additions to show shared_by_dir infomask usage
      iio:temperature:tmp006 put sampling_frequency in info_mask_shared_by_all

Lars-Peter Clausen (31):
      iio:buffer: Simplify iio_buffer_is_active()
      iio:kfifo_buf: Use wake_up_interruptible_poll()
      iio:buffer_cb: Constify iio_cb_access
      iio: iio_push_to_buffers(): Change type of 'data' to const void *
      iio: Remove unnecessary casts for iio_push_to_buffers()
      staging:iio: Remove unnecessary casts for iio_push_to_buffers()
      iio:max1361: Use default triggered buffer setup ops
      iio: Add iio_push_buffers_with_timestamp() helper
      iio:bma180: Use iio_push_buffers_with_timestamp()
      iio:ad7266: Use iio_push_to_buffers_with_timestamp()
      iio:ad7298: Use iio_push_to_buffers_with_timestamp()
      iio:ad7476: Use iio_push_to_buffers_with_timestamp()
      iio:ad7887: Use iio_push_to_buffers_with_timestamp()
      iio:ad7923: Use iio_push_to_buffers_with_timestamp()
      iio:ad_sigma_delta: Use iio_push_to_buffers_with_timestamp()
      iio:at91_adc: Use iio_push_to_buffers_with_timestamp()
      iio:max1363: Use iio_push_to_buffers_with_timestamp()
      iio:st_sensors: Use iio_push_to_buffers_with_timestamp()
      iio:itg3200: Use iio_push_to_buffers_with_timestamp()
      iio:adis16400: Use iio_push_to_buffers_with_timestamp()
      iio:adis_lib: Use iio_push_to_buffers_with_timestamp()
      iio:mpu6050: Use iio_push_to_buffers_with_timestamp()
      iio:adjd_s311: Use iio_push_to_buffers_with_timestamp()
      iio:tcs3472: Use iio_push_to_buffers_with_timestamp()
      iio:gp2ap020a00f: Use iio_push_to_buffers_with_timestamp()
      staging:iio:lis3l02dq: Use iio_push_to_buffers_with_timestamp()
      staging:iio:ad7606: Use iio_push_to_buffers_with_timestamp()
      staging:iio:ad799x: Use iio_push_to_buffers_with_timestamp()
      staging:iio:mxs-lradc: Use iio_push_to_buffers_with_timestamp()
      staging:iio:dummy: Use iio_push_to_buffers_with_timestamp()
      staging:iio:ade7758: Use iio_push_to_buffers_with_timestamp()

Lee Jones (13):
      iio: sensors-core: st: Allow full-scale to be an optional feature
      iio: sensors-core: st: Clean-up error handling in st_sensors_read_info_raw()
      iio: pressure-core: st: Describe LPS331AP defines by name
      iio: pressure-core: st: Expand and rename LPS331AP's channel descriptor
      iio: pressure-core: st: Allow for number of channels to vary
      iio: sensors-core: st: Support sensors which don't have a Data Ready pin
      iio: sensors-core: st: Clean-up error handling in st_sensors_init_sensor()
      iio: sensors-core: st: Clean-up error handling in st_sensors_read_axis_data()
      iio: pressure-core: st: Clean-up probe() function
      iio: pressure: st: Add support for new LPS001WP pressure sensor
      iio: accel-core: st: Clean up error handling in probe()
      iio: gyro-core: st: Clean up error handling in probe()
      iio: magn-core: st: Clean up error handling in probe()

Peter Meerwald (11):
      iio: Remove trailing ; from function definitions
      staging:iio:hmc5843: Use devm_iio_device_alloc
      iio: Add INT_TIME (integration time) channel info attribute
      iio: adjd_s311: Use INT_TIME channel info
      iio: Add tsl4531 ambient light sensor driver
      iio: Add tcs3472 color light sensor driver
      iio: Fix tcs3472 buffer size
      iio: Minor cleanups of industrialio-buffer
      iio: Make available scan_masks const in ad7266
      iio: Fix tcs3472 dev-to-indio_dev conversion in suspend/resume
      iio: Pass scan mask as unsigned long

Sachin Kamat (36):
      staging: iio: ad7192: Use devm_* APIs and fix a memory leak
      staging: iio: ad7280a: Use devm_iio_device_alloc
      staging: iio: ad7291: Use devm_* APIs
      staging: iio: ad7606_core: Use devm_* APIs
      staging: iio: ad7780: Use devm_* APIs
      staging: iio: ad7816: Use devm_* APIs
      staging: iio: ad799x_core: Use devm_* APIs
      staging: iio: lpc32xx_adc: Use devm_* APIs
      staging: iio: adt7316: Use devm_* APIs
      staging: iio: ad5933: Use devm_* APIs
      staging: iio: tsl2583: Use devm_iio_device_alloc
      staging: iio: ad5930: Use devm_iio_device_alloc
      staging: iio: ad9832: Use devm_* APIs
      staging: iio: ad9834: Use devm_* APIs
      staging: iio: ad9850: Use devm_iio_device_alloc
      staging: iio: ad9852: Use devm_iio_device_alloc
      staging: iio: ad9910: Use devm_iio_device_alloc
      staging: iio: ad9951: Use devm_iio_device_alloc
      staging: iio: tsl2x7x_core: Use devm_* APIs
      staging: iio: tsl2x7x_core: Fix sparse warning
      staging: iio: hmc5843: Fix a trivial typo
      MAINTAINERS: Update Jonathan's email address
      iio: gyro: adis16130: Remove redundant break
      iio: gyro: adis16260: Remove redundant break
      iio: gyro: adxrs450: Remove redundant break
      iio: dac: ad5686: Remove redundant break
      staging: iio: tsl2x7x_core: Remove redundant break
      staging: iio: ad2s1200: Use devm_* APIs
      staging: iio: ad2s1200: Use dev_err instead of pr_err
      staging: iio: ad2s1210: Use devm_iio_device_alloc
      staging: iio: ad2s90: Use devm_iio_device_alloc
      staging: iio: ade7753: Use devm_iio_device_alloc
      staging: iio: ade7754: Use devm_iio_device_alloc
      staging: iio: ade7758_core: Use devm_iio_device_alloc
      staging: iio: ade7759: Use devm_iio_device_alloc
      staging: iio: ade7854: Use devm_iio_device_alloc

Thomas Meyer (1):
      iio: at91_adc: Cocci spatch "noderef"

Xie XiuQi (1):
      staging:iio:adc:ad7606 remove unnecessary work pending test

Yann Droneaud (1):
      iio: use anon_inode_getfd() with O_CLOEXEC flag

Zubair Lutfullah (6):
      input: ti_am335x_tsc: Enable shared IRQ for TSC
      iio: ti_am335x_adc: optimize memory usage
      iio: ti_am335x_adc: Add continuous sampling support
      iio: ti_am335x_adc: fix static in function header
      iio: ti_am335x_adc: cleanup trigger related code
      iio: ti_am335x_adc: cleanup error case

 Documentation/ABI/testing/sysfs-bus-iio            |   11 +
 .../devicetree/bindings/iio/light/gp2ap020a00f.txt |   21 +
 MAINTAINERS                                        |    4 +-
 drivers/iio/accel/bma180.c                         |    7 +-
 drivers/iio/accel/hid-sensor-accel-3d.c            |    7 +-
 drivers/iio/accel/st_accel_core.c                  |   30 +-
 drivers/iio/adc/Kconfig                            |   11 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7266.c                           |   13 +-
 drivers/iio/adc/ad7298.c                           |   10 +-
 drivers/iio/adc/ad7476.c                           |    9 +-
 drivers/iio/adc/ad7887.c                           |   10 +-
 drivers/iio/adc/ad7923.c                           |   10 +-
 drivers/iio/adc/ad_sigma_delta.c                   |    6 +-
 drivers/iio/adc/at91_adc.c                         |   10 +-
 drivers/iio/adc/max1363.c                          |   15 +-
 drivers/iio/adc/mcp3422.c                          |  409 +++++
 drivers/iio/adc/ti_am335x_adc.c                    |  223 ++-
 drivers/iio/buffer_cb.c                            |    8 +-
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |    7 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |   70 +-
 drivers/iio/dac/ad5064.c                           |    3 +-
 drivers/iio/dac/ad5380.c                           |    4 +-
 drivers/iio/dac/ad5446.c                           |    3 +-
 drivers/iio/dac/ad5504.c                           |    4 +-
 drivers/iio/dac/ad5624r_spi.c                      |    4 +-
 drivers/iio/dac/ad5686.c                           |    4 +-
 drivers/iio/dac/ad5755.c                           |    1 +
 drivers/iio/dac/ad5791.c                           |    5 +-
 drivers/iio/dac/ad7303.c                           |    1 +
 drivers/iio/dac/mcp4725.c                          |    3 +-
 drivers/iio/frequency/adf4350.c                    |    1 +
 drivers/iio/gyro/adis16130.c                       |    2 -
 drivers/iio/gyro/adis16260.c                       |    1 -
 drivers/iio/gyro/adxrs450.c                        |    1 -
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |    7 +-
 drivers/iio/gyro/itg3200_buffer.c                  |    5 +-
 drivers/iio/gyro/st_gyro_core.c                    |   30 +-
 drivers/iio/iio_core.h                             |    2 +-
 drivers/iio/imu/adis16400_buffer.c                 |    9 +-
 drivers/iio/imu/adis_buffer.c                      |    9 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |    6 +-
 drivers/iio/industrialio-buffer.c                  |   60 +-
 drivers/iio/industrialio-core.c                    |  180 ++-
 drivers/iio/industrialio-event.c                   |    2 +-
 drivers/iio/kfifo_buf.c                            |    5 +-
 drivers/iio/light/Kconfig                          |   32 +
 drivers/iio/light/Makefile                         |    3 +
 drivers/iio/light/adjd_s311.c                      |   77 +-
 drivers/iio/light/gp2ap020a00f.c                   | 1617 ++++++++++++++++++++
 drivers/iio/light/hid-sensor-als.c                 |    7 +-
 drivers/iio/light/tcs3472.c                        |  367 +++++
 drivers/iio/light/tsl4531.c                        |  258 ++++
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |    7 +-
 drivers/iio/magnetometer/st_magn_core.c            |   31 +-
 drivers/iio/pressure/st_pressure.h                 |    1 +
 drivers/iio/pressure/st_pressure_core.c            |  268 +++-
 drivers/iio/pressure/st_pressure_i2c.c             |    1 +
 drivers/iio/temperature/tmp006.c                   |   57 +-
 drivers/input/touchscreen/ti_am335x_tsc.c          |   12 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c         |    6 +-
 drivers/staging/iio/accel/sca3000_core.c           |    8 +-
 drivers/staging/iio/accel/sca3000_ring.c           |    4 +-
 drivers/staging/iio/adc/ad7192.c                   |   15 +-
 drivers/staging/iio/adc/ad7280a.c                  |   11 +-
 drivers/staging/iio/adc/ad7291.c                   |   27 +-
 drivers/staging/iio/adc/ad7606_core.c              |   26 +-
 drivers/staging/iio/adc/ad7606_ring.c              |    8 +-
 drivers/staging/iio/adc/ad7780.c                   |   28 +-
 drivers/staging/iio/adc/ad7816.c                   |   59 +-
 drivers/staging/iio/adc/ad799x_core.c              |   16 +-
 drivers/staging/iio/adc/ad799x_ring.c              |   10 +-
 drivers/staging/iio/adc/lpc32xx_adc.c              |   49 +-
 drivers/staging/iio/adc/mxs-lradc.c                |   19 +-
 drivers/staging/iio/addac/adt7316.c                |   86 +-
 drivers/staging/iio/frequency/ad5930.c             |   16 +-
 drivers/staging/iio/frequency/ad9832.c             |   36 +-
 drivers/staging/iio/frequency/ad9834.c             |   33 +-
 drivers/staging/iio/frequency/ad9850.c             |   16 +-
 drivers/staging/iio/frequency/ad9852.c             |   17 +-
 drivers/staging/iio/frequency/ad9910.c             |   16 +-
 drivers/staging/iio/frequency/ad9951.c             |   17 +-
 drivers/staging/iio/iio_simple_dummy.c             |   16 +
 drivers/staging/iio/iio_simple_dummy_buffer.c      |    7 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   32 +-
 drivers/staging/iio/light/isl29018.c               |   18 +-
 drivers/staging/iio/light/tsl2583.c                |   48 +-
 drivers/staging/iio/light/tsl2x7x_core.c           |   48 +-
 drivers/staging/iio/magnetometer/hmc5843.c         |   26 +-
 drivers/staging/iio/meter/ade7753.c                |   31 +-
 drivers/staging/iio/meter/ade7754.c                |   31 +-
 drivers/staging/iio/meter/ade7758_core.c           |   32 +-
 drivers/staging/iio/meter/ade7758_ring.c           |    6 +-
 drivers/staging/iio/meter/ade7759.c                |   30 +-
 drivers/staging/iio/meter/ade7854-i2c.c            |    4 +-
 drivers/staging/iio/meter/ade7854-spi.c            |    4 +-
 drivers/staging/iio/meter/ade7854.c                |   22 +-
 drivers/staging/iio/resolver/ad2s1200.c            |   28 +-
 drivers/staging/iio/resolver/ad2s1210.c            |   34 +-
 drivers/staging/iio/resolver/ad2s90.c              |   16 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   23 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    4 +-
 include/linux/iio/buffer.h                         |   31 +-
 include/linux/iio/common/st_sensors.h              |    1 +
 include/linux/iio/consumer.h                       |    2 +-
 include/linux/iio/iio.h                            |   35 +-
 include/linux/iio/sysfs.h                          |   15 +
 include/linux/mfd/ti_am335x_tscadc.h               |    9 +
 108 files changed, 3913 insertions(+), 1145 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/gp2ap020a00f.txt
 create mode 100644 drivers/iio/adc/mcp3422.c
 create mode 100644 drivers/iio/light/gp2ap020a00f.c
 create mode 100644 drivers/iio/light/tcs3472.c
 create mode 100644 drivers/iio/light/tsl4531.c
