Return-Path: <robert.dolca@intel.com>
From: Robert Dolca <robert.dolca@intel.com>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Robert Dolca <robert.dolca@intel.com>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: [PATCH RFC 0/3] Add IIO trigger symlink in iio:device0/trigger/
Date: Thu, 16 Apr 2015 12:01:05 +0300
Message-Id: <1429174868-11953-1-git-send-email-robert.dolca@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Currently the user space applications write the trigger name in the
current_trigger file. The user space application should know what trigger to
use. The association can be manually configured or can be "detected" based
on the trigger's name if the triggers name has the device's index in the name
or any other custom and unstandard convention.

This issue is being fixed by these patches. They create a symlink in the
device's trigger folder for all triggers registered by the device.

/ # ls -l /sys/bus/iio/devices/iio:device0/trigger/
total 0
-rw-r--r--    1 root     root          4096 Apr 16 08:33 current_trigger
lrwxrwxrwx    1 root     root             0 Apr 16 08:33 trigger0 -> ../../trigg
er0

This way the user space application can know what triggers were registered by
the device.

The 1st patch adds the main functionality (creating symlink if the trigger was
registered before the device was registered).

The 2nd patch improves the functionality allowing to register a trigger after
the IIO device was registered and the symlink is being created.

In the final patch there is an example on how to use this new API.

Robert Dolca (3):
  iio: Add symlink to triggers in the devoce's trigger folder
  iio: Improve iio_trigger_register_with_dev to register trigger after
    device
  iio: Use with iio_trigger_register_with_dev to register trigger

 drivers/iio/common/st_sensors/st_sensors_trigger.c |  2 +-
 drivers/iio/industrialio-core.c                    | 24 ++++++++
 drivers/iio/industrialio-trigger.c                 | 70 ++++++++++++++++++++++
 include/linux/iio/iio.h                            |  2 +
 include/linux/iio/trigger.h                        | 24 ++++++++
 5 files changed, 121 insertions(+), 1 deletion(-)

-- 
1.9.1
