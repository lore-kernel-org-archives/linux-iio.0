Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964775AbdEXTiL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 May 2017 15:38:11 -0400
Date: Wed, 24 May 2017 20:38:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff White <Jeff.White@zii.aero>,
        Chris Healy <Chris.Healy@zii.aero>
Subject: Re: [PATCH 4/4] iio: hi8435: cleanup reset gpio
Message-ID: <20170524203808.34aec03a@kernel.org>
In-Reply-To: <5eec10c5-9e13-b0fc-fe40-a8b74a4fdbb0@cogentembedded.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
        <20170519144802.14427-4-nikita.yoush@cogentembedded.com>
        <18fc343b-d7a4-c5b8-84e6-702af6e94e44@cogentembedded.com>
        <4ba5a0ce-d443-bdf0-bb23-9941b7db59a4@cogentembedded.com>
        <5eec10c5-9e13-b0fc-fe40-a8b74a4fdbb0@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 24 May 2017 14:27:50 +0300
Vladimir Barinov <vladimir.barinov@cogentembedded.com> wrote:

> On 23.05.2017 11:18, Nikita Yushchenko wrote:
> >>> Reset GPIO is active low.
> >>>
> >>> Currently driver uses gpiod_set_value(1) to clean reset, which depends
> >>> on device tree to contain GPIO_ACTIVE_HIGH - that does not match reality.
> >>>
> >>> This fixes driver to use _raw version of gpiod_set_value() to enforce
> >>> active-low semantics despite of what's written in device tree. Allowing
> >>> device tree to override that only opens possibility for errors and does
> >>> not add any value.
> >>>
> >>> Additionally, use _cansleep version to make things work with i2c-gpio
> >>> and other sleeping gpio drivers.  
> >> The reset gpio comes from platform hence it should be handled by DTS.
> >>
> >> In driver the gpio should not be raw.
> >>
> >> Even the hi8435 is active low but platform may invert signal (f.e. by
> >> adding trigger on the circuit path).  
> > I see.  However - isn't this pure theoretic?  Does such case exist?  
> I assure you that this is frequently used.
> 
> Simply search google for "simple voltage level shifter"
> It might be on PNP or NPN transistor, hence logic might be inverted.
> 
> >
> > In vast majority of cases, GPIO polarity is chip-specific, not
> > chip-use-specific.  Thus this knowlege belongs to driver and not to
> > device tree describing particular chip usage.  Having this always
> > defined at usage side is IMO major source of errors.  
> GPIO comes from SoC then "circuit path" and finally chip reset input.
> 
> What do you propose if h/w circuit path has simple voltage level shifter 
> on transistor. How to differentiate PNP and NPN cases?
> 
> Regards,
> Vladimir
> 

Hmm. Ah well, I clearly jumped too fast on this set and should have
left it for a while longer (I rushed a little as I'm away next weekend
and the cycle is moving towards rc3)

Sorry about that.

Anyhow, I am tempted to queue a revert of this patch.  The level
shifting case hadn't occurred to me (oops).

Thoughts?

I'm travelling at the end of this week, so may be the middle
of next before I can do anything about this one.

Jonathan
