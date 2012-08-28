Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40173 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab2H1Tes (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Aug 2012 15:34:48 -0400
Message-ID: <503D1D4F.2030805@kernel.org>
Date: Tue, 28 Aug 2012 20:34:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
CC: linux-iio@vger.kernel.org, jkosina@suse.cz,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/9] HID-Sensor v8
References: <1346082597-768-1-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1346082597-768-1-git-send-email-srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I am pretty happy with the whole series now, so next question from
my end is what route this takes into the kernel?

Patch 1 should go through the IIO tree (as it touches
a fairly high churn area of the IIO core).

2-4 are very much in HID...
5-9 very much IIO.

My personal preference is to take the lot though the IIO tree
but then I know we have a few patches in the pipeline that will
touch this driver after it merges (internal api changes) and have
no idea what is going on from the HID side so naturally I full on
the side of least work for me :)

Jiri what are you thoughts on this series?

CC'd Greg given he's the one who will get the fishy pull request
from me if it goes though IIO...

> v8:
> - Rebase against staging-next
> - Kernel doc generation warnings
> - Makefile single line/driver
> - Some stubtle warnings on some platforms
> 
> v7:
> - Changes related to pow function
> - channel spec constant for sensors
> - Remove additional init/exit functions
> - Error handling for invalid report ids
>   	
> v6:
> - Fix kernel oops during mfd_add_device on some devices
> - Jonathan's suggested change to remove private member from common to associate a sensor type state. The
> sensor state contains a member to hold all common attributes
> - Fix issue with decimal point interface
> 
> v5:
> - Documentation changes as suggested by Peter Meerwald and Jonathan Cameron
> - Change Kconfigs to corrected typo pointed by David Herrmann (3G to 3D (3-dimension))
> 
> - Sensor framework changes for comments from Jonathan
> -- Modified help to for HID_SENSOR_HUB
> -- Removed all size restrictions (#define ...)
> -- Use of kasprintf for driver names
> -- Removed defines for reports
> -- kernel doc for structures
> -- Embed pending structure to sensor hub data structure and removed dynamic allocation of requests
> -- Removed unused structure fields
> -- Blank line before returns
> -- Shorter defines for HID sensor usage id defines
> 
> - Common attributes and triggers
> -- Removed maximunm sampling freq restrictions
> -- Allow decimal format from channel raw read calls with micro fractions
> -- Can't get arround FW quirk config with the information from report
> 
> - Accelerometer 3D support
> -- Changed defines for channels to enums
> -- Added hysteresis and sampling frequency to channels definition
> -- Simpliefiled state structure
> -- Removed casts
> -- Error handling
> -- Removed channel mask settings
> -- Changed to module_platform_driver
> 
> v4:
> Addressed comments from Lars-Peter Clausen and Jiri Kosina.
> - Added Documentation/hid/hid-sensor.txt
> - As suggested, created iio/common folder which can contain common code for iio sensor driver.This contain common module to process trigger and attributes
> - Removed empty callback functions.
> - Duplicating channel structure for an IIO driver instance.
> 
> v3 :
> - Using TRIGGERRED BUFFER
> - Using MFD framework
> The sensor hub driver is submiited to drivers/hid. This contains core processing of hid sensor
> usage table, registers as an hid driver and adds registration function for routing data
> to individual sensor driver. So core driver independent of user mode interface method (IIO/input etc.)
> 
> - Submiiting four drivers for Accelerometer-3D, Gyro-3D, Compass-3D and ALS. These uses IIO triggered
> buffer interface. They are childrens of hid sensor hub driver.
> They reside in iio/accel, iio/gyro iio/magnetometer and iio/light.
> 
> - Still using driver/staging/iio. Not able to test with driver/iio.
> 
> v2 :
> - Replaced Ring-SW with KFiFO
> - Accel-3d, Gyro-3D and Compass-3D uses 3 different channels for X, Y and Z
> - SysFS (
> --- Changed "polling_interval" to sampling_frequency (IIO_DEV_ATTR_SAMP_FREQ) with units HZ
> --- Changed "sensitivity" to hyst_raw, which is already used by some ADC modules
> --- Removed "Activate". No longer need this. Using trigger state to activate/deactivate
> )
> - Removed sysfs attributes for "xxx_offset". Instead using mask 0 in read_raw. So each
> sensor have only channels, sampling_frequency and hyst_raw as the ABI.
> - Additional patch to enable ST Micro sensor hub-
> 
> v1:
> Base implementation for comments
> 
> srinivas pandruvada (9):
>   IIO: core: Add hysteresis in channel spec
>   HID-Sensors: Documentation
>   HID Sensors: Add to special driver list
>   HID-Sensors: Sensor framework
>   HID-Sensors: Common attribute and trigger
>   HID-Sensors: Added accelerometer 3D
>   HID-Sensors: Added Gyroscope 3D
>   HID-Sensors: Added Compass/Magnetometer 3D
>   HID-Sensors: Added ALS
> 
>  Documentation/hid/hid-sensor.txt                   |  139 ++++
>  drivers/hid/Kconfig                                |   14 +
>  drivers/hid/Makefile                               |    1 +
>  drivers/hid/hid-core.c                             |   10 +
>  drivers/hid/hid-ids.h                              |    6 +
>  drivers/hid/hid-sensor-hub.c                       |  682 ++++++++++++++++++++
>  drivers/iio/Kconfig                                |    5 +
>  drivers/iio/Makefile                               |    5 +
>  drivers/iio/accel/Kconfig                          |   16 +
>  drivers/iio/accel/Makefile                         |    5 +
>  drivers/iio/accel/hid-sensor-accel-3d.c            |  419 ++++++++++++
>  drivers/iio/common/Kconfig                         |    6 +
>  drivers/iio/common/Makefile                        |    9 +
>  drivers/iio/common/hid-sensors/Kconfig             |   26 +
>  drivers/iio/common/hid-sensors/Makefile            |    6 +
>  .../iio/common/hid-sensors/hid-sensor-attributes.c |  250 +++++++
>  .../iio/common/hid-sensors/hid-sensor-attributes.h |   57 ++
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    |  102 +++
>  .../iio/common/hid-sensors/hid-sensor-trigger.h    |   26 +
>  drivers/iio/gyro/Kconfig                           |   16 +
>  drivers/iio/gyro/Makefile                          |    5 +
>  drivers/iio/gyro/hid-sensor-gyro-3d.c              |  419 ++++++++++++
>  drivers/iio/industrialio-core.c                    |    1 +
>  drivers/iio/light/Kconfig                          |   10 +
>  drivers/iio/light/Makefile                         |    1 +
>  drivers/iio/light/hid-sensor-als.c                 |  386 +++++++++++
>  drivers/iio/magnetometer/Kconfig                   |   16 +
>  drivers/iio/magnetometer/Makefile                  |    5 +
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c      |  420 ++++++++++++
>  include/linux/hid-sensor-hub.h                     |  160 +++++
>  include/linux/hid-sensor-ids.h                     |  111 ++++
>  include/linux/iio/iio.h                            |    5 +
>  32 files changed, 3339 insertions(+), 0 deletions(-)
>  create mode 100755 Documentation/hid/hid-sensor.txt
>  create mode 100644 drivers/hid/hid-sensor-hub.c
>  create mode 100644 drivers/iio/accel/Kconfig
>  create mode 100644 drivers/iio/accel/Makefile
>  create mode 100644 drivers/iio/accel/hid-sensor-accel-3d.c
>  create mode 100644 drivers/iio/common/Kconfig
>  create mode 100644 drivers/iio/common/Makefile
>  create mode 100644 drivers/iio/common/hid-sensors/Kconfig
>  create mode 100644 drivers/iio/common/hid-sensors/Makefile
>  create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>  create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-attributes.h
>  create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>  create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-trigger.h
>  create mode 100644 drivers/iio/gyro/Kconfig
>  create mode 100644 drivers/iio/gyro/Makefile
>  create mode 100644 drivers/iio/gyro/hid-sensor-gyro-3d.c
>  create mode 100644 drivers/iio/light/hid-sensor-als.c
>  create mode 100644 drivers/iio/magnetometer/Kconfig
>  create mode 100644 drivers/iio/magnetometer/Makefile
>  create mode 100644 drivers/iio/magnetometer/hid-sensor-magn-3d.c
>  create mode 100644 include/linux/hid-sensor-hub.h
>  create mode 100644 include/linux/hid-sensor-ids.h
> 
