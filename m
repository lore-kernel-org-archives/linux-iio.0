Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:39051 "EHLO
	ppsw-6.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933424Ab0CKRuy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 11 Mar 2010 12:50:54 -0500
Message-ID: <4B99288C.3080601@cam.ac.uk>
Date: Thu, 11 Mar 2010 17:29:48 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PATCH] staging:iio:lis3l02dq - incorrect ws used in container of
 call.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Signed-of-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 The word oops comes to mind.  Original patch to merge the two work queues
 in here (prior to Greg taking them into staging) changed the top half to
 only use one of them and the bottom half to assume it was the other.

 Currently causes a NULL pointer dereference if you enable any of the events
 on an lis3l02dq. Just goes to show I need a few more regression tests.

 drivers/staging/iio/accel/lis3l02dq_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index f008837..56ab337 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -617,7 +617,7 @@ static int lis3l02dq_thresh_handler_th(struct iio_dev *dev_info,
 static void lis3l02dq_thresh_handler_bh_no_check(struct work_struct *work_s)
 {
 	struct iio_work_cont *wc
-		= container_of(work_s, struct iio_work_cont, ws_nocheck);
+		= container_of(work_s, struct iio_work_cont, ws);
 	struct lis3l02dq_state *st = wc->st;
 	u8 t;
 
-- 
1.6.4.4

