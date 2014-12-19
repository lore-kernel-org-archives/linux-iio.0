Return-Path: <k.wrona@samsung.com>
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>,
 Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH v2 0/3] iio: Add resource management kfifo alloc/free
Date: Fri, 19 Dec 2014 18:39:23 +0100
Message-id: <1419010766-13557-1-git-send-email-k.wrona@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

Hello,

iio kfifo alloc took one argument struct iio_dev * indio_dev which was not used 
so it was removed in allocate function and in several drivers which used it.
Second patch adds devm_ alloc/free.

Karol

changes from RFC:
- rebased on next-20141219
- changes in clients
- add minor doc fix to iio core


Karol Wrona (3):
  iio: kfifo: Remove unused argument in iio_kfifo_allocate
  iio: kfifo: Add resource management devm_iio_kfifo_allocate/free
  iio: core: Get rid of misleading comment

 drivers/iio/adc/ti_am335x_adc.c                 |    2 +-
 drivers/iio/industrialio-core.c                 |    1 -
 drivers/iio/industrialio-triggered-buffer.c     |    2 +-
 drivers/iio/kfifo_buf.c                         |   60 ++++++++++++++++++++++-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |    2 +-
 drivers/staging/iio/iio_simple_dummy_buffer.c   |    2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |    2 +-
 drivers/staging/iio/meter/ade7758_ring.c        |    2 +-
 include/linux/iio/kfifo_buf.h                   |    5 +-
 9 files changed, 68 insertions(+), 10 deletions(-)

-- 
1.7.9.5
