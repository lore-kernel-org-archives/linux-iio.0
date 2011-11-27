Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/5] IIO/staging inkernel pull interface
Date: Sun, 27 Nov 2011 13:13:57 +0000
Message-Id: <1322399642-22924-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is a direct lift across from the out of staging tree
of the proposed in kernel pull interface. We need this here
to allow work on having both push and pull interfaces.

This may get tweaked in response to futher feedback on the other
patches.

Thanks,

Jonathan

Jonathan Cameron (5):
  staging:iio: core: add datasheet_name to chan_spec
  staging:iio:adc:max1363 add datasheet_name entries.
  staging:iio:core add in kernel interface mapping and getting IIO
    channels.
  staging;iio: move iio data return types into types.h for use by
    inkern
  staging:iio::hwmon interface client driver.

 drivers/staging/Makefile                |    2 +-
 drivers/staging/iio/Kconfig             |    8 +
 drivers/staging/iio/Makefile            |    4 +-
 drivers/staging/iio/adc/max1363_core.c  |    2 +
 drivers/staging/iio/iio.h               |   17 ++-
 drivers/staging/iio/iio_hwmon.c         |  225 ++++++++++++++++++++++++++
 drivers/staging/iio/industrialio-core.c |  268 ++++++++++++++++++++++++++++++-
 drivers/staging/iio/inkern.c            |   21 +++
 drivers/staging/iio/inkern.h            |   86 ++++++++++
 drivers/staging/iio/types.h             |    4 +
 10 files changed, 623 insertions(+), 14 deletions(-)
 create mode 100644 drivers/staging/iio/iio_hwmon.c
 create mode 100644 drivers/staging/iio/inkern.c
 create mode 100644 drivers/staging/iio/inkern.h

-- 
1.7.7.3
