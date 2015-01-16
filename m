Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1421360720-1533-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1421360720-1533-1-git-send-email-roberta.dobrescu@gmail.com>
Date: Fri, 16 Jan 2015 11:36:51 +0200
Message-ID: <CAEnQRZALuzB2rudR8QeOFeA4Bk5c4SgqgCHGGonfprOrpfMfFA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: hid-sensor-als: Use IIO_CHAN_INFO_RAW instead
 of hardcoded 0
From: Daniel Baluta <daniel.baluta@intel.com>
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>, Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jan 16, 2015 at 12:25 AM, Roberta Dobrescu
<roberta.dobrescu@gmail.com> wrote:
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/light/hid-sensor-als.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index a5283d7..e97101d 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -85,7 +85,7 @@ static int als_read_raw(struct iio_dev *indio_dev,
>         *val = 0;
>         *val2 = 0;
>         switch (mask) {
> -       case 0:
> +       case IIO_CHAN_INFO_RAW:
>                 switch (chan->scan_index) {
>                 case  CHANNEL_SCAN_INDEX_ILLUM:
>                         report_id = als_state->als_illum.report_id;
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
