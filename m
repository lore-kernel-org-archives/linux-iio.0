Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:41616 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754941AbcGELzq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 07:55:46 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 3/9] staging: iio: isl29018: Drop newlines
Date: Tue,  5 Jul 2016 13:55:38 +0200
Message-Id: <1467719744-19450-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
References: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/staging/iio/light/isl29018.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 875007f..9b3ca0e 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -215,7 +215,6 @@ static int isl29018_read_lux(struct isl29018_chip *chip, int *lux)
 
 	lux_data = isl29018_read_sensor_input(chip,
 					      ISL29018_CMD1_OPMODE_ALS_ONCE);
-
 	if (lux_data < 0)
 		return lux_data;
 
@@ -233,7 +232,6 @@ static int isl29018_read_ir(struct isl29018_chip *chip, int *ir)
 
 	ir_data = isl29018_read_sensor_input(chip,
 					     ISL29018_CMD1_OPMODE_IR_ONCE);
-
 	if (ir_data < 0)
 		return ir_data;
 
@@ -271,7 +269,6 @@ static int isl29018_read_proximity_ir(struct isl29018_chip *chip, int scheme,
 
 	ir_data = isl29018_read_sensor_input(chip,
 					     ISL29018_CMD1_OPMODE_IR_ONCE);
-
 	if (ir_data < 0)
 		return ir_data;
 
-- 
1.7.10.4

