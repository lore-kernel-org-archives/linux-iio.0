Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:42924 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbaF0QUX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jun 2014 12:20:23 -0400
Received: by mail-we0-f178.google.com with SMTP id x48so5476056wes.23
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2014 09:20:22 -0700 (PDT)
From: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de,
	yannick.bedhomme@mobile-devices.fr,
	Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Subject: [PATCH 1/2] iio: staging: sca3000: hide stufftoread logic
Date: Fri, 27 Jun 2014 18:20:00 +0200
Message-Id: <1403886001-23354-2-git-send-email-josselin.costanzi@mobile-devices.fr>
In-Reply-To: <1403886001-23354-1-git-send-email-josselin.costanzi@mobile-devices.fr>
References: <1403886001-23354-1-git-send-email-josselin.costanzi@mobile-devices.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Change sca3000_ring implementation so that it exports a data_available
function to iio.

Signed-off-by: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
---
 drivers/iio/industrialio-buffer.c        | 5 +----
 drivers/staging/iio/accel/sca3000_ring.c | 6 ++++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 36b1ae9..2952ee0 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -39,10 +39,7 @@ static bool iio_buffer_is_active(struct iio_buffer *buf)
 
 static bool iio_buffer_data_available(struct iio_buffer *buf)
 {
-	if (buf->access->data_available)
-		return buf->access->data_available(buf);
-
-	return buf->stufftoread;
+	return buf->access->data_available(buf);
 }
 
 /**
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 1987106..33f0e92 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -141,6 +141,11 @@ static int sca3000_ring_get_bytes_per_datum(struct iio_buffer *r)
 	return 6;
 }
 
+static bool sca3000_ring_buf_data_available(struct iio_buffer *r)
+{
+	return r->stufftoread;
+}
+
 static IIO_BUFFER_ENABLE_ATTR;
 static IIO_BUFFER_LENGTH_ATTR;
 
@@ -274,6 +279,7 @@ static const struct iio_buffer_access_funcs sca3000_ring_access_funcs = {
 	.read_first_n = &sca3000_read_first_n_hw_rb,
 	.get_length = &sca3000_ring_get_length,
 	.get_bytes_per_datum = &sca3000_ring_get_bytes_per_datum,
+	.data_available = sca3000_ring_buf_data_available,
 	.release = sca3000_ring_release,
 };
 
-- 
1.9.1

