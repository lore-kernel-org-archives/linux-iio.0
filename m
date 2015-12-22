Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48798 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbbLVSpu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2015 13:45:50 -0500
Subject: Re: [PULL] Second set of IIO new core stuff and drivers for the 4.5
 cycle
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <566D7F68.4010109@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56799A5A.9030405@kernel.org>
Date: Tue, 22 Dec 2015 18:45:46 +0000
MIME-Version: 1.0
In-Reply-To: <566D7F68.4010109@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

I'm going to send you a pull request that builds on top of this one as
our final IIO one for this cycle. It's pretty small but involves at
least one fix for a patch in this cycle.

If you particularly want me to combine them into a single pull request
then give me a shout.

Jonathan

On 13/12/15 14:23, Jonathan Cameron wrote:
> The following changes since commit f3cf3fb7ec854c2b2429e5bb23186746e6511dae:
> 
>   Merge tag 'iio-for-4.5a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2015-12-01 09:13:29 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.5b
> 
> for you to fetch changes up to c34c18195d30aa3b95f5ae1b4349875c45fdb8e4:
> 
>   iio/inkern.c Use list_for_each_entry_safe (2015-12-12 17:23:37 +0000)
> 
> ----------------------------------------------------------------
> Second set of IIO new drivers, functionality and cleanups for the 4.5 cycle.
> 
> The big one here is the configfs support which has been a long time in the
> works but should allow for cleaner ways to do instantiation of those elements
> of IIO that aren't directly connected to specific hardware. Lots of cool new
> stuff we can use this for in the works!
> 
> New core stuff (basically all configfs support related)
> * Configfs support
>   - Core support (was waiting for a configfs patch that went in around 4.4rc2)
>   - A little fixlet to add a configfs.h to contain a reference to the
>     configfs_subsystem structure.
> * Some infrastructure to simplify handling of software based triggers
>   (i.e. ones with no actual hardware associated with them)
> * A high resolution timer based trigger.  This has been around for years
>     but until the configfs support was ready we didn't have a sensible way
>     of instantiating instances of it (the method used for the sysfs_trigger
>     has never been really satisfactory)
> 
> New Device Support
> * AMS iAQ Volatile Organic Compounds sensor support.
> * Freescale imx7d ADC driver
> * Maxim MAX30100 oximeter driver (note that for these devices most of the
>   smart stuff will be in userspace - effectively they are just light sensors
>   with some interesting led synchronization as far as the kernel is concerned).
> * Microchip mcp3421 support added to the mcp3422 driver.
> * TI adc124s021 support added to the adc128s052 driver.
> * TI ina219, inda226 power monitors. Note that there is an existing hwmon driver
>   for these parts, the usecase is somewhat different so it is unclear at this
>   point if the hwmon driver will eventually be replaced by a bridge from
>   this driver.  In the meantime the Kconfig dependencies should prevent both
>   from being built.
> 
> New driver functionality
> * us8152d power management support.
> 
> Cleanups, fixups
> * Use list_for_each_entry_safe instead of list_for_each_safe with the entry
>   bit coded longhand.
> * Select IRQ_WORK for IIO_DUMMY_EVGEN.  This is a fix that somehow got lost
>   when the driver was moved so lets do it again.
> * st-accel - drop an unused define.
> * vz89x, lidar - optimize i2c transactions by using a single i2c tranfers
>   instead of multiple calls where supported (fall back to smbus calls as
>   before if not).
> * Use dev_get_platdata() in staging drivers: tsl2x7x, adcs and frequency
>   drivers instead of direct access to the structure element.
> 
> ----------------------------------------------------------------
> Adriana Reus (4):
>       iio: light: us5182d: Add property for choosing default power mode
>       Documentation: devicetree: Add property for controlling power saving mode for the us5182 als sensor
>       iio: light: us5182d: Add functions for selectively enabling als and proximity
>       iio: light: us8152d: Add power management support
> 
> Anshul Garg (1):
>       iio/inkern.c Use list_for_each_entry_safe
> 
> Arnd Bergmann (1):
>       staging: iio: select IRQ_WORK for IIO_DUMMY_EVGEN
> 
> Daniel Baluta (4):
>       iio: core: Introduce IIO configfs support
>       iio: core: Introduce IIO software triggers
>       iio: trigger: Introduce IIO hrtimer based trigger
>       iio: Documentation: Add IIO configfs documentation
> 
> Haibo Chen (2):
>       iio: adc: add IMX7D ADC driver support
>       Documentation: add the binding file for Freescale imx7d ADC driver
> 
> Jonathan Cameron (1):
>       iio:configfs: Introduce iio/configfs.h to provide a location for the configfs_subsystem
> 
> Marc Titinger (4):
>       iio: ina2xx: add support for TI INA2xx Power Monitors
>       iio: ina2xx: provide a sysfs parameter to allow async readout of the ADCs
>       iio: ina2xx: re-instate a sysfs show/store for the shunt resistor value
>       iio: ina2xx: give the capture kthread a more useful name string.
> 
> Matt Ranostay (4):
>       iio: chemical: vz89x: rework i2c transfer reading
>       iio: proximity: lidar: optimize i2c transactions
>       iio: light: add MAX30100 oximeter driver support
>       iio: chemical: add AMS iAQ-core support
> 
> Nizam Haider (3):
>       Staging: iio: adc: use dev_get_platdata()
>       Staging: iio: light: tsl2x7x_core: use dev_get_platdata()
>       Staging: iio: frequency: use dev_get_platdata()
> 
> Oliver Stäbler (1):
>       iio:adc128s052: add support for adc124s021
> 
> Robert Kmiec (1):
>       iio: st_accel_core: Remove unneeded define
> 
> Sascha Hauer (2):
>       iio: adc: mcp3422: Add mcp3421 support
>       dt-bindings: iio: adc: Update mcp342x binding for the mcp3421
> 
>  Documentation/ABI/testing/configfs-iio             |  21 +
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>  .../devicetree/bindings/iio/adc/imx7d-adc.txt      |  22 +
>  .../devicetree/bindings/iio/adc/mcp3422.txt        |   3 +-
>  .../devicetree/bindings/iio/adc/ti-adc128s052.txt  |   4 +-
>  .../devicetree/bindings/iio/health/max30100.txt    |  21 +
>  .../devicetree/bindings/iio/light/us5182d.txt      |  11 +
>  Documentation/iio/iio_configfs.txt                 |  93 +++
>  drivers/iio/Kconfig                                |  17 +
>  drivers/iio/Makefile                               |   3 +
>  drivers/iio/adc/Kconfig                            |  25 +-
>  drivers/iio/adc/Makefile                           |   2 +
>  drivers/iio/adc/imx7d_adc.c                        | 609 +++++++++++++++++
>  drivers/iio/adc/ina2xx-adc.c                       | 745 +++++++++++++++++++++
>  drivers/iio/adc/mcp3422.c                          |   9 +
>  drivers/iio/adc/ti-adc128s052.c                    |  13 +-
>  drivers/iio/chemical/Kconfig                       |   8 +
>  drivers/iio/chemical/Makefile                      |   1 +
>  drivers/iio/chemical/ams-iaq-core.c                | 200 ++++++
>  drivers/iio/chemical/vz89x.c                       |  66 +-
>  drivers/iio/common/st_sensors/st_sensors_core.c    |   3 -
>  drivers/iio/dummy/Kconfig                          |   3 +-
>  drivers/iio/health/Kconfig                         |  21 +
>  drivers/iio/health/Makefile                        |   7 +
>  drivers/iio/health/max30100.c                      | 453 +++++++++++++
>  drivers/iio/industrialio-configfs.c                |  51 ++
>  drivers/iio/industrialio-sw-trigger.c              | 184 +++++
>  drivers/iio/inkern.c                               |   6 +-
>  drivers/iio/light/us5182d.c                        | 243 ++++++-
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c  |  95 ++-
>  drivers/iio/trigger/Kconfig                        |  10 +
>  drivers/iio/trigger/Makefile                       |   2 +
>  drivers/iio/trigger/iio-trig-hrtimer.c             | 193 ++++++
>  drivers/staging/iio/adc/ad7192.c                   |   2 +-
>  drivers/staging/iio/adc/ad7280a.c                  |   2 +-
>  drivers/staging/iio/adc/ad7816.c                   |   2 +-
>  drivers/staging/iio/frequency/ad9832.c             |   2 +-
>  drivers/staging/iio/frequency/ad9834.c             |   2 +-
>  drivers/staging/iio/light/tsl2x7x_core.c           |   2 +-
>  include/linux/iio/configfs.h                       |  15 +
>  include/linux/iio/sw_trigger.h                     |  70 ++
>  41 files changed, 3163 insertions(+), 79 deletions(-)
>  create mode 100644 Documentation/ABI/testing/configfs-iio
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/health/max30100.txt
>  create mode 100644 Documentation/iio/iio_configfs.txt
>  create mode 100644 drivers/iio/adc/imx7d_adc.c
>  create mode 100644 drivers/iio/adc/ina2xx-adc.c
>  create mode 100644 drivers/iio/chemical/ams-iaq-core.c
>  create mode 100644 drivers/iio/health/Kconfig
>  create mode 100644 drivers/iio/health/Makefile
>  create mode 100644 drivers/iio/health/max30100.c
>  create mode 100644 drivers/iio/industrialio-configfs.c
>  create mode 100644 drivers/iio/industrialio-sw-trigger.c
>  create mode 100644 drivers/iio/trigger/iio-trig-hrtimer.c
>  create mode 100644 include/linux/iio/configfs.h
>  create mode 100644 include/linux/iio/sw_trigger.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

