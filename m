Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48857 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1039265AbdDUQjo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2017 12:39:44 -0400
Message-ID: <1492787944.2364.16.camel@pengutronix.de>
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Peter Rosin <peda@axentia.se>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <jic23@kernel.org>
Date: Fri, 21 Apr 2017 17:19:04 +0200
In-Reply-To: <6bc3120a-81dd-3b6c-d246-559a3c072969@axentia.se>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
         <1492101794-13444-4-git-send-email-peda@axentia.se>
         <1492784582.2364.10.camel@pengutronix.de>
         <9e3d48c4-0dbc-3e80-c653-b0357abf1d6f@axentia.se>
         <1492785664.2364.13.camel@pengutronix.de>
         <6bc3120a-81dd-3b6c-d246-559a3c072969@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2017-04-21 at 16:55 +0200, Peter Rosin wrote:
> On 2017-04-21 16:41, Philipp Zabel wrote:
> > On Fri, 2017-04-21 at 16:32 +0200, Peter Rosin wrote:
> >> On 2017-04-21 16:23, Philipp Zabel wrote:
> >>> On Thu, 2017-04-13 at 18:43 +0200, Peter Rosin wrote:
> >>> [...]
> >>>> +int mux_chip_register(struct mux_chip *mux_chip)
> >>>> +{
> >>>> +	int i;
> >>>> +	int ret;
> >>>> +
> >>>> +	for (i = 0; i < mux_chip->controllers; ++i) {
> >>>> +		struct mux_control *mux = &mux_chip->mux[i];
> >>>> +
> >>>> +		if (mux->idle_state == mux->cached_state)
> >>>> +			continue;
> >>>
> >>> I think this should be changed to
> >>>  
> >>> -               if (mux->idle_state == mux->cached_state)
> >>> +               if (mux->idle_state == mux->cached_state ||
> >>> +                   mux->idle_state == MUX_IDLE_AS_IS)
> >>>                         continue;
> >>>
> >>> or the following mux_control_set will be called with state ==
> >>> MUX_IDLE_AS_IS. Alternatively, mux_control_set should return when passed
> >>> this value.
> >>
> >> That cannot happen because ->cached_state is initialized to -1
> >> in mux_chip_alloc, so should always be == MUX_IDLE_AS_IS when
> >> registering. And drivers are not supposed to touch ->cached_state.
> >> I.e., ->cached_state is "owned" by the core.
> > 
> > So this was caused by me filling cached_state from register reads in the
> > mmio driver. Makes me wonder why I am not allowed to do this, though, if
> > I am able to read back the initial state?
> 
> You gain fairly little by reading back the original state. If the mux
> should idle-as-is, you can avoid a maximum of one mux update if the first
> consumer happens to starts by requesting the previously active state.
> Similarly, if the mux should idle in a specific state, you can avoid a
> maximum of one mux update.
> 
> In both cases it costs one unconditional read of the mux state.
> 
> Sure, in some cases reads are cheaper than writes, but I didn't think
> support for seeding the cache was worth it. Is it worth it?

Probably not, I'll just drop the cached_state initialization. It should
be documented in the mux.h that this field is framework internal and not
to be touched by the drivers. At least I was surprised.

regards
Philipp

