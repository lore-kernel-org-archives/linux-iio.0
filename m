Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-242.synserver.de ([212.40.185.242]:1052 "EHLO
	smtp-out-238.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751479AbaHRIJH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Aug 2014 04:09:07 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MAINTAINERS: Add entry for Analog Devices IIO drivers
Date: Mon, 18 Aug 2014 10:08:59 +0200
Message-Id: <1408349339-21757-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add Michael and myself as the maintainer for the Analog Devices IIO drivers.
The entry matches on all files in drivers/staging/iio and drivers/iio/ starting
with the 'ad' prefix, except for 'adjd' as that one is used by Avago
Technologies.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d2c52e..894756c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -667,6 +667,16 @@ W:	http://blackfin.uclinux.org/
 S:	Supported
 F:	sound/soc/blackfin/*
 
+ANALOG DEVICES INC IIO DRIVERS
+M:	Lars-Peter Clausen <lars@metafoo.de>
+M: Michael Hennerich <Michael.Hennerich@analog.com>
+W:	http://wiki.analog.com/
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/*/ad*
+X:	drivers/iio/*/adjd*
+F:	drivers/staging/iio/*/ad*
+F:	staging/iio/trigger/iio-trig-bfin-timer.c
+
 AOA (Apple Onboard Audio) ALSA DRIVER
 M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linuxppc-dev@lists.ozlabs.org
-- 
1.8.0

