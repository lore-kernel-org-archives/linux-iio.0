Return-Path: <matt.ranostay@intel.com>
From: Matt Ranostay <matt.ranostay@intel.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <matt.ranostay@intel.com>
Subject: [PATCH 0/3] iio: pressure: bmp280: add BME280 part support
Date: Mon, 11 Apr 2016 22:21:31 -0700
Message-Id: <1460438494-16135-1-git-send-email-matt.ranostay@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Add functionality to allow multiple parts to be selected via ACPI or DT
properties; also allows per chip info and initialiation.

Add BME280 device and relative humidity reading functionality.

Matt Ranostay (3):
  iio: pressure: bmp280: add initial support for multiple chips
  iio: pressure: bmp280: add per chip initialize function pointer
  iio: pressure: bmp280: add humidity support

 drivers/iio/pressure/bmp280.c | 209 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 199 insertions(+), 10 deletions(-)

-- 
1.9.1
