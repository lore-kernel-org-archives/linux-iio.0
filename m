Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:34185 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932271Ab3JNVfC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Oct 2013 17:35:02 -0400
Received: from sirene.lan (83-215-0-241.stadt.dyn.salzburg-online.at [83.215.0.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pmeerw)
	by pmeerw.net (Postfix) with ESMTPSA id A6CACC50171
	for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2013 23:35:00 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Subject: [PATCH v3 00/10] hmc5843 cleanup
Date: Mon, 14 Oct 2013 23:34:48 +0200
Message-Id: <1381786498-25954-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

remaining patches for the hmc5843 cleanup; the main
change over v2 is in patch 1: use SCALE to show/set the 
range/gain of the measurement; in v2 this was done with
CALIBSCALE to show/set the range and SCALE to show the multiplier

patch 10 is new and has two trivial cleanups

regards, p.

Peter Meerwald (10):
  staging:iio:hmc5843: Use SCALE instead of magn_range
  staging:iio:hmc5843: Always read all channels values otherwise no updates
  staging:iio:hmc5843: Add trigger handling
  staging:iio:hmc5843: Remove ability to change operating mode
  staging:iio:hmc5843: Rename _configure() to _set_mode()
  staging:iio:hmc5843: Reorganize _set_meas_conf()
  staging:iio:hmc5843: Rename _set_rate() to _set_samp_freq()
  staging:iio:hmc5843: Introduce _set_range_gain()
  staging:iio:hmc5843: Check initialization and chip identifier
  staging:iio:hmc5843: Trivial cleanups

 drivers/staging/iio/magnetometer/hmc5843.c | 482 ++++++++++++++---------------
 1 file changed, 230 insertions(+), 252 deletions(-)

-- 
1.8.4

