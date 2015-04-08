Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 0/8] Fixes for the mma9553 driver
Date: Wed,  8 Apr 2015 17:37:29 +0300
Message-Id: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This is a set of follow-up patches for the mma9553 driver that fixes
some issues as suggested by Hartmut.

I have also added the enable channel for activity as suggested by Daniel.

Irina Tirdea (8):
  iio: accel: mma9553: coding style fixes
  iio: accel: mma9553: use unsigned counters
  iio: accel: mma9553: fix gpio bitnum init value
  iio: accel: mma9553: refactor mma9553_read_activity_stepcnt
  iio: accel: mma9553: refactor mma9553_read_raw
  iio: accel: mma9553: check input value for activity period
  iio: accel: mma9551_core: prevent buffer overrun
  iio: accel: mma9553: add enable channel for activity

 drivers/iio/accel/mma9551_core.c |  58 ++++++----
 drivers/iio/accel/mma9551_core.h |   2 +-
 drivers/iio/accel/mma9553.c      | 227 +++++++++++++++++----------------------
 3 files changed, 136 insertions(+), 151 deletions(-)

-- 
1.9.1
