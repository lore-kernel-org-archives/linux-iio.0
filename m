Return-Path: <jic23@kernel.org>
Message-ID: <4FCF1638.7020704@kernel.org>
Date: Wed, 06 Jun 2012 09:35:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:ad7606: Re-add missing scale attribute
References: <1338912991-26095-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1338912991-26095-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 6/5/2012 5:16 PM, Lars-Peter Clausen wrote:
> Commit 50ac23be ("staging:iio:adc:ad7606 add local define for chan_spec
> structures.") accidentally removed the scale info_mask flag. This patch
> adds it back again.
oops
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

> ---
>   drivers/staging/iio/adc/ad7606_core.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index 10ab6dc..a13afff 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -235,7 +235,8 @@ static const struct attribute_group ad7606_attribute_group_range = {
>   		.indexed = 1,					\
>   		.channel = num,					\
>   		.address = num,					\
> -		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,	\
> +		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
> +				IIO_CHAN_INFO_SCALE_SHARED_BIT, \
>   		.scan_index = num,				\
>   		.scan_type = IIO_ST('s', 16, 16, 0),		\
>   	}
