Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 0/6] staging:iio: Event handling updates
Date: Wed,  1 Feb 2012 22:17:48 +0100
Message-Id: <1328131074-2739-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

This series is a resend of the same series form early January, with two minor
issues in patch 4 and 5 being fixed. Also the order of patch 5 and 6 in the
series has been changed.

The series starts with fixing some documentation issues for the
iio_event_interface struct. The second patch moves the IIO event handling code
from the IIO core file to its own file with the next patches containing some
cleanups to the event handling code. The last patch implements poll support for
IIO event handling fds.

- Lars

Lars-Peter Clausen (6):
  staging:iio: Update iio_event_interface documentation
  staging:iio: Factor out event handling into its own file
  staging:iio:events: Use kfifo for event queue
  staging:iio:events: Use waitqueue lock to protect event queue
  staging:iio:events: Use non-atomic bitops
  staging:iio:events: Add poll support

 drivers/staging/iio/Makefile             |    2 +-
 drivers/staging/iio/iio_core.h           |    4 +
 drivers/staging/iio/industrialio-core.c  |  458 ------------------------------
 drivers/staging/iio/industrialio-event.c |  453 +++++++++++++++++++++++++++++
 4 files changed, 458 insertions(+), 459 deletions(-)
 create mode 100644 drivers/staging/iio/industrialio-event.c

-- 
1.7.8.3
