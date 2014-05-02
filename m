Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43755 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbaEBIJv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 2 May 2014 04:09:51 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org
Subject: [PATCH 0/2] iio:magnetometer:mag3110, missing patches
Date: Fri,  2 May 2014 10:09:45 +0200
Message-Id: <1399018187-29742-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

two patches are still missing for the mag3110 driver that
were posted in January, see
http://comments.gmane.org/gmane.linux.kernel.iio/10871

I think these patches could/should be applied now

thanks, p.

Peter Meerwald (2):
  iio:magnetometer:mag3110: Fix initialization of ctrl_reg1
  iio:magnetometer:mag3110: Enable user offset calibration

 drivers/iio/magnetometer/mag3110.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
1.9.1

