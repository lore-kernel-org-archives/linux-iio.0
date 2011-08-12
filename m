Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:imu adis16344 support
Date: Fri, 12 Aug 2011 18:04:36 +0100
Message-Id: <1313168677-18803-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

Trivial addition of support for another part in the adis16400 driver.

I don't think this has any dependencies, but in my tree it is sitting after
staging:iio:cleanups2 post iio_chan_spec_conversion. Hence that might
be the easiest point.  For reference, Michael Hennerich's impedance-analyzer
patch looks fine to apply here or anywhere earlier in the series I've posted
today.

That concludes the less controversial elements of what we have currently
queued up.

I may hold the rest until we have resolved this issue with dummy groups
for attribute handling (to get the reference counting correct).

If you want to take a look at what is to come they are all in
iio-blue.git on kernel.org.

Thanks,

Jonathan

Jonathan Cameron (1):
  staging:iio:imu:adis16344 support

 drivers/staging/iio/imu/adis16400_core.c |   44 ++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

-- 
1.7.3.4
