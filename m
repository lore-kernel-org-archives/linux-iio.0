Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:49575 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755242Ab2GAKUP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 1 Jul 2012 06:20:15 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: kernel version typo in sysfs-bus-iio
Date: Sun,  1 Jul 2012 12:20:11 +0200
Message-Id: <1341138013-28267-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1341138013-28267-1-git-send-email-pmeerw@pmeerw.net>
References: <1341138013-28267-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a3774a7..2f06d40 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -275,7 +275,7 @@ What:		/sys/.../iio:deviceX/in_voltage-voltage_scale_available
 What:		/sys/.../iio:deviceX/out_voltageX_scale_available
 What:		/sys/.../iio:deviceX/out_altvoltageX_scale_available
 What:		/sys/.../iio:deviceX/in_capacitance_scale_available
-KernelVersion:	2.635
+KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		If a discrete set of scale values is available, they
-- 
1.7.9.5

