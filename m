Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:57733 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402Ab1DMNlW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Apr 2011 09:41:22 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/12] staging:iio:light:tsl2563 constify gain level table.
Date: Wed, 13 Apr 2011 14:42:57 +0100
Message-Id: <1302702187-953-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1302702187-953-1-git-send-email-jic23@cam.ac.uk>
References: <1302702187-953-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Trivial cleanup.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/tsl2563.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 8c00584..19b7215 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -92,7 +92,7 @@ struct tsl2563_gainlevel_coeff {
 	u16 max;
 };
 
-static struct tsl2563_gainlevel_coeff tsl2563_gainlevel_table[] = {
+static const struct tsl2563_gainlevel_coeff tsl2563_gainlevel_table[] = {
 	{
 		.gaintime	= TSL2563_TIMING_400MS | TSL2563_TIMING_GAIN16,
 		.min		= 0,
@@ -122,7 +122,7 @@ struct tsl2563_chip {
 	/* Remember state for suspend and resume functions */
 	pm_message_t		state;
 
-	struct tsl2563_gainlevel_coeff *gainlevel;
+	struct tsl2563_gainlevel_coeff const *gainlevel;
 
 	u16			low_thres;
 	u16			high_thres;
-- 
1.7.3.4

