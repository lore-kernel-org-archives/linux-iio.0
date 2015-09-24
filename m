Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47965 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbbIXRzU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Sep 2015 13:55:20 -0400
Subject: Re: [PULL] 1st set of IIO new drivers, functionality and cleanups for
 the 4.4 cycle.
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <56043868.1090601@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56043907.1020701@kernel.org>
Date: Thu, 24 Sep 2015 18:55:19 +0100
MIME-Version: 1.0
In-Reply-To: <56043868.1090601@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/09/15 18:52, Jonathan Cameron wrote:
> The following changes since commit 1c46ae0af6df0bbde66c5e868563be57f18a27b4:
> 
>   Merge tag 'iio-for-4.3b-2' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2015-08-12 12:43:41 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.4a
> 
> for you to fetch changes up to 1d2f1e084b7386b4082ebc2490ce0ddc8efe5667:
> 
>   iio: light: apds9960: fix platform_no_drv_owner.cocci warnings (2015-09-23 20:23:30 +0100)
> 
> ----------------------------------------------------------------
Just to note, there will be a few automerges.  The only manual one that
will need doing is in the devicetree vendors list file and is trivial.

Bit of a mammoth set this time round!

Thanks,

Jonathan
> First round of new driver, new functionality and cleanups for IIO in the 4.4 cycle
> 
> New device support
> * APDS9960 ALS + proximity driver
> * bmg160 SPI devices.
> * HDC100x humidity sensors
> * Holt HI-8435 threshold detector
> * mma8453Q accelerometer added to the mma8452 driver
> * mma86452FC and mma8653FC accelerometers added to the mma8452 driver
> * mxc4005 accelerometer
> * PulsedLight LIDAR
> * SensorTech VZ89x volatile organic compound sensor
> * UPISEMI uS5182d ALS and proximity sensors
> 
> New core functionality
> * triggered events - use triggers to check for changes in threshold type
>   detectors on devices with out interrupt support.  First user is the holt
>   comparator.
> * chemical concentration and resistance channel types.
> 
> New driver functionality
> * vf610
>   - buffer support.
>   - followup coccinelle warning fix.
> 
> Core rework
> * buffers
>   - break out callback buffer to own module.
>   - move buffer implementations to a new subdirectory
> * percolate the error code form iio_event_getfd out to userspace
>   rather than giving a missleading error later on.
> 
> Cleanups
> * adddac drivers
>   - use BIT macro where appropriate.
> * meter drivers
>   - use BIT macro where appropriate.
> 
> * ad7303
>  - add an OF match table to line up with the binding docs.
> * adc128s052
>   - add an OF match table to line up with the binding docs.
> * adf4350
>   - add an OF match table to line up with the binding docs
> * as3935
>   - add an OF match table to line up with the binding docs.
> * berlin2-adc
>   - use GENMASK and BIT for masks
>   - prevent attempting to sample multiple channels at once by moving a
>     mutex scop
>   - coding style cleanups
> * bmg150_magn
>   - kconfig sort order was wrong - fix it.
> * bmg160
>   - use i2c regmap and drop all uses of i2c_client
>   - separate i2c and core driver
> * cc10001_adc
>   - kconfig sort order was wrong - fix it.
> * evgen (dummy driver helper module)
>   - move interrupt generation to irq_work to reduce differences between
>     the dummy driver and real hardware drivers.
> * hmc5843
>   - set the name dynamically rather than to a fixed value for one of the
>     suported parts.
>   - export module alias information to allow autoprobing of module.
> * lpc32xx
>   - on failure to get resource or irq return -ENXIO as uppose to -EBUSY
> * max1027
>   - set .of_match_table to actually allow OF style matching.
> * max5821
>   - add MODULE_DEVICE_TABLE for OF table.
> * mma8452
>   - refactor to separate out chip specific data.
>   - add freefall / motion interrupt source for devices that do their
>     interrupts slightly differently.
>   - update copywrite notice.
>   - leave naming of events directory in sysfs to the core
> * mcp320x
>   - set .of_match_table so that it can be use for OF style matching.
> * mlx90614
>   - Implement filter configuration (note the datasheet changed as a result
>     of the driver reviews to include the values we needed ;)
> * opt3001
>   - drop .owner field as assigned by platform driver core.
> * si7020
>   - replace a bitmask on the humidity values with a more correct range
>     check.
> * stk310
>   - improved error handling.
>   - use BIT macro where appropriate and use the resulting defines
>     instead of magic numbers in the code.
>   - fix indentation
> * st-sensors
>   - add debugfs register read hook
> * tsl4531
>   - fix error handling in check_id
> * twl6030
>   - fix module autoload for OF
> * iio-trig-sysfs
>   - document add and remove attribute
> * trigger in staging
>   - code alignment fixes.
>   - braces on both branches of if statement if needed for one.
> * xilinx-xadc
>   - push interrupts into hardirq context as there isn't much in them
>     any more and it avoids breaking PREEMPT_RT builds due to the use
>     of a spinlock between the hardirq and the thread.
> 
> Tools
> * event-monitor
>   - report unsupported events.  We keep expanding what can come from drivers
>     so give a helpful error if one turns up in an out of date userspace
>     program.
> * generic-buffer
>   - helpful message about needing to enable a channel to start the buffer.
> 
> ----------------------------------------------------------------
> Adriana Reus (2):
>       iio: light: Add support for UPISEMI uS5182d als and proximity sensor
>       devicetree: Add documentation for UPISEMI us5182d ALS and Proximity sensor
> 
> Cristina Opriceana (5):
>       Documentation: iio-trig-sysfs: Document add_trigger attribute
>       Documentation: iio-trig-sysfs: Add remove_trigger attribute ABI
>       Staging: iio: trigger: Alignment should match open parenthesis
>       Staging: iio: trigger: Use braces on both branches of if statement
>       Staging: iio: Move evgen interrupt generation to irq_work
> 
> Crt Mori (1):
>       iio: mlx90614: Implement filter configuration
> 
> Dan Carpenter (1):
>       iio: tsl4531: fix error handling in tsl4531_check_id()
> 
> Hartmut Knaack (8):
>       iio:adc:berlin2-adc: use GENMASK and BIT for masks
>       iio:adc:berlin2-adc: enable interrupts with mutex locked
>       iio:adc:berlin2-adc: coding style cleanup
>       iio:light:stk3310: add more error handling
>       iio:light:stk3310: use correct names and type for state
>       iio:light:stk3310: adjust indentation
>       iio:magnetometer:bmc150_magn: sort entry alphabetically
>       iio:adc:cc10001_adc: resort entry in Kconfig and Makefile
> 
> Javier Martinez Canillas (8):
>       staging: iio: hmc5843: Export missing SPI module alias information
>       iio: adc: max1027: Set struct spi_driver .of_match_table
>       iio: as3935: Add OF match table
>       iio: adc128s052: Add OF match table
>       iio: frequency: adf4350: Add OF match table
>       iio: dac: ad7303: Add OF match table
>       iio: Export SPI module alias information in missing drivers
>       iio: adc: mcp320x: Set struct spi_driver .of_match_table
> 
> Lars-Peter Clausen (2):
>       iio: Move callback buffer to its own module
>       iio: Move generic buffer implementations to sub-directory
> 
> Linus Walleij (4):
>       iio: st_sensors: add debugfs register read hook
>       iio: event_monitor: report unsupported events
>       iio: generic_buffer: be helpful about enabling channels
>       iio: percolate error if event fd fails
> 
> Luis de Bethencourt (2):
>       iio: dac: max5821: Fix module autoload for OF platform driver
>       iio: adc: twl6030-gpadc: Fix module autoload for OF platform driver
> 
> Markus Pargmann (6):
>       iio: bmg160: Use i2c regmap instead of direct i2c access
>       iio: bmg160: Remove i2c_client from data struct
>       iio: bmg160: Use generic dev_drvdata
>       iio: bmg160: Remove remaining uses of i2c_client
>       iio: bmg160: Separate i2c and core driver
>       iio: bmg160: Add SPI driver
> 
> Martin Kepplinger (6):
>       iio: mma8452: refactor for seperating chip specific data
>       iio: mma8452: add support for MMA8453Q accelerometer chip
>       iio: mma8452: add freefall / motion interrupt source
>       iio: mma8452: add support for MMA8652FC and MMA8653FC
>       iio: mma8452: add copyright notice comment
>       iio: mma8452: leave sysfs namings to the iio core
> 
> Matt Ranostay (9):
>       iio: light: DT binding docs for APDS9960 driver
>       iio: light: add APDS9960 ALS + promixity driver
>       devicetree: add PulsedLight vendor + device docs
>       iio: proximity: add support for PulsedLight LIDAR
>       iio: humidity: add HDC100x support
>       iio: chemical: Add IIO_CONCENTRATION channel type
>       iio: resistance: add IIO_RESISTANCE channel type
>       devicetree: add SGX Sensortech vendor id
>       iio: chemical: add SGX VZ89x VOC sensor support
> 
> Nicola Corna (1):
>       iio: humidity: si7020: replaced bitmask on humidity values with range check
> 
> Peng Fan (1):
>       staging: iio: adc: lpc32xx: use correct reutrn value
> 
> Sanchayan Maity (1):
>       iio: adc: vf610: Add IIO buffer support for Vybrid ADC
> 
> Shraddha Barke (2):
>       Staging: iio: meter: Prefer using the BIT macro
>       Staging: iio: addac: Prefer using the BIT macro
> 
> Teodora Baluta (3):
>       iio: accel: add support for mxc4005 accelerometer
>       iio: mxc4005: add triggered buffer mode for mxc4005
>       iio: mxc4005: add data ready trigger for mxc4005
> 
> Vladimir Barinov (4):
>       iio: Support triggered events
>       dt: Add vendor prefix 'holt'
>       iio: adc: hi8435: Holt HI-8435 threshold detector
>       dt: Document Holt HI-8435 bindings
> 
> Xander Huff (1):
>       iio: adc: xilinx-xadc: Push interrupts into hardirq context
> 
> Yong Li (1):
>       staging: iio: hmc5843: Set iio name dynamically
> 
> kbuild test robot (4):
>       iio: light: fix platform_no_drv_owner.cocci warnings
>       iio: adc: vf610: fix simple_return.cocci warnings
>       iio: apds9960: light: fix simple_return.cocci warnings
>       iio: light: apds9960: fix platform_no_drv_owner.cocci warnings
> 
>  Documentation/ABI/testing/sysfs-bus-iio            |   20 +
>  Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435 |   43 +
>  .../ABI/testing/sysfs-bus-iio-chemical-vz89x       |    7 +
>  .../ABI/testing/sysfs-bus-iio-humidity-hdc100x     |    9 +
>  .../ABI/testing/sysfs-bus-iio-trigger-sysfs        |   22 +
>  Documentation/DocBook/iio.tmpl                     |    2 +-
>  .../devicetree/bindings/i2c/trivial-devices.txt    |    3 +-
>  .../devicetree/bindings/iio/accel/mma8452.txt      |   24 +
>  .../devicetree/bindings/iio/adc/hi8435.txt         |   21 +
>  .../devicetree/bindings/iio/light/apds9960.txt     |   22 +
>  .../devicetree/bindings/iio/light/us5182d.txt      |   34 +
>  .../devicetree/bindings/vendor-prefixes.txt        |    4 +
>  MAINTAINERS                                        |    7 +
>  drivers/iio/Kconfig                                |   29 +-
>  drivers/iio/Makefile                               |    6 +-
>  drivers/iio/accel/Kconfig                          |   19 +-
>  drivers/iio/accel/Makefile                         |    2 +
>  drivers/iio/accel/mma8452.c                        |  356 ++++--
>  drivers/iio/accel/mxc4005.c                        |  567 ++++++++++
>  drivers/iio/accel/st_accel_core.c                  |    1 +
>  drivers/iio/adc/Kconfig                            |   35 +-
>  drivers/iio/adc/Makefile                           |    3 +-
>  drivers/iio/adc/berlin2-adc.c                      |   91 +-
>  drivers/iio/adc/hi8435.c                           |  534 +++++++++
>  drivers/iio/adc/max1027.c                          |    1 +
>  drivers/iio/adc/mcp320x.c                          |    1 +
>  drivers/iio/adc/ti-adc128s052.c                    |    8 +
>  drivers/iio/adc/twl6030-gpadc.c                    |    1 +
>  drivers/iio/adc/vf610_adc.c                        |  101 +-
>  drivers/iio/adc/xilinx-xadc-core.c                 |   37 +-
>  drivers/iio/adc/xilinx-xadc.h                      |    2 -
>  drivers/iio/amplifiers/ad8366.c                    |    1 +
>  drivers/iio/buffer/Kconfig                         |   24 +
>  drivers/iio/buffer/Makefile                        |    8 +
>  .../industrialio-buffer-cb.c}                      |   12 +
>  .../{ => buffer}/industrialio-triggered-buffer.c   |    0
>  drivers/iio/{ => buffer}/kfifo_buf.c               |    0
>  drivers/iio/chemical/Kconfig                       |   15 +
>  drivers/iio/chemical/Makefile                      |    6 +
>  drivers/iio/chemical/vz89x.c                       |  237 ++++
>  drivers/iio/common/st_sensors/st_sensors_core.c    |   22 +
>  drivers/iio/dac/ad7303.c                           |    7 +
>  drivers/iio/dac/max5821.c                          |    1 +
>  drivers/iio/frequency/adf4350.c                    |    9 +
>  drivers/iio/gyro/Kconfig                           |   19 +-
>  drivers/iio/gyro/Makefile                          |    4 +-
>  drivers/iio/gyro/bmg160.h                          |   10 +
>  drivers/iio/gyro/{bmg160.c => bmg160_core.c}       |  361 +++----
>  drivers/iio/gyro/bmg160_i2c.c                      |   71 ++
>  drivers/iio/gyro/bmg160_spi.c                      |   57 +
>  drivers/iio/gyro/st_gyro_core.c                    |    1 +
>  drivers/iio/humidity/Kconfig                       |   10 +
>  drivers/iio/humidity/Makefile                      |    1 +
>  drivers/iio/humidity/hdc100x.c                     |  319 ++++++
>  drivers/iio/humidity/si7020.c                      |    6 +-
>  drivers/iio/industrialio-core.c                    |   10 +-
>  drivers/iio/industrialio-trigger.c                 |   12 +-
>  drivers/iio/industrialio-triggered-event.c         |   68 ++
>  drivers/iio/light/Kconfig                          |   23 +
>  drivers/iio/light/Makefile                         |    2 +
>  drivers/iio/light/apds9960.c                       | 1130 ++++++++++++++++++++
>  drivers/iio/light/opt3001.c                        |    1 -
>  drivers/iio/light/stk3310.c                        |   75 +-
>  drivers/iio/light/tsl4531.c                        |    9 +-
>  drivers/iio/light/us5182d.c                        |  507 +++++++++
>  drivers/iio/magnetometer/Kconfig                   |   33 +-
>  drivers/iio/magnetometer/Makefile                  |    3 +-
>  drivers/iio/magnetometer/st_magn_core.c            |    1 +
>  drivers/iio/pressure/st_pressure_core.c            |    1 +
>  drivers/iio/proximity/Kconfig                      |   12 +
>  drivers/iio/proximity/Makefile                     |    1 +
>  drivers/iio/proximity/as3935.c                     |    7 +
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |  288 +++++
>  drivers/iio/temperature/mlx90614.c                 |   90 +-
>  drivers/staging/iio/adc/lpc32xx_adc.c              |    4 +-
>  drivers/staging/iio/addac/adt7316.c                |   14 +-
>  drivers/staging/iio/iio_dummy_evgen.c              |   26 +-
>  drivers/staging/iio/iio_simple_dummy.h             |    1 +
>  drivers/staging/iio/iio_simple_dummy_events.c      |   19 +-
>  drivers/staging/iio/magnetometer/hmc5843.h         |    2 +-
>  drivers/staging/iio/magnetometer/hmc5843_core.c    |    4 +-
>  drivers/staging/iio/magnetometer/hmc5843_i2c.c     |    2 +-
>  drivers/staging/iio/magnetometer/hmc5843_spi.c     |    4 +-
>  drivers/staging/iio/meter/ade7753.c                |    8 +-
>  drivers/staging/iio/meter/ade7754.c                |    6 +-
>  drivers/staging/iio/meter/ade7758_core.c           |    6 +-
>  drivers/staging/iio/meter/ade7759.c                |    8 +-
>  drivers/staging/iio/meter/ade7854.c                |    6 +-
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |    7 +-
>  .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    5 +-
>  include/linux/iio/common/st_sensors.h              |    4 +
>  include/linux/iio/iio.h                            |    3 +
>  include/linux/iio/triggered_event.h                |   11 +
>  include/uapi/linux/iio/types.h                     |    4 +
>  tools/iio/generic_buffer.c                         |    9 +
>  tools/iio/iio_event_monitor.c                      |    6 +-
>  96 files changed, 5145 insertions(+), 500 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/mma8452.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/hi8435.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/light/apds9960.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/light/us5182d.txt
>  create mode 100644 drivers/iio/accel/mxc4005.c
>  create mode 100644 drivers/iio/adc/hi8435.c
>  create mode 100644 drivers/iio/buffer/Kconfig
>  create mode 100644 drivers/iio/buffer/Makefile
>  rename drivers/iio/{buffer_cb.c => buffer/industrialio-buffer-cb.c} (89%)
>  rename drivers/iio/{ => buffer}/industrialio-triggered-buffer.c (100%)
>  rename drivers/iio/{ => buffer}/kfifo_buf.c (100%)
>  create mode 100644 drivers/iio/chemical/Kconfig
>  create mode 100644 drivers/iio/chemical/Makefile
>  create mode 100644 drivers/iio/chemical/vz89x.c
>  create mode 100644 drivers/iio/gyro/bmg160.h
>  rename drivers/iio/gyro/{bmg160.c => bmg160_core.c} (75%)
>  create mode 100644 drivers/iio/gyro/bmg160_i2c.c
>  create mode 100644 drivers/iio/gyro/bmg160_spi.c
>  create mode 100644 drivers/iio/humidity/hdc100x.c
>  create mode 100644 drivers/iio/industrialio-triggered-event.c
>  create mode 100644 drivers/iio/light/apds9960.c
>  create mode 100644 drivers/iio/light/us5182d.c
>  create mode 100644 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>  create mode 100644 include/linux/iio/triggered_event.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

