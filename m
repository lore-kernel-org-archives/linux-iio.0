Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:48507 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757848Ab1F0J5H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2011 05:57:07 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, anish <anish198519851985@gmail.com>
Subject: [PATCH 53/54] staging: IIO corrected the spelling in iio-trig-gpio
Date: Mon, 27 Jun 2011 11:05:03 +0100
Message-Id: <1309169104-22139-54-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: anish <anish198519851985@gmail.com>

Corrected the spelling.

Signed-off-by: anish kumar <anish198519851985@gmail.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/trigger/iio-trig-gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-gpio.c b/drivers/staging/iio/trigger/iio-trig-gpio.c
index b188635..f1fb795 100644
--- a/drivers/staging/iio/trigger/iio-trig-gpio.c
+++ b/drivers/staging/iio/trigger/iio-trig-gpio.c
@@ -7,7 +7,7 @@
  * under the terms of the GNU General Public License version 2 as published by
  * the Free Software Foundation.
  *
- * Currently this is more of a functioning proof of concept that a fully
+ * Currently this is more of a functioning proof of concept than a full
  * fledged trigger driver.
  *
  * TODO:
-- 
1.7.3.4

