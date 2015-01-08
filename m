Return-Path: <k.wrona@samsung.com>
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>,
 Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH 0/2] iio: Add no-triggered buffer helper functions
Date: Thu, 08 Jan 2015 17:40:25 +0100
Message-id: <1420735227-21091-1-git-send-email-k.wrona@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

Hello,

This small patchset introduces helpers for iio kfifo which are useful when
IIO_HARDWARE/SOFTWARE_BUFFER is used.  I decided to do it similar to Lars'
industrialio-triggered-buffer as a separate module what can be considered
as overkill but there is some risk that this source file will grow as new
needs will appear.  Also it gives some flexibility with buffer handling choice.

Second patch deselect IIO_TRIGGER for iio kfifo.  I think that there is no need
to use triggers always when iio kfifo is used and IIO_TRIGGERED_BUFFER also
selects IIO_KFIFO_BUF.  I need some comments for this one to be sure if I do not
missed something.  TI's AM335X ADC driver uses kfifo directly but without
triggered buffer/trigger in its sources so I hope there should be no problem
with that.

Thanks,
Karol

Karol Wrona (2):
  iio: Add no-triggered buffer helper functions
  iio: Deselect IIO_TRIGGER for IIO_KFIFO_BUF

 drivers/iio/Kconfig                           |    7 ++-
 drivers/iio/Makefile                          |    1 +
 drivers/iio/industrialio-notriggered-buffer.c |   72 +++++++++++++++++++++++++
 include/linux/iio/notriggered-buffer.h        |   11 ++++
 4 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/industrialio-notriggered-buffer.c
 create mode 100644 include/linux/iio/notriggered-buffer.h

-- 
1.7.9.5
