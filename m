Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:60235 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932961Ab2DMJnI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 05:43:08 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 14/14] staging:iio:core drop the IIO_CHAN macro for ease of maintenance.
Date: Fri, 13 Apr 2012 10:43:00 +0100
Message-Id: <1334310180-22170-15-git-send-email-jic23@kernel.org>
In-Reply-To: <1334310180-22170-1-git-send-email-jic23@kernel.org>
References: <1334310180-22170-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I was warned long ago that this macro would cause trouble but didn't
heed the advice, hence I'm unwinding it now!

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio.h |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 4824812..fa6fca0 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -176,23 +176,6 @@ struct iio_chan_spec {
 #define IIO_ST(si, rb, sb, sh)						\
 	{ .sign = si, .realbits = rb, .storagebits = sb, .shift = sh }
 
-/* Macro assumes input channels */
-#define IIO_CHAN(_type, _mod, _indexed, _proc, _name, _chan, _chan2, \
-		 _inf_mask, _address, _si, _stype, _event_mask)		\
-	{ .type = _type,						\
-	  .output = 0,							\
-	  .modified = _mod,						\
-	  .indexed = _indexed,						\
-	  .processed_val = _proc,					\
-	  .extend_name = _name,						\
-	  .channel = _chan,						\
-	  .channel2 = _chan2,						\
-	  .info_mask = _inf_mask,					\
-	  .address = _address,						\
-	  .scan_index = _si,						\
-	  .scan_type = _stype,						\
-	  .event_mask = _event_mask }
-
 #define IIO_CHAN_SOFT_TIMESTAMP(_si)					\
 	{ .type = IIO_TIMESTAMP, .channel = -1,				\
 			.scan_index = _si, .scan_type = IIO_ST('s', 64, 64, 0) }
-- 
1.7.0.4

