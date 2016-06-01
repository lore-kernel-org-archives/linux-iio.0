Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36061 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcFAS3y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jun 2016 14:29:54 -0400
Date: Wed, 1 Jun 2016 11:29:49 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ksenija =?utf-8?Q?Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>,
	linux-iio@vger.kernel.org, Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCH 3/3] input: touchscreen: mxs-lradc: Add support for
 touchscreen
Message-ID: <20160601182949.GE4114@dtor-ws>
References: <cover.1461930102.git.ksenija.stanojevic@gmail.com>
 <61fe1da2e8d82921f3222ec939047b6823f695e1.1461930102.git.ksenija.stanojevic@gmail.com>
 <20160429233616.GA13361@dtor-ws>
 <CAL7P5j+WhTGyn2gZRX9pvyrPss_PfwrvXHRMKmhR+=De2gSsRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAL7P5j+WhTGyn2gZRX9pvyrPss_PfwrvXHRMKmhR+=De2gSsRA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, May 28, 2016 at 07:46:07PM +0200, Ksenija Stanojević wrote:
> On Sat, Apr 30, 2016 at 1:36 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Ksenija,
> >
> > On Fri, Apr 29, 2016 at 01:49:11PM +0200, Ksenija Stanojevic wrote:
> >> +
> >> +     mxs_lradc_ts_hw_init(ts);
> >> +     for (i = 0; i < lradc->irq_count; i++) {
> >> +             ret = devm_request_irq(dev, lradc->irq[i],
> >> +                                    mxs_lradc_ts_handle_irq,
> >
> > Hmm, if you have several interrupts handled by the same interrupt
> > handler you'd need some locking there.
> 
> same interrupt handler can run concurrently only on multi cores, so
> why do we need locking?

We do not necessarily need it on single core (unless someone will turn
it int threaded IRQ down the road), but adding it costs almost nothing
and will ensure that the driver will continue working even if block is
moved to multi-core SOC in the future...

Thanks.

-- 
Dmitry
