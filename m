Return-Path: <k.wrona@samsung.com>
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>,
 Karol Wrona <k.wrona@samsung.com>
Subject: [RFC PATCH 0/2] iio: kfifo: Add resource management alloc/free
Date: Tue, 09 Dec 2014 20:29:43 +0100
Message-id: <1418153385-18212-1-git-send-email-k.wrona@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

This is RFC because I felt a bit confused while devm_alloc/free adding.
It applies on next but I've tested it partialy on 3.16.  It can cause some
problemsi with several drivers so it does not fit for now. 

iio kfifo alloc takes one argument struct iio_dev * which is not used.
iio_buffer is attached by external function.  In such situation resource 
management alloc can be implemented in two ways:
1. indio_dev ptr in iio_kfifo_alloc stays and devm_ functions have to
provide it but it is still unused.
2.  As there are a few drivers which use kfifo it can be removed and 
iio_kfifo_allocate refactored.

I apologise if I missed something and it was done in such way intentionally.



Karol Wrona (2):
  iio: kfifo: Remove unused argument in iio_kfifo_allocate
  iio: kfifo: Add resource management devm_iio_kfifo_allocate/free

 drivers/iio/kfifo_buf.c       |   58 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/iio/kfifo_buf.h |    5 +++-
 2 files changed, 61 insertions(+), 2 deletions(-)

-- 
1.7.9.5
