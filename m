Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751784AbdFKOMq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 10:12:46 -0400
Date: Sun, 11 Jun 2017 15:12:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: cpcap: Fix default register values and
 battery temperature
Message-ID: <20170611151241.34f80929@kernel.org>
In-Reply-To: <20170607062200.GD3730@atomide.com>
References: <20170523005146.726-1-tony@atomide.com>
        <20170523005146.726-2-tony@atomide.com>
        <20170524201831.3504c42d@kernel.org>
        <20170607062200.GD3730@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 6 Jun 2017 23:22:00 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Jonathan Cameron <jic23@kernel.org> [170524 12:22]:
> > On Mon, 22 May 2017 17:51:44 -0700
> > Tony Lindgren <tony@atomide.com> wrote:
> >   
> > > Looking at the register dumps from Android kernel on droid 4, I noticed
> > > the values with the mainline kernel don't match. Let's fix this by
> > > initializing the ADC registers to what Android does.
> > > 
> > > For getting correct values from the battery thermistor, we need to
> > > toggle the CPCAP_BIT_THERMBIAS_EN when measuring battery temperature
> > > to get correct battery temperatures. And looks like we also need to
> > > wait a little bit before reading the battery temperature as otherwise
> > > the results are inaccurate.
> > > 
> > > Cc: Marcel Partap <mpartap@gmx.net>
> > > Cc: Michael Scott <michael.scott@linaro.org>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>  
> > Applied to the togreg branch of iio.git and will be shortly pushed
> > out as testing for the autobuilders to play with it.  
> 
> Not seeing these in your togreg brach or in next? The
> branch I just checked is the one below, maybe I'm looking
> at a wrong branch or something.
I think I was being a muppet last weekend.  Forgot to actually
push out anything much.

Done now, though still as testing as obviously the autobuilders haven't
looked at it yet.
Sorry about that and thanks for point it out!

Jonathan
> 
> Regards,
> 
> Tony
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=togreg

