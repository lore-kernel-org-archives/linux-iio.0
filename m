Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4757 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbaL2Jsu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 29 Dec 2014 04:48:50 -0500
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH] staging: iio: dummy: fix compile error when not using buffering
Date: Mon, 29 Dec 2014 11:50:16 +0200
Message-Id: <1419846616-31441-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit 4ae03019923f ("staging:iio:dummy: Register same channels for
device and buffer") has changed the number of parameters for
iio_simple_dummy_configure_buffer() only for the IIO_SIMPLE_DUMMY_BUFFER
case.  Fix this by also changing the placeholder function declared in
the header when buffering is not enabled.

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/staging/iio/iio_simple_dummy.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.h b/drivers/staging/iio/iio_simple_dummy.h
index af70126..34989bf 100644
--- a/drivers/staging/iio/iio_simple_dummy.h
+++ b/drivers/staging/iio/iio_simple_dummy.h
@@ -117,8 +117,7 @@ enum iio_simple_dummy_scan_elements {
 int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev);
 void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev);
 #else
-static inline int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *channels, unsigned int num_channels)
+static inline int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 {
 	return 0;
 };
-- 
1.9.1

