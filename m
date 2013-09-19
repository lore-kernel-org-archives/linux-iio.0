Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43357 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab3ISTgE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 19 Sep 2013 15:36:04 -0400
Received: from localhost.localdomain (83-215-0-241.stadt.dyn.salzburg-online.at [83.215.0.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pmeerw)
	by pmeerw.net (Postfix) with ESMTPSA id 34C28C50171
	for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2013 21:36:01 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Subject: [PATCH v2 00/15] staging:iio:hmc5843 cleanup
Date: Thu, 19 Sep 2013 21:35:45 +0200
Message-Id: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

updated v2 patch series of the hmc5843 cleanup, addressnig comments by 
Jonathan Cameron

patch 1: correctly dereferencing dev, fixed suspend/resume
patch 7: checked CALIBSCALE, output is as follows

  # cat calibscale_available 
  0.880000 1.300000 1.900000 2.500000 4.0 4.700000 5.600000 8.100000
  # cat in_magn_calibscale 
  1.300000
  # cat in_magn_scale 
  0.000009174
  # cat in_magn_x_raw 
  252
  # echo 1.900000 > in_magn_calibscale
  # cat in_magn_scale 
  0.000012195
  # cat in_magn_x_raw 
  198
  # echo 0.88 > in_magn_calibscale
  # cat in_magn_scale 
  0.000007299
  # cat in_magn_x_raw
  318

  calibscale adjusts the measurement range and scale is used to keep Gauss
  reading the same
  
patch 9: buffer is now part of hmc5843_data, using IIO core demux as suggested

remaining patches should not have changed

Peter Meerwald (15):
  staging:iio:hmc5843: Add pointer to i2c client to data struct
  staging:iio:hmc5843: Rewrite init function
  staging:iio:hmc5843: Use INFO_SAMP_FREQ
  staging:iio:hmc5843: Remove unused LSB register #defines
  staging:iio:hmc5843: Tighten comments
  staging:iio:hmc5843: Introduce helper functions to show/check list of
    int pairs
  staging:iio:hmc5843: Use CALIBSCALE instead of magn_range
  staging:iio:hmc5843: Always read all channels values otherwise no
    updates
  staging:iio:hmc5843: Add trigger handling
  staging:iio:hmc5843: Remove ability to change operating mode
  staging:iio:hmc5843: Rename _configure() to _set_mode()
  staging:iio:hmc5843: Reorganize _set_meas_conf()
  staging:iio:hmc5843: Rename _set_rate() to _set_samp_freq()
  staging:iio:hmc5843: Introduce _set_range_gain()
  staging:iio:hmc5843: Check initialization and chip identifier

 drivers/staging/iio/magnetometer/hmc5843.c | 612 ++++++++++++++---------------
 1 file changed, 287 insertions(+), 325 deletions(-)

-- 
1.8.4

