Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbdFCJO6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 05:14:58 -0400
Date: Sat, 3 Jun 2017 10:14:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ryan Mallon <rmallon@gmail.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/5] iio: ADC driver for EP93xx SoC
Message-ID: <20170603101453.6b44b85a@kernel.org>
In-Reply-To: <5921F894.90809@gmail.com>
References: <20170517171352.20369-1-alexander.sverdlin@gmail.com>
        <df337513-23c7-06b8-50e4-94560e75650c@kernel.org>
        <5921F894.90809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 22 May 2017 06:29:08 +1000
Ryan Mallon <rmallon@gmail.com> wrote:

> On 22/05/17 00:03, Jonathan Cameron wrote:
> > On 17/05/17 18:13, Alexander Sverdlin wrote:  
> >> This series prepares the necessary infrastructure for ADC platform
> >> device on
> >> Cirrus Logic EP93xx family of SoCs and adds the driver for ADC device
> >> using
> >> IIO subsystem.  
> > Hartley, Ryan,
> > 
> > How do you want to handle taking this series forward.
> > Clearly we have a few arch specific bits and then the driver which
> > is dependent on some of them.  
> 
> I no longer maintain an ep93xx tree because the architecture gets very
> few patches now. Patches should go via the arm-soc tree, which is
> maintained by (I believe) Arnd and Olaf.
> 
> > 
> > I'm happy to take the lot through the IIO tree, but will be wanting
> > a few acks.  
> 
> Sure, the series looks fine to me. For the ep93xx specific bits:
> 
> Acked-by: Ryan Mallon <rmallon@gmail.com>
> 
> > I'm interested to note how few implementations there are of clk_get_parent
> > in tree.  Any comments on that little bit of the code would be
> > particularly welcome.  
> 
> The ep93xx architecture is old and obsolete. Because of this, and the
> relatively few number of people developing for it and with hardware to
> test, it hasn't gotten upgraded to some of the more modern kernel apis
> like the common clock framework.
> 
> It probably isn't too difficult to move ep93xx to the common clock
> framework, but it is a separate change and I don't think Alexander
> should have to do it as a prerequisite to getting this adc support merged.
Agreed entirely!

Alexander, would you mind reposting the whole series, with
the linux-arm-kernel@lists.infrared.org cc'd.

I've cc'd it to this email to provide a bit of background to
the maintainers, but please add a note to the cover letter
highlighting what Ryan has covered here.

Thanks,

Jonathan

> 
> ~Ryan

