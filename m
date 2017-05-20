Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:48530 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750975AbdETQCp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 May 2017 12:02:45 -0400
Date: Sat, 20 May 2017 09:02:40 -0700
From: Tony Lindgren <tony@atomide.com>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND..." <linux-iio@vger.kernel.org>,
        linux-omap@vger.kernel.org, Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: cpcap: Fix default register values and
 battery temperature
Message-ID: <20170520160240.GL10472@atomide.com>
References: <20170519034035.16795-1-tony@atomide.com>
 <20170519034035.16795-2-tony@atomide.com>
 <CAJCx=gm7t=2nuHiLCXUohLXR62gZ-ux62tWyEQXyNXMrhTutKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJCx=gm7t=2nuHiLCXUohLXR62gZ-ux62tWyEQXyNXMrhTutKg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* Matt Ranostay <matt.ranostay@konsulko.com> [170519 22:55]:
> On Thu, May 18, 2017 at 8:40 PM, Tony Lindgren <tony@atomide.com> wrote:
> >  enum cpcap_adc_channel {
> >         /* Bank0 channels */
> > -       CPCAP_ADC_AD0_BATTDETB, /* Battery detection */
> > +       CPCAP_ADC_AD0_BATTDETB, /* Battery temperature */
> 
> Since this doesn't mean battery detection anymore I'd recommend
> renaming to CPCAP_ADC_AD0_BATTEMP or similar.

OK I'll change it to just CPCAP_ADC_AD0 as it seems it's use has
changed across revisions or products.

Regards,

Tony
