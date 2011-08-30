Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:42956 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab1H3LdL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2011 07:33:11 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 04/14] staging:iio: remove orphaned function definition.
Date: Tue, 30 Aug 2011 12:41:09 +0100
Message-Id: <1314704479-15956-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
References: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

