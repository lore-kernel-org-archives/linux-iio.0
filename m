Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH V2 0/4] staging:iio:meter stub removal and general cleanup
Date: Fri, 11 Feb 2011 14:07:39 +0000
Message-Id: <1297433263-23166-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

This lot make a start on cleaning up the energy meter drivers from Analog.
I've added a couple of static's that sparse pointed out but otherwise
this is as posted to linux-iio last week.

Lots more to do with these including pinning down the interface.
There is a bug in ade7759 that sparse points out but fix for that
will be in a separate patch as it isn't covered by cleanup.

description from V1

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

 drivers/staging/iio/meter/ade7753.c     |  208 +++++++------------------------
 drivers/staging/iio/meter/ade7753.h     |   64 ----------
 drivers/staging/iio/meter/ade7754.c     |  165 ++++---------------------
 drivers/staging/iio/meter/ade7754.h     |   67 ----------
 drivers/staging/iio/meter/ade7759.c     |  165 +++++--------------------
 drivers/staging/iio/meter/ade7759.h     |   65 ----------
 drivers/staging/iio/meter/ade7854-spi.c |  120 ++++++++++--------
 drivers/staging/iio/meter/ade7854.c     |   78 ++----------
 drivers/staging/iio/meter/ade7854.h     |   69 ----------
 9 files changed, 180 insertions(+), 821 deletions(-)

-- 
1.7.3.4
