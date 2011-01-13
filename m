Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.work-microwave.de ([62.245.205.51]:53747 "EHLO
	work-microwave.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755768Ab1AMNKB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jan 2011 08:10:01 -0500
From: Roland Stigge <rst@work-microwave.de>
To: linux-iio@vger.kernel.org
Cc: Roland Stigge <rst@work-microwave.de>
Subject: [PATCH 3/3] iio: Fixed documentation
Date: Thu, 13 Jan 2011 14:09:52 +0100
Message-Id: <1294924192-28923-3-git-send-email-rst@work-microwave.de>
In-Reply-To: <1294924192-28923-1-git-send-email-rst@work-microwave.de>
References: <1294924192-28923-1-git-send-email-rst@work-microwave.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Removed reference to named versions.
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index e993fe2..8e5d8d1 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -228,9 +228,7 @@ KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled, no bias etc.) output voltage for
-		channel Y. In special cases where the channel does not
-		correspond to externally available output one of the named
-		versions may be used. The number must always be specified and
+		channel Y.  The number must always be specified and
 		unique if the output corresponds to a single channel.
 
 What:		/sys/bus/iio/devices/deviceX/outY&Z_raw
-- 
1.7.2.3

