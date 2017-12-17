Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751623AbdLQKJ3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Dec 2017 05:09:29 -0500
Date: Sun, 17 Dec 2017 10:09:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH v1 3/7] iio: adc: ina2xx: Remove unneeded dummy read to
 clear CNVR flag
Message-ID: <20171217100922.388ed7a1@archlinux>
In-Reply-To: <2569854.02uJhrbl9B@pebbles>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
        <1575331.Q2WhDFQurN@pebbles>
        <20171212201530.3c64d47e@archlinux>
        <2569854.02uJhrbl9B@pebbles>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 13 Dec 2017 00:48:40 +0100
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> On Tuesday, December 12, 2017 9:15:30 PM CET Jonathan Cameron wrote:
> > On Sun, 10 Dec 2017 21:53:42 +0100
> > 
> > Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:  
> > > On Sunday, December 10, 2017 6:27:33 PM CET Jonathan Cameron wrote:  
> > > > On Fri, 8 Dec 2017 18:41:48 +0100
> > > > 
> > > > Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:  
> > > > > Although the datasheet states the CNVR flag is cleared by reading the
> > > > > BUS_VOLTAGE register, it is actually cleared by reading any of the
> > > > > voltage/current/power registers.
> > > > > 
> > > > > The behaviour has been confirmed by TI support:
> > > > > http://e2e.ti.com/support/amplifiers/current-shunt-monitors/f/931/p/64
> > > > > 7053
> > > > > /2378282
> > > > > 
> > > > > Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>  
> > > > 
> > > > I haven't checked the code thoroughly so there may well be something
> > > > stopping it but have you checked the case where the only channel enabled
> > > > is
> > > > the timestamp?
> > > > 
> > > > Obviously it makes little sense, but IIRC there is nothing in the core
> > > > preventing that happening.  
> > > 
> > > The timestamp is completely unrelated to the status register, so I fail to
> > > understand your question. Can you please clarify?  
> > 
> > If you only have a timestamp, the trigger will still fire (I think)
> > but you'll do no reading at all from the device.  If configured in this,
> > admittedly odd, way you should just get a stream of timestamps with no
> > data.  
> 
> If there are reads depends on the mode - if running asynchronously, it will 
> just stream out 64 bits of timestamp each interval. In synchronous mode, the 
> driver will read the status register (low bits of bus voltage register for 
> INA219, msk register for INA226), which implicitly clears the CNVR flag.
>  
> > > This only removes a redundant read.  
> > 
> > The question is whether it is redundant if we have no non timestamp
> > registers enabled.  
> 
> According to the documentation, INA219 and 226 had to be treated differently. 
> As it turned out, both actually behave the same way regarding the CNVR flag, 
> so we just poll the status register, which for both devices clears the flag.
Ah, fine then. I thought we were talking about having to read a channel
not just the register we are anyway polling for status.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> 
> Regards,
> 
> Stefan
> 
> 

