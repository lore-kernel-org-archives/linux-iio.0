Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53825 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965346Ab1GMLwF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Jul 2011 07:52:05 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/3] staging:iio:accel:lis3l02dq: fix incorrect pointer passed to spi_set_drvdata.
Date: Wed, 13 Jul 2011 12:51:59 +0100
Message-Id: <1310557920-30519-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310557920-30519-1-git-send-email-jic23@cam.ac.uk>
References: <1310557920-30519-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This mean all sorts of interesting results on driver removal.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index ba5bc67..a29dfd2 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -676,7 +676,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	}
 	st = iio_priv(indio_dev);
 	/* this is only used tor removal purposes */
-	spi_set_drvdata(spi, st);
+	spi_set_drvdata(spi, indio_dev);
 
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-- 
1.7.3.4

