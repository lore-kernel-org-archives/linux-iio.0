Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.work-microwave.de ([62.245.205.51]:49648 "EHLO
	work-microwave.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751951Ab1AMNKA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jan 2011 08:10:00 -0500
From: Roland Stigge <rst@work-microwave.de>
To: linux-iio@vger.kernel.org
Cc: Roland Stigge <rst@work-microwave.de>,
	Roland Stigge <stigge@antcom.de>
Subject: [PATCH 2/3] iio: Documentation update for outputs / dac
Date: Thu, 13 Jan 2011 14:09:51 +0100
Message-Id: <1294924192-28923-2-git-send-email-rst@work-microwave.de>
In-Reply-To: <1294924192-28923-1-git-send-email-rst@work-microwave.de>
References: <1294924192-28923-1-git-send-email-rst@work-microwave.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added documentation for outX_raw, outX&Y_raw and outX_scale sysfs iio interface

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index 38b9813..e993fe2 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -233,7 +233,7 @@ Description:
 		versions may be used. The number must always be specified and
 		unique if the output corresponds to a single channel.
 
-What:		/sys/bus/iio/devices/deviceX/outY&Z&..._raw
+What:		/sys/bus/iio/devices/deviceX/outY&Z_raw
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
1.7.2.3

