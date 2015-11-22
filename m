Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45718 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbbKVOb4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2015 09:31:56 -0500
Subject: Re: [PULL] IIO - First set of new drivers, core support and cleanups
 for the 4.5 cycle
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <5651D09C.6030209@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5651D1DA.9020903@kernel.org>
Date: Sun, 22 Nov 2015 14:31:54 +0000
MIME-Version: 1.0
In-Reply-To: <5651D09C.6030209@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Hi Greg,

When this one and the fixes set I sent a few minutes ago merge you curiously
get an issue with drivers/staging/iio/Kconfig.  The right resolution is
to dump all the dummy driver stuff.

All the other changes related to that move and various automerge stuff that
occurs looks fine to me.

Thanks as ever for dealing with our mess ;)

Jonathan

On 22/11/15 14:26, Jonathan Cameron wrote:
> The following changes since commit c3af8a28f43315fc46753465a4e77e5619dd9f30:
> 
>   staging: IB/hfi1: use TASK_COMM_LEN in hfi1_ctxtdata (2015-10-17 22:05:17 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.5a
> 
> for you to fetch changes up to 4ac4e086fd8c59e6b69089e6f7605500b63a6d17:
> 
>   iio: pulsedlight-lidar-lite: add runtime PM (2015-11-22 12:18:47 +0000)
> 
> ----------------------------------------------------------------
> First set of new device support, features and cleanups for IIO in the 4.5 cycle
> 
> Usual mixed bag, but the big item perhaps in this series is the DMA buffer
> support added by Lars-Peter Clausen. It's been in the works for a long time
> and it will be interesting to see what hardware support shows up now that
> this is available.
> 
> New core features + associate cleanup.
> * Add generic DMA buffer infrastructure
> * Add a DMAengine framework based buffer
>  Also associated minor changes.
>    - Set the device buffer watermark based on the minimum watermark for all
>      attached buffers rather than just the 'primary' one.
>    - iio_buffer_init - only set the watermark default if one hasn't already
>      been provided.  This allows simple support for devices with a fixed
>      watermark.
>    - read only attribute for watermark on fixed watermark devices.
>    - add explicit buffer enable/disable callbacks to allow the buffer to
>      do more than trivial actions when it is being turned on and off.
> * IIO_VAL_INT support in write_raw_get_fmt function.
> 
> New device support
> * Freescale MMA7455/7456L accelerometers
> * Memsic MXC6255XC accelerometer
> * ST lis2dh12 accelerometer
> * TI ADS8688 ADC
> * TI Palamas (twl6035/7) gpadc
> 
> New driver features
> * mma8452
>   - support either of the available interrupt pins to cope with the case
>     where board layout has lead to a particular one being connected.
> 
> Staging graduation
> * Dummy driver
>   - this driver acts as both an example and a test device for those with
>     out hardware to develop userspace code against.
> 
> Cleanups and minor bits and bobs.
> * treewide
>   - Sort out the ordering of iio_device_register/unregister vs runtime
>     pm function calls so that it's all nice and consistent and not race
>     prone.
>   - Check sscanf return values.  None of the cases will actually happen as
>     the strings are supplied internally, but best to be consistent on this.
> * ad7780
>   - switch over to the gpio descriptor interface and remove the now unused
>     platform data which gets rid of a header entirely.
> * ad7793
>   - drop a pointless else statement.
> * at91_adc
>   - Swap kmalloc_array in for a kmalloc doing the same job.
> * dummy
>   - get rid of some commented out lines that snuck in during the move of
>     the driver.
> * lm3533-als
>   - Print an error message on provision of an invalid resistance.
> * mcp320x
>   - Add compatible strings with vendor prefix and deprecate those with
>     no vendor prefix.
> * mxs-lradc
>   - Use BIT macro in various places rather than shifted ones.
> * pa12203001
>   - Power off the chip if the registration fails.
> * pulsedlight-lidar-lite
>   - add runtime PM support.
> * xilinx XADC
>   - constify an iio_buffer_setup_ops structure.
> 
> ----------------------------------------------------------------
> Adriana Reus (2):
>       iio: light: pa12203001: Poweroff chip if register fails
>       iio: Reconcile operation order between iio_register/unregister and pm functions
> 
> Bjorn Andersson (1):
>       iio: light: lm3533-als: Print error message on invalid resistance
> 
> Cristina Opriceana (1):
>       iio: Move IIO Dummy Driver out of staging
> 
> Dragos Bogdan (2):
>       staging:iio:ad7780: Switch to the gpio descriptor interface
>       staging:iio:ad7780: Remove the ad7780_platform_data
> 
> Giuseppe Barba (1):
>       iio: st-accel: add support for lis2dh12
> 
> H. Nikolaus Schaller (1):
>       iio:adc: add iio driver for Palmas (twl6035/7) gpadc
> 
> Ioana Ciornei (2):
>       iio: gyro: check sscanf return value
>       iio: imu: check sscanf return value
> 
> Javier Martinez Canillas (2):
>       iio: adc: mcp320x: Deprecated compatible strings with no vendor prefix
>       iio: adc: mcp320x: Add compatible with vendor prefix to OF table
> 
> Joachim Eastwood (1):
>       iio: accel: add Freescale MMA7455L/MMA7456L 3-axis accelerometer driver
> 
> Jonathan Cameron (1):
>       staging:iio: Delete some commented out lines in Kconfig and Makefile.
> 
> Julia Lawall (1):
>       iio: adc: xilinx: constify iio_buffer_setup_ops structure
> 
> Lars-Peter Clausen (6):
>       iio: Set device watermark based on watermark of all attached buffers
>       iio:iio_buffer_init(): Only set watermark if not already set
>       iio: Add support for indicating fixed watermarks
>       iio: Add buffer enable/disable callbacks
>       iio: Add generic DMA buffer infrastructure
>       iio: Add a DMAengine framework based buffer
> 
> Marek Belisko (1):
>       iio:adc:palmas: add DT support
> 
> Martin Kepplinger (1):
>       iio: mma8452: support either of the available interrupt pins
> 
> Matt Ranostay (1):
>       iio: pulsedlight-lidar-lite: add runtime PM
> 
> Nizam Haider (3):
>       iio: adc: mxs-lradc: Prefer using the BIT macro
>       iio: adc: ad7793: removed unnecessary else.
>       IIO: adc: at91_adc.c Prefer kmalloc_array over kmalloc with multiply
> 
> Sean Nyekjaer (3):
>       iio: core: added support for IIO_VAL_INT
>       iio: adc: Add TI ADS8688
>       iio: ti-ads8688: Add DT binding documentation
> 
> Teodora Baluta (1):
>       iio: accel: add support for Memsic MXC6255XC sensor
> 
>  .../devicetree/bindings/iio/accel/mma8452.txt      |   6 +
>  .../devicetree/bindings/iio/adc/mcp320x.txt        |  30 +-
>  .../devicetree/bindings/iio/adc/palmas-gpadc.txt   |  48 ++
>  .../devicetree/bindings/iio/adc/ti-ads8688.txt     |  20 +
>  .../devicetree/bindings/iio/st-sensors.txt         |   1 +
>  drivers/iio/Kconfig                                |   1 +
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/accel/Kconfig                          |  42 +-
>  drivers/iio/accel/Makefile                         |   6 +
>  drivers/iio/accel/bmc150-accel-core.c              |  20 +-
>  drivers/iio/accel/kxcjk-1013.c                     |  20 +-
>  drivers/iio/accel/mma7455.h                        |  19 +
>  drivers/iio/accel/mma7455_core.c                   | 311 ++++++++
>  drivers/iio/accel/mma7455_i2c.c                    |  56 ++
>  drivers/iio/accel/mma7455_spi.c                    |  52 ++
>  drivers/iio/accel/mma8452.c                        |  21 +-
>  drivers/iio/accel/mma9551.c                        |  19 +-
>  drivers/iio/accel/mma9553.c                        |  20 +-
>  drivers/iio/accel/mxc6255.c                        | 198 +++++
>  drivers/iio/accel/st_accel.h                       |   1 +
>  drivers/iio/accel/st_accel_core.c                  |   1 +
>  drivers/iio/accel/st_accel_i2c.c                   |   5 +
>  drivers/iio/accel/st_accel_spi.c                   |   1 +
>  drivers/iio/adc/Kconfig                            |  18 +
>  drivers/iio/adc/Makefile                           |   2 +
>  drivers/iio/adc/ad7793.c                           |   5 +-
>  drivers/iio/adc/at91_adc.c                         |   2 +-
>  drivers/iio/adc/mcp320x.c                          |  28 +
>  drivers/iio/adc/palmas_gpadc.c                     | 859 +++++++++++++++++++++
>  drivers/iio/adc/ti-ads8688.c                       | 486 ++++++++++++
>  drivers/iio/adc/xilinx-xadc-core.c                 |   2 +-
>  drivers/iio/buffer/Kconfig                         |  20 +
>  drivers/iio/buffer/Makefile                        |   2 +
>  drivers/iio/buffer/industrialio-buffer-dma.c       | 683 ++++++++++++++++
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 213 +++++
>  drivers/iio/dummy/Kconfig                          |  35 +
>  drivers/iio/dummy/Makefile                         |  10 +
>  .../{staging/iio => iio/dummy}/iio_dummy_evgen.c   |   0
>  .../{staging/iio => iio/dummy}/iio_dummy_evgen.h   |   0
>  .../{staging/iio => iio/dummy}/iio_simple_dummy.c  |   0
>  .../{staging/iio => iio/dummy}/iio_simple_dummy.h  |   0
>  .../iio => iio/dummy}/iio_simple_dummy_buffer.c    |   0
>  .../iio => iio/dummy}/iio_simple_dummy_events.c    |   0
>  drivers/iio/gyro/adis16136.c                       |   4 +-
>  drivers/iio/gyro/bmg160_core.c                     |  19 +-
>  drivers/iio/imu/adis16400_core.c                   |   6 +-
>  drivers/iio/imu/adis16480.c                        |   4 +-
>  drivers/iio/imu/kmx61.c                            |  24 +-
>  drivers/iio/industrialio-buffer.c                  |  58 +-
>  drivers/iio/industrialio-core.c                    |   9 +
>  drivers/iio/light/lm3533-als.c                     |   4 +-
>  drivers/iio/light/pa12203001.c                     |  16 +-
>  drivers/iio/light/rpr0521.c                        |  14 +-
>  drivers/iio/magnetometer/bmc150_magn.c             |  20 +-
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |  56 +-
>  drivers/staging/iio/Kconfig                        |  28 -
>  drivers/staging/iio/Makefile                       |   7 -
>  drivers/staging/iio/adc/ad7780.c                   |  36 +-
>  drivers/staging/iio/adc/ad7780.h                   |  30 -
>  drivers/staging/iio/adc/mxs-lradc.c                |   2 +-
>  include/linux/iio/buffer-dma.h                     | 152 ++++
>  include/linux/iio/buffer-dmaengine.h               |  18 +
>  include/linux/iio/buffer.h                         |  16 +
>  include/linux/mfd/palmas.h                         |  75 +-
>  64 files changed, 3625 insertions(+), 237 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8688.txt
>  create mode 100644 drivers/iio/accel/mma7455.h
>  create mode 100644 drivers/iio/accel/mma7455_core.c
>  create mode 100644 drivers/iio/accel/mma7455_i2c.c
>  create mode 100644 drivers/iio/accel/mma7455_spi.c
>  create mode 100644 drivers/iio/accel/mxc6255.c
>  create mode 100644 drivers/iio/adc/palmas_gpadc.c
>  create mode 100644 drivers/iio/adc/ti-ads8688.c
>  create mode 100644 drivers/iio/buffer/industrialio-buffer-dma.c
>  create mode 100644 drivers/iio/buffer/industrialio-buffer-dmaengine.c
>  create mode 100644 drivers/iio/dummy/Kconfig
>  create mode 100644 drivers/iio/dummy/Makefile
>  rename drivers/{staging/iio => iio/dummy}/iio_dummy_evgen.c (100%)
>  rename drivers/{staging/iio => iio/dummy}/iio_dummy_evgen.h (100%)
>  rename drivers/{staging/iio => iio/dummy}/iio_simple_dummy.c (100%)
>  rename drivers/{staging/iio => iio/dummy}/iio_simple_dummy.h (100%)
>  rename drivers/{staging/iio => iio/dummy}/iio_simple_dummy_buffer.c (100%)
>  rename drivers/{staging/iio => iio/dummy}/iio_simple_dummy_events.c (100%)
>  delete mode 100644 drivers/staging/iio/adc/ad7780.h
>  create mode 100644 include/linux/iio/buffer-dma.h
>  create mode 100644 include/linux/iio/buffer-dmaengine.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

