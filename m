Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160520170633.GA2629@d830.WORKGROUP>
References: <20160520170633.GA2629@d830.WORKGROUP>
From: Matt Ranostay <mranostay@gmail.com>
Date: Fri, 20 May 2016 10:44:34 -0700
Message-ID: <CAKzfze8evJnbffJid1vqTjNoC=4t41XHsaG=F38hkxq_vRBO+g@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hdc100x: correct humidity integration time mask
To: Alison Schofield <amsfield22@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Reviewed-by: Matt Ranostay <mranostay@gmail.com>

On Fri, May 20, 2016 at 10:06 AM, Alison Schofield <amsfield22@gmail.com> wrote:
> Apply the correct mask to enable all available humidity integration
> times.  Currently, the driver defaults to 6500 and all is okay with that.
> However, if 3850 is selected we get a stuck bit and can't change back
> to 6500 or select 2500.  (Verified with HDC1008)
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> ---
>  drivers/iio/humidity/hdc100x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index fa47676..59aa1cb 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -55,7 +55,7 @@ static const struct {
>         },
>         { /* IIO_HUMIDITYRELATIVE channel */
>                 .shift = 8,
> -               .mask = 2,
> +               .mask = 3,

Yikes that is embarrassing on my part! I guess our validation was only
in the high resolution mode... good catch!

>         },
>  };
>
> --
> 2.1.4
>
