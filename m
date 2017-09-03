Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753049AbdICQFc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 12:05:32 -0400
Date: Sun, 3 Sep 2017 17:05:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-iio@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads1015: add 10% to conversion wait
 time
Message-ID: <20170903170527.706ee9f4@archlinux>
In-Reply-To: <CAC5umyi-f2+xfv=apiMk8cfA0iqAovStj-GcB5=tFkDJKsVZbQ@mail.gmail.com>
References: <20170824082708.6qkcmf6qt2wjvqd3@lenoch>
        <CAC5umyhkGSN5DYJM6Qp-05MASZLBNpcSna1pVGN4feR=_MH5fQ@mail.gmail.com>
        <20170825053916.lbubxudnm3errnld@lenoch>
        <CAC5umyi-f2+xfv=apiMk8cfA0iqAovStj-GcB5=tFkDJKsVZbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 28 Aug 2017 00:01:22 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> 2017-08-25 14:39 GMT+09:00 Ladislav Michl <ladis@linux-mips.org>:
> > As user's guide "ADS1015EVM, ADS1115EVM, ADS1015EVM-PDK, ADS1115EVM-PDK
> > User Guide (Rev. B)" (http://www.ti.com/lit/ug/sbau157b/sbau157b.pdf)
> > states at page 16:
> > "Note that both the ADS1115 and ADS1015 have internal clocks with a ±10%
> > accuracy. If performing FFT tests, frequencies may appear to be incorrect
> > as a result of this tolerance range.", add those 10% to converion wait
> > time.
> >
> > Cc: Daniel Baluta <daniel.baluta@gmail.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Akinobu Mita <akinobu.mita@gmail.com>
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > ---
> >  Changes:
> >  -v2: Add comment explaining why those 10% are needed
> >
> >  drivers/iio/adc/ti-ads1015.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> > index 034e48566ab5..ae29dd87c597 100644
> > --- a/drivers/iio/adc/ti-ads1015.c
> > +++ b/drivers/iio/adc/ti-ads1015.c
> > @@ -268,6 +268,7 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
> >                 dr_old = (old & ADS1015_CFG_DR_MASK) >> ADS1015_CFG_DR_SHIFT;
> >                 conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr_old]);
> >                 conv_time += DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
> > +               conv_time += conv_time / 10; /* 10% internal clock inaccuracy */  
> 
> Perhaps we'd better use DIV_ROUND_UP to avoid the worst case.
> 
> Anyway, this and patch 2/2 look good to me.

I'm guessing you mean 1/2 as this is the updated version of 2/2.

Which brings me to...
Ladislav,

Please don't do this.  If you update one patch in a series, a new
posting of the entire series - not as a reply to the previous version but
as a new thread, is the what you should be doing.

The whole replying to the thread etc might seem to make more sense but
it doesn't scale to complex patch series, so we would prefer everything
to be done in a fashion that does, however simple the series is.

Just makes things easier for maintainers and we can get awfully
grumpy about things that make our lives harder!

On another note, I've applied this though the togreg branch which
means it will take quite sometime to reach a mainline release.

If you wanted this fix in place quicker it should have been as
a separate patch rather than tied up with what was a performance
optimization (patch 1/2).  Anyhow, done now.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
> >                 usleep_range(conv_time, conv_time + 1);
> >                 data->conv_invalid = false;
> >         }
> > --
> > 2.11.0
> >  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

