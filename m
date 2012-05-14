Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42398 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932528Ab2ENW3A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 May 2012 18:29:00 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org, marek.belisko@gmail.com,
	shubhrajyoti@ti.com
Subject: iio: v3, add support for HMC5883/HMC5883L to HMC5843 driver
Date: Tue, 15 May 2012 00:27:25 +0200
Message-Id: <1337034454-29717-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

here is a v3 patch series to extend the HMC5843 magnetometer 
driver to support the HMC5883/HMC5883L devices

patch 1 fixes access issues to the hmc5843 private data,
patches 2 to 8 are preparatory patches,
patch 9 actually brings in the support for the new devices

patches 1 to 7 are same as v2
patch 8 is new and splits out one modification as suggested
patch 9 addresses all review comments (see detailed history there)

the timeout in the read loop has not yet been implemented (suggestions by 
Lars-Peter Clausen)

the driver has a severe limitation: X/Y/Z must ALL be read to allow new
data to become available (the device goes into a locked state until all 
are read), discussed but not worked on yet

Belisko Marek is also working on HMC5883 support and intends to improve the
driver once merged

