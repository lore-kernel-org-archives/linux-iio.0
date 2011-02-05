Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/4] staging:iio:meter clean up and dead code removal.
Date: Sat,  5 Feb 2011 19:34:15 +0000
Message-Id: <1296934459-15760-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is very much the starting point for bashing the meter drivers into
shape.  For now I've just removed most of the unused code and stubs.

I have also cleaned up spi bus handling.  I may well have gotten that
bit wrong so please do take a look.  In some cases this involved turning
one transfer into two so as to clarify what the code was doing.  This
may cause issues if the spi bus drivers don't play the game properly or
as if I got the conversion wrong.

Next job is to pin down, standardise and document the sysfs interface
for these parts.  Anyone care to take this on?

Note I have currently left the ade7758 driver alone
as it is by far the most complex and didn't suffer the large amount of
dead code to be found in the others.

All comments as ever welcome.  I'd also like to know what test
coverage we have on these parts.

Thanks,

Jonathan

Jonathan Cameron (4):
  staging:iio:meter remove stubs from ade7753.
  staging:iio:meter remove stubs from ade7754.
  staging:iio:meter remove stubs from ade7759.
  staging:iio:meter remove stubs from ade7854.

 drivers/staging/iio/meter/ade7753.c     |  200 +++++++------------------------
 drivers/staging/iio/meter/ade7753.h     |   64 ----------
 drivers/staging/iio/meter/ade7754.c     |  165 ++++---------------------
 drivers/staging/iio/meter/ade7754.h     |   67 ----------
 drivers/staging/iio/meter/ade7759.c     |  163 +++++---------------------
 drivers/staging/iio/meter/ade7759.h     |   65 ----------
 drivers/staging/iio/meter/ade7854-spi.c |  120 ++++++++++---------
 drivers/staging/iio/meter/ade7854.c     |   78 ++----------
 drivers/staging/iio/meter/ade7854.h     |   69 -----------
 9 files changed, 175 insertions(+), 816 deletions(-)

-- 
1.7.3.4
