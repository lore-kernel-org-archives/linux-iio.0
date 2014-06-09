Return-Path: <lars@metafoo.de>
Message-ID: <5395A44A.8000900@metafoo.de>
Date: Mon, 09 Jun 2014 14:10:50 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH v2 01/13] iio:adc:ad799x: Fix reading and writing of event
 values, apply shift
References: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net> <1402155097-435-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155097-435-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/07/2014 05:31 PM, Peter Meerwald wrote:
> last two bits of ADC and limit values are zero and should not be reported
> (ad7993, ad7997); compare with read_raw()
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>   drivers/iio/adc/ad799x.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 39b4cb4..099b830 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -429,7 +429,8 @@ static int ad799x_write_event_value(struct iio_dev *indio_dev,
>
>   	mutex_lock(&indio_dev->mlock);
>   	ret = ad799x_i2c_write16(st, ad799x_threshold_reg(chan, dir, info),
> -		val);
> +		(val & RES_MASK(chan->scan_type.realbits))
> +			<< chan->scan_type.shift);

Rather than applying a mask to the written value and cutting off the upper 
bits, I'd prefer to have patch 8 (iio:adc:ad799x: Check range when writing 
event value) squashed into this.

Thanks,
- Lars
