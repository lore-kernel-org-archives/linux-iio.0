Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1421360654-1390-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1421360654-1390-1-git-send-email-roberta.dobrescu@gmail.com>
Date: Fri, 16 Jan 2015 11:37:24 +0200
Message-ID: <CAEnQRZC4Xa1ArYPYKQZ1VV2qoen+V8t94T4oxrKs5vr2R6bNdg@mail.gmail.com>
Subject: Re: [PATCH] iio: industrialio-event: Fix typo 's/dynically/dynamically/'
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
>  drivers/iio/industrialio-event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 0c1e37e..db0cc4f 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -404,7 +404,7 @@ static inline int __iio_add_event_config_attrs(struct iio_dev *indio_dev)
>  {
>         int j, ret, attrcount = 0;
>
> -       /* Dynically created from the channels array */
> +       /* Dynamically created from the channels array */
>         for (j = 0; j < indio_dev->num_channels; j++) {
>                 ret = iio_device_add_event_sysfs(indio_dev,
>                                                  &indio_dev->channels[j]);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
