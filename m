Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH 1/2] Staging:iio:Prefer using BIT macro
To: Bhumika Goyal <bhumirks@gmail.com>, gregkh@linuxfoundation.org,
 Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
 pmeerw@pmeerw.net
References: <cover.1454913458.git.bhumirks@gmail.com>
 <74ee6d155e15fbfe06512c7caa52f1575727402e.1454913458.git.bhumirks@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56B85C88.7040506@metafoo.de>
Date: Mon, 8 Feb 2016 10:14:48 +0100
MIME-Version: 1.0
In-Reply-To: <74ee6d155e15fbfe06512c7caa52f1575727402e.1454913458.git.bhumirks@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 02/08/2016 07:48 AM, Bhumika Goyal wrote:
> This patch replaces bit shifting on 1 with the BIT(x) macro.
> This was done with coccinelle:
>  @@ int g; @@
> -(1 << g)
> +BIT(g)
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Hi,

Thanks for the patch.

> ---
>  drivers/staging/iio/adc/ad7816.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 2226051..f631012 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -222,7 +222,7 @@ static ssize_t ad7816_show_value(struct device *dev,
>  		value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
>  		data &= AD7816_TEMP_FLOAT_MASK;
>  		if (value < 0)
> -			data = (1 << AD7816_TEMP_FLOAT_OFFSET) - data;
> +			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;


But in this case this is a false positive. The intended semantic meaning
here is 2**... not BIT(...). Using BIT() here in my opinion only causes
confusion.

>  		return sprintf(buf, "%d.%.2d\n", value, data * 25);
>  	}
>  	return sprintf(buf, "%u\n", data);
> 
