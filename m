Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH 1/1] iio: fix config watermark initial value
To: Irina Tirdea <irina.tirdea@intel.com>, Jonathan Cameron
 <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <1458810585-24555-1-git-send-email-irina.tirdea@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Octavian Purdila <octavian.purdila@intel.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56F3B217.8040206@metafoo.de>
Date: Thu, 24 Mar 2016 10:23:35 +0100
MIME-Version: 1.0
In-Reply-To: <1458810585-24555-1-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 03/24/2016 10:09 AM, Irina Tirdea wrote:
> config structure is set to 0 when updating the buffers, so by
> default config->watermark will be 0. When computing the minimum
> between config->watermark and the buffer->watermark or
> insert_buffer-watermark, this will always be 0 regardless of the
> value set by the user for the buffer.
> 
> Set as initial value for config->watermark the maximum allowed
> value so that the minimum value will always be set from one of the
> buffers.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>

Looks good. This bug was my fault, sorry.

Fixes: f0566c0c405d ("iio: Set device watermark based on watermark of all
attached buffers")

> ---
>  drivers/iio/industrialio-buffer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index b976332..90462fc 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -653,6 +653,7 @@ static int iio_verify_update(struct iio_dev *indio_dev,
>  	unsigned int modes;
>  
>  	memset(config, 0, sizeof(*config));
> +	config->watermark = ~0;
>  
>  	/*
>  	 * If there is just one buffer and we are removing it there is nothing
> 
