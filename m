Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hotel311.server4you.de ([85.25.146.15]:44634 "EHLO
	hotel311.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933748AbcHDOBZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2016 10:01:25 -0400
From: Daniel Wagner <wagi@monom.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH 1/2] iio: adc: Use complete() instead of complete_all()
Date: Thu,  4 Aug 2016 15:07:09 +0200
Message-Id: <1470316030-4153-2-git-send-email-wagi@monom.org>
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

nau7802_read_irq()
  reinit_completion()
  nau7802_read_conversion()
  wait_for_completion_interruptible_timeout()

                                        nau7802_eoc_trigger()
                                          complete()

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 drivers/iio/adc/nau7802.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index db9b829..08f4466 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -197,7 +197,7 @@ static irqreturn_t nau7802_eoc_trigger(int irq, void *private)
 	if (st->conversion_count < NAU7802_MIN_CONVERSIONS)
 		st->conversion_count++;
 	if (st->conversion_count >= NAU7802_MIN_CONVERSIONS)
-		complete_all(&st->value_ok);
+		complete(&st->value_ok);
 
 	return IRQ_HANDLED;
 }
-- 
2.7.4
