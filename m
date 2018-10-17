Return-Path: <SRS0=UFOI=M5=gmail.com=shreeya.patel23498@kernel.org>
Message-ID: <0a6618af45b673ff14e4b92cd4642b72b632c7b8.camel@gmail.com>
Subject: Re: [PATCH] Staging iio/adc: fixes parenthesis alignment
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
 pmeerw@pmeerw.net,  gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	kernel-usp@googlegroups.com
Date: Wed, 17 Oct 2018 21:13:19 +0530
In-Reply-To: <20181016160104.6276-1-marcelo.schmitt1@gmail.com>
References: <20181016160104.6276-1-marcelo.schmitt1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Tue, 2018-10-16 at 13:01 -0300, Marcelo Schmitt wrote:
> Fixes close parenthesis alignment to match open parenthesis at
> iio/drivers/staging/iio/adc/ad7606.c line 379.
> 
> Signed-of-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Hi Marcelo,

Some suggestions from my side....

1) Your subject line should look like "Staging: iio: adc:" instead of
"Staging iio/adc:"
This is the pattern that everyone in the Linux Kernel community has to
follow for having consistency around.

2) Your subject line and commit message should be in the imperative
form.

For example :-
Staging: iio: adc: Match alignment with open parenthesis

Similar should be the case for commit message.

3) Try to avoid the word 'fix' as it becomes an easy way for
people to avoid explanation for the patch.
Try giving more information about what you are doing and why are you
doing that.

You can have a look here
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/comm
it/?id=efd44cf468fe7e7ff9150dc52879426e0d0801eb

Bdw, good try if it's your first patch :)

Thanks

> ---
>  drivers/staging/iio/adc/ad7606.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c
> b/drivers/staging/iio/adc/ad7606.c
> index 0b728b6ea135..230faae38c12 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -376,7 +376,7 @@ static int ad7606_request_gpios(struct
> ad7606_state *st)
>  		return 0;
>  
>  	st->gpio_os = devm_gpiod_get_array_optional(dev,
> "oversampling-ratio",
> -			GPIOD_OUT_LOW);
> +						    GPIOD_OUT_LOW);
>  	return PTR_ERR_OR_ZERO(st->gpio_os);
>  }
>  
