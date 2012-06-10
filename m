Return-Path: <srinivas.pandruvada@intel.com>
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jiri Kosina <jkosina@suse.cz>,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 0/8] HID-Sensor: v2
Date: Sat,  9 Jun 2012 18:53:10 -0700
Message-Id: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Submitting v2.
Changes compared to version 1:

- Replaced Ring-SW with KFiFO
- Accel-3d, Gyro-3D and Compass-3D uses 3 different channels for X, Y and Z
- SysFS (
--- Changed "polling_interval" to sampling_frequency (IIO_DEV_ATTR_SAMP_FREQ) with units HZ
--- Changed "sensitivity" to hyst_raw, which is already used by some ADC modules
--- Removed "Activate". No longer need this. Using trigger state to activate/deactivate
)
- Removed sysfs attributes for "xxx_offset". Instead using mask 0 in read_raw. So each
sensor have only channels, sampling_frequency and hyst_raw as the ABI.
- Additional patch to enable ST Micro sensor hub 

TBD for v3
- Use Lars-Peter's patch: "v2 1/9 patch: Add helper function for initialize trigger buffers). Want to make sure
that API is final. 

DATA Format examples:
Had few questions on data format for floating point. This spec uses.
- First of size of each field is specified in report descriptor. So it is variable
- It uses VT_F16Ex format. For example VTF16E0 means 16 bit float with unit exponent 0. 
Refer to Page 43 of the "HID Sensor Usage Table"
For example, if the size is 16 bits
0xFFF4 with VTF16E14 format -> -0.12
0xFFF8 with VTF16E14 format -> -0.08
0x0067 with VTF16E14 format -> +1.03

I tried sensor hubs from two different makers. One use 16 bit and other uses 32 bit for accelerometer.
Also the unit expo is different for them. Also units are different.

Possible IIO addition:
I wish we can add two more items for unit and unit_expo in IIO_CHAN_INFO_XXXX. So that we can add
them during channel definition. Currently I am using offset and scale, which doesn't actually mean
this. I think conversion should be done is user space based on the info provided.


Srinivas pandruvada (5):
  HID-Sensors: Common attributes and interfaces
  HID-Sensors: Added accelerometer 3D
  HID-Sensors: Added Gyro 3D
  HID-Sensors: Added Compass 3D
  HID-Sensors: Added ALS

srinivas pandruvada (3):
  HID-Sensors: Add ST Micro Sensor hub
  HID-Sensors: Add Intel HID sensor
  HID-Sensors: Sensor framework

 drivers/hid/hid-core.c                             |    8 +
 drivers/hid/hid-ids.h                              |    6 +
 drivers/staging/Kconfig                            |    2 +
 drivers/staging/Makefile                           |    1 +
 drivers/staging/hid-sensors/Kconfig                |   19 +
 drivers/staging/hid-sensors/Makefile               |   16 +
 drivers/staging/hid-sensors/hid-sensor-accel-3d.c  |  375 ++++++++++
 drivers/staging/hid-sensors/hid-sensor-als.c       |  313 ++++++++
 .../staging/hid-sensors/hid-sensor-attributes.c    |  169 +++++
 .../staging/hid-sensors/hid-sensor-attributes.h    |   51 ++
 drivers/staging/hid-sensors/hid-sensor-buffer.c    |   98 +++
 .../staging/hid-sensors/hid-sensor-compass-3d.c    |  375 ++++++++++
 drivers/staging/hid-sensors/hid-sensor-gyro-3d.c   |  375 ++++++++++
 drivers/staging/hid-sensors/hid-sensor-hub.c       |  747 ++++++++++++++++++++
 drivers/staging/hid-sensors/hid-sensor-ids.h       |  117 +++
 drivers/staging/hid-sensors/hid-sensor-interface.h |   95 +++
 drivers/staging/hid-sensors/hid-sensor-trigger.c   |   83 +++
 17 files changed, 2850 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/hid-sensors/Kconfig
 create mode 100644 drivers/staging/hid-sensors/Makefile
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-accel-3d.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-als.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-attributes.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-attributes.h
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-buffer.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-compass-3d.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-gyro-3d.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-hub.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-ids.h
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-interface.h
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-trigger.c

-- 
1.7.7.6
