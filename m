Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	mranostay@gmail.com
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 0/2] iio: driver for Semtech SX9500
Date: Mon, 17 Nov 2014 17:12:47 +0200
Message-Id: <1416237169-10707-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Add a driver for Semtech's SX9500 proximity sensor, but first change the
Kconfig prompt from 'Lightning sensors' to 'Proximity sensors'.

The device does not estimate distance, it only outputs a single bit which
indicates proximity.  We use 0 to mean that an object is close and 1 otherwise,
sort of an uncalibrated distance.  From what I understand in the ABI
specification, this is allowed.

Vlad Dogaru (2):
  iio: rename proximity sensors in kernel config
  iio: driver for Semtech SX9500 proximity solution

 drivers/iio/proximity/Kconfig  |  12 +-
 drivers/iio/proximity/Makefile |   1 +
 drivers/iio/proximity/sx9500.c | 752 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 764 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/proximity/sx9500.c

-- 
1.9.1
