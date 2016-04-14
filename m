Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1460662602-2951-2-git-send-email-sst@poczta.fm>
References: <1460662602-2951-1-git-send-email-sst@poczta.fm> <1460662602-2951-2-git-send-email-sst@poczta.fm>
From: Matt Ranostay <mranostay@gmail.com>
Date: Thu, 14 Apr 2016 16:29:53 -0700
Message-ID: <CAKzfze8PtR559e2gjbWnZ=KHqETKr56tYUAyH7kJxwfQi=5tFg@mail.gmail.com>
Subject: Re: [PATCH 01/10] iio: light apds9960: fix wrong use of brace
To: Slawomir Stepien <sst@poczta.fm>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 14, 2016 at 12:36 PM, Slawomir Stepien <sst@poczta.fm> wrote:
> This fixes the error reported by checkpatch.pl:
>
> ERROR: that open brace { should be on the previous line
>
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
>  drivers/iio/light/apds9960.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index a6af56a..ade18aa 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -321,8 +321,12 @@ static const struct iio_chan_spec apds9960_channels[] = {
>  };
>
>  /* integration time in us */
> -static const int apds9960_int_time[][2] =
> -       { {28000, 246}, {100000, 219}, {200000, 182}, {700000, 0} };
> +static const int apds9960_int_time[][2] = {
> +       { 28000, 246},
> +       {100000, 219},
> +       {200000, 182},
> +       {700000,   0}
Extra space between the comma and zero. Or was this intended for alignment?

> +};
>
>  /* gain mapping */
>  static const int apds9960_pxs_gain_map[] = {1, 2, 4, 8};
> --
> 2.8.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
