Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v3 0/6] Added LTR501 Interrupt support
Date: Wed,  8 Apr 2015 17:06:04 -0700
Message-Id: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset adds interrupt support and acpi enumeration support for
LTR-501 chip.

Also added a new event option (IIO_EV_INFO_PERSISTENCE) to specifcy
threshold interrupt persistence filter value. Currently, we don't
have any way to specify the persistence filter value in iio event
framework. Many drivers use channel ext info to work around this
issue. This patch adds this option to event info list.

I was suggested to use IIO_EV_INFO_PERIOD for this purpose. But it
is not a valid option for this use case because, IIO_EV_INFO_PERIOD
specifies period value in 'seconds'. But this option needs to represent
the value as "counts".

Please let me know your review comments.

v1:
1. Added support to enable ALS & PS intterupts based 
   on threshold settings.
2. Added support to control intrrupt rate.
3. Added acpi enumeration support.

v2:
1. Removed persistance attribute from ext_channel and
   added support for IIO_EV_INFO_PERIOD.
2. Rebased my patches on top of Daniel's alignment fix.

v3:
1. Added a new ABI to define threshold interrupt persistence
   filter value.
2. Added Documentation for persistence filter iio ABI
3. Used IIO_EV_INFO_PERSISTENCE instead of IIO_EV_INFO_PERIOD
   in ltr501 driver.

Daniel Baluta (1):
  iio: light: ltr501: Fix alignment to match open parenthesis

Kuppuswamy Sathyanarayanan (5):
  iio: core : events ABI for specifying interrupt persistence
  iio: documentation: Add ABI info for iio event persistence filter
  iio: ltr501: Add interrupt support
  iio: ltr501: Add interrupt rate control support
  iio: ltr501: Add ACPI enumeration support

 Documentation/ABI/testing/sysfs-bus-iio |  82 ++++++
 drivers/iio/industrialio-event.c        |   1 +
 drivers/iio/light/ltr501.c              | 469 ++++++++++++++++++++++++++++++--
 include/linux/iio/types.h               |   1 +
 4 files changed, 529 insertions(+), 24 deletions(-)

-- 
1.9.1
