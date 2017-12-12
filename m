Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752247AbdLLUPe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 Dec 2017 15:15:34 -0500
Date: Tue, 12 Dec 2017 20:15:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v1 3/7] iio: adc: ina2xx: Remove unneeded dummy read to
 clear CNVR flag
Message-ID: <20171212201530.3c64d47e@archlinux>
In-Reply-To: <1575331.Q2WhDFQurN@pebbles>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
        <ed9716c7-5e15-461a-985c-eea93257928c@rwthex-w2-a.rwth-ad.de>
        <20171210172733.4adaae77@archlinux>
        <1575331.Q2WhDFQurN@pebbles>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 10 Dec 2017 21:53:42 +0100
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> On Sunday, December 10, 2017 6:27:33 PM CET Jonathan Cameron wrote:
> > On Fri, 8 Dec 2017 18:41:48 +0100
> > 
> > Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:  
> > > Although the datasheet states the CNVR flag is cleared by reading the
> > > BUS_VOLTAGE register, it is actually cleared by reading any of the
> > > voltage/current/power registers.
> > > 
> > > The behaviour has been confirmed by TI support:
> > > http://e2e.ti.com/support/amplifiers/current-shunt-monitors/f/931/p/647053
> > > /2378282
> > > 
> > > Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>  
> > 
> > I haven't checked the code thoroughly so there may well be something
> > stopping it but have you checked the case where the only channel enabled is
> > the timestamp?
> > 
> > Obviously it makes little sense, but IIRC there is nothing in the core
> > preventing that happening.  
> 
> The timestamp is completely unrelated to the status register, so I fail to 
> understand your question. Can you please clarify?

If you only have a timestamp, the trigger will still fire (I think)
but you'll do no reading at all from the device.  If configured in this,
admittedly odd, way you should just get a stream of timestamps with no
data.

> 
> This only removes a redundant read.
The question is whether it is redundant if we have no non timestamp
registers enabled.

I'll be honest, whilst I can't immediately spot any protection against
this in the core (and it definitely used to be possible), I'm not totally
sure it now is and don't have a system to hand to test against.

We had some debate a long time back on whether it made sense to have
only timestamps and I think we concluded it did as you might in theory
only care about the timing and not the data in some obscure cases.

Jonathan
 
> 
> All channel combinations (w/ and w/o timestamp) work, but combinations not 
> including the power register use less bus time now.
> 
> Kind regards,
> 
> Stefan
> 

