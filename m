Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58014 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932373Ab2IFS1Y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Sep 2012 14:27:24 -0400
Message-ID: <5048EB0B.4000800@kernel.org>
Date: Thu, 06 Sep 2012 19:27:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
CC: linux-iio@vger.kernel.org, jkosina@suse.cz
Subject: Re: [PATCH 0/9] HID-Sensor v9
References: <1346849792-22417-1-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1346849792-22417-1-git-send-email-srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

add to the togreg branch of

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Will send them on to Greg in a day or so once I've caught
up with a few other pending patches.

Thanks,

Jonathan

> v9:
> - change commit messages
> - Trivial changes suggested by Jiri
> 
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
> - Jonathan's suggested change to remove private member from common to associate a \
> sensor type state. The sensor state contains a member to hold all common attributes
> - Fix issue with decimal point interface
> 
> v5:
> - Documentation changes as suggested by Peter Meerwald and Jonathan Cameron
> - Change Kconfigs to corrected typo pointed by David Herrmann (3G to 3D \
> (3-dimension)) 
> - Sensor framework changes for comments from Jonathan
> -- Modified help to for HID_SENSOR_HUB
> -- Removed all size restrictions (#define ...)
> -- Use of kasprintf for driver names
> -- Removed defines for reports
> -- kernel doc for structures
> -- Embed pending structure to sensor hub data structure and removed dynamic \
>                 allocation of requests
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
> - As suggested, created iio/common folder which can contain common code for iio \
>                 sensor driver.This contain common module to process trigger and \
>                 attributes
> - Removed empty callback functions.
> - Duplicating channel structure for an IIO driver instance.
> 
> v3 :
> - Using TRIGGERRED BUFFER
> - Using MFD framework
> The sensor hub driver is submiited to drivers/hid. This contains core processing of \
> hid sensor usage table, registers as an hid driver and adds registration function \
> for routing data to individual sensor driver. So core driver independent of user \
> mode interface method (IIO/input etc.) 
> - Submiiting four drivers for Accelerometer-3D, Gyro-3D, Compass-3D and ALS. These \
> uses IIO triggered buffer interface. They are childrens of hid sensor hub driver.
> They reside in iio/accel, iio/gyro iio/magnetometer and iio/light.
> 
> - Still using driver/staging/iio. Not able to test with driver/iio.
> 
> v2 :
> - Replaced Ring-SW with KFiFO
> - Accel-3d, Gyro-3D and Compass-3D uses 3 different channels for X, Y and Z
> - SysFS (
> --- Changed "polling_interval" to sampling_frequency (IIO_DEV_ATTR_SAMP_FREQ) with \
>                 units HZ
> --- Changed "sensitivity" to hyst_raw, which is already used by some ADC modules
> --- Removed "Activate". No longer need this. Using trigger state to \
> activate/deactivate )
> - Removed sysfs attributes for "xxx_offset". Instead using mask 0 in read_raw. So \
> each sensor have only channels, sampling_frequency and hyst_raw as the ABI.
> - Additional patch to enable ST Micro sensor hub-
> 
> v1:
> Base implementation for comments
> 
> srinivas pandruvada (9):
>   iio: core: Add hysteresis in channel spec
>   HID: sensors: add documentation
>   HID: sensors: add to special driver list
>   HID: sensors: introduce sensor framework
>   iio: hid-sensors: Common attribute and trigger
>   iio: hid-sensors: Added accelerometer 3D
>   iio: hid-sensors: Added Gyroscope 3D
>   iio: hid-sensors: Added Compass/Magnetometer 3D
>   iio: hid-sensors: Added ALS
> 
>  Documentation/hid/hid-sensor.txt                   | 140 +++++
>  drivers/hid/Kconfig                                |  14 +
>  drivers/hid/Makefile                               |   1 +
>  drivers/hid/hid-core.c                             |   5 +
>  drivers/hid/hid-ids.h                              |   6 +
>  drivers/hid/hid-sensor-hub.c                       | 695 +++++++++++++++++++++
>  drivers/iio/Kconfig                                |   5 +
>  drivers/iio/Makefile                               |   5 +
>  drivers/iio/accel/Kconfig                          |  16 +
>  drivers/iio/accel/Makefile                         |   5 +
>  drivers/iio/accel/hid-sensor-accel-3d.c            | 419 +++++++++++++
>  drivers/iio/common/Kconfig                         |   6 +
>  drivers/iio/common/Makefile                        |   9 +
>  drivers/iio/common/hid-sensors/Kconfig             |  26 +
>  drivers/iio/common/hid-sensors/Makefile            |   6 +
>  .../iio/common/hid-sensors/hid-sensor-attributes.c | 250 ++++++++
>  .../iio/common/hid-sensors/hid-sensor-attributes.h |  57 ++
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    | 102 +++
>  .../iio/common/hid-sensors/hid-sensor-trigger.h    |  26 +
>  drivers/iio/gyro/Kconfig                           |  16 +
>  drivers/iio/gyro/Makefile                          |   5 +
>  drivers/iio/gyro/hid-sensor-gyro-3d.c              | 419 +++++++++++++
>  drivers/iio/industrialio-core.c                    |   1 +
>  drivers/iio/light/Kconfig                          |  10 +
>  drivers/iio/light/Makefile                         |   1 +
>  drivers/iio/light/hid-sensor-als.c                 | 386 ++++++++++++
>  drivers/iio/magnetometer/Kconfig                   |  16 +
>  drivers/iio/magnetometer/Makefile                  |   5 +
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 420 +++++++++++++
>  include/linux/hid-sensor-hub.h                     | 160 +++++
>  include/linux/hid-sensor-ids.h                     | 112 ++++
>  include/linux/iio/iio.h                            |   5 +
>  32 files changed, 3349 insertions(+)
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
