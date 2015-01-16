Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1421360681-1443-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1421360681-1443-1-git-send-email-roberta.dobrescu@gmail.com>
Date: Fri, 16 Jan 2015 11:40:58 +0200
Message-ID: <CAEnQRZBp7BC-phZ71h3EmkTM9KeY5_3GMJszbiYdWEAk+Nbaiw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: cm32181: Fix typo 's/claibscale/calibscale/'
From: Daniel Baluta <daniel.baluta@intel.com>
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>, Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jan 16, 2015 at 12:24 AM, Roberta Dobrescu
<roberta.dobrescu@gmail.com> wrote:
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/light/cm32181.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index ad36b29..5d12ae54 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -169,7 +169,7 @@ static int cm32181_write_als_it(struct cm32181_chip *cm32181, int val)
>   * @cm32181:   pointer of struct cm32181.
>   *
>   * Convert sensor raw data to lux.  It depends on integration
> - * time and claibscale variable.
> + * time and calibscale variable.
>   *
>   * Return: Positive value is lux, otherwise is error code.
>   */
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
