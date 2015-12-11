Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38579 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321AbbLKQtb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Dec 2015 11:49:31 -0500
Received: by wmec201 with SMTP id c201so78320006wme.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Dec 2015 08:49:30 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH 2/3] iio: ina2xx: give the capture kthread a more useful name string.
Date: Fri, 11 Dec 2015 17:49:16 +0100
Message-Id: <1449852557-3138-2-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1449852557-3138-1-git-send-email-mtitinger@baylibre.com>
References: <1449852557-3138-1-git-send-email-mtitinger@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

  PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
  144     2 root     DW       0   0%  33% [ina226:1-8800us]
  141     2 root     DW       0   0%  25% [ina226:0-8800us]
   40     2 root     SW       0   0%  15% [irq/156-4802a00]
  147     2 root     DW       0   0%   7% [ina226:2-8800us]
  145     1 root     S     1236   0%   6% dd if /dev/iio:device1 of /dev/null
  148     1 root     S     1236   0%   4% dd if /dev/iio:device2 of /dev/null
  149   137 root     R     1244   0%   3% top -d 1
  142     1 root     S     1236   0%   2% dd if /dev/iio:device0 of /dev/null

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 drivers/iio/adc/ina2xx-adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index fe42872..99afa6e 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -542,7 +542,8 @@ int ina2xx_buffer_enable(struct iio_dev *indio_dev)
 	chip->prev_ns = iio_get_time_ns();
 
 	chip->task = kthread_run(ina2xx_capture_thread, (void *)indio_dev,
-				 "ina2xx-%uus", sampling_us);
+				 "%s:%d-%uus", indio_dev->name, indio_dev->id,
+				 sampling_us);
 
 	return PTR_ERR_OR_ZERO(chip->task);
 }
-- 
1.9.1

