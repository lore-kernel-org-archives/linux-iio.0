Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:50728 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab2LNCEp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Dec 2012 21:04:45 -0500
From: Marek Vasut <marex@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/3 V2] iio: mxs: Implement support for touchscreen
Date: Fri, 14 Dec 2012 03:04:43 +0100
Cc: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org
References: <1355449598-15980-1-git-send-email-marex@denx.de> <1355449598-15980-2-git-send-email-marex@denx.de> <CAOMZO5DDcPpePEiJe0hg0Er60OBuJM+Rik1CSc9zcphycpEr4g@mail.gmail.com>
In-Reply-To: <CAOMZO5DDcPpePEiJe0hg0Er60OBuJM+Rik1CSc9zcphycpEr4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201212140304.43291.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Fabio Estevam,

> Hi Marek,
> 
> On Thu, Dec 13, 2012 at 11:46 PM, Marek Vasut <marex@denx.de> wrote:
> > +static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
> > +{
> > +       struct input_dev *input;
> > +       struct device *dev = lradc->dev;
> > +       int ret;
> > +
> > +       if (!lradc->use_touchscreen)
> > +               return 0;
> 
> Shouldn't we return an error code here?

No, why ? No touchscreen present, we register nothing.

> > +
> > +       input = input_allocate_device();
> > +       if (!input) {
> > +               dev_warn(dev, "Failed to allocate TS device,
> > disabling.\n"); +               lradc->use_touchscreen =
> > MXS_LRADC_TOUCHSCREEN_NONE; +               return 0;
> > +       }
> 
> Shouldn't we return an error code here?

Yes.

> Regards,
> 
> Fabio Estevam

Best regards,
Marek Vasut
