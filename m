Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 0/3] iio: proximity: as3935: fix major drivers
Date: Sat, 21 May 2016 20:01:00 -0700
Message-Id: <1463886063-20004-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This series has some major ABI changes, and bugfixes related to stack
corruption.

Seems these partly are to blame from the driver's author being in one the
least active thunderstorm parts of the world (Oregon has almost none).

Matt Ranostay (3):
  iio: proximity: as3935: correct IIO_CHAN_INFO_RAW output
  iio: proximity: as3935: remove triggered buffer processing
  iio: proximity: as3935: fix buffer stack trashing

 .../ABI/testing/sysfs-bus-iio-proximity-as3935          |  2 +-
 drivers/iio/proximity/as3935.c                          | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.7.4
