Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: allow event usage when no buffer support present.
Date: Fri, 21 Oct 2011 12:34:24 +0100
Message-Id: <1319196865-22766-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Lars-Peter pointed out this issue.

Basically the checks for whether we had a buffer were in the open
wheras they should be in the read.

I've tested this on the tsl2563 driver and it all seems fine.
Lars-Peter - could you hammer this a little to see if I have
missed any corner cases?

Thanks,

Jonathan

Jonathan Cameron (1):
  staging:iio: core.  Allow for event chrdev obtaining ioctl if no
    buffer present.

 drivers/staging/iio/iio_core.h            |    2 +-
 drivers/staging/iio/industrialio-buffer.c |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
1.7.7
