Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 0/4] Added LTR501 Interrupt support
Date: Wed,  1 Apr 2015 20:51:43 -0700
Message-Id: <cover.1427945689.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset adds interrupt support for LTR501 chip. Also
added acpi enumaration support.

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

Daniel Baluta (1):
  iio: light: ltr501: Fix alignment to match open parenthesis

Kuppuswamy Sathyanarayanan (3):
  iio: ltr501: Add interrupt support
  iio: ltr501: Add interrupt rate control support
  iio: ltr501: Add ACPI enumeration support

 drivers/iio/light/ltr501.c | 469 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 445 insertions(+), 24 deletions(-)

-- 
1.9.1
