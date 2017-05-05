Return-Path: <SRS0=Q1y2=4L=gmail.com=daniel.baluta@kernel.org>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1493983193-8753-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
References: <1493983193-8753-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
From: Daniel Baluta <daniel.baluta@intel.com>
Date: Fri, 5 May 2017 14:24:11 +0300
Message-ID: <CAEnQRZA=YwX4jP95JutzDkPmtTVCR4vbiYrQRr3aBRMpvT1+5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] iio: light: rpr0521 disable sensor -bugfix
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, May 5, 2017 at 2:19 PM, Mikko Koivunen
<mikko.koivunen@fi.rohmeurope.com> wrote:
> Sensor was marked enabled on each call even if the call was for disabling
> sensor.
>
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
> ---
> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
> Patch v2->v3 changes:
> whitespace change.
>
>  drivers/iio/light/rpr0521.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 7de0f39..03504f6 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -197,7 +197,10 @@ static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
>         if (ret < 0)
>                 return ret;
>
> -       data->als_dev_en = true;

How about:

data->als_dev_en = !!(status & RPR0521_MODE_ALS_MASK);

Thanks for fixing this!
