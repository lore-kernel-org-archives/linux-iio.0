Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38653 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754268AbaIPD6H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Sep 2014 23:58:07 -0400
From: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v7 0/1] iio: jsa1212: Add JSA1212 proximity/ALS sensor
Date: Mon, 15 Sep 2014 20:54:07 -0700
Message-Id: <cover.1410839445.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Please let me know your review comments.

PATCH v7 changes:

Fixed a check patch warning.

PATCH v6 changes:

Addressed comments from Peter & Hartmut. Mainly, 
1. Removed duplicate header files
2. Renamed IRDR settings macro names
3. Simplified endian conversion expression
4. Refactored the code in many sections to remove
   unncessary breaks statements and returns.
5. Renamed jsa1212 priv data variable name in probe function.

PATCH v5 changes:

1. Removed irq.h and interrupt.h.
2. Disabled the device under error condition when reading data.
3. Added TODO and slave address info in file header.

PATCH v4 changes:

1. Removed unused register defines
2. Used standard endian conversion function instead of custom one.
3. Replaced register default value constants with appropriate bit value macros.
4. Removed iio user interfaces before powering off the device in remove function.

PATCH v3 changes:

1. Replaced status flags with bool values.
2. Added regmap suppport to avoid adding custom i2c register update routine.
3. Also addressed some minor comments from Jonathan Cameron

PATCH v2 changes:

1. Combined ALS/PXS enable/disable functions into a single routine.
2. Removed extra debug messages.
3. Also addressed review comments from Peter Meerwald

Kuppuswamy Sathyanarayanan (1):
  iio: jsa1212: Add JSA1212 proximity/ALS sensor

 drivers/iio/light/Kconfig   |  10 +
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/jsa1212.c | 471 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 482 insertions(+)
 create mode 100644 drivers/iio/light/jsa1212.c

-- 
1.9.1

