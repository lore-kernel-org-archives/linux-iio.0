Return-Path: <SRS0=ItX8=AO=gmail.com=himshijain.hj@kernel.org>
Date: Wed, 13 Sep 2017 13:24:41 +0530
From: Himanshi Jain <himshijain.hj@gmail.com>
To: outreachy-kernel@googlegroups.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, nick.desaulniers@gmail.com,
	daniel.baluta@gmail.com
Subject: [PATCH 0/2] Rewrite the IIO_DEVICE_ATTR_NAMED API to pass name as
 string.
Message-ID: <cover.1505288677.git.himshijain.hj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patchset is to rewrite the IIO_DEVICE_ATTR_NAMED API to pass name
as string.

Himanshi Jain (2):
  include: linux: sysfs: Add __ATTR_NAMED macro
  iio: Use __ATTR_NAMED to allow passing name as string to
    IIO_DEVICE_ATTR_NAMED and change usage to pass string

 drivers/iio/adc/ad7793.c          | 2 +-
 drivers/staging/iio/adc/ad7192.c  | 2 +-
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 include/linux/iio/sysfs.h         | 6 +++++-
 include/linux/sysfs.h             | 7 +++++++
 5 files changed, 16 insertions(+), 5 deletions(-)

-- 
1.9.1
