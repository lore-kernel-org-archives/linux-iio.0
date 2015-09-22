Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:37589 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbbIVPik (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2015 11:38:40 -0400
From: Peter Rosin <peda@lysator.liu.se>
To: linux-iio@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Crt Mori <cmo@melexis.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Andreas Dannenberg <dannenberg@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Peter Rosin <peda@lysator.liu.se>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] iio: resistance: Document that resistance can be output
Date: Tue, 22 Sep 2015 17:36:48 +0200
Message-Id: <1442936209-27057-2-git-send-email-peda@lysator.liu.se>
In-Reply-To: <1442936209-27057-1-git-send-email-peda@lysator.liu.se>
References: <1442936209-27057-1-git-send-email-peda@lysator.liu.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/ABI/testing/sysfs-bus-iio |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 9398484196c4..2eea468f704d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1475,6 +1475,8 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_resistance_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceX_raw
 KernelVersion:	4.3
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
1.7.10.4

