Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/7] Add scan demux unit and use it in max1363
Date: Sun, 27 Nov 2011 13:10:05 +0000
Message-Id: <1322399412-21622-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The last patch technically is a simple bug fix, but included here as
it came up during testing of this series.

The 'interesting' bits are the rewrite of iio_sw_buffer_preenable. I'd like
people with drivers currently using that function to test and see what
I have broken.  We should also be able to drop a number of cases in specific
drivers in favour of this version.

The demux unit is designed to offer a straight path with little or no
overhead if the client (here still the IIO buffer) needs all the data and to
only get in the way when a subset of the active scan mask is requested.

I may well have messed this up so please please test this set.

Thanks,

Jonathan

Jonathan Cameron (7):
  staging:iio:find iio channel from scan index util function
  staging:iio:buffer add a cache of the timestamp scan index.
  staging:iio: add hook to allow core to perform scan related config.
  staging:iio: make iio_sw_buffer_preenable much more general.
  staging:iio: add demux optionally to path from device to buffer
  staging:iio:adc:max1363 use new demuxing support.
  staging:iio:adc:max1363 correctly set channels as big endian.

 drivers/staging/iio/adc/max1363.h         |   11 ++-
 drivers/staging/iio/adc/max1363_core.c    |   18 ++-
 drivers/staging/iio/adc/max1363_ring.c    |   51 ++-----
 drivers/staging/iio/buffer.h              |   16 ++
 drivers/staging/iio/iio.h                 |   13 ++-
 drivers/staging/iio/industrialio-buffer.c |  216 +++++++++++++++++++++++++----
 drivers/staging/iio/industrialio-core.c   |   11 ++
 7 files changed, 263 insertions(+), 73 deletions(-)

-- 
1.7.7.3
