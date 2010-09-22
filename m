Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:58424 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805Ab0IVLmh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2010 07:42:37 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: manuel.stahl@iis.fraunhofer.de, linux-iio@vger.kernel.org
Cc: drivers@analog.com
Subject: [PATCH 1/8] staging:iio:adis16350 bug in spi bus speed setup
Date: Wed, 22 Sep 2010 12:47:46 +0100
Message-Id: <1285156073-6327-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1285156073-6327-1-git-send-email-jic23@cam.ac.uk>
References: <1285156073-6327-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>

Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Acked-by: Jonathan Cameron  <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16350_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index cc33843..fd39dd9 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -467,7 +467,7 @@ static int adis16350_initial_setup(struct adis16350_state *st)
 	/* use high spi speed if possible */
 	ret = adis16350_spi_read_reg_16(dev, ADIS16350_SMPL_PRD, &smp_prd);
 	if (!ret && (smp_prd & ADIS16350_SMPL_PRD_DIV_MASK) < 0x0A) {
-		st->us->max_speed_hz = ADIS16350_SPI_SLOW;
+		st->us->max_speed_hz = ADIS16350_SPI_FAST;
 		spi_setup(st->us);
 	}
 
-- 
1.7.2.2

