Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH V2 0/7] Add scan demux unit and use it in max1363
Date: Sun,  4 Dec 2011 20:56:55 +0000
Message-Id: <1323032222-21338-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

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
 drivers/staging/iio/industrialio-buffer.c |  213 +++++++++++++++++++++++++----
 drivers/staging/iio/industrialio-core.c   |   11 ++
 7 files changed, 260 insertions(+), 73 deletions(-)

-- 
1.7.7.4
