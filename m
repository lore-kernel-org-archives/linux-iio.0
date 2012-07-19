Return-Path: <srinivas.pandruvada@intel.com>
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	jkosina@suse.cz,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 0/9] HID-Sensor v5
Date: Thu, 19 Jul 2012 11:17:22 -0700
Message-Id: <1342721851-2655-1-git-send-email-srinivas.pandruvada@intel.com>
List-ID: <linux-iio@vger.kernel.org>

v5:
- Documentation changes as suggested by Peter Meerwald and Jontathan Cameron
- Change Kconfigs to corrected typo pointed by David Herrmann (3G to 3D (3-dimension))

- Sensor framework changes for comments from Jonathan
-- Modified help to for HID_SENSOR_HUB
-- Removed all size restrictions (#define ...)
-- Use of kasprintf for driver names
-- Removed defines for reports
-- kernel doc for structures
-- Embed pending structure to sensor hub data structure and removed dynamic allocation of requests
-- Removed unused structure fields
-- Blank line before returns
-- Shorter defines for HID sensor usage id defines

- Common attributes and triggers
-- Removed maximunm sampling freq restrictions
-- Allow decimal format from channel raw read calls with micro fractions
-- Can't get arround FW quirk config with the information from report

- Accelerometer 3D support
-- Changed defines for channels to enums
-- Added hysteresis and sampling frequency to channels definition
-- Simpliefiled state structure
-- Removed casts
-- Error handling
-- Removed channel mask settings
-- Changed to module_platform_driver

v4:
Addressed comments from Lars-Peter Clausen and Jiri Kosina.
- Added Documentation/hid/hid-sensor.txt
- As suggested, created iio/common folder which can contain common code for iio sensor driver.This contain common module to process trigger and attributes
- Removed empty callback functions.
- Duplicating channel structure for an IIO driver instance.

v3 :
- Using TRIGGERRED BUFFER
- Using MFD framework
The sensor hub driver is submiited to drivers/hid. This contains core processing of hid sensor
usage table, registers as an hid driver and adds registration function for routing data
to individual sensor driver. So core driver independent of user mode interface method (IIO/input etc.)

- Submiiting four drivers for Accelerometer-3D, Gyro-3D, Compass-3D and ALS. These uses IIO triggered
buffer interface. They are childrens of hid sensor hub driver.
They reside in iio/accel, iio/gyro iio/magnetometer and iio/light.

- Still using driver/staging/iio. Not able to test with driver/iio.

v2 :
- Replaced Ring-SW with KFiFO
- Accel-3d, Gyro-3D and Compass-3D uses 3 different channels for X, Y and Z
- SysFS (
--- Changed "polling_interval" to sampling_frequency (IIO_DEV_ATTR_SAMP_FREQ) with units HZ
--- Changed "sensitivity" to hyst_raw, which is already used by some ADC modules
--- Removed "Activate". No longer need this. Using trigger state to activate/deactivate
)
- Removed sysfs attributes for "xxx_offset". Instead using mask 0 in read_raw. So each
sensor have only channels, sampling_frequency and hyst_raw as the ABI.
- Additional patch to enable ST Micro sensor hub-

v1:
Base implementation for comments


srinivas pandruvada (9):
  IIO: core: Add hysteresis in channel spec
  HID-Sensors: Documentation
  HID Sensors: Add to special driver list
  HID-Sensors: Sensor framework
  HID-Sensors: Common attribute and trigger
  HID-Sensors: Added accelerometer 3D
  HID-Sensors: Added Gyroscope 3D
  HID-Sensors: Added Compass/Magnetometer 3D
  HID-Sensors: Added ALS

 Documentation/hid/hid-sensor.txt                   |  139 ++++
 drivers/hid/Kconfig                                |   14 +
 drivers/hid/Makefile                               |    1 +
 drivers/hid/hid-core.c                             |   10 +
 drivers/hid/hid-ids.h                              |    6 +
 drivers/hid/hid-sensor-hub.c                       |  681 ++++++++++++++++++++
 drivers/iio/Kconfig                                |    5 +
 drivers/iio/Makefile                               |    5 +
 drivers/iio/accel/Kconfig                          |   16 +
 drivers/iio/accel/Makefile                         |    6 +
 drivers/iio/accel/hid-sensor-accel-3d.c            |  431 +++++++++++++
 drivers/iio/common/Kconfig                         |    6 +
 drivers/iio/common/Makefile                        |    9 +
 drivers/iio/common/hid-sensors/Kconfig             |   26 +
 drivers/iio/common/hid-sensors/Makefile            |    6 +
 .../iio/common/hid-sensors/hid-sensor-attributes.c |  277 ++++++++
 .../iio/common/hid-sensors/hid-sensor-attributes.h |   58 ++
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  103 +++
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |   25 +
 drivers/iio/gyro/Kconfig                           |   16 +
 drivers/iio/gyro/Makefile                          |    6 +
 drivers/iio/gyro/hid-sensor-gyro-3d.c              |  431 +++++++++++++
 drivers/iio/industrialio-core.c                    |    1 +
 drivers/iio/light/Kconfig                          |   16 +
 drivers/iio/light/Makefile                         |    6 +
 drivers/iio/light/hid-sensor-als.c                 |  397 ++++++++++++
 drivers/iio/magnetometer/Kconfig                   |   16 +
 drivers/iio/magnetometer/Makefile                  |    6 +
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      |  431 +++++++++++++
 include/linux/hid-sensor-hub.h                     |  160 +++++
 include/linux/hid-sensor-ids.h                     |  111 ++++
 include/linux/iio/iio.h                            |    5 +
 32 files changed, 3426 insertions(+), 0 deletions(-)
 create mode 100755 Documentation/hid/hid-sensor.txt
 create mode 100644 drivers/hid/hid-sensor-hub.c
 create mode 100644 drivers/iio/accel/Kconfig
 create mode 100644 drivers/iio/accel/Makefile
 create mode 100644 drivers/iio/accel/hid-sensor-accel-3d.c
 create mode 100644 drivers/iio/common/Kconfig
 create mode 100644 drivers/iio/common/Makefile
 create mode 100644 drivers/iio/common/hid-sensors/Kconfig
 create mode 100644 drivers/iio/common/hid-sensors/Makefile
 create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-attributes.c
 create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-attributes.h
 create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-trigger.c
 create mode 100644 drivers/iio/common/hid-sensors/hid-sensor-trigger.h
 create mode 100644 drivers/iio/gyro/Kconfig
 create mode 100644 drivers/iio/gyro/Makefile
 create mode 100644 drivers/iio/gyro/hid-sensor-gyro-3d.c
 create mode 100644 drivers/iio/light/Kconfig
 create mode 100644 drivers/iio/light/Makefile
 create mode 100644 drivers/iio/light/hid-sensor-als.c
 create mode 100644 drivers/iio/magnetometer/Kconfig
 create mode 100644 drivers/iio/magnetometer/Makefile
 create mode 100644 drivers/iio/magnetometer/hid-sensor-magn-3d.c
 create mode 100644 include/linux/hid-sensor-hub.h
 create mode 100644 include/linux/hid-sensor-ids.h

-- 
1.7.7.6
