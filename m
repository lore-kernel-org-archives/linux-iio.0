Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hotel311.server4you.de ([85.25.146.15]:44635 "EHLO
	hotel311.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933748AbcHDOBV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2016 10:01:21 -0400
From: Daniel Wagner <wagi@monom.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH 2/2] iio: sx9500: Use complete() instead of complete_all()
Date: Thu,  4 Aug 2016 15:07:10 +0200
Message-Id: <1470316030-4153-3-git-send-email-wagi@monom.org>
In-Reply-To: <1470316030-4153-1-git-send-email-wagi@monom.org>
References: <1470316030-4153-1-git-send-email-wagi@monom.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

There is only one waiter for the completion, therefore there
is no need to use complete_all(). Let's make that clear by
using complete() instead of complete_all().

The usage pattern of the completion is:

waiter context                          waker context

sx9500_read_proximity()
  sx9500_inc_chan_users()
  sx9500_inc_data_rdy_users()
  wait_for_completion_interruptible()

                                        s9500_irq_thread_handler()
                                          complete()

  reinit_completion()

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 drivers/iio/proximity/sx9500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 1d74b3a..6f84f53 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -516,7 +516,7 @@ static irqreturn_t sx9500_irq_thread_handler(int irq, void *private)
 		sx9500_push_events(indio_dev);
 
 	if (val & SX9500_CONVDONE_IRQ)
-		complete_all(&data->completion);
+		complete(&data->completion);
 
 out:
 	mutex_unlock(&data->mutex);
-- 
2.7.4
