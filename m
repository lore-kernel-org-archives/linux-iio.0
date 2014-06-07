Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Subject: [PATCH 00/12] misc IIO cleanup
Date: Sat,  7 Jun 2014 17:42:40 +0200
Message-Id: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

patches 1 to 5 aim to use the BIT() and GENMASK() macros in various AD ADC 
drivers; this gets rid of the RES_MASK() macro #defined in each driver

patch 6 move documentation of /sys/bus/iio/devices/triggerX/trigger_now to
Documentation/ABI/testing/sysfs-bus-iio as iio-trig-sysfs has left staging
with commit e64e7d5c

patches 7 to 10 are cleanup and bugfixse to iio/staging

patch 11 is cleanup to iio-trig-periodic-rtc (which is important and I think
should leave staging soon -- what is left to do?)

patch 12 allows to set the frequency of the periodic rtc to 0, thereby temporarily
disabling the trigger

Peter Meerwald (12):
  iio:adc:ad5791: Use BIT() and GENMASK() macros
  iio:adc:ad5504: Use BIT() and GENMASK() macros
  iio:adc:ad7887: Use BIT() and GENMASK() macros
  iio:adc:ad7476: Use GENMASK() macro
  iio:adc:ad7298: Use BIT() and GENMASK() macros
  iio: Move documentation of iio-trig-sysfs to ABI
  staging:iio: Update iio_event_monitor program
  staging:iio: Fix iio_utils.h function prototypes
  staging:iio: Fix mention of INDIO_RING_TRIGGERED to
    INDIO_BUFFER_TRIGGERED
  staging:iio: Fix error handling in generic_buffer example
  staging:iio-trig-periodic-rtc: Cleanup
  staging:iio-trig-periodic-rtc: Allow to reset frequency to 0

 Documentation/ABI/testing/sysfs-bus-iio            | 12 +++++++++
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
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    | 28 +++++++++++++++------
 12 files changed, 92 insertions(+), 73 deletions(-)
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs

-- 
1.9.1
