Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34290 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbaBXOfn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Feb 2014 09:35:43 -0500
From: Juergen Beisert <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Mon, 24 Feb 2014 15:38:26 +0100
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
	devel@driverdev.osuosl.org, marex@denx.de,
	fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	jic23@cam.ac.uk, linux-input@vger.kernel.org
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <201402241416.24270.jbe@pengutronix.de> <20140224133316.GI26722@mwanda>
In-Reply-To: <20140224133316.GI26722@mwanda>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201402241538.26530.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Dan,

On Monday 24 February 2014 14:33:16 Dan Carpenter wrote:
> On Mon, Feb 24, 2014 at 02:16:24PM +0100, Juergen Beisert wrote:
> > > While I don't have much experience with the TS part of the code but I
> > > can investigate if you don't have any idea.
> >
> > can you please test the following patch?
> > After releasing the touchscreen the internal state machine was left in a
> > wrong state.
> >
> > diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> > index e2dd783..558a76c 100644
> > --- a/drivers/staging/iio/adc/mxs-lradc.c  
> > +++ b/drivers/staging/iio/adc/mxs-lradc.c
> > @@ -698,6 +698,7 @@ static void mxs_lradc_finish_touch_event(struct
> > mxs_lradc *lradc, bool valid) }
> >
> >         /* if it is released, wait for the next touch via IRQ */
> > +       lradc->cur_plate = LRADC_TOUCH;
> >         mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
> >         mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
> >         } 
>
> I am confused.  Why don't you send this like a normal patch?

For testing fist. But you are right, patch will follow.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
