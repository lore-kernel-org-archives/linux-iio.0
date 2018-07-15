Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeGOIhx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Jul 2018 04:37:53 -0400
Date: Sun, 15 Jul 2018 09:15:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: fix up casting in
 at91_adc_read_info_raw()
Message-ID: <20180715091540.161e4875@archlinux>
In-Reply-To: <20180709114107.khy2265d4aqa3hmx@mwanda>
References: <20180709110658.bjtebvyinfqjrzbr@kili.mountain>
        <bd530537-1e5a-cf92-fd9b-b9caa04e56b7@microchip.com>
        <20180709114107.khy2265d4aqa3hmx@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 9 Jul 2018 14:41:07 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Mon, Jul 09, 2018 at 02:22:40PM +0300, Eugen Hristev wrote:
> > 
> > 
> > On 09.07.2018 14:06, Dan Carpenter wrote:  
> > > This code is problematic because we're supposed to be writing an int but
> > > we instead write to only the high 16 bits.  This doesn't work on big
> > > endian systems, and there is a potential that the bottom 16 bits are
> > > used without being initialized.  
> > 
> > Hi Dan,
> > 
> > Thanks for the patch.
> > Please correct me if I'm wrong, the caller of this function should mask out
> > the unused bits w.r.t. the channel spec ?

Nope, the chan spec shift stuff is only for buffered reads, they are not used
in the read_raw paths.  We could in theory, but we don't.  Given those raw
reads do a lot more than just read values, (scales etc) it would be really
odd to do masking for the raw values, but nothing else. It's expected that
a driver will deal with that itself.  If nothing else, lots of drivers don't
have that section of the chan spec filled in because it would just make them
more complex.

When you are using the buffered interfaces it is acceptable to not mask
out other bits that are definitely coming from the hardware, however we should
still mask out any that are due to not initializing local variables as otherwise
we leak kernel data.

> > 
> > Indeed there may be an issue if we actually write the data to the wrong 16
> > bit part of the 32 bit integer.
> > 
> > Would be safer to check for the endianess and write the proper part of the
> > int ? (macros that do the magic for us - cpu_to_le etc.), or we rely on the
> > compiler to do it for us as it looks in your code ?
> > 
> > Another option is to pass the int directly and do the ugly task inside the
> > read_position/pressure functions, I am not sure which one looks better
> >   
> 
> To be honest, I'm just doing static analysis.  I'm not very familiar
> with the subsystem and I don't know the answers to your questions.
> 
> The code as it's written now doesn't make sense.  I looked at code like
> ntc_adc_iio_read() where it's called like so:
> 
> 	int raw, uv, ret;
> 
> 	ret = iio_read_channel_raw(channel, &raw);
> 
> If we only write to the high 16 bits then the low 16 bits of "raw" are
> uninitalized.
Superficially Dan's patch looks right to me, but I would like some
testing to make sure nothing odd is taking advantage of the previous
'unusual :)' code.

Jonathan

> 
> regards,
> dan carpenter
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

