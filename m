Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Subject: [PATCH v2 00/12] misc IIO cleanup
Date: Thu, 12 Jun 2014 07:00:17 +0200
Message-Id: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

v2 doesn't change the periodic rtc trigger name and just moves iio-trig-sysfs
documentation to ABI/testing (instead of merging with sysfs-bus-iio)

Peter Meerwald (12):
  iio:adc:ad5791: Use BIT() and GENMASK() macros
  iio:adc:ad5504: Use BIT() and GENMASK() macros
  iio:adc:ad7887: Use BIT() and GENMASK() macros
  iio:adc:ad7476: Use GENMASK() macro
  iio:adc:ad7298: Use BIT() and GENMASK() macros
  iio: Move documentation of iio-trig-sysfs to ABI/testing
  staging:iio: Update iio_event_monitor program
  staging:iio: Fix iio_utils.h function prototypes
  staging:iio: Fix mention of INDIO_RING_TRIGGERED to
    INDIO_BUFFER_TRIGGERED
  staging:iio: Fix error handling in generic_buffer example
  staging:iio-trig-periodic-rtc: Cleanup
  staging:iio-trig-periodic-rtc: Allow to reset frequency to 0

 .../ABI/testing/sysfs-bus-iio-trigger-sysfs        | 11 ++++++++
 drivers/iio/adc/ad7298.c                           | 21 +++++++---------
 drivers/iio/adc/ad7476.c                           |  5 ++--
 drivers/iio/adc/ad7887.c                           | 21 ++++++++--------
 drivers/iio/dac/ad5504.c                           | 11 ++++----
 drivers/iio/dac/ad5791.c                           | 29 +++++++++++-----------
 drivers/staging/iio/Documentation/generic_buffer.c |  9 ++++---
 .../staging/iio/Documentation/iio_event_monitor.c  | 10 ++++++++
 drivers/staging/iio/Documentation/iio_utils.h      |  6 ++---
 .../iio/Documentation/sysfs-bus-iio-trigger-sysfs  | 11 --------
 drivers/staging/iio/Documentation/trigger.txt      |  2 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    | 26 +++++++++++++------
 12 files changed, 90 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs

-- 
1.9.1
