Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/5]  staging:iio: inkern pull interfaces for staging tree.
Date: Mon,  5 Dec 2011 21:55:59 +0000
Message-Id: <1323122164-32314-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

This set is a little bit of a novelty.  It's actually a direct lift
of a series that has been proposed and reviewed against the
set of patches for the core of IIO outside of the staging
tree.  We need it here in staging for two reasons.

1) To allow for drivers using this to exist in the staging tree
with all the stuff that is there but not yet ready to go out
of staging.

2) To allow development of the push in kernel interface stuff (triggered
capture) to procede.  We have no where near enough of the core
ready to go out of staging yet to be able to do that work there.

Anyhow, very little review here because it was all in the other thread.

For reference:
https://lkml.org/lkml/2011/11/7/258

I haven't lifted the acks across because they were obviously not
able to consider any issues of interaction with the rest of IIO
given they were only looking at a subset.  (Not that I think
there are any!).

Lars-Peter pointed out a silly mess up to do with two patches
getting weirdly split up so that is fixed here wrt to the version
I posted to linux-iio.

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
1.7.7.4
