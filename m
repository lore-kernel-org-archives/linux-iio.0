Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47785 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbaFLEy2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 12 Jun 2014 00:54:28 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Subject: [PATCH v3 00/12] ad799x cleanup
Date: Thu, 12 Jun 2014 06:54:04 +0200
Message-Id: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v3 folds reading/writing event values and range checking into first patch

Peter Meerwald (12):
  iio:adc:ad799x: Fix reading and writing of event values, apply shift
  iio:adc:ad799x: Fix ad799x_chip_info kerneldoc
  iio:adc:ad799x: Drop I2C access helper functions
  iio:adc:ad799x: Save some lines in ad7997_8_update_scan_mode() exit
    handling
  iio:adc:ad799x: Use BIT() and GENMASK()
  iio:adc:ad799x: Only expose event interface when IRQ is available
  iio:adc:ad799x: Make chan_spec const in ad799x_chip_config struct
  iio:adc:ad799x: Add helper function to read/write config register
  iio:adc:ad799x: Write default config on probe and reset alert status
    on probe
  iio:adc:ad799x: Set conversion channels and rename
    ad7997_8_update_scan_mode()
  iio:adc:ad799x: Return more meaningful event enabled state
  iio:adc:ad799x: Allow to write event config

 drivers/iio/adc/ad799x.c | 509 ++++++++++++++++++++++++++++-------------------
 1 file changed, 306 insertions(+), 203 deletions(-)

-- 
1.9.1

