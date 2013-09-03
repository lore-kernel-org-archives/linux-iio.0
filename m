Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33376 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756373Ab3ICBFc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:05:32 -0400
Received: from sirene.lan (83-215-0-241.stadt.dyn.salzburg-online.at [83.215.0.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pmeerw)
	by pmeerw.net (Postfix) with ESMTPSA id 68321C50171
	for <linux-iio@vger.kernel.org>; Tue,  3 Sep 2013 03:05:28 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Subject: [PATCH 00/18] Cleanup hmc5843 magnetometer driver in staging
Date: Tue,  3 Sep 2013 03:05:02 +0200
Message-Id: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

some more cleanup and reorganization

patch 1 fixes a conversion bug introduced recently, sorry
patch 5 makes use of SAMP_FREQ chan_info
patch 8 adds helper functions to show/check int.micro pairs -- maybe 
  useful elsewhere?
patch 9 makes use of CALIBSCALE to adjust gain
patch 10 forces read of all channel data, no matter how much is actually
  needed
patch 11 add trigger handling
patch 13 drops the operating_mode attribute
patch 18 adds init checks

 drivers/staging/iio/magnetometer/hmc5843.c |  632 +++++++++++++---------------
 1 file changed, 297 insertions(+), 335 deletions(-)

-- 
1.7.9.5

