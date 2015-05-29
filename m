Return-Path: <rodriguez.twister@gmail.com>
From: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
To: jic23@kernel.org,
	daniel.baluta@intel.com,
	dan.carpenter@oracle.com,
	gregkh@linuxfoundation.org
Cc: cristina.opriceana@gmail.com,
	driverdev-devel@linuxdriverproject.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 0/3] staging: iio_simple_dummy: minor driver fixes
Date: Sat, 30 May 2015 00:45:20 +0300
Message-Id: <1432935923-28928-1-git-send-email-rodriguez.twister@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

v2 Fixed the code as per the comments from version 1:
	* Removed unnecessary comments
	* Fixed the label name to address label location
	* Changed the type of functions, which always return 0 to void

Vladimirs Ambrosovs (3):
  staging: iio_simple_dummy: fix init function
  staging: iio_simple_dummy: fix return types
  staging: iio_simple_dummy: fix module_param type

 drivers/staging/iio/iio_dummy_evgen.c         |  4 +---
 drivers/staging/iio/iio_simple_dummy.c        | 21 +++++++++++----------
 drivers/staging/iio/iio_simple_dummy_events.c |  4 +---
 3 files changed, 13 insertions(+), 16 deletions(-)

-- 
2.4.1
