Return-Path: <SRS0=EcKQ=3T=konsulko.com=matt.ranostay@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170410170001.GA2524@project>
References: <20170410170001.GA2524@project>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Tue, 11 Apr 2017 16:59:31 -0700
Message-ID: <CAJCx=gmVtxgnWbRKRYMOjVXAVRJciZ2w-5GxUQ4D+1GwMZ4k2Q@mail.gmail.com>
Subject: Re: [PATCH v2] IIO: bmp280-core.c: fix error in humidity calculation
To: Andreas Klinger <ak@it-klinger.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Vlad Dogaru <ddvlad@gmail.com>, Akinobu Mita <akinobu.mita@gmail.com>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Aniroop Mathur <a.mathur@samsung.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Apr 10, 2017 at 10:00 AM, Andreas Klinger <ak@it-klinger.de> wrote:
> While calculating the compensation of the humidity there are negative values
> interpreted as unsigned because of unsigned variables used.  These values as
> well as the constants need to be casted to signed as indicated by the
> documentation of the sensor.
>
> Changes in v2:
> - cast also constants to signed; otherwise calculation is not correct
>
> I removed the Acked-By of Linus Walleij because of another change in the
> calculation. Don't know how it should be treated.
>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/pressure/bmp280-core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 4d18826ac63c..d82b788374b6 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -175,11 +175,12 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
>         }
>         H6 = sign_extend32(tmp, 7);
>
> -       var = ((s32)data->t_fine) - 76800;
> -       var = ((((adc_humidity << 14) - (H4 << 20) - (H5 * var)) + 16384) >> 15)
> -               * (((((((var * H6) >> 10) * (((var * H3) >> 11) + 32768)) >> 10)
> -               + 2097152) * H2 + 8192) >> 14);
> -       var -= ((((var >> 15) * (var >> 15)) >> 7) * H1) >> 4;
> +       var = ((s32)data->t_fine) - (s32)76800;
> +       var = ((((adc_humidity << 14) - (H4 << 20) - (H5 * var))
> +               + (s32)16384) >> 15) * (((((((var * H6) >> 10)
> +               * (((var * (s32)H3) >> 11) + (s32)32768)) >> 10)
> +               + (s32)2097152) * H2 + 8192) >> 14);
> +       var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)H1) >> 4;
>
>         return var >> 12;
>  };
> --
> 2.1.4
>
>
> --
