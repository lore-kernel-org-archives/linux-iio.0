Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 0/2] tools: iio: generic_buffer fixes
Date: Thu, 23 Jul 2015 20:22:50 +0300
Message-Id: <1437672172-21189-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Fixes for a couple of small issues found while testing the
bmc150_magn driver.

Irina Tirdea (2):
  tools: iio: fix mask for 32 bit sensor data
  tools: iio: print error message when buffer enable fails

 tools/iio/generic_buffer.c | 5 ++++-
 tools/iio/iio_utils.c      | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
1.9.1
