Return-Path: <SRS0=tTdj=4I=csie.org=wens@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170501224559.21028-1-edu.molinas@gmail.com>
References: <20170501224559.21028-1-edu.molinas@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 2 May 2017 10:10:23 +0800
Message-ID: <CAGb2v65Cgtxjhuj8v5A8RF8pGTK0FD3MDmDeirO4T_T7UCF4Vw@mail.gmail.com>
Subject: Re: [PATCH 1/2] [PATCH 1/2] iio: adc: sun4i-gpadc-iio: Fix module
 autoload when PLATFORM devices are registered
To: Eduardo Molinas <edu.molinas@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 2, 2017 at 6:45 AM, Eduardo Molinas <edu.molinas@gmail.com> wrote:
> If the driver is built as a module, it won't be autloaded if the devices
> are registered via PLATFORM code because the PLATFORM device table
> entries are not exported as aliases
>
> Before the patch:
> $ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
> $
>
> After th patch:

        ^^ the

> $ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
> alias:          platform:sun6i-a31-gpadc-iio
> alias:          platform:sun5i-a13-gpadc-iio
> alias:          platform:sun4i-a10-gpadc-iio
>
> Signed-off-by: Eduardo Molinas <edu.molinas@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Can we merge this as a fix for 4.12?
