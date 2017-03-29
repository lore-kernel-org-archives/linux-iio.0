Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35710 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbdC2FJP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 01:09:15 -0400
Date: Wed, 29 Mar 2017 10:39:09 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: lars@metafoo.de
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: iio: Use devm functions
Message-ID: <20170329050909.GA18738@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use managed resource functions devm_request_irq instead of request_irq.
Remove corresponding calls to free_irq in the probe.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 4e0b4eedb53d..42473d095911 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -211,8 +211,9 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
-	ret = request_irq(st->irq, iio_bfin_tmr_trigger_isr,
-			  0, st->trig->name, st);
+	ret = devm_request_irq(&pdev->dev,
+			       st->irq, iio_bfin_tmr_trigger_isr,
+			       0, st->trig->name, st);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"request IRQ-%d failed", st->irq);
@@ -256,7 +257,6 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
 
 	return 0;
 out_free_irq:
-	free_irq(st->irq, st);
 out1:
 	iio_trigger_unregister(st->trig);
 out:
@@ -271,7 +271,6 @@ static int iio_bfin_tmr_trigger_remove(struct platform_device *pdev)
 	disable_gptimers(st->t->bit);
 	if (st->output_enable)
 		peripheral_free(st->t->pin);
-	free_irq(st->irq, st);
 	iio_trigger_unregister(st->trig);
 	iio_trigger_free(st->trig);
 
-- 
2.11.0

