Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH V3 0/7] Add scan demux unit and use it in max1363
Date: Mon,  5 Dec 2011 21:37:09 +0000
Message-Id: <1323121036-21094-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

The v3 here is just to indicate a tiny change suggested by
Lars-Peter from the version that has been out for review on
linux-iio. (Using ALIGN instead of hand rolling in one case
in patch 4).  Anyhow, not worth putting out for another review
as Lars-Peter has tested and acked without it anyway.

Technically Lars-Peter only acked patches 4 and 5 but they
are the important ones (the others being trivial or tied
up with the max1363 driver which is one of mine..)

This set introduces the an optional demultiplexer into the
path of data form devices to buffers.  It is a necessary step
on the path to in kernel push interfaces (trigger driven ones).
Also rather useful on it's own as shown by the max1363 patches
and some uses Lars-Peter has made of it in another series.

Anyhow fair bit more to come so time to send these on to you!

Thanks,

Jonathan

v2 text:
Hi All,

New version of this series.  Two changes as per Lars-Peter's
suggestions.  ALIGN macro usage in patch 4 and one of the two
for each bit set suggestions.  The second is subtly different
as it is finding bits after a certain point rather than from
the start.

As explained in patch 5 discussion, I personally feel that
the demux should occur prior to the buffer and avoiding the
extra copy should be done by allowing buffers to provide
callbacks for reserving (plus getting access to) space and
notifying that they are done filling it.   Either way, now
is not the time to do this change. Too much else going on!

v1 text:
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
 drivers/staging/iio/industrialio-buffer.c |  212 +++++++++++++++++++++++++----
 drivers/staging/iio/industrialio-core.c   |   11 ++
 7 files changed, 259 insertions(+), 73 deletions(-)

-- 
1.7.7.4
