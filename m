Return-Path: <lars@metafoo.de>
Message-ID: <55CA424F.1030704@metafoo.de>
Date: Tue, 11 Aug 2015 20:43:27 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
 Michael Hennerich <Michael.Hennerich@analog.com>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/19] staging: iio: Remove unnecessary externs
References: <cover.1439241825.git.joe@perches.com> <fba2902597293652f4d8561730c0cf16cd4369a0.1439241825.git.joe@perches.com>
In-Reply-To: <fba2902597293652f4d8561730c0cf16cd4369a0.1439241825.git.joe@perches.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 08/10/2015 11:51 PM, Joe Perches wrote:
> Using 'extern' is not necessary for function prototypes.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>  drivers/staging/iio/meter/ade7854.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
> index 52ca541..52f4195 100644
> --- a/drivers/staging/iio/meter/ade7854.h
> +++ b/drivers/staging/iio/meter/ade7854.h
> @@ -168,7 +168,7 @@ struct ade7854_state {
>  
>  };
>  
> -extern int ade7854_probe(struct iio_dev *indio_dev, struct device *dev);
> -extern int ade7854_remove(struct iio_dev *indio_dev);
> +int ade7854_probe(struct iio_dev *indio_dev, struct device *dev);
> +int ade7854_remove(struct iio_dev *indio_dev);
>  
>  #endif
> 
