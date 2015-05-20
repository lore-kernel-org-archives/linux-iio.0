Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36113 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbbETAeo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2015 20:34:44 -0400
Received: by igbpi8 with SMTP id pi8so90008816igb.1
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2015 17:34:44 -0700 (PDT)
Date: Tue, 19 May 2015 19:34:35 -0500
From: Michael Welling <mwelling@ieee.org>
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: BBB touch screen and ADC interactions
Message-ID: <20150520003435.GA16055@deathray>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87CFA4@sfamail.SAKURAUS.LOCAL>
 <20150513011137.GA23255@deathray>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D113@sfamail.SAKURAUS.LOCAL>
 <20150519230932.GA15718@deathray>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D46F@sfamail.SAKURAUS.LOCAL>
 <F4A1ABDE-E030-405D-A0BB-A4CD80E9F84F@ieee.org>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D47E@sfamail.SAKURAUS.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D47E@sfamail.SAKURAUS.LOCAL>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 19, 2015 at 05:16:46PM -0700, Greg Wilson-Lindberg wrote:
> 
> I would be happy to test the patch, better than what I was going to try.
> 
> -Greg

Below is the simple workaround patch that I used to eliminate the repeated
release events that were occurring without touching the screen.

See if it helps.

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 191a1b8..f876097 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -281,13 +281,11 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	if (status & IRQENB_PENUP) {
 		fsm = titsc_readl(ts_dev, REG_ADCFSM);
 		if (fsm == ADCFSM_STEPID) {
-			ts_dev->pen_down = false;
 			input_report_key(input_dev, BTN_TOUCH, 0);
 			input_report_abs(input_dev, ABS_PRESSURE, 0);
 			input_sync(input_dev);
-		} else {
-			ts_dev->pen_down = true;
 		}
+		ts_dev->pen_down = false;
 		irqclr |= IRQENB_PENUP;
 	}
 
