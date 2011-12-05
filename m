Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/7] staging:iio: add hook to allow core to perform scan related config.
Date: Mon,  5 Dec 2011 21:37:12 +0000
Message-Id: <1323121036-21094-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1323121036-21094-1-git-send-email-jic23@kernel.org>
References: <1323121036-21094-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 95d6318..4fb8f2f 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -262,7 +262,8 @@ struct iio_info {
 				 int val);
 	int (*validate_trigger)(struct iio_dev *indio_dev,
 				struct iio_trigger *trig);
-
+	int (*update_scan_mode)(struct iio_dev *indio_dev,
+				const unsigned long *scan_mask);
 };
 
 /**
-- 
1.7.7.4
