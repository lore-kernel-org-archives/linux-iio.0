Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] IIO fix for staging-next
Date: Wed, 13 Jul 2011 13:42:46 +0100
Message-Id: <1310560967-1287-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

Same issue as for the lis3l02dq patch in the 3.0 fixes set.
The change that introduces the bug is only in staging-next at
the moment know hence this separate series.

Thanks,

Jonathan

Jonathan Cameron (1):
  staging:iio:adc:ad7476: Incorrect pointer into spi_set_drvdata.

 drivers/staging/iio/adc/ad7476_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
1.7.3.4
