Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:49582 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbdKEXZG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Nov 2017 18:25:06 -0500
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 2/2] Documentation: iio: Fix typo
Date: Mon,  6 Nov 2017 00:25:00 +0100
Message-Id: <1509924300-14634-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509924300-14634-1-git-send-email-pmeerw@pmeerw.net>
References: <1509924300-14634-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2e3f919..a478740 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1290,7 +1290,7 @@ KernelVersion:	3.4
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Unit-less light intensity. Modifiers both and ir indicate
-		that measurements contains visible and infrared light
+		that measurements contain visible and infrared light
 		components or just infrared light, respectively. Modifier uv indicates
 		that measurements contain ultraviolet light components.
 
-- 
2.7.4

