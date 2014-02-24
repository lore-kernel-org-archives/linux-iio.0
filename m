Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48354 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbaBXNNj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Feb 2014 08:13:39 -0500
From: Juergen Beisert <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Mon, 24 Feb 2014 14:16:24 +0100
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	devel@driverdev.osuosl.org, marex@denx.de,
	fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
	jic23@cam.ac.uk, linux-input@vger.kernel.org
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <52CEA4AA.8050503@free-electrons.com> <201401100955.45885.jbe@pengutronix.de>
In-Reply-To: <201401100955.45885.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201402241416.24270.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Alexandre,

> While I don't have much experience with the TS part of the code but I
> can investigate if you don't have any idea.

can you please test the following patch?
After releasing the touchscreen the internal state machine was left in a
wrong state.

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index e2dd783..558a76c 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -698,6 +698,7 @@ static void mxs_lradc_finish_touch_event(struct mxs_lradc *lradc, bool valid)
        }

        /* if it is released, wait for the next touch via IRQ */
+       lradc->cur_plate = LRADC_TOUCH;
        mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
        mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
 }

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-5121-206917-5128 |
Peiner Str. 6-8, 31137 Hildesheim, Germany    | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
