Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] i.MX28 LRADC driver
Date: Sun, 12 Aug 2012 16:23:54 +0200
Cc: linux-arm-kernel@lists.infradead.org,
 Jonathan Cameron <jic23@kernel.org>,
 Juergen Beisert <jbe@pengutronix.de>,
 "Lars-Peter Clausen" <lars@metafoo.de>,
 Wolfgang Denk <wd@denx.de>
References: <1344007721-11595-1-git-send-email-marex@denx.de>
In-Reply-To: <1344007721-11595-1-git-send-email-marex@denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201208121623.54801.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Marek Vasut,

> Introduce the i.MX28 LRADC driver and support tech that comes with it.
> 
> Marek Vasut (3):
>   IIO: Add 4-byte unsigned reads into generic-buffer example
>   IIO: Add basic MXS LRADC driver
>   IIO: arm: Add LRADC to i.MX28 dts

What about 1/3 btw? Can that be applied ?

>  arch/arm/boot/dts/imx28.dtsi                       |    3 +
>  drivers/staging/iio/Documentation/generic_buffer.c |   10 +
>  drivers/staging/iio/adc/Kconfig                    |   12 +
>  drivers/staging/iio/adc/Makefile                   |    1 +
>  drivers/staging/iio/adc/mxs-lradc.c                |  591
> ++++++++++++++++++++ 5 files changed, 617 insertions(+)
>  create mode 100644 drivers/staging/iio/adc/mxs-lradc.c
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Juergen Beisert <jbe@pengutronix.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Wolfgang Denk <wd@denx.de>

Best regards,
Marek Vasut
