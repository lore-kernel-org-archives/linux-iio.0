Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/16] staging:iio:adc cleanups / fixes.
Date: Fri, 23 Sep 2011 13:01:26 +0100
Message-Id: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Michael,

Result of doing a careful review of these fundamentally clean
drivers.  A few actual bug fixes and quite a few cases of moving
to prefered means of doing things (not using IIO_CHAN for starters).

Please look over these as I may well have 'cleaned' things into
not working.  Only functional changes beyond bug fixes are that
we now have event _en attributes for the ad799x (read only and always
equal to 1) and what happens with gpio request failures has changed
in the ad7606.

Thanks,

Jonathan

Jonathan Cameron (16):
  staging:iio:adc:ad799x fix incorrect scan_type descriptions.
  staging:iio:adc:ad799x stop using IIO_CHAN macro.
  staging:iio:adc:ad799x fix incorrect setting of configuration
    register on single channel read.
  staging:iio:adc:ad799x trivial: use the convenient chan struct.
  staging:iio:adc:ad799x use a table for frequency values rather than
    big switch.
  staging:iio:adc:ad799x avoid bouncing back and forth from iio_priv
    space.
  staging:iio:adc:ad799x use the core handling for as much of the
    events as possible.
  staging:iio:adc:ad799x set the device name only once.
  staging:iio:adc:ad799x address and scan_index always match so stop
    using address
  staging:iio:adc:ad7606 add local define for chan_spec structures.
  staging:iio:adc:ad7606 trivial code style fix.
  staging:iio:adc:ad7606 make gpio request failures more consistent
  staging;iio:adc:ad7606 use iio_sw_buffer_preenable rather than local
    equiv
  staging:iio:adc:ad7606 refactor to remove st->irq and st->id.
  staging:iio:adc:ad7606 remove unused chip info elements.
  staging:iio:adc:ad7887 stop using IIO_CHAN macro.

 drivers/staging/iio/adc/ad7606.h      |   12 +-
 drivers/staging/iio/adc/ad7606_core.c |  226 ++++++------
 drivers/staging/iio/adc/ad7606_par.c  |    2 +-
 drivers/staging/iio/adc/ad7606_ring.c |   44 +--
 drivers/staging/iio/adc/ad7606_spi.c  |    2 +-
 drivers/staging/iio/adc/ad7887_core.c |   26 +-
 drivers/staging/iio/adc/ad799x.h      |    4 +-
 drivers/staging/iio/adc/ad799x_core.c |  645 ++++++++++++++++++++-------------
 drivers/staging/iio/adc/ad799x_ring.c |    4 +-
 9 files changed, 546 insertions(+), 419 deletions(-)

-- 
1.7.3.4
