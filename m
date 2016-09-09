Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
In-Reply-To: <20160909134026.12055-1-ico@pruts.nl>
References: <20160909134026.12055-1-ico@pruts.nl>
From: Crt Mori <cmo@melexis.com>
Date: Fri, 9 Sep 2016 15:56:31 +0200
Message-ID: <CAKv63usKoodnShr4Nw00F-X0qrhZ7s01yN8Az5rn3J-vJyE2VA@mail.gmail.com>
Subject: Re: [PATCH] Tiny whitespace fix to make ad7192.c cleanly pass checkpatch.pl
To: Ico Doornekamp <ico@pruts.nl>
Cc: Johnathan Iain Cameron <jic23@kernel.org>, Linux Iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hey.
You are missing Signed-off-by flag.
BR
Crt

On 9 September 2016 at 15:40, Ico Doornekamp <ico@pruts.nl> wrote:
> ---
>  drivers/staging/iio/adc/ad7192.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 1cf6b79..5688b29 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -391,7 +391,7 @@ ad7192_show_scale_available(struct device *dev,
>  }
>
>  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> -                            in_voltage-voltage_scale_available,
> +                            in_voltage - voltage_scale_available,
>                              S_IRUGO, ad7192_show_scale_available, NULL, 0);
>
>  static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
> --
> 2.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
