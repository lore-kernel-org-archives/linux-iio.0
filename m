Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH V2] staging:iio: allow event usage when no buffer support present.
Date: Fri, 21 Oct 2011 12:52:59 +0100
Message-Id: <1319197980-1405-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <4EA15BE5.50906@cam.ac.uk>
References: <4EA15BE5.50906@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

v2: Changed error to -EINVAL as per Lars-Peter's suggestion.

v1:
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
 drivers/staging/iio/industrialio-buffer.c |    6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
1.7.7
