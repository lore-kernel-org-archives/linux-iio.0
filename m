Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 0/5] Added LTR501 Interrupt support
Date: Fri, 17 Apr 2015 22:15:09 -0700
Message-Id: <cover.1429326499.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset adds Integration time, sampling frequency, interrupt
and acpi enumeration support for LTR-501 chip.

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

v4:
1. Added regmap support to handle register bitwise updates easily.
2. Added support to change integration time from user code.
3. Modified threshold interrupt persistence code to use IIO_EV_INFO_PERIOD
   values.
4. Added support to change sampling frequency from user code
5. Addressed Jonathan's comments

Kuppuswamy Sathyanarayanan (5):
  iio: ltr501: Add regmap support.
  iio: ltr501: Add integration time support
  iio: ltr501: Add interrupt support
  iio: ltr501: Add interrupt rate control support
  iio: ltr501: Add ACPI enumeration support

 drivers/iio/light/ltr501.c | 894 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 853 insertions(+), 41 deletions(-)

-- 
1.9.1
