Return-Path: <sudipm.mukherjee@gmail.com>
Date: Mon, 7 Mar 2016 16:36:32 +0530
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org,
	kernel-testers@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: imx25-gcq: fix do_div
Message-ID: <20160307110632.GA10337@sudip-pc>
References: <1457009513-7069-1-git-send-email-sudipm.mukherjee@gmail.com>
 <56DB28BF.9070508@kernel.org>
 <8010548.jDMIC4yOG6@adelgunde>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8010548.jDMIC4yOG6@adelgunde>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 07, 2016 at 10:01:34AM +0100, Markus Pargmann wrote:
> Hi,
> 
> On Saturday 05 March 2016 18:43:11 Jonathan Cameron wrote:
> > On 03/03/16 12:51, Sudip Mukherjee wrote:
> > > We are getting build failure with tilepro allmodconfig with the error:
> > > 
> > > drivers/iio/adc/fsl-imx25-gcq.c:236:4: note: in expansion of macro 'do_div'
> > > do_div(priv->channel_vref_mv[reg], 1000);
> > >     ^
> > > 
> > > include/asm-generic/div64.h:198:17: note: expected 'uint64_t *
> > > 	{aka long long unsigned int *}' but argument is of type 'u32 *
> > > 	{aka unsigned int *}'
> > > 
> > > Create a temporary variable of type u64 and use that in do_div.
> > > 
> > > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> > Markus, can you take a quick look at this. 
> 
> Thanks. I think this was already fixed by Arnd.
> 	"iio: adc/imx25-gcq: move incorrect do_div"

It should. But I still have the same build failure with next-20160307
and not only tilepro, even m32r is also having the same build failure.

regards
sudip
