Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:49246 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758716Ab3JPWTT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Oct 2013 18:19:19 -0400
Received: from sirene.lan (83-215-0-241.stadt.dyn.salzburg-online.at [83.215.0.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pmeerw)
	by pmeerw.net (Postfix) with ESMTPSA id CD05CC50171
	for <linux-iio@vger.kernel.org>; Thu, 17 Oct 2013 00:19:15 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Subject: [PATCH v4 00/11] hmc5843 cleanup
Date: Thu, 17 Oct 2013 00:19:03 +0200
Message-Id: <1381961954-25596-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

v4 is addressing comments by Lars-Peter Clausen (use __be16 instead of s16) and 
Jonathan Cameron (naming of _get_scale_index() vs _check_scale())

Jonathan's comment led to changes in patch 1 mainly
patch 2 is new and renames _check_samp_freq() to get_samp_freq_index() in the
same spirit and merges/inlines unused helper functions

Lars-Peter's comment is addressed in patches 3 and 4

Peter Meerwald (11):
  staging:iio:hmc5843: Use SCALE instead of magn_range
  staging:iio:hmc5843: Rename _check_samp_freq to get_samp_freq_index
  staging:iio:hmc5843: Always read all channels values otherwise no
    updates
  staging:iio:hmc5843: Add trigger handling
  staging:iio:hmc5843: Remove ability to change operating mode
  staging:iio:hmc5843: Rename _configure() to _set_mode()
  staging:iio:hmc5843: Reorganize _set_meas_conf()
  staging:iio:hmc5843: Rename _set_rate() to _set_samp_freq()
  staging:iio:hmc5843: Introduce _set_range_gain()
  staging:iio:hmc5843: Check initialization and chip identifier
  staging:iio:hmc5843: Trivial cleanup

 drivers/staging/iio/magnetometer/hmc5843.c | 516 ++++++++++++++---------------
 1 file changed, 240 insertions(+), 276 deletions(-)

-- 
1.8.4

