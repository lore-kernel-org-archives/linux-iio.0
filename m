Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/3] staging:iio:buffer scrap to_iio_buffer as it no longer has meaning.
Date: Sun, 27 Nov 2011 14:46:51 +0000
Message-Id: <1322405213-13570-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1322405213-13570-1-git-send-email-jic23@kernel.org>
References: <1322405213-13570-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Now buffers do not have a specific dev structure, this is garbage.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/buffer.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 7272333..501d4ee 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -129,9 +129,6 @@ int iio_scan_mask_query(struct iio_buffer *buffer, int bit);
  **/
 int iio_scan_mask_set(struct iio_buffer *buffer, int bit);
 
-#define to_iio_buffer(d)				\
-	container_of(d, struct iio_buffer, dev)
-
 /**
  * iio_push_to_buffer() - push to a registered buffer.
  * @buffer:		IIO buffer structure for device
-- 
1.7.7.3
