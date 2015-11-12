Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33645 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbbKLNMx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2015 08:12:53 -0500
Received: by lffz63 with SMTP id z63so33737650lff.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2015 05:12:51 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio: st_sensors: request any context IRQ
Date: Thu, 12 Nov 2015 14:12:44 +0100
Message-Id: <1447333964-10276-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It really doesn't matter if the poll is triggered from a
fastpath or threaded IRQ, the IIO core runs its own interrupt
thread anyway. Sometimes this is connected to a hard IRQ line,
sometimes to something on an I2C expander that needs to
run from a thread, so request any context IRQ.

Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 3c0aa17d753f..e33796cdd607 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -32,9 +32,8 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 		goto iio_trigger_alloc_error;
 	}
 
-	err = request_threaded_irq(sdata->get_irq_data_ready(indio_dev),
+	err = request_any_context_irq(sdata->get_irq_data_ready(indio_dev),
 			iio_trigger_generic_data_rdy_poll,
-			NULL,
 			IRQF_TRIGGER_RISING,
 			sdata->trig->name,
 			sdata->trig);
-- 
2.4.3

