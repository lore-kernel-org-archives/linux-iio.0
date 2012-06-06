Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-134.synserver.de ([212.40.185.134]:1182 "EHLO
	smtp-out-123.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752541Ab2FFMAS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jun 2012 08:00:18 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/9] iio: Add helper function for initializing triggered buffers
Date: Wed,  6 Jun 2012 13:55:47 +0200
Message-Id: <1338983756-31243-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series revives some older patches from a few months back which somehow fell
off the table. It introduces two helper functions for managing triggered
buffers, since almost all drivers which use triggered buffers have the same
code for setting up and registering the pollfunc and trigger. New in this series
is that the helper functions now only support kfifo buffers. So only these
drivers which do use a kfifo buffer have been converted. There are a few more
drivers which could make use of these helper functions if we switch them from
the swring buffer to the kfifo buffer. Also new in this series is that the
helper functions are now in their own module, since it has dependencies on
IIO_BUFFER, IIO_KFIFO_BUF and IIO_TRIGGER_BUF but neither of these have
 on each other. So putting the helper functions in one of these
modules would add a dependency of the other modules to that module.

- Lars

Lars-Peter Clausen (9):
  iio: Add helper function for initializing triggered buffers
  iio:adc:at91: Use new triggered buffer setup helper
  staging:iio:adc:ad7192: Use new triggered buffer setup helper function
  staging:iio:adc:ad7298: Use new triggered buffer setup helper function
  staging:iio:adc:ad7476: Use new triggered buffer setup helper function
  staging:iio:adc:ad7606: Use new triggered buffer setup helper function
  staging:iio:adc:ad7793: Use new triggered buffer setup helper function
  staging:iio:adc:ad7887: Use new triggered buffer setup helper function
  staging:iio:adc:ad799x: Use new triggered buffer setup helper function

 drivers/iio/Kconfig                         |    7 ++
 drivers/iio/Makefile                        |    1 +
 drivers/iio/adc/Kconfig                     |    2 +-
 drivers/iio/adc/at91_adc.c                  |   49 +-----------
 drivers/iio/industrialio-triggered-buffer.c |  109 +++++++++++++++++++++++++++
 drivers/staging/iio/adc/Kconfig             |    7 ++
 drivers/staging/iio/adc/ad7192.c            |   47 ++----------
 drivers/staging/iio/adc/ad7298.h            |    5 ++
 drivers/staging/iio/adc/ad7298_core.c       |   11 +--
 drivers/staging/iio/adc/ad7298_ring.c       |   62 +++------------
 drivers/staging/iio/adc/ad7476_core.c       |    9 ---
 drivers/staging/iio/adc/ad7476_ring.c       |   44 +----------
 drivers/staging/iio/adc/ad7606_core.c       |    9 ---
 drivers/staging/iio/adc/ad7606_ring.c       |   44 +----------
 drivers/staging/iio/adc/ad7793.c            |   47 ++----------
 drivers/staging/iio/adc/ad7887_core.c       |    9 ---
 drivers/staging/iio/adc/ad7887_ring.c       |   33 +-------
 drivers/staging/iio/adc/ad799x.h            |    2 -
 drivers/staging/iio/adc/ad799x_core.c       |   25 +++---
 drivers/staging/iio/adc/ad799x_ring.c       |   63 +---------------
 include/linux/iio/buffer.h                  |    7 ++
 21 files changed, 189 insertions(+), 403 deletions(-)
 create mode 100644 drivers/iio/industrialio-triggered-buffer.c

-- 
1.7.10

