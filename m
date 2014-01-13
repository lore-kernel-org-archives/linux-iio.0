Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47952 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102AbaAMVRD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 13 Jan 2014 16:17:03 -0500
Received: from localhost.localdomain (83-215-0-241.stadt.dyn.salzburg-online.at [83.215.0.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pmeerw)
	by pmeerw.net (Postfix) with ESMTPSA id 57B2AC50001
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2014 22:16:59 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Subject: [PATCH 0/6] some staging:iio:access:sca3000 cleanup
Date: Mon, 13 Jan 2014 22:16:56 +0100
Message-Id: <1389647817-31320-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

sca3000 seems to be broken, esp. for the chip variant that supports
temperature (no event_attribute_group, no channels at all registered, 
this variant seem to be ... not popular :)

this series cleans kerneldoc and comments (patches 1, 2), adds the 
event_attribute_group for the temp_output case (patch 3), registers channels
for the temp_output case (patch 4), uses IIO_TEMP instead of DEV_ATTR_TEMP
(patch 5), and cleans sca3000.h

I'm not sure if it is worth cleaning up this old sensor
driver, but still...

my motivation was to get rid of DEV_ATTR_TEMP which is only used in staging by
accel/sca3000 and meter/ade7* and superceeded (?) by IIO_TEMP

ciao, p.

Peter Meerwald (6):
  staging:iio:accel:sca3000: Fix kerneldoc
  staging:iio:accel:sca3000: Fix format of comments
  staging:iio:accel:sca3000: Event_attribute_group seems to be missing
    for _info_with_temp
  staging:iio:accel:sca3000: Channels missing in temp_output case
  staging:iio:accel:sca3000: Move temperature attribute to channels
  staging:iio:accel:sca3000: Cleanup sca3000.h

 drivers/staging/iio/accel/sca3000.h      |  26 +++--
 drivers/staging/iio/accel/sca3000_core.c | 172 +++++++++++++------------------
 2 files changed, 90 insertions(+), 108 deletions(-)

-- 
1.8.3.2

