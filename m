Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1414069696-15439-1-git-send-email-vlad.dogaru@intel.com>
References: <1414069696-15439-1-git-send-email-vlad.dogaru@intel.com>
Date: Thu, 23 Oct 2014 17:00:18 +0300
Message-ID: <CAEnQRZC1+cc0OwOngkF3QS99-f7=Uh4w1J3aeAtNeXfknU+Abw@mail.gmail.com>
Subject: Re: [PATCH] bmp280: use correct routine for division
From: Daniel Baluta <daniel.baluta@intel.com>
To: Vlad Dogaru <vlad.dogaru@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 23, 2014 at 4:08 PM, Vlad Dogaru <vlad.dogaru@intel.com> wrote:
> The proper way to divide two signed 64-bit values is to use div4_s64.

s/div4_s64/div64_s64

Otherwise, it looks good to me. Thanks Vlad!

>
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> ---
>  drivers/iio/pressure/bmp280.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index fb91cb3..ce29ff9 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -239,7 +239,7 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
>                 return 0;
>
>         p = ((((s64) 1048576 - adc_press) << 31) - var2) * 3125;
> -       do_div(p, var1);
> +       p = div64_s64(p, var1);
>         var1 = (((s64) comp->dig_p9) * (p >> 13) * (p >> 13)) >> 25;
>         var2 = (((s64) comp->dig_p8) * p) >> 19;
>         p = ((p + var1 + var2) >> 8) + (((s64) comp->dig_p7) << 4);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
