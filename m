Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 04/14] staging:iio: remove orphaned function definition.
Date: Fri, 26 Aug 2011 11:05:38 +0100
Message-Id: <1314353148-6670-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353148-6670-1-git-send-email-jic23@cam.ac.uk>
References: <1314353148-6670-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I have no idea what this was, or what it did, but it doesn't
do it any more.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_generic.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index db8d0d1..a63a9cb 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -211,8 +211,6 @@ int iio_ring_buffer_register_ex(struct iio_dev *indio_dev, int id,
 				const struct iio_chan_spec *channels,
 				int num_channels);
 
-void iio_ring_access_release(struct device *dev);
-
 /**
  * iio_ring_buffer_unregister() - unregister the buffer from IIO core
  * @indio_dev: the device with the buffer to be unregistered
-- 
1.7.3.4
