Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35247 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbbFQKGs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jun 2015 06:06:48 -0400
Received: by lbbwc1 with SMTP id wc1so28184840lbb.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2015 03:06:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bd2cf6c9af8c7b741cf0f544d273952976e6e07c.1434492557.git.knaack.h@gmx.de>
References: <cover.1434492557.git.knaack.h@gmx.de>
	<bd2cf6c9af8c7b741cf0f544d273952976e6e07c.1434492557.git.knaack.h@gmx.de>
Date: Wed, 17 Jun 2015 13:06:46 +0300
Message-ID: <CAEnQRZDpZTwADuTqUMjoMrjBnu9vCU0Z8S7UR80zT8K72tiiVw@mail.gmail.com>
Subject: Re: [PATCH 3/7] iio:light:cm3323: pass up error value
From: Daniel Baluta <daniel.baluta@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jun 17, 2015 at 1:17 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> cm3323_get_it_bits() returns a valid error code, so pass it up in
> cm3323_read_raw().
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Agree, it's better this way.

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/light/cm3323.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index 1e6092a..f88a0ed 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -175,7 +175,7 @@ static int cm3323_read_raw(struct iio_dev *indio_dev,
>                 i = cm3323_get_it_bits(data);
>                 if (i < 0) {
>                         mutex_unlock(&data->mutex);
> -                       return -EINVAL;
> +                       return i;
>                 }
>
>                 *val = cm3323_int_time[i].val;
> --
> 2.3.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
