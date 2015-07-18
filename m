Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V2 0/6] iio: mxs-lradc: Clean up and add datasheet names
Date: Sat, 18 Jul 2015 17:38:21 +0200
Cc: Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>,
 "Lars-Peter Clausen" <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Kristina
 =?utf-8?q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201507181738.21236.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Saturday, July 18, 2015 at 02:30:40 PM, Stefan Wahren wrote:
> This patch series does some clean up in mxs-lradc and finally add the
> datasheet names for every usable channel.
> 
> Changes in V2:
>   - remove confusing i.MX28 specific comments
>   - fix some spelling errors
>   - fix up includes
>   - separate channel spec for i.MX23 and i.MX28
> 
> Stefan Wahren (6):
>   iio: mxs-lradc: clarify supported devices
>   iio: mxs-lradc: fix some spelling errors
>   iio: mxs-lradc: add missing include
>   iio: mxs-lradc: remove unnecessary header includes
>   iio: mxs-lradc: reorder header includes
>   iio: mxs-lradc: add datasheet name for every usable channel
> 
>  .../bindings/staging/iio/adc/mxs-lradc.txt         |    2 +-
>  drivers/staging/iio/adc/mxs-lradc.c                |  122
> +++++++++++++------- 2 files changed, 82 insertions(+), 42 deletions(-)

Entire series

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
