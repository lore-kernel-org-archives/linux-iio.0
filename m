Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43254 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011AbaFGPbr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:31:47 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org
Subject: [PATCH v2 00/13] ad799x cleanup
Date: Sat,  7 Jun 2014 17:31:24 +0200
Message-Id: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

first patch is bug fix (reading/writing of event values, apply shift), 
could be backported to -stable (when the ad799x driver was still in stable)

incorporating comments by Lars-Peter and Jonathan regarding
patch description

Peter Meerwald (13):
  iio:adc:ad799x: Fix reading and writing of event values, apply shift
  iio:adc:ad799x: Fix ad799x_chip_info kerneldoc
  iio:adc:ad799x: Drop I2C access helper functions
  iio:adc:ad799x: Save some lines in ad7997_8_update_scan_mode() exit
    handling
  iio:adc:ad799x: Use BIT() and GENMASK()
  iio:adc:ad799x: Only expose event interface when IRQ is available
  iio:adc:ad799x: Make chan_spec const in ad799x_chip_config struct
  iio:adc:ad799x: Check range when writing event value
  iio:adc:ad799x: Add helper function to read/write config register
  iio:adc:ad799x: Write default config on probe and reset alert status
    on probe
  iio:adc:ad799x: Set conversion channels and rename
    ad7997_8_update_scan_mode()
  iio:adc:ad799x: Return more meaningful event enabled state
  iio:adc:ad799x: Allow to write event config

 drivers/iio/adc/ad799x.c | 510 ++++++++++++++++++++++++++++-------------------
 1 file changed, 307 insertions(+), 203 deletions(-)

-- 
1.9.1

