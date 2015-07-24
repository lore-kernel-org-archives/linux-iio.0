Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 0/2] tools: iio: generic_buffer fixes
Date: Fri, 24 Jul 2015 16:28:04 +0300
Message-Id: <1437744486-16456-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Fixes for a couple of small issues found while testing the
bmc150_magn driver.

Changes in v2:
 - use ret instead of errno to print error message
 - add Hartmut's Ack for the first patch

Irina Tirdea (2):
  tools: iio: fix mask for 32 bit sensor data
  tools: iio: print error message when buffer enable fails

 tools/iio/generic_buffer.c | 5 ++++-
 tools/iio/iio_utils.c      | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
1.9.1
