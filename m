Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/2] blue part 6: IIO abi rework
Date: Mon, 25 Jul 2011 14:23:52 +0100
Message-Id: <1311600234-16128-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Michael pointed out the issues that not having an explicit
direction for channels was causing and the inconsistency
of the inX and outX channel naming we got from hmwon.

They are stuck with it, but we aren't, so lets fix this now.

Interesting question is whether we reset the base units to be
volts whilst we are at it? (for voltage channels obviously!)

Given there will be a lot of auditing and datasheet reading
to do that, I suggest that if we decide to do it, we leave
that for when we are moving drivers out of staging.

We could roll the doc patch in with the one in the previous
series to reduce churn.  If they go together I'll probably
do that.

Thanks,

Jonathan

Jonathan Cameron (2):
  staging:iio: ABI rework - add in_ or out_ prefix to channnels
  staging:iio:Documentation sysfs-bus-iio add in and out prefixes

 drivers/staging/iio/Documentation/sysfs-bus-iio |  536 +++++++++++-----------
 drivers/staging/iio/dac/ad5686.c                |   24 +-
 drivers/staging/iio/iio.h                       |   31 ++-
 drivers/staging/iio/industrialio-core.c         |   28 +-
 4 files changed, 324 insertions(+), 295 deletions(-)

-- 
1.7.3.4
