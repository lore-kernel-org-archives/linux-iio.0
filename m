Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42254 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeHYBvM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Aug 2018 21:51:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so4869466pgp.9
        for <linux-iio@vger.kernel.org>; Fri, 24 Aug 2018 15:14:41 -0700 (PDT)
Date: Fri, 24 Aug 2018 15:14:39 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5: Add ADC5_AMUX_THM[24]_100K_PU
 to rev2 channel list
Message-ID: <20180824221439.GT160295@google.com>
References: <20180810194702.144641-1-mka@chromium.org>
 <20180819175452.31e0906b@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180819175452.31e0906b@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Aug 19, 2018 at 05:54:52PM +0100, Jonathan Cameron wrote:
> On Fri, 10 Aug 2018 12:47:02 -0700
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > Add ADC5_AMUX_THM2_100K_PU and ADC5_AMUX_THM4_100K_PU to the list of
> > rev2 ADC channels.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> This is fine and applied to the togreg branch of iio.git.
> Pushed out as testing to let the autobuilders play with it.

Thanks!

> However, I took a quick look and can't immediately see what prevents us
> specifying channels in DT that don't have these definitions in the driver.

Indeed, the DT could just specify an arbitrary value.

> Should we have a check for that as at least superficially it seems like
> a bad idea!

It seems there isn't a single contiguous range, but a very superficial
check could at least verify that the value isn't larger than CHAN_MAX
or check a few sub-ranges.

> > ---
> >  drivers/iio/adc/qcom-spmi-adc5.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> > index a4299417f3de..1f9298a5c83d 100644
> > --- a/drivers/iio/adc/qcom-spmi-adc5.c
> > +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> > @@ -491,8 +491,12 @@ static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
> >  					SCALE_HW_CALIB_PMIC_THERM)
> >  	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 1,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > +	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 1,
> > +					SCALE_HW_CALIB_THERM_100K_PULLUP)
> >  	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 1,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> > +	[ADC5_AMUX_THM4_100K_PU] = ADC5_CHAN_TEMP("amux_thm4_100k_pu", 1,
> > +					SCALE_HW_CALIB_THERM_100K_PULLUP)
> >  	[ADC5_AMUX_THM5_100K_PU] = ADC5_CHAN_TEMP("amux_thm5_100k_pu", 1,
> >  					SCALE_HW_CALIB_THERM_100K_PULLUP)
> >  	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm_100k_pu", 1,
> 
