Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1418721107-5429-2-git-send-email-roberta.dobrescu@gmail.com>
References: <1418721107-5429-1-git-send-email-roberta.dobrescu@gmail.com>
	<1418721107-5429-2-git-send-email-roberta.dobrescu@gmail.com>
Date: Tue, 16 Dec 2014 13:22:40 +0200
Message-ID: <CAEnQRZDMWDUQXXXZ+hBY68ECMmnJ1d+KcgKRAO8cJc1TcFVC2A@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: frequency: Remove 'out of memory' message
From: Daniel Baluta <daniel.baluta@intel.com>
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>, Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Dec 16, 2014 at 11:11 AM, Roberta Dobrescu
<roberta.dobrescu@gmail.com> wrote:
> This patch fixes the following checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message
>
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/frequency/adf4350.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 63a25d9..2b301eb 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -387,10 +387,8 @@ static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
>         int ret;
>
>         pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> -       if (!pdata) {
> -               dev_err(dev, "could not allocate memory for platform data\n");
> +       if (!pdata)
>                 return NULL;
> -       }
>
>         strncpy(&pdata->name[0], np->name, SPI_NAME_SIZE - 1);
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
