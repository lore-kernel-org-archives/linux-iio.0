Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:58509 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab3IPP2v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 11:28:51 -0400
Date: Mon, 16 Sep 2013 08:28:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Juergen Beisert <jbe@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
	marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt
 driven touch detection
Message-ID: <20130916152846.GC12105@core.coreip.homeip.net>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de>
 <1378887511-24530-6-git-send-email-jbe@pengutronix.de>
 <52359259.8010202@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52359259.8010202@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Sep 15, 2013 at 11:56:25AM +0100, Jonathan Cameron wrote:
> On 09/11/13 09:18, Juergen Beisert wrote:
> > For battery driven systems it is a very bad idea to collect the touchscreen
> > data within a kernel busy loop.
> > 
> > This change uses the features of the hardware to delay and accumulate samples in
> > hardware to avoid a high interrupt and CPU load.
> > 
> > Note: this is only tested on an i.MX23 SoC yet.
> > 
> > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> > CC: linux-arm-kernel@lists.infradead.org
> > CC: devel@driverdev.osuosl.org
> > CC: Marek Vasut <marex@denx.de>
> > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > CC: Jonathan Cameron <jic23@cam.ac.uk>
> While this driver is placed in IIO within staging at the moment, these changes are definitely
> input related.  Hence I have cc'd Dmitry and the input list.
> 
> I am personaly a little uncomfortable that we have such a complex bit of input code sat
> within an IIO driver but such is life.
> 

...

> >  
> >  static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
> > @@ -641,6 +1056,7 @@ static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
> >  
> >  	cancel_work_sync(&lradc->ts_work);
> >  
> > +	mxs_lradc_disable_ts(lradc);
> >  	input_unregister_device(lradc->ts_input);
> >  }

This looks iffy... Normally you disable the device so that it does not
generate more interrupts, and then cancel outstanding work(s), otherwise
newly generated interrupts may cause more work to be scheduled. Or I
missed some of the context and this is not a concern here?

Thanks.

-- 
Dmitry
