Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58617 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932485AbaFCWmY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Jun 2014 18:42:24 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, knaack.h@gmx.de
Subject: [PATCH 00/15] ad799x cleanup
Date: Wed,  4 Jun 2014 00:42:00 +0200
Message-Id: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

I ran into some issues with IIO events using the ad799x ADC driver with an
ad7997 chip; the following series has cleanups and fixes

patches 1-6, 8 are cleanup

patch 7 exposes the IIO event interface of the driver only if an IRQ has been configured
for the device; no IRQ -> no events

patch 9 shifts out the last two bits when reading the event value on ad7993 and ad7997
(which have 10-bit ADCs); same as read_raw()

patch 10 checks the range of the event value on write and shifts the value into place;
similar to the previous patch

patch 11 adds helper function to read/write the chip's config register (16-bit on 
ad7997/ad7998, 8-bit everywhere else)

patch 12 actually writes the default config to the chip and keeps a copy of
the config register in the driver's state

patch 13 changes update_scan_mode() to store the enabled channels in the config
register, on ad7992/ad7993/ad7994/ad7997/ad7998, hence the rename

patch 14 reports only those events as enabled which actually are

patch 15 allows to write the event config, previously events could only be
set implicitly via the buffer scan mode

regards, p.

Peter Meerwald (15):
  staging:iio: Update iio_event_monitor program
  staging:iio: Fix iio_utils.h function prototypes
  iio:adc:ad799x: Fix ad799x_chip_info kerneldoc
  iio:adc:ad799x: Drop I2C access helper functions
  iio:adc:ad799x: Save some lines in ad7997_8_update_scan_mode() exit
    handling
  iio:adc:ad799x: Use BIT() and GENMASK()
  iio:adc:ad799x: Only expose event interface when IRQ is available
  iio:adc:ad799x: Make chan_spec const in ad799x_chip_config struct
  iio:adc:ad799x: Fix reported event values, apply shift
  iio:adc:ad799x: Check event value range on write
  iio:adc:ad799x: Add helper function to read/write config register
  iio:adc:ad799x: Write default config on probe and reset alert status
    on probe
  iio:adc:ad799x: Rename ad7997_8_update_scan_mode() to
    ad799x_update_scan_mode()
  iio:adc:ad799x: Return more meaningful event enabled state
  iio:adc:ad799x: Allow to write event config

 drivers/iio/adc/ad799x.c                           | 507 ++++++++++++---------
 .../staging/iio/Documentation/iio_event_monitor.c  |  10 +
 drivers/staging/iio/Documentation/iio_utils.h      |   6 +-
 3 files changed, 317 insertions(+), 206 deletions(-)

-- 
1.9.1

