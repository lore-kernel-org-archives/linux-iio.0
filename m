Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbdFCJnp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 05:43:45 -0400
Date: Sat, 3 Jun 2017 10:43:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/7] twl4030-madc cleanup
Message-ID: <20170603104330.17a87ec0@kernel.org>
In-Reply-To: <2c9e59f1-6bf9-bdd8-eb03-4e46e5333883@kernel.org>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
        <20170520165450.aet2oekjakzorcw3@earth>
        <2c9e59f1-6bf9-bdd8-eb03-4e46e5333883@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 20 May 2017 18:57:39 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On 20/05/17 17:54, Sebastian Reichel wrote:
> > Hi,
> >   
> >> Here are a few cleanup patches for the twl4030-madc
> >> driver, that remove the last users of the driver's
> >> legacy API and then remove it.
> >>
> >> Sebastian Reichel (7):
> >>    hwmon: twl4030-madc: drop driver
> >>    power: supply: avoid unused twl4030-madc.h
> >>    iio: adc: twl4030: Drop twl4030_get_madc_conversion()
> >>    iio: adc: twl4030: Unexport twl4030_madc_conversion()
> >>    iio: adc: twl4030: Drop struct twl4030_madc_user_parms
> >>    iio: adc: twl4030: Remove twl4030_madc_request.func_cb
> >>    iio: adc: twl4030: Fold twl4030-madc.h into driver  
> > 
> > Just a reminder, that patch 1 & 2 have been merged into 4.12-rc1
> > and Wolfram acked the changes to header in include/linux/i2c,
> > so patch 3-7 can be queued by iio for 4.13 :)
> > 
> > -- Sebastian
> >   
> Thanks for the reminder.  I'll have to wait until I've fast
> forwarded my togreg branch of iio.git (possibly a week or
> so) as I have a lot of stuff queued up from prior to and
> during the merge window.  That'll pull in the driver drop at
> which point the rest should go in nicely.
> 
> Anyhow, please feel free to remind me again if I look
> like I've forgotten this after the fast forward merge has
> occurred.
> 
All now applied

Thanks,

Jonathan
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

