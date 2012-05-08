Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:54481 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755953Ab2EHWVR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 May 2012 18:21:17 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de
Subject: iio: v2, add support for HMC5883/HMC5883L to HMC5843 driver
Date: Wed,  9 May 2012 00:19:58 +0200
Message-Id: <1336515606-12364-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

here is my updated patch series to extend the HMC5843 magnetometer 
driver to support the HMC5883/HMC5883L devices

patch 1 fixes access issues to the hmc5843 private data,
patches 2 to 7 are preparatory patches,
patch 8 actually brings in the support for the new devices

the timeout in the read loop has not yet been implemented (suggestions by 
Lars-Peter Clausen)

the driver has a severe limitation: X/Y/Z must ALL be read to allow new
data to become available (the device goes into a locked state until all 
are read)

