Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCHv4 0/3] iio: mxs-lradc: add support to optional divider_by_two
Date: Mon, 9 Dec 2013 01:18:45 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
 lars@metafoo.de,
 harald@ccbib.org,
 hector.palacios@digi.com,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1386375840-24984-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1386375840-24984-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201312090118.45749.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Saturday, December 07, 2013 at 01:23:57 AM, Alexandre Belloni wrote:
> Hello,
> 
> This is v4 of the patchset that adds support to the optional divider_by_two
> of LRADC channels.
> 
> Changes since v3:
>  - removed DT bindings for vref_mv (was the second patch of the series)
>  - rebased on v3.13.0-rc3
>  - the first patch of the previous series had been applied previously
>  - this will apply after https://lkml.org/lkml/2013/12/6/676
> 
> This was tested on a custom i.MX28 platform.
> Could someone please test on an i.MX23?
> 
> Hector Palacios (3):
>   iio: mxs-lradc: add scale attribute to channels
>   iio: mxs-lradc: add scale_available file to channels
>   iio: mxs-lradc: add write_raw function to modify scale
> 
>  drivers/staging/iio/adc/mxs-lradc.c | 222
> +++++++++++++++++++++++++++++++++++- 1 file changed, 219 insertions(+), 3
> deletions(-)

Looks OK to me for all but the tweaks Jonathan requested, thanks!

Whole series otherwise:

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
