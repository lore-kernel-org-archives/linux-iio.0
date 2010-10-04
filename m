Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:51876 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756338Ab0JDPwm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Oct 2010 11:52:42 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 13/16] staging:iio:light remove empty light.h file
Date: Mon,  4 Oct 2010 16:58:02 +0100
Message-Id: <1286207885-26689-14-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We can put this back when there is something to put in it!

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/light.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/light.h b/drivers/staging/iio/light/light.h
deleted file mode 100644
index 8328658..0000000
--- a/drivers/staging/iio/light/light.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#include "../sysfs.h"
-
-/* Light to digital sensor attributes */
-
-
-- 
1.7.2.2

