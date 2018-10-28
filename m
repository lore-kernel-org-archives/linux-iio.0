Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbeJ2AnM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 20:43:12 -0400
Date: Sun, 28 Oct 2018 15:58:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Renato Lui Geh <renatogeh@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        alexandru.Ardelean@analog.com, stefan.popa@analog.com,
        giuliano.belinassi@usp.br, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/2] staging: iio: ad7780: fix offset read value
Message-ID: <20181028155807.4de0f874@archlinux>
In-Reply-To: <ff71d89625c048601d3e3770ca3b4bcceb2068ac.1540506298.git.renatogeh@gmail.com>
References: <cover.1540506298.git.renatogeh@gmail.com>
        <ff71d89625c048601d3e3770ca3b4bcceb2068ac.1540506298.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 25 Oct 2018 19:30:37 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> Variable val subtracted an uninitialized value on IIO_CHAN_INFO_OFFSET.
> This was fixed by assigning the correct value instead.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>

It obviously doesn't make much difference, but as you are respinning anyway...
Please could you always put fixes at the beginning of a set as it makes it
easier to back port them.  It think this one is simple enough that it is
worth applying to the stable kernels.

(naturally I could do that anyway as the rebase is trivial, so I'm just
encouraging good practice by asking you to do it in v3!)

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7780.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index 27972563bb6a..06700fe554a2 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -100,7 +100,7 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
>  		*val2 = chan->scan_type.realbits - 1;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val -= (1 << (chan->scan_type.realbits - 1));
> +		*val = -(1 << (chan->scan_type.realbits - 1));
>  		return IIO_VAL_INT;
>  	}
>  
