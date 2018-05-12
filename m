Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33440 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeELSB2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 May 2018 14:01:28 -0400
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        John Syne <john3909@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/4] staging:iio: Drop 4 meter drivers.
Date: Sat, 12 May 2018 18:51:00 +0100
Message-Id: <20180512175104.24797-1-Jonathan.Cameron@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I announced an intent to drop all the meter drivers from staging as
none of them have been the subject of substantial work in a very long
time indeed.

For the ADE7854 John Syne stepped forward to say he had test hardware
and Rodrigo Siqueira was keen to work on the cleanup.  Some extensive
conversations have been since had about the changes required in the IIO
core to support these devices and the resulting userspace and kernel
ABI that we need to get to for the drivers.

However, whilst this progress is excellent, the remaining four drivers
are for obsolete and more or less unobtainable hardware.  Hence I am
now proposing we drop them.  There are some great looking new meter
parts out there from ADI (and I'm hopeful we'll be able to add support
for some of those!), but they are very different devices.

I am going to take an increasingly hard look at the remaining IIO drivers
in staging.  Some have recieved considerable attention (quite a few have
graduated in the last few months) so I'm happy with the progress on them.
Others have sat there since before we took any of IIO out of staging
and are not showing any signs of moving in the right direction.

Anyhow, if no one shouts in the next week I'll apply this series.
Ideally I'd like some ack's on these, but appreciate that they are no longer
really in anyone's purview.

Jonathan Cameron (4):
  staging:iio:meter: Drop ADE7753 driver
  staging:iio:meter: Drop ADE7754 driver
  staging:iio:meter: Drop ADE7758 driver
  staging:iio:meter: Drop ADE7759 driver

 drivers/staging/iio/meter/Kconfig           |  42 -
 drivers/staging/iio/meter/Makefile          |   8 -
 drivers/staging/iio/meter/ade7753.c         | 630 -------------
 drivers/staging/iio/meter/ade7754.c         | 664 --------------
 drivers/staging/iio/meter/ade7758.h         | 183 ----
 drivers/staging/iio/meter/ade7758_core.c    | 955 --------------------
 drivers/staging/iio/meter/ade7758_ring.c    | 177 ----
 drivers/staging/iio/meter/ade7758_trigger.c | 108 ---
 drivers/staging/iio/meter/ade7759.c         | 558 ------------
 9 files changed, 3325 deletions(-)
 delete mode 100644 drivers/staging/iio/meter/ade7753.c
 delete mode 100644 drivers/staging/iio/meter/ade7754.c
 delete mode 100644 drivers/staging/iio/meter/ade7758.h
 delete mode 100644 drivers/staging/iio/meter/ade7758_core.c
 delete mode 100644 drivers/staging/iio/meter/ade7758_ring.c
 delete mode 100644 drivers/staging/iio/meter/ade7758_trigger.c
 delete mode 100644 drivers/staging/iio/meter/ade7759.c

-- 
2.17.0

