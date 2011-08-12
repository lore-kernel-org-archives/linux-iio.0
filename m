Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/12] staging:iio:dac:ad5504 dereferencing just freed st in error path.
Date: Fri, 12 Aug 2011 16:55:33 +0100
Message-Id: <1313164538-1769-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
References: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Introduced when I did the iio_chan_spec conversion. Detected by smatch.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/ad5504.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 1915f45..88512dd 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -338,7 +338,7 @@ error_free_dev:
 	iio_free_device(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(reg))
-		regulator_disable(st->reg);
+		regulator_disable(reg);
 error_put_reg:
 	if (!IS_ERR(reg))
 		regulator_put(reg);
-- 
1.7.3.4
