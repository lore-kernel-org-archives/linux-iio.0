Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 73/99] staging:iio:max1363 trivial removal of unused trig pointer.
Date: Wed,  4 May 2011 12:58:45 +0100
Message-Id: <1304510351-10922-74-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
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
