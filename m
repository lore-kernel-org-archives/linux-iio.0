Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:33097 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbaBXNeT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Feb 2014 08:34:19 -0500
Date: Mon, 24 Feb 2014 16:33:16 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Juergen Beisert <jbe@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
	marex@denx.de, fabio.estevam@freescale.com,
	linux-iio@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	jic23@cam.ac.uk, linux-input@vger.kernel.org
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver
 implementation
Message-ID: <20140224133316.GI26722@mwanda>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
 <52CEA4AA.8050503@free-electrons.com>
 <201401100955.45885.jbe@pengutronix.de>
 <201402241416.24270.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201402241416.24270.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 24, 2014 at 02:16:24PM +0100, Juergen Beisert wrote:
> Hi Alexandre,
> 
> > While I don't have much experience with the TS part of the code but I
> > can investigate if you don't have any idea.
> 
> can you please test the following patch?
> After releasing the touchscreen the internal state machine was left in a
> wrong state.
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index e2dd783..558a76c 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -698,6 +698,7 @@ static void mxs_lradc_finish_touch_event(struct mxs_lradc *lradc, bool valid)
>         }
> 
>         /* if it is released, wait for the next touch via IRQ */
> +       lradc->cur_plate = LRADC_TOUCH;
>         mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
>         mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
>  }

I am confused.  Why don't you send this like a normal patch?

regards,
dan carpenter

