Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-124.synserver.de ([212.40.185.124]:1076 "EHLO
	smtp-out-124.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527Ab2JROmG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2012 10:42:06 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] staging:iio: Don't compare boolean values with true/false
Date: Thu, 18 Oct 2012 16:43:16 +0200
Message-Id: <1350571399-17723-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes the following coccicheck warnings:
	drivers/staging/iio/accel/lis3l02dq_ring.c:240:5-10: WARNING: Comparison to bool
	drivers/staging/iio/iio_dummy_evgen.c:111:6-25: WARNING: Comparison to bool

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c |    2 +-
 drivers/staging/iio/iio_dummy_evgen.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index fa4190d..ee887e9 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -237,7 +237,7 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	u8 t;
 
 	__lis3l02dq_write_data_ready_config(indio_dev, state);
-	if (state == false) {
+	if (!state) {
 		/*
 		 * A possible quirk with the handler is currently worked around
 		 * by ensuring outstanding read events are cleared.
diff --git a/drivers/staging/iio/iio_dummy_evgen.c b/drivers/staging/iio/iio_dummy_evgen.c
index 74e24e8..132d278 100644
--- a/drivers/staging/iio/iio_dummy_evgen.c
+++ b/drivers/staging/iio/iio_dummy_evgen.c
@@ -108,7 +108,7 @@ int iio_dummy_evgen_get_irq(void)
 
 	mutex_lock(&iio_evgen->lock);
 	for (i = 0; i < IIO_EVENTGEN_NO; i++)
-		if (iio_evgen->inuse[i] == false) {
+		if (!iio_evgen->inuse[i]) {
 			ret = iio_evgen->base + i;
 			iio_evgen->inuse[i] = true;
 			break;
-- 
1.7.10.4

