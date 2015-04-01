Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:32844 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbbDALqZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Apr 2015 07:46:25 -0400
Received: by wgoe14 with SMTP id e14so50088907wgo.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2015 04:46:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1abedb2004323a23e8dd120abf761f3488c8e9f6.1427797741.git.cristina.opriceana@gmail.com>
References: <cover.1427797741.git.cristina.opriceana@gmail.com>
	<1abedb2004323a23e8dd120abf761f3488c8e9f6.1427797741.git.cristina.opriceana@gmail.com>
Date: Wed, 1 Apr 2015 14:46:23 +0300
Message-ID: <CAEnQRZAVb_70+Fyj+PiXLQ3ShZTomafE3ZEnCFUEkhQnb8ERYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: ltr501: Powerdown device on error
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Cristina Opriceana <cristina.opriceana@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: outreachy-kernel@googlegroups.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Apr 1, 2015 at 2:01 PM, Cristina Opriceana
<cristina.opriceana@gmail.com> wrote:
> Power down device when an error occurs  in order to avoid wasting
> power. Also move powerdown function up to be seen by the new call.
>
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
> ---
>  drivers/iio/light/ltr501.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 62b7072..29ca4b8 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -333,6 +333,13 @@ static int ltr501_init(struct ltr501_data *data)
>                 data->ps_contr);
>  }
>
> +static int ltr501_powerdown(struct ltr501_data *data)
> +{
> +       return ltr501_write_contr(data->client,
> +               data->als_contr & ~LTR501_CONTR_ACTIVE,
> +               data->ps_contr & ~LTR501_CONTR_ACTIVE);
> +}
> +

While at it please also fix the alignment for ltr501_write_contr
parameters. Don't forget
to mention this in the commit message. When running checkpatch.pl
please use --strict parameter.

thanks,
Daniel.
