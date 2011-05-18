Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 079/111] staging:iio:max1363 trivial removal of unused trig pointer.
Date: Wed, 18 May 2011 14:42:09 +0100
Message-Id: <1305726161-5606-80-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index 2d41a27..15227bd 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -195,7 +195,6 @@ struct max1363_state {
 	const struct max1363_chip_info	*chip_info;
 	const struct max1363_mode	*current_mode;
 	u32				requestedmask;
-	struct iio_trigger		*trig;
 	struct regulator		*reg;
 
 	/* Using monitor modes and buffer at the same time is
-- 
1.7.3.4
