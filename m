Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387956AbeGWOaR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Jul 2018 10:30:17 -0400
MIME-Version: 1.0
References: <20180717084158.23532-1-masneyb@onstation.org> <20180717084158.23532-4-masneyb@onstation.org>
 <20180720173635.GA21241@rob-hp-laptop> <20180721183716.524632f1@archlinux>
 <20180722123720.GB20029@onstation.org> <20180722181748.24bc47d8@archlinux>
In-Reply-To: <20180722181748.24bc47d8@archlinux>
From: Rob Herring <robh@kernel.org>
Date: Mon, 23 Jul 2018 07:28:49 -0600
Message-ID: <CAL_JsqLCQG_CNppd9f7xtwYkruvU4=3PziPOPCTt1P4phg5iLg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] iio: tsl2772: add support for reading power
 settings from device tree
To: Jonathan Cameron <jic23@kernel.org>
Cc: Brian Masney <masneyb@onstation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Martin Kelly <mkelly@xevo.com>, fischerdouglasc@gmail.com,
        bshah@kde.org, Craig Tatlor <ctatlor97@gmail.com>,
        drew.paterson@ams.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jul 22, 2018 at 11:17 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 22 Jul 2018 12:37:20 +0000
> Brian Masney <masneyb@onstation.org> wrote:
>
> > On Sat, Jul 21, 2018 at 06:37:16PM +0100, Jonathan Cameron wrote:
> > > On Fri, 20 Jul 2018 11:36:35 -0600
> > > Rob Herring <robh@kernel.org> wrote:
> > >
> > > > On Tue, Jul 17, 2018 at 04:41:54AM -0400, Brian Masney wrote:
> > > > > This patch adds support for optionally reading the prox_diode and
> > > > > prox_power settings from device tree. This was tested using a LG
> > > > > Nexus 5 (hammerhead) which requires a different diode than the driver
> > > > > default for the IR LED.
> > > > >
> > > > > Signed-off-by: Brian Masney <masneyb@onstation.org>

> > > > > +  - amstaos,prox_diode - must be TSL2772_DIODE0, TSL2772_DIODE1, or
> > > > > +                         TSL2772_DIODE_BOTH.
> > > >
> > > > s/_/-/
> > > >
> > > > > +  - amstaos,prox_power - must be TSL2772_100_mA, TSL2772_50_mA, TSL2772_25_mA,
> > > > > +                         or TSL2772_13_mA.
> > > >
> > > > I wonder if this should be common. Perhaps we should use the existing
> > > > 'led-max-microamp' as this is setting the current for an IR LED.
> > >
> > > Seems reasonable, then perhaps have two controls to turn on the diodes
> > > above.
> > >
> > > >
> > > > And while called 'power' this setting is current.
> > >
> > > Also can we have real values?  I really don't like defines if they
> > > aren't absolutely necessary - particularly when there is a nice real
> > > unit to be used.
> >
> > How about these options then?
> >
> > amstaos,proximity-diode-0-enabled;
> > amstaos,proximity-diode-1-enabled;
> > led-max-microamp = <100000>;
>
> Works for me.  Rob?

I think we're bikeshedding, but I'd prefer a single property though
perhaps as a list (0, 1, or <0 1>) or mask. A list would be similar to
the "led-sources" property format.

Rob
